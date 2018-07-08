# 数据来源：SRP062694
# 测序仪器：Illumina Genome Analyzer II
# 测序方式：paired-end

# SRP062694
https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=SRP062694&result=read_run&fields=study_accession,sample_accession,secondary_sample_accession,experiment_accession,run_accession,tax_id,scientific_name,instrument_model,library_layout,fastq_ftp,fastq_galaxy,submitted_ftp,submitted_galaxy,sra_ftp,sra_galaxy,cram_index_ftp,cram_index_galaxy&download=txt

# 服务器

mkdir ~/data/anchr/Vigna_angularis/download_link
cd ~/data/anchr/Vigna_angularis/download_link
rm ./*.tsv

SRP=SRP062694
wget -O ${SRP}.tsv  -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${SRP}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"

cat <<EOF >download_list.txt
SRR2177511
SRR2177503
SRR2177505
SRR2177479
SRR2177462
EOF

```
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
      if( grep {$run_accession eq $_} keys %SRP_list ){
        my $link = $F[$hash{"fastq_ftp"}];
        my $md5  = $F[$hash{"fastq_md5"}];
        my ($link1,$link2) = split /;/,$link;
        my ($md5_1,$md5_2) = split /;/,$md5;
        my @list = ([$link1,$md5_1],[$link2,$md5_2]);
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
```

# 超算
# 
