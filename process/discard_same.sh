# 排除相同的read
usage () {
cat <<EOF
  discard_same.sh file.fasta
EOF
}
# 分两步走
# 第一步，排除一摸一样的序列
# 第二步，得到较长的序列

cat $1 | perl -p -e 's/\r?\n//;s/^>(.+)$/>$1\n/;s/^>/\n>/ ' | \
perl -n -e '
  if(index($_,">")==0){
    ($title = $_) =~ s/\r?\n//;
    ($sequence = <>) =~ s/\r?\n//;
    
    unless($hash{$sequence}++){
      print "$title\n$sequence\n";
    }
  }
' | \
perl -n -e '
  # 现将序列放在内存中
  # [
  #   [title1,sequence1],
  #   [title2,sequence2],
  # ]
  if(index($_,">")==0){
    ($title = $_) =~ s/\r?\n//;
    ($sequence = <>) =~ s/\r?\n//;
    push @$list,[$title,$sequence];
  }
  # 将序列按照从短到长进行排序
  END{
    @list = sort {length($a->[1]) <=> length($b->[1])} @$list;
    for my $host_num (0..scalar(@$list)-1){
      my $flag = 1;
      if($host_num < scalar(@$list)-1){
        MATCH:
        for my $guest_num ($host_num+1..scalar(@$list)-1){
          if(index($list->[$guest_num]->[1],$list->[$host_num]->[1]) != -1){
            $flag = 0;
            last MATCH;
          }
        }
      }
      if($flag == 1){
        printf "%s\n%s\n",$list->[$host_num]->[0],$list->[$host_num]->[1];
      }
    }
  }
'
