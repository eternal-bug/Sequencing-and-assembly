#!perl -w
#####################
#screen blast result#
#####################

use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$FindBin::Bin/lib";
use Getopt::Long;
use List::Util qw/max min/;
use Data::Dumper qw/Dumper/;
use File::Basename qw/basename dirname/;
use File::Path qw/mkpath/;
use threads;
use Thread::Semaphore;
use POSIX qw/strftime/;
use YAML::Syck qw/Dump/;
use Carp qw/croak/;
use Spreadsheet::WriteExcel;
use Spreadsheet::ParseExcel;
use Spreadsheet::ParseExcel::SaveParser;
use Tblastnpx;
use ReadFasta qw/get_dic_file/;

use constant FH_TYPE => "GLOB";
use constant LI_TYPE => "ARRAY";

my $arguments = GetOptions(
    "q|query=s"     =>\(my $query),
    "d|database=s"  =>\(my $sbjct),
    "t|threshold=i" =>\(my $threshold),
    "o|out=s"       =>\(my $out_path),
    "threads=i"     =>\(my $threads = 2),
    "h|help"        =>\(my $help),
);

if(defined $help or not defined $arguments){
    die "please enter the argument!
    ____________________________________________________________________
     S|L           TYPE  description
    --------------------------------------------------------------------
    -q|--query     STR   the path or dictionary of query  fasta file
    -d|--database  STR   the path or dictionary of database  fasta file
    -t|--threshold INT   the threshold of blast match length
    -o|--out       STR   the path of output
    --threads      INT   the thread number
    -h|--help            help information
    ____________________________________________________________________
    ";
}

# 得到文件列表
my @database_file = &ReadFasta::get_dic_file($sbjct,"fasta|fa|fas");
my @query_list    = &ReadFasta::get_dic_file($query,"fa|fas|fasta");

# 生成线程信号量
my $semaphore = Thread::Semaphore->new($threads);
my $n = 0;
my $thread_href = {};

# 打印初始运行的时候的时间
&warn_or_tip(POSIX::strftime "%Y-%m-%d %H:%M:%S",localtime())->("");

# 遍历文件blast
for my $database_path (@database_file){
    for my $query_path (@query_list){
        {
            my $statistic_total_href = {};
            $n++;    # 线程计数
            $semaphore->down();  # 目前可用的线程数减去1
            $thread_href->{$n} = threads->new(\&progress,$database_path,$query_path,$statistic_total_href);  # 创建线程
            $thread_href->{$n}->detach();    # 剥离线程
            SIGNAL: while(1){
                if($$semaphore  > 0){
                    last SIGNAL;
                }
                select(undef,undef,undef,0.1);
            }
        }
    }
}

&waitquit;

sub waitquit{
    print "wait to quit......\n";
    my $num = 0;
    while($num < $threads){
        $semaphore->down();
        $num++;
        print "$num thread quit...\n";
    }
    &warn_or_tip("All $threads thread quit")->("");
    &warn_or_tip(POSIX::strftime "%Y-%m-%d %H:%M:%S",localtime())->("");
}

