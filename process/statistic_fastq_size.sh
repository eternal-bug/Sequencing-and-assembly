usage () {
echo "statistic_fastq_size.sh <file_path_list>"
cat <<EOF
such as:
  statistic_fastq_size.sh $(ls)
or:
  list=(file1.fastq.gz file2.fastq.gz file3.fastq.gz)
  statistic_fastq_size.sh ${list[@]}
EOF
exit 0
}

if [ -z $1 ]; then
  usage
fi

gzip_read () {
  export name=$1
  gzip -d -c $1 | perl -n -e'
  BEGIN{
    $total = 0;
  }
  chomp;
  if($. % 4 == 2){
    $total += length($_);
  }
  END{
    $gb = $total/1000_000_000;
    $mb = $total/1000_000;
    $kb = $total/1000;
    printf "| %s | %.1f | %.1f | %.1f | %d |\n",$ENV{name},$gb,$mb,$kb,$total;
  } '
}

fastq_read () {
  export name=$1
  cat $1 | perl -n -e'
  BEGIN{
    $total = 0;
  }
  chomp;
  if($. % 4 == 2){
    $total += length($_);
  }
  END{
    $gb = $total/1000_000_000;
    $mb = $total/1000_000;
    $kb = $total/1000;
    printf "| %s | %.1f | %.1f | %.1f | %d |\n",$ENV{name},$gb,$mb,$kb,$total;
  } '
}

md_title () {
  echo "| file | Gbp | Mbp | Kbp | Bp |"
  echo "| --- | --- | --- | --- | --- |"
}

statistic_fastq_size () {
  type=$(file -b $1)
  prefix=$(echo -n $type | perl -p -e 's/^(\w+).+/$1/' )
  
  if [ ${prefix} == "gzip" ];
  then
    gzip_read $1
  elif [ ${prefix} == "ASCII" ];
  then
    fastq_read $1
  fi
}

md_title
for i in $@;
do
  statistic_fastq_size ${i}
done
