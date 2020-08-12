package Blast::Tblastnpx::Screen;
use strict;
use warnings;
use 5.008001;
use Getopt::Long; # get arguments
use File::Basename qw/basename/;
use List::Util qw/first/;
use Data::Dumper qw/Dumper/;
use File::Path qw/mkpath/;

use parent qw/Blast::Tblastnpx::Common/;
use Blast::Tblastnpx; 
use Blast::Tblastnpx::Store;
use Read::Fasta; 
use Fasta::Info qw/Fasta::Info::title_to_sequence/;
use Fasta::Extract;

sub usage{
    my $self = shift;
    my $usage =<<EOF;
        This progrss is to screen blast result

        usege:

            bugdog.pl ScreenBlast [switchs] [options]

        ______________________________________________________________________
        ______________________________________________________________________

        [options]:

        ### path type
        ______________________________________________________________________
        
        *   -q|query                Input query file or query file path,
                                    This mean you can put a series of
                                    file in a file directory and run.
                                    [example]: -q ./query

        *   -s|sbjct                Input sbjct qfile or sbjct file path,
                                    This mean you can put a series of
                                    file in a file directory and run.
                                    [example]: -s ./sbjct

        *   --ob                    Blast result Output directory
                                    [default]="./"

        *   --om                    Output directory of blast sequence of
                                    Match rule 
                                    [default]=N/A
                                    if you open with --stdout switch and this
                                    sequence will be send to STDOUT.

        *   --on                    Output directory of blast sequence of
                                    No Match rule
                                    [default]=N/A

        *   --prefix                generate file directory prefix.
                                    [default]=N/A

            Tip: N/A mean that the default of this option is unavailable.
        ______________________________________________________________________

        ### screen type

        *   -l|length               Blast length threshold. if length of
                                    blast result segment under this value
                                    will be discard.
                                    default=100

        *   -i|identity             Blast segment identity threshold. if 
                                    identity of blast result segment under
                                    this value will be discard.[0-100].
                                    [default]=50

        *   -t|total_len            Total blast length of query threshold.
                                    blast result segment under this value
                                    will be discard.
                                    *FIRST:You should use
                                    --consider_all_segment switch
        
        *   align_percent           Total blast length of query account for
                                    the sequence length scale.
                                    like --align_percent "70:80"
                                    [default]=N/A

        *   --start                 maintain begin start point of sbjct of 
                                    this set value.
            
        *   --end                   maintain end until point of sbjct of 
                                    this set value.
        ______________________________________________________________________
        ______________________________________________________________________
        
        [switchs]

        *   --consider_all_segment  all blast sequence of query will
                                    be consider to restrict.
                                    [default]:only consider the longest
                                    blast segment 

        *   --identity_prior        if the segment of blast under identity
                                    threshold value will be discard no matter
                                    the segment of blast upper length threshold
                                    value.
                                    [default]:the segment of blast upper
                                    length threshold will be used and ignore
                                    identity threshold value.
            
        *   --no_cross              whether merge blast segment to one-liner
                                    and calculate length  when use 
                                    --consider_all_segment switch.
                                    such as
                                    sbjct ---------------------------------
                                    query --------
                                    query       -------
                                    query                         ------
                                                |                    |
                                                v                    v
                                    merge -------------           ------
        
        ______________________________________________________________________
        ______________________________________________________________________

        ### help
        *   -h|help                 Help infomation.
        
        _______________________________________________________________________

EOF
die $usage;
}




sub blast_items{
    return [0,1,2,3,6,7,8,9];
}

