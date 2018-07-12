#!perl -w
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$FindBin::Bin/lib";
use POSIX qw/strftime/;
use File::Path qw/mkpath/;
use File::Basename qw/basename dirname/;
use Data::Dumper qw/Dumper/;
use List::Util qw/max min/;
use threads;
use Thread::Semaphore;
use Getopt::Long;
use ReadFasta qw/get_dic_file/;
use Mymath;

use constant FH_TYPE => "GLOB";
use constant LI_TYPE => "ARRAY";
use constant HA_TYPE => "HASH";
use constant RE_TYPE => "Regexp";

my $arguments = GetOptions(
    "f|file=s"         =>\(my $file_dic),  
    "r|reference=s"    =>\(my $ref_name),     # 作为参考序列的title（例如 >title ）
    "o|out=s"          =>\(my $out_path),
    "s|start_site=i"   =>\(my $start_site = 0),  # 计数器从几号开始，以便与sequencher同步
    "c|cutoff_len=i"   =>\(my $cutoff = 0),  # 将序列按照多长进行分割分别分析，加快速度
    "x|context=i"      =>\(my $context_scale = 1), # 上下文
    "w|maskword=s"     =>\(my $mask_word = "N-"),  # 需要mask起来的字符，搭配-a参数
    "d|downthrehold=i" =>\(my $continuous_appear_floor = 10),    # 字符连续出现多少次就被mask起来，搭配-w参数使用
    "t|threads=i"      =>\(my $threads = 5),  # 多线程
    "h|help"           =>\(my $help),
);

if(defined $help){
    die 'please enter the argument!
    _________________________________________________________________
     S|L            TYPE  description
    -----------------------------------------------------------------
    -f|--file           STR   the path or dictionary of fasta file
    -r|--reference      STR   the title of reference(contain ">")
    -s|--start_site     INT   the start site of count
    -c|--cutoff         INT   the segment of sliced sequence
    -w|--maskword=s     STR   the word need to be mask(collocate -d)
    -d|--downthrehold=i INT   the count of continuous appearing 
                              will be mask(collocate -w)
    -x|--context        INT   the context scale
    -o|--out            STR   the path of output
    -t|--threads        INT   the thread number
    -h|--help                 help information
    __________________________________________________________________
    ';
}

# 初始化碱基替换矩阵
my $base_index = {
    A=>0,
    C=>1,
    G=>2,
    T=>3,
    N=>4,
    "-"=>5,
};
# 考虑颠换与置换的矩阵
#      A      C     G     T     N     -
# _______________________________________
# A | 0.990 0.060 0.020 0.020 0.010 0.000
# C | 0.020 0.990 0.060 0.020 0.010 0.000
# G | 0.060 0.020 0.990 0.020 0.010 0.000
# T | 0.020 0.060 0.020 0.990 0.010 0.000
# N | 0.001 0.001 0.001 0.001 0.000 0.000
# - | 0.000 0.000 0.000 0.000 0.000 0.990
my $base_pair = [
    [0.990,0.060,0.020,0.020,0.010,0.001],
    [0.020,0.990,0.060,0.020,0.010,0.001],
    [0.060,0.020,0.990,0.020,0.010,0.001],
    [0.020,0.060,0.020,0.990,0.010,0.001],
    [0.001,0.001,0.001,0.001,0.000,0.001],
    [0.001,0.001,0.001,0.001,0.001,0.990],
];

my @file_list = &ReadFasta::get_dic_file($file_dic,"fasta|fa|fas");

# 生成线程信号量
my $semaphore = Thread::Semaphore->new($threads);
my $thread_count = 0;
my $thread_href = {};

&main_loop(\@file_list);

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

sub main_loop {
    # 打印初始运行的时候的时间
    &warn_or_tip(POSIX::strftime "%Y-%m-%d %H:%M:%S",localtime())->("");

    my $file_list_lref = shift;
    for my $file (@$file_list_lref){
        open my $file_fh,"<","$file" or die "$!";
        &slice_and_process({
                            FILE_FH   =>$file_fh,
                            CUTOFF    =>$cutoff,
                            THREADS   =>$threads,
                            START_SITE=>$start_site,
                            });
    }
}

