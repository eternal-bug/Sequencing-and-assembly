#！usr/bin/bash
# perl one-line
# 处理sequencher的文件
# seuqnecher-菜单-export-contig-fastaalign

# ref seq          ===============================
# contig1  !!!!!!!!!!!!!
# contig2      ************
# contig3                   -----------
# contig4                                 &&&&&&&&&&&&&
# contig5                                            ###########

# 由于叶绿体序列是环形的，所以开头结尾是人为规定的，在组装的时候会出现上面的情况
# 我要做是得到如下结果
# ref seq          ===============================
# contig1          !!!!!                  !!!!!!!!
# contig2          ********                   ****
# contig3                   -----------
# contig4          &&&&&                  &&&&&&&&
# contig5             ###########                 

# 也就是将两边裁切
#                 |                               |
# ref seq         |===============================|
# contig1 !!!!!!!!|!!!!!                          |
# contig2     ****|********                       |
# contig3         |         -----------           |
# contig4         |                       &&&&&&&&|&&&&&
# contig5         |                               |   ###########
#         |       |                               |              |
#         0       x                               y              z
#        零点    偏移量                          结束位置        尾端
# 也就是环形的

# 实际的sequencher的输出文件
# >ref
# ---ATGCGAATGTACGT-ATGCTGTA-------
# >contig1
# AAAATGCGAATGTACGTT---------------
# >contig2
# ----------------------TGTAACGATGC

usage () {
cat <<EOF
This progress is used to cut-off two-side of sequencher output file

like this
[before]

    ref seq          ===============================
    contig1  !!!!!!!!!!!!!
    contig2      ************
    contig3                   -----------
    contig4                                 &&&&&&&&&&&&&
    contig5                                            ###########

[after]

    ref seq          ===============================
    contig1          !!!!!                  !!!!!!!!
    contig2          ********                   ****
    contig3                   -----------
    contig4          &&&&&                  &&&&&&&&
    contig5             ###########                 

[or]

    ref seq          ===============================
    contig1          !!!!! 
    contig2          ******** 
    contig3                   -----------
    contig4                                 &&&&&&&&
    contig5  

cutoff_sequencher.sh <file_name> <reference sequence name> <delete two-side direction>

*    <file_name>                 : input file name.
*    <reference sequence name>   : which sequence is base reference sequence
*    <delete two-side direction> : whether delete two-side sequence of reference sequence

example:
________________________________________________________
# delete left and right sequence of contigs relative to reference
$ cutoff_sequencher.sh test.fasta "plstid" "left right"
# delete right sequence relative of contigs to reference
$ cutoff_sequencher.sh test.fasta "plstid" "right"
# don't delete
$ cutoff_sequencher.sh test.fasta "plstid" "no"
# or
$ cutoff_sequencher.sh test.fasta "plstid"
________________________________________________________
EOF
exit 1
}

if [ -z $1 ]; then
  usage
fi

if [ -z $2 ]; then
  usage
fi
# 序列合并为单行

file_name=$1
export ref_name=$2
export del_direction=$3
bibiname=$(echo ${file_name} | perl -p -e 's/\.\w+$//')
one_line_file=$(echo ${bibiname}.merge.fasta)
n=0
if [ -e ${one_line_file} ];
then
  ((n=n+1))
  one_line_file=$(echo ${bibiname}_${n}.merge.fasta)
else
  cat ${file_name} | \
  perl -p -e 's/\r?\n//;s/^>(.+)$/>$1\n/;s/^>/\n>/' | \
  perl -n -e '
    BEGIN{
      $ref = $ENV{ref_name};
    }
    s/\r?\n//;
    if(m/^>/){
      $title = $_;
      ($sequence = <>) =~ s/\r?\n//;
  
      # 记录参考序列的位置范围
      # 范围的位置点为机器码(减去1的值)
      if($title =~ m/\b\Q$ref\E\b/){
  
        if($sequence =~ m/[AGTC]/){
          $start = $-[0];
        }
        $reverse_seq = reverse $sequence;
        if($reverse_seq =~ m/[AGTC]/){
          $end = length($sequence) - $-[0];
        }
      }else{
        $hash{$title} = $sequence;
      }
    }
    END{
      if(defined $start and defined $end ){
        my ($title,$sequence);
        while(($title,$sequence)=each %hash){
          my($right_cut,$left_cut);
          my $len = length($sequence);
          if($len>$end+1){
            ($right_cut = substr($sequence,$end,$len-$end,""))=~s/-//g;
          }
          ($left_cut = substr($sequence,0,$start,""))=~s/-//g;
          $sequence =~ s/-//g;
          
          # 打印出相对于参考序列左边，中间，右边的序列
          if($left_cut){
            printf "%s\n%s\n","${title}_left",$left_cut;
          }
          if($sequence){
            printf "%s\n%s\n","${title}_middle",$sequence;
          }
          if($right_cut){
            printf "%s\n%s\n","${title}_right",$right_cut;
          }
      }else{
        die "Please check your ref_name!";
      }
    }
  ' | \
  perl -n -e '
    BEGIN{
      @del_list;
      $direction = $ENV{del_direction};
      my @accept_dir = qw/left middle right/;
      for my $dir (split /\s+/,$direction){
        if (grep {lc($dir) eq $_} @accept_dir){
          push $dir,@del_list;
        }else{
          warn("You have typed a error direction : $dir\n");
        }
      }
    }
    if(@del_list){
      chomp;
      if(grep {m/^>(.+?)${_}$/} @del_list){
        <>;
      }else{
        my $title = $_;
        chomp(my $sequence = <>);
        print "$title\n$sequence";
      }
    }else{
      print;
    }
  '
fi