sub get_argument {
    no strict 'refs';
    
    my $self = shift;
    
    *{__PACKAGE__."::ARGV"} = *{caller."::ARGV"};
    
    my $argument = GetOptions(
        # options
        "q|query=s"               => \($self->{query}                        ), # 比对的文件路径
        "s|sbjct=s"               => \($self->{sbjct}                        ), # 作为数据库的文件的路径
        "ob=s"                    => \($self->{blast_output} = undef         ), # blast结果输出路径
        "o|output=s"              => \($self->{result_output} = undef        ), # 结果输出路径
        "l|length=i"              => \($self->{length} = 100                 ), # 单个比对的blast片段长度限制
        "i|identity=f"            => \($self->{identity} = 50                ), # 相似度的限制
        "align_percent=s"         => \($self->{align_percent}  = undef       ), # 比对到总长度与序列实际长度的占比限制[设置范围]
        "length_class=s"          => \($self->{length_class} = "100 500 1000"), # 长度的档次(0-100-500-1000-最大)
        "identity_class=s"        => \($self->{identity_class} = "50 80 90"  ), # 相似度的档次(0-50-80-90-100)
        "start=s"                 => \($self->{start}                        ), # 数据库文件开始位置
        "end=s"                   => \($self->{end}                          ), # 数据库文件结束位置
        "total_len=i"             => \($self->{total_len} = 0                ), # 总的比对长度限制
        # switch   
        "stdout"                  => \($self->{stdout} =  undef              ), # 是否将结果输出到标准输出中
        "extract_no_blast_region" => \($self->{extract_no_blast_region}=undef), # 将那些没有blast的片段提取出来
        "exclude_itself"          => \($self->{exclude_itself} = undef       ), # 排除与自身blast的结果
        "quick_run"               => \($self->{quick_run} = undef            ), # 是否快速运行（直接读取blast结果）：待写
        "get_no_match"            => \($self->{get_no_match} = undef         ), # 是否取得那些不符合条件的序列（包含没有blast结果的序列），这个选项会改变-o输出行为，相当于取反义
        "scale_restrict"          => \($self->{scale_restrict} = undef       ), # 是否限制比对到的数据库的位置
        "consider_all_segment"    => \($self->{consider_all} = undef         ), # 是否限制总的比对长度
        "identity_prior"          => \($self->{identity_prior} = undef       ), # 分类的时候是否相似度优先
        "segement_cross"          => \($self->{segment_cross} = undef        ), # 在限制总的比对长度之后，是否将这些比对序列交叠
        "no_strict_length"        => \($self->{no_strict_length} = undef     ), # 是否限制长度
        "h|help"                  => \(my $help                              ), # 帮助信息
    );
    $help && die $self->usage();
    # $argument && die usage();
    return $self;
}

sub itself_progress {
    my $self = shift;
    my $segment_hr = {};
    my $sequence_hr = {};
    if($self->{get_no_match}){
        $sequence_hr = $self->extract_no_blast_sequence();
        $segment_hr = $self->extract_all_query_no_blast_region();
    }else{
        1;
    }
    $self->get_print($segment_hr,".part",">");
    $self->get_print($sequence_hr,".all",">");
}

sub get_print {
    my $self = shift;
    my $hash_lr = shift;
    my $suffix = shift;
    my $write_type = shift;
    my $query_ba_ba_name = get_file_ba_basename($self->{file}->{query},"fa(?:s|sta)?");
    my $sbjct_ba_ba_name = get_file_ba_basename($self->{file}->{sbjct},"fa(?:s|sta)?");

    my $file_name = $query_ba_ba_name . "~" . $sbjct_ba_ba_name . $suffix;
    
    {
        my $fh;
        if(defined $self->{result_output}){
            &mkdir_path("$self->{result_output}");
            open $fh,$write_type,"$self->{result_output}/$file_name.fa";
        }elsif(defined $self->{stdout}){
            $fh = *{STDOUT}{IO};
        }
        if($fh){
            for my $key  (sort {$a cmp $b} keys %{$hash_lr}){
                printf $fh ">%s\n%s\n",$key,$hash_lr->{$key};
            }
        }
    }

    # {
    #     my $m_fh;
    #     if(defined $self->{sequence_output}){
    #         &mkdir_path("$self->{match_output}");
    #         open $m_fh,">","$self->{match_output}/$file_name.match.fa";
    #     }elsif(defined $self->{stdout}){
    #         $m_fh = *{STDOUT}{IO};
    #     }
    #     if($m_fh){
    #         for my $key (keys %{$self->{sequence}->{success}}){
    #             printf $m_fh ">%s\n%s\n",$key,$self->{sequence}->{success}->{$key};
    #         }
    #     }
    # }
    # {
    #     my $n_fh;
    #     if(defined $self->{segment_output}){
    #         &mkdir_path("$self->{nomatch_output}");
    #         open $n_fh,">","$self->{nomatch_output}/$file_name.nomatch.fa";
    #         for my $key (keys %{$self->{sequence}->{fail}}){
    #             printf $n_fh ">%s\n%s\n",$key,$self->{sequence}->{fail}->{$key};
    #         }
    #     }else{
    #         1;
    #     }
    # }
}

