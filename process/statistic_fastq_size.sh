usage () {
echo "statistic_fastq_size.sh <file_path>"
exit 0
}

if [ -z $1 ]; then
  usage
fi

gzip_read () {
  gzip -d -c $1 | perl -n -l -e'
  BEGIN{
    $total = 0;
  }
  if($. % 4 == 2){
    $total += length($_);
  }
  END{
    print $total;
  } '
}

fastq_read () {
  cat $1 | perl -n -l -e'
  BEGIN{
    $total = 0;
  }
  if($. % 4 == 2){
    $total += length($_);
  }
  END{
    print $total;
  } '
}

statistic_fastq_size () {
  type=$(file -b $1)
  prefix=$(echo -n $type | perl -p -e 's/^(\w+).+/$1/' )
  if [ ${prefix} == "gzip" ];
  then
    gzip_read $1
  elif [ ${prefix} == "ASCII" ];
    fastq_read $1
  fi
}
statistic_fastq_size $1