sub slice_and_process{   # 将序列切成多少段
    # 片段段存储到哈希中，然后分到process中分别处理（多线程）
    my $self = shift;
    my $threads = $self->{"THREADS"};
    my $cutoff = $self->{"CUTOFF"};
    my $file_fh = $self->{"FILE_FH"};
    my $start_site = $self->{"START_SITE"};
    # 存贮fasta文件信息
    my ($all_fasta_info_href,$len_max) = &store_fasta($file_fh);
    # 将无效的信息mask起来（替换为空格），加快程序运行速度
    # 正则表达式
    my $re = sprintf "%s",(join "|",(split /\s*/,$mask_word));
    &mask_invalid_base({
                        HASH=>$all_fasta_info_href,
                        FLOOR=>$continuous_appear_floor,
                        MASKWORD=>qr{$re},
                        });
    if($cutoff == 0){
        $cutoff = $len_max;  # 使用默认值就不对序列切片
    }
    my $fragments = int ($len_max / $cutoff + 0.999999); # 向上取整

    for(my $n = 0;$n < $fragments; $n++){
        # 新的hash
        my $segment_href = {};
        my $max_len;
        my $residue = $len_max - ($n * $cutoff + 1 + $cutoff - 1);
        for my $title (keys %$all_fasta_info_href){
            if($residue < 0){
                $segment_href->{$title} = substr($all_fasta_info_href->{$title},$n * $cutoff,abs($residue));
                $max_len = abs($residue);
                goto PROCESS;
            }
            $segment_href->{$title} = substr($all_fasta_info_href->{$title},$n * $cutoff,$cutoff - 1);
            $max_len = $cutoff;
        }

        # 多线程
        PROCESS: $thread_count++;    # 线程计数
        $semaphore->down();  # 目前可用的线程数减去1
        my $arguments = {
                    HASH=>$segment_href,
                    REF=>$ref_name,
                    CONTEXT_SCALE=>$context_scale,
                    MAX_LEN=>$max_len,
                    OFFSET=>$n * $cutoff,
                };
        $thread_href->{$n} = threads->new(\&process,$arguments);
        $thread_href->{$n}->detach();    # 剥离线程
        SIGNAL: while(1){
            if($$semaphore  > 0){
                last SIGNAL;
            }
            select(undef,undef,undef,0.1);
        }
    }
}

sub process {
    # 传入参数
    my $self = shift;
    my $context_scale =  $self->{"CONTEXT_SCALE"};
    my $fasta_info_href = $self->{"HASH"};
    my $len_max = $self->{"MAX_LEN"};
    my $ref_name = $self->{"REF"};
    my $offset = $self->{"OFFSET"};
    my $start_site = $self->{"START"};


    for my $move_windows (0..$len_max-2){
        my $base_list = {};
        my $ref;
        my $content_href;

        ROWBYROW: 
        for my $title (keys %$fasta_info_href){
            my $base = substr($fasta_info_href->{$title},$move_windows,1);
            if($title eq $ref_name){
                $ref = $base;
                next ROWBYROW;
            }else{
                $base_list->{$title}=$base;
            }
            # 得到上下文的字符串列表
            # $content_href = &matrix_context({
            #                                     FASTA_HASH=>$fasta_info_href,
            #                                     WINDOWS=>$move_windows,
            #                                     CONTENT=>$context_scale,
            #                                 });
        }
        my $value_href = &analysis_base({
                                            BASE=>$base_list,
                                            REF =>$ref,
                                        });
        my $value_lref = [values %$value_href];
        my $average_value = Mymath::average_value($value_lref);
        if(sprintf("%.3f",$average_value) == 0.990){
            1;
        }elsif(sprintf("%.3f",$average_value) != 0.000){
            open my $f,">>","./123.txt";
        	print {$f} "$move_windows\t$average_value\n";
            printf "%d : $ref-%f-@$value_lref\n\n\n",$move_windows + $offset,$average_value;
        }
    }

    # 信号增加1
    $semaphore->up();
}

