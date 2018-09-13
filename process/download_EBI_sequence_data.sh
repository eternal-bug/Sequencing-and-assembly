#!usr/bin/bash

usage () {
echo "download_EBI_sequence_data.sh <SRP number> <SRR number list>"
echo
echo
cat <<EOF
example:
________________________________________________________
$ SRR_list=(SRR5282968 SRR5283017 SRR5283074 SRR5283111)
$ PRJ=PRJNA375953
$ download_EBI_sequence_data.sh \$PRJ \${SRR_list[@]}
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

# 得到PRJ或者SRP项目文件
SRP=$1
wget -O ${SRP}.tsv  -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${SRP}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"

# 设置下载的列表
agr_num=0
for SRR in $@
do
  let agr_num+=1
  # 排除第一个参数
  if [ $agr_num -eq 1 ];
  then
    echo -n
  else
  # 将参数输出到文件中
    echo $SRR >> download_list.txt
  fi
done

# 解析tsv文件
ls *.tsv | while read TSV;
do
  cat $TSV | perl -MData::Dumper -n -a -F"\t+" -e '
    BEGIN{
      open my $file_fh,"<","./download_list.txt" or die $!;
      while(<$file_fh>){
        chomp;
        my $read = $_;
        $SRP_list{$read}++;
      }
      close $file_fh;
      open $md5_fh,">>","./sra_md5.txt" or die $!;
      $n=0;
    }
    $n++;
    if($n==1){
      while (my($index,$item) = each @F){
        $hash{$item} = $index;
      }
      next;
    }else{
      my $run_accession = $F[$hash{"run_accession"}];
      if((keys %SRP_list)[0] =~ m/ALL/i){
        goto LINK;
      }
      if( grep {$run_accession eq $_} keys %SRP_list ){
        LINK:
        my $link = $F[$hash{"fastq_ftp"}];
        my $md5  = $F[$hash{"fastq_md5"}];
        my @link_l = split /;/,$link;
        my @md5_l  = split /;/,$md5;
        
        my @list = map {[$link_l[$_],$md5_l->[$_]]} 0..scalar(@link_l)-1;
        for my $link_md5 (@list){
          my $max_download_count = 3;
          my $basename = ($link_md5->[0] =~ s/^.+\///r);
          my $md5_value = $link_md5->[1];
          print $md5_fh $link_md5->[1];
          print $md5_fh " ",$basename,"\n";
          my $link = "ftp://". $link_md5->[0] unless $link_md5->[0] =~ m{^ftp://};
          my $shell = "aria2c -x 9 -s 3 -c $link";
          DOWNLOAD: system "$shell";
          # 检查md5值
          $md5check = `md5sum $basename`;
          # 可以判断文件是否完整，但是无法在终端中用ctrl+c打断，怎么改进？
          if($max_download_count > 0){
            $max_download_count--;
            unless($md5check =~ /$md5_value/){
              unlink ("./$basename") if (-e "./$basename");
              goto DOWNLOAD;
            }else{
              print "\n\n";
              my $info = "\033[0;31m$basename\033[0m md5 value is \033[0;32mOK\033[0m\n";
              print "_" x length($info),"\n";
              print $info;
              print "_" x length($info),"\n";
            }
          }
        }
      }
    }
  '
done
