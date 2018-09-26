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

cutoff_sequencher.sh <file_name> <reference sequence name> <whether delete two-side>

*    <file_name> : input file name.
*    <reference sequence name> : which sequence is base reference sequence
*    <whether delete two-side> : whether delete two-side sequence of reference sequence

example:
________________________________________________________
$ cutoff_sequencher.sh test.fasta "plstid" "yes"
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

if [ -z $3 ]; then
  usage
fi
# 序列合并为单行

file_name=$1
export ref_name=$2
export whether_del=$3
bibiname=$(echo ${file_name} | perl -p -e 's/\.\w+$//')
one_line_file=$(echo ${bibiname}.merge.fasta)
n=0
if [ -e ${one_line_file} ];
then
  ((n=n+1))
  one_line_file=$(echo ${bibiname}_${n}.merge.fasta)
else
  cat ${file_name} | perl -p -e 's/\r?\n//;s/^>(.+)$/>$1\n/;s/^>/\n>/' | \
  perl -n -e '
    BEGIN{
      $ref = $ENV{ref_name};
      $del = $ENV{whether_del};
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
          if ($del eq "yes"){
            1;
          }else{
            if($left_cut){
              printf "%s\n%s\n","${title}_left",$left_cut;
            }
            if($right_cut){
              printf "%s\n%s\n","${title}_right",$right_cut;
            }
          }
          if($sequence){
            printf "%s\n%s\n","${title}_middle",$sequence;
          }
        }
      }else{
        die "Please check your ref_name!";
      }
    }
  '
fi
