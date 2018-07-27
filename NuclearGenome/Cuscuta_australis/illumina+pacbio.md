# *Cuscuta_australis*[南方菟丝子]

+ **Illumina** HiSeq 2000 PAIRED [PRJNA217944(40个文件)-*Cuscuta Pentagona*(五角菟丝子)](https://www.ebi.ac.uk/ena/data/view/PRJNA217944)
+ **PacBio** RS II SINGLE [PRJNA394036-*Cuscuta australis*(南方菟丝子)](https://www.ebi.ac.uk/ena/data/view/PRJNA394036)
---
## Illumina数据下载

[Large-scale gene losses underlie the genome evolution of parasitic plant Cuscuta australis](https://www.nature.com/articles/s41467-018-04721-8)

```bash
# 在服务器端
mkdir -p ~/data/anchr/Cuscuta_australis/illumina
cd ~/data/anchr/Cuscuta_australis/illumina
rm ./*.tsv

SRP=PRJNA217944
wget -O ${SRP}.tsv  -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${SRP}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"

cat <<EOF >download_list.txt
SRR965929
SRR965963
SRR966236
SRR966405
SRR966412

EOF

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
