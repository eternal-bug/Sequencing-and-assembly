usage () {
echo "statistic_fastq_size.sh <file_path>"
exit 0
}

if [ -z $1 ]; then
  usage
fi

statistic_fastq_size () {
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