sub progress{
    my ($database_path,$query_path) = @_;
    
    my $statistic_href ; # 用来记录总的统计结果
    # 首先得到fasta的储存哈希
    open my $query_total_fh,"<",$query_path or die $!;
    my $query_info_fh = &store_fasta($query_total_fh);
    close $query_total_fh;
    
    # 新建文件夹
    my $database_basename = File::Basename::basename($database_path);
    my $dir_basename  = File::Basename::basename($query_path =~ s#(/.+?)/.+$#$1#r);
    my $base_basename = File::Basename::basename($query_path);
    # 输出结果的文件
    my $blast_out_path = "$out_path/$database_basename/$dir_basename/$base_basename";
    &warn_or_tip($blast_out_path)->("");

    &new_built_path ($blast_out_path);

    # 打印信息
    {
        my $info = sprintf "<%s> to <%s> begin to blast",$base_basename,$database_basename;
        warn_or_tip($info)->();
    }
    
    # 得到blast结果
    my ($blast_result,$balst_type) = &Tblastnpx::getblast({
                                            QUERY=>$query_path,
                                            SBJCT=>$database_path,
                                            OUT  =>$blast_out_path,
                                            });
    my %result_list = %{ &store_blast_result($blast_result) };

    # 新建日志文件
    open my $log_up_fh,">","$blast_out_path/log_up.txt" or die $!;
    open my $log_down_fh,">","$blast_out_path/log_down.txt" or die $!;

    # 筛选blast结果
    my %up_list;
    my %count;
    my %cross;
    for my $sbjct (sort {$a cmp $b} keys %result_list){
        printf $log_up_fh "======== %s ========\n",$sbjct;
        printf $log_down_fh "======== %s ========\n",$sbjct;
        for my $query ( sort {$a cmp $b} keys %{$result_list{$sbjct}}){
            my $match_len = ${$result_list{$sbjct}{$query}}[1] - ${$result_list{$sbjct}{$query}}[0];
            if( $match_len > $threshold){
                $cross{$query}++;
                $count{$sbjct}{"up"}++;
                $statistic_href->{$dir_basename}->{$base_basename}->{$sbjct}->{"up"}++;
                printf $log_up_fh ">%s\t%s-%s\n",$query,${$result_list{$sbjct}{$query}}[0],${$result_list{$sbjct}{$query}}[1];
                $up_list{$sbjct}{$query}++;
            }else{
                $count{$sbjct}{"down"}++;
                $statistic_href->{$dir_basename}->{$base_basename}->{$sbjct}->{"down"}++;
                printf $log_down_fh ">%s\t%s-%s\n",$query,${$result_list{$sbjct}{$query}}[0],${$result_list{$sbjct}{$query}}[1];
            }
        }
    }
    close $log_up_fh;
    close $log_down_fh;
    # 查看相交的结果
    
    my $cross_lr = [];
    my $cross_max_num = scalar(keys %result_list);
    if ($cross_max_num == 1){
        $cross_max_num = 2;
    }
    open my $cross_fh,">","$blast_out_path/cross_$cross_max_num.txt" or die "$!";
    for my $title (keys %cross){
        if($cross{$title} == $cross_max_num){
            printf  $cross_fh ">%s\n",$title."#".$dir_basename;
            push @$cross_lr,$title;
            $statistic_href->{$dir_basename}->{$base_basename}->{'cross'}++;
            for my $sbjct (keys %up_list){
                delete $up_list{$sbjct}{$title};
            }
        }
    }


    open my $query_fh,"<",$query_path or die "$!";
    open my $log_no_fh,">","$blast_out_path/log_no.txt" or die $!;

    my %no_blast;
    my $line;
    my $contig_count;
    

    # 打开输出文件的文件句柄，并且存放在引用中
    my $file_fh_href = {};
    for my $sbjct (keys %up_list){
        open my $file_fh,">","$blast_out_path/${sbjct}_not_cross.fasta" or die $!;
        &store_filehandle_in_hashref({
                                        HASH=>$file_fh_href,
                                        NAME=>$sbjct,
                                        FILEHANDLE=>$file_fh,
                                     });
    }

    for my $key (keys %$query_info_fh){
        my $title_trim = &_trim_contig_name($key);
        $contig_count++;
        for my $sbjct (keys %up_list){
            # 新建提取文件
            open my $ok_query,">>","$blast_out_path/${sbjct}_not_cross.fasta" or die $!;
            for my $query (keys %{$up_list{$sbjct}}){
                if($key =~ m/\b\Q$query\E\b/){
                    my $title_trim_combine = $title_trim . "#" . &_trim_basename($dir_basename) . "_" . &_trim_file_name($base_basename);
                    printf {$file_fh_href->{$sbjct}} "%s\n%s\n",$title_trim_combine,$query_info_fh->{$key};
                }else{
                    $no_blast{$key}++;
                    $statistic_href->{$dir_basename}->{$base_basename}->{'no'}++;
                }
            }
        }
        for my $query (@$cross_lr){
        	open my $cross_query,">>","$blast_out_path/cross.fasta" or die $!;
        	if($key =~ m/\b\Q$query\E\b/){
				my $title_trim_combine = $title_trim ."_cross_". "#" . &_trim_basename($dir_basename) . "_" . &_trim_file_name($base_basename);
                printf $cross_query "%s\n%s\n",$title_trim_combine,$query_info_fh->{$key};
        	}
        }
    }
    print $log_no_fh  Data::Dumper::Dumper(\%no_blast);

    # 打印到统计文件中
    # 新建R作图文件
    open my $r_tsv_fh,">","$blast_out_path/R_data.txt" or die $!;
    printf $r_tsv_fh "Threshold: %s\n",$threshold;
    printf $r_tsv_fh "contig_count : %s\n",$contig_count;
    printf $r_tsv_fh "%s\t%s\t%s\t%s\n","items","up_threshold","down_threshold","total";
    for my $sbjct (sort {$a cmp $b} keys %count){
        printf $r_tsv_fh "%s\t%s\t%s\t%s\n",$sbjct,$count{$sbjct}{"up"},$count{$sbjct}{"down"} || 0,$count{$sbjct}{"up"}+$count{$sbjct}{"down"} || 0;
    }
    close $r_tsv_fh;



    # 填写总结文件
    # 写入yaml文件
    &write_file("$out_path","statistic.yaml",YAML::Syck::Dump($statistic_href),">>");
    # 写入excel文件
    unless(-e "$out_path/statistic.xls"){
        my $workbook = Spreadsheet::WriteExcel->new("$out_path/statistic.xls");
        $workbook->close() or die "Error closing file: $!";
    }
    my $parser   = Spreadsheet::ParseExcel::SaveParser->new();
    my $template = $parser->Parse("$out_path/statistic.xls");
    # Get the first worksheet.
    my $worksheet = $template->worksheet(0);
    my $row  = 0;
    my $col  = 0;


    # Overwrite the string in cell A1
    $worksheet->AddCell( $row, $col, 'New string' );


    # Add a new string in cell B1
    $worksheet->AddCell( $row, $col + 1, 'Newer' );


    # Add a new string in cell C1 with the format from cell A3.
    my $cell = $worksheet->get_cell( $row + 2, $col );
    my $format_number = $cell->{FormatNo};

    $worksheet->AddCell( $row, $col + 2, 'Newest', $format_number );


    # Write over the existing file or write a new file.
    $template->SaveAs("$out_path/statistic.xls");

    # my $workbook = Excel::Writer::XLSX->new("$out_path/${dir_basename}_${base_basename}.xlsx");
    # my $worksheet = $workbook->add_worksheet();
    # $worksheet->write(0,0,"Hello world!");
    # for my $dirname (keys %$statistic_href){
    #     my $worksheet = $workbook->add_worksheet("123");
    #     for my $merge_file (keys %{ $statistic_href->{$dirname} }){
    #         $worksheet->write(0,0,$merge_file);
    #         my $n = 0;
    #         for my $type (keys %{ $statistic_href->{$dirname}->{$merge_file} }){
    #             $n++;
    #             if($type eq "no"){
    #                 $worksheet->write(1,($n*2-1),"no");
    #                 $worksheet->write(2,($n*2-1),$statistic_href->{$dirname}->{$merge_file}->{"no"});
    #             }else{
    #                 for my $down_up (keys %{ $statistic_href->{$dirname}->{$merge_file}->{$type} }){
    #                     my $m;
    #                     if($down_up eq "down"){
    #                         $m = 1;
    #                     }else{
    #                         $m = 0;
    #                     }
    #                     $worksheet->write(2,($n*2-1)+$m,$statistic_href->{$dirname}->{$merge_file}->{$down_up});
    #                 }
    #             }
    #         }
    #     }
    # }

    # 信号增加1
    $semaphore->up();
}

sub write_file{
    my($path,$name,$content,$write_type) = @_;
    open my $filehandle,"$write_type","$path/$name" or croak "please enter right file path!:$!";
    print {$filehandle} $content;
    close $filehandle;
}

sub store_fasta {      # 存储fasta文件信息
    my $fasta_fh = shift;
    my $fasta_href = {};
    my $len_max = 0;
    my $length = 0;
    my $title;
    if(ref $fasta_fh eq FH_TYPE){
        while(my $readline = <$fasta_fh>){
            chomp($readline);
            if(index($readline,">") == 0){
                $len_max = $length if $len_max < $length;
                $title = $readline;
                $length = 0;
            }else{
                my $sequence = $readline;
                $length += length($sequence);
                $fasta_href->{$title} .= uc($sequence);
            }
        }
    }
    if(wantarray){
        return ($fasta_href,$len_max);
    }else{
        return $fasta_href;
    }
}

sub store_filehandle_in_hashref{   # 将文件句柄存放在哈希中以便调用
    my $self = shift;
    if(ref $self->{"FILEHANDLE"} eq FH_TYPE){
        $self->{"HASH"}->{$self->{"NAME"}} = $self->{"FILEHANDLE"};
    }else{
        warn "please put filehandle";
    }
}

sub store_blast_result {
# 存贮blast的关键信息（query的名称以及比对到的片段位置）,但是是将blast的比对结果叠加后的东西
# --------
#    --------
#      |
#      v
# -----------

    my $blast_result = shift;
    my %result_list;  
    my $result_line;
        for $result_line (split /\n/, $blast_result){
            my @result = (split /\t/, $result_line);
            my ($query,$sbjct,$identity,$align_length,$start,$end) = map {$result[$_]} qw/0 1 2 3 6 7/;
            #=================== blast结果存储 =================
            #     列1    列2      列3          列4         列5       列6       列7    列8    列9   列10   列11    列12 
            #  Queryid Sbjctid identity% alignmentLength MisMatch GapOpening Q.start Q.end S.start S.end E-value BitScore
            if(exists $result_list{$sbjct}{$query}){
                #   -------------         ------------------
                #        -------------        ----------
                if(${$result_list{$sbjct}{$query}}[0] < $start && ${$result_list{$sbjct}{$query}}[1] < $start){
                    1;
                }elsif(${$result_list{$sbjct}{$query}}[0] > $end && ${$result_list{$sbjct}{$query}}[1] > $end){
                    1;
                }else{
                    ${$result_list{$sbjct}{$query}}[0] = List::Util::min((${$result_list{$sbjct}{$query}}[0],$start));
                    ${$result_list{$sbjct}{$query}}[1] = List::Util::max((${$result_list{$sbjct}{$query}}[1],$end));
                }
            }else{
                $result_list{$sbjct}{$query} = [$start,$end];
            }
        }
    return {%result_list};
}

sub _trim_file_name{
    my $file_name = shift;
    # 形式为 anchor.fasta spades.non-contained.fasta
    return $file_name =~ s#(?:\w+\.)*([\w]{1,5}).+\.fa.*$#$1#r;
}

sub _trim_contig_name{     # 将文件名进行修剪
	my $contig_name = shift;
	# 形式为 >infile_0/101/0_1087
	return $contig_name =~ s#infile.+/(\d+)/.+?(\d+)$#f$1_$2#r;
}

sub _trim_basename{
    my $basename = shift;
    # 形式为 7_mergeAnchors 8_megahit 8_megahit_MR
    return $basename =~ s#(\d+)_([a-z_])[a-z_]+([A-Z]*).*$#$1$2$3#r;
}

sub new_built_path {   # 新建文件夹，可以新建多层级的文件夹
    my $path = shift;
    if(-d "$path"){
        return 0;
    }else{
        (File::Path::mkpath ("$path",0,0755) && return 1) || return undef;
    }
}

sub warn_or_tip {  # 将信息以有颜色的形式打印终端上
    my $info = shift;
    my $os = $^O;
    my $color = {
        "MSWin32"=>{
            "RED"=>'\e[1;31m',
            "NC"=>'\e[0m',
            "GREEN"=>'\e[1;32m',
        },
        "linux"=>{
            "RED"=>'\033[0;31m',
            "NC"=>'\033[0m',
            "GREEN"=>'\033[0;32m',
        },
        "darwin"=>{
            "RED"=>'\033[0;31m',
            "NC"=>'\033[0m',
            "GREEN"=>'\033[0;32m',
        },
    };
    if($os eq 'MSWin32'){
        eval("use Win32::Console::ANSI") || warn "please install Win32::Console::ANSI";
        return sub {
            my $choose = shift;
            if(defined $choose){
                # 警告将会打印红色的字
                printf STDOUT ("%s%s%s\n",$color->{$os}->{"RED"},$info,$color->{$os}->{"NC"});
            }else{
                # 默认将会打印绿色的字
                printf  STDOUT ("%s%s%s\n",$color->{$os}->{"GREEN"},$info,$color->{$os}->{"NC"});
            }
        }
    }
    # $^O变量是当前操作系统的信息
    return sub {
        my $choose = shift;
        if(defined $choose){
            # 警告将会打印红色的字
            system sprintf ("echo >&2 \"%s%s%s\"",$color->{$os}->{"RED"},$info,$color->{$os}->{"NC"});
        }else{
            # 默认将会打印绿色的字
            system sprintf  ("echo >&2 \"%s%s%s\"",$color->{$os}->{"GREEN"},$info,$color->{$os}->{"NC"});
        }
    }
}
