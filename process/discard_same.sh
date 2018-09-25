# 排除相同的read
usage () {
cat <<EOF
  discard_same.sh file.fasta
EOF
}

cat $1 | perl -n -e '
  if(index($_,">")==0){
    ($title = $_) =~ s/\r?\n//;
    ($sequence = <>) =~ s/\r?\n//;
    
    unless($hash{$sequence}++){
      print "$title\n$sequence\n";
    }
  }
'