sub get_file_ba_basename {
    my $name = shift;
    my $suffix = shift;
    my $name_trim = (File::Basename::basename($name) =~ s/\.$suffix$//r);
    return $name_trim;
}


sub get_coincide_sequence {
    my $self = shift;
    my $title_list_lr = &get_coincide_title($self);
    my $sequence_hr = get_sequence($self->{'file'}->{'query'},[keys %$title_list_lr]);
    $self->{sequence}->{success} = $sequence_hr;
    return $sequence_hr;
}

sub get_coincide_title {
    my $self = shift;

    my $title_list_hr = {};
    if(defined $self->{"blast_result"}{"merge"}){
        map {$title_list_hr->{$_}++} keys %{$self->{"blast_result"}{"merge"}};
        return [keys %$title_list_hr];
    }else{
        die "Please add --consider_all_segment switch!\n";
    }
}

sub get_no_blast_sequence_list {
    my $self = shift;
    my @no_blast_title;
    my @blast_list = @{ $self->get_coincide_title() };
    for my $title_host (keys %{ $self->{info}->{query} }){
        my $flag = 1;
        for my $title_guest (@blast_list){
            if($title_host eq $title_guest){
                $flag = 0;
            }
        }
        if($flag == 1){
            push @no_blast_title,$title_host;
        }
    }
    return \@no_blast_title;
}

sub extract_all_no_blast_sequence {
    1;
}

sub extract_no_blast_sequence {
    my $self = shift;
    my $complement_title_lr = $self->get_no_blast_sequence_list();
    my $fasta_hr = get_sequence($self->{file}->{query},$complement_title_lr);
    return $fasta_hr;
}

sub extract_all_query_no_blast_region{
    my $self  = shift;
    my $hash_hr = {};
    my @blast_list = @{ $self->get_coincide_title() };
    for my $query (@blast_list){
        my $hr = $self->extract_one_query_no_blast_region($query);
        for my $key (keys %$hr){
            $hash_hr->{$key} = $hr->{$key};
        }
    }
    return $hash_hr;
}

sub extract_one_query_no_blast_region{
    my $self  = shift;
    my $query = shift;
    my $scale_lr = $self->{"blast_result"}->{"merge"}->{$query};
    my $total_len = $self->{info}->{query}->{$query} || 0;
    # total =============================
    # seg   ---   ---   ---   ---   ---
    #          |-|   |-|   |-|   |-|   |-
    my $complement_lr = Blast::Tblastnpx::Common::diffuse_scale($total_len,$scale_lr);
    my $extract_region = Fasta::Extract::extrict_segment_from_fasta($self->{file}->{query},$query,$complement_lr);
    return $extract_region;
}

# 待写
sub extract_all_query_blast_region {
    my $self  = shift;
    my $hash_hr = {};
    my @blast_list = @{ $self->get_coincide_title() };
    for my $query (@blast_list){
        1;
    }
}

sub extract_one_query_blast_region {
    my $self = shift;
    my $query = shift;
    for my $query (keys %{$self->{"blast_result"}->{"merge"}}){
        my $scale_lr = $self->{"blast_result"}->{"merge"}->{$query};
        my $extract_region = Fasta::Extract::extrict_segment_from_fasta($self->{file}->{query},$query,$scale_lr);
        return $extract_region;
    }
}

sub get_no_coincide_sequence{
    my $self = shift;

    my $title_list_lr = &get_coincide_title($self);

    my $host_list_lr = [keys %{$self->{info}->{query}}];
    my $guest_list_lr = [];
    if(defined $self->{"blast_result"}->{"merge"}){
        $guest_list_lr = [keys %{$self->{"blast_result"}->{"merge"}}];
    }else{
        my %temp;
        map {$temp{$_->[0]}++} @{$self->{"blast_result"}->{"cooked"}};
        $guest_list_lr = [keys %temp];
    }
    my ($undef,$no_contain_lr) = list_not_in_list($guest_list_lr,$host_list_lr);

    # 得到序列
    my $sequence_hr = get_sequence($self->{'file'}->{'query'},$no_contain_lr);
    return $sequence_hr;
}

sub list_not_in_list {
    my ($list1_lr,$list2_lr) = @_;
    my @contain;
    my @no_contain;
    for my $host (@$list2_lr){
        if(List::Util::first {$host eq $_} @$list1_lr){
            push @contain,$host;
        }else{
            push @no_contain,$host;
        }
    }
    return (\@contain,\@no_contain);
}

sub mkdir_path {
    my $path = shift;
    if(-e $path){
        return 1;
    }elsif(File::Path::mkpath($path)){
        return 0;
    }else{
        return 2;
    }
}


sub get_sequence{
    my $file_path = shift;
    my $title_list_lr = shift;
    my $sequence_hr = Fasta::Info::title_to_sequence($file_path,$title_list_lr);
    return $sequence_hr;
}

1;