sub mask_invalid_base {  # 将无效的碱基蒙起来
    my $self = shift;  # 需要传入哈西引
    if(ref $self eq HA_TYPE){
        my $fasta_href = $self->{"HASH"};    # 对原来的哈西进行修改，加快速度
        my $threshold = $self->{"FLOOR"};  # 某种字符连续出现多次的下限值
        my $word = $self->{"MASKWORD"};  # 需要对该类字符是否有效进行判断
        for my $title (keys %$fasta_href){
            # 采用正则表达式的方法来进行替换
            my $string = uc($fasta_href->{$title});
            # 清除其他字母
            $string =~ s/[^AGTCN-]/ /g;
            # 用空格替换两端的无效序列
            if($string =~ m/^${word}+/){
                substr($string,0,length($&)) = q{ } x length($&);
            }
            if($string =~ m/${word}+$/){
                substr($string,0 - length($&),length($&)) = q{ } x length($&);
            }
            # 查找中部大范围的gap
            while($string =~ m/${word}{$threshold,}/g){
                my $pos = pos ($string);
                substr($string,$pos-length($&),length($&)) = q{ } x length($&);
            }
            $fasta_href->{$title} = $string;
        }
        return $fasta_href;
    }
}

sub matrix_context{  # 每次提取一个包括中心点的列表，以及其上下文
    my $self = shift;
    my $fasta_href = $self->{"FASTA_HASH"};
    my $windows_site = $self->{"WINDOWS"};
    my $content_scale = $self->{"CONTENT"};
    my $content_href = {};
    #                center   content_scale = 2
    #                  |      ^取值的碱基
    #                  v
    # title1   ACGATCGATGCATGCATCGTAGCTAGCTACGTAGA
    #                ^^^^^
    # title2   ACAGCTAGTACGAGCTAGCTGACTAGCGTAGCATG
    #                ^^^^^
    for my $title (keys %$fasta_href){
        for my $i ($windows_site-$content_scale..$windows_site+$content_scale){
            my $relative_site = $windows_site - $i;
            push @{$content_href->{$relative_site}},substr($fasta_href->{$title},$i,1);
        }
    }
    #       1 2 3 4 5 6 7 8 9   不同链中的该相对偏移量的碱基情况
    #  2   [-,-,-,-,G,C,C,-,-]
    #  1   [-,-,G,-,-,A,A,-,-]
    #  0   [-,-,-,C,G,-,C,-,-]
    # -1   [-,-,C,-,-,C,-,-,-]
    # -2   [-,-,A,-,G,C,C,-,-]
    #偏移量
    # 键           值
    return $content_href;
}

sub get_baselist_effective{
    my $base_href = shift;  # 碱基列表
    my @list = ();
    map {   
            if($_){
                if($_ ne '-' && $_ ne  " " && $_ ne ""){
                    push @list,$_;
                }
            }

        } @$base_href;
    return [@list];
}

sub _get_baselist_effective{  # 通过上下文得到碱基列表来判断有效的项目的数目
    #    情况1 情况2 情况3 情况4 情况5 情况6 情况7 
    #ref  -     A     A    A     A     -    A   
    #_____________________________________________
    # s1  -     -     A    G     G     A    -
    # s2  -     -     A    A     G     A    -
    # s3  -     G     A    A     C     A    -
    # s4  A     G     A    A     A     G    -
    # s5  A     A     A    A     A     A    -
    # s6  -     -     -    -     -     -    -
    # s7  -     -     -    -     -     -    -
    # s8  -     -     -    -     -     -    -
    # s9  -     -     -    -     -     -    -
    
    # 关键是如何判断有意义的gap呢？需要上下文。
    # AGTAGCTATGCATCGTAGCTACGTAGCTAGCACGAGATCATCGATCG
    # AGTAGCTATGCATCG-AGCTACGTAGCTAGC------------------------
    #                ^                ^
    #                |                |
    #               有意义          无意义

    my $base_href = shift;  # 碱基列表
    my $max_value = List::Util::max(keys %$base_href);  # 偏移量的最大值
    my $min_value = List::Util::min(keys %$base_href);  # 偏移量的最小值
    my $effect_base_lref = [];
    # 通过当前的位置（相对的0点）来查看碱基
    SITE: for my $base_site ( 0..scalar( @{$base_href->{0}} ) -1 ){
        if($base_href->{0}->[$base_site] eq "-"){
            # 通过上下文来判断这种gap是否有意义
            if( scalar (grep { $base_href->{$_}->[$base_site] ne "-" } $min_value..0 ) >= 1
                &&
                scalar (grep { $base_href->{$_}->[$base_site] ne "-" } 0..$max_value ) >= 1
            ){
                push @$effect_base_lref , $base_href->{0}->[$base_site];
            }else{
                next SITE;
            }
        }else{
            push @$effect_base_lref,$base_href->{0}->[$base_site];
        }
    }
    return $effect_base_lref;
}

