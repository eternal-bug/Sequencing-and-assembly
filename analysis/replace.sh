# 按照snp文件得到参考序列的替换序列
pattern=SRR*
prefix=Pt
# absolute path
# export Pt_ref=($(cd ./genome;pwd)"/Pt.fa")
export Pt_ref=./genome/Pt.fa
for i in $(ls ./${pattern}/screen/delindel/${prefix}.diff.one);
do
  if [ -f ${i} ];
  then
    dirname=$(dirname ${i})
    export dir_bibiname=$(echo ${i} | perl -n -e 's{\.?/?(.+?)/.+}{$1};print')
    # echo "#${dir_name}"
    cat ${i} \
    | grep -v -E "\-$" \
    | tail -n+2 \
    | perl -nla -F"\s+" -e '
      BEGIN{ # read ref seq
        $\ = undef;
        use vars qw/%ref_seq %snp/;
        # open ref seq
        open my $handle,"<",$ENV{Pt_ref} or die $!;
        while(<$handle>){
          chomp;
          if(m/^>(.+?)\s*$/){
            $title = $1;
          }elsif(defined $title){
          # 将这条序列的长度进行累加，直到遇到>或者文件尾
            $ref_seq{$title} .= $_;
          }
        }
      }
      if (defined $F[4]){
        $snp{$F[0]} = $F[4];
      }
      END{ # substitute
        my $ref = uc($ref_seq{(keys %ref_seq)[0]});
        print ">$ENV{dir_bibiname}\n";
        for my $site ( sort { $b <=> $a } keys %snp){
            substr($ref,$site-1,1) = lc($snp{$site});
        }
        print "$ref\n";
      }
    '
  fi \
  | perl -n -e '
    chomp;
    if(m/^>/){
        print $_,"\n";
    }else{
        s/(\w{80})/$1\n/g;
        # 因为保不齐恰巧有的序列是80的倍数，如果是那样最后一行序列会存在换行符
        if(substr($_,-1,1) =~ m/\n/){
            print $_;
        }else{
            print $_,"\n";
        }
    }
  '
done > total.fasta