sub analysis_base{   # 传入包含一个或者多个碱基的列表，然后返回分数值列表
    my $self = shift;

    my $base_lref = $self->{"BASE"};  # 碱基列表
    my $ref = $self->{"REF"} || "-";  # 是否指定了引用
    if(defined ref $self){
        if(ref $base_lref eq LI_TYPE){
            my $value_list_lref = []; # 分值列表
            if($ref){
                my $items_count = scalar(@$base_lref); # 列表元素数目
                if($items_count == 0){return [];}
                # 如果参考序列的gap，那么各个query互相比较
                if($ref eq q{ }){
                    # 得到有效的碱基数（包含有上下文的gap）

                    # 互相比较
                    # 偏移量   A    C    G    A    C
                    # 1       A->C,A->G,A->A,A->C
                    # 2       C->G,C->A,C->C
                    # 3       G->A,G->C
                    # 4       A->C
                    my $offset = 0;# 偏移量
                    my $n = 0; # 记录当前的列数
                    HOST: for my $base (@$base_lref){
                        $offset++;
                        if($base eq q{ }){
                            next HOST;
                        }
                        if($items_count - 1 - $offset > 0){
                            GUEST: for my $i ($offset..$items_count - 1){
                                my $guest = $base_lref->[$i];
                                if($guest eq q{ }){
                                    next GUEST;
                                }
                                push @$value_list_lref,$base_pair->[$base_index->{$base}]->[$base_index->{$guest}];
                            }
                        }else{
                            last HOST;
                        }
                    }
                }else{
                    if($items_count == 0){
                        # 该处为gap，直接跳过
                        return [0];
                    }else{
                        BASE: for my $base (@$base_lref){
                            if($base eq q{ }){
                                next BASE;
                            }
                            push @$value_list_lref,
                                $base_pair->[$base_index->{$ref}]->[$base_index->{$base}];
                            if(defined $base_index->{$ref} && defined $base_index->{$base}){
                                1;
                            }else{
                                print "===> *$ref* + *$base*\n";
                            }
                        }
                    }
                }
                return $value_list_lref;
            }
        }elsif(ref $base_lref eq HA_TYPE){
            my $value_list_href = {}; # 分值哈希
            if($ref){
                my $items_count = scalar(keys %$base_lref); # 列表元素数目
                if($items_count == 0){return [];}
                # 如果参考序列的gap，那么各个query互相比较
                if($ref eq q{ }){
                    # 得到有效的碱基数（包含有上下文的gap）

                    # 互相比较
                    # 偏移量   A    C    G    A    C
                    # 1       A->C,A->G,A->A,A->C
                    # 2       C->G,C->A,C->C
                    # 3       G->A,G->C
                    # 4       A->C
                    HOST: 
                    for my $title (keys %$base_lref){
                        if($base_lref->{$title} eq q{ }){
                            next HOST;
                        }
                        for my $title_guest (keys %$base_lref){
                            if($base_lref->{$title_guest} eq q{ } || $title_guest eq $title){
                                next HOST;
                            }else{
                                $value_list_href->{$title} += 
                                    $base_pair->[$base_index->{$base_lref->{$title}}]->[$base_index->{$base_lref->{$title_guest}}];
                            }
                        }
                    }
                }else{
                    if($items_count == 0){
                        # 该处为gap，直接跳过
                        return [0];
                    }else{
                        BASE: 
                        for my $title (keys %$base_lref){
                            if($base_lref->{$title} eq q{ }){
                                next BASE;
                            }
                            $value_list_href->{$title} += 
                                    $base_pair->[$base_index->{$ref}]->[$base_index->{$base_lref->{$title}}];

                        }
                    }
                }
                return $value_list_href;
            }
        }
    }
}

sub store_fasta {
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
        eval('use Win32::Console::ANSI');
        return sub {
            my $choose = shift;
            if(defined $choose){
                # 警告将会打印红色的字
                printf STDOUT "\e[1;31m%s\e[0m\n",$info;
            }else{
                # 默认将会打印绿色的字
                printf  STDOUT "%s%s%s\n",$color->{$os}->{"GREEN"},$info,$color->{$os}->{"NC"};
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
