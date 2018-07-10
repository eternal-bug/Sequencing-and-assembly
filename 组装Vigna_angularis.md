# *Vigna angularis*（赤豆）的组装
+ **数据来源**：SRP062694
+ **测序仪器**：Illumina Genome Analyzer II
+ **测序方式**：paired-end


>SRP062694下载数据来源
https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=SRP062694&result=read_run&fields=study_accession,sample_accession,secondary_sample_accession,experiment_accession,run_accession,tax_id,scientific_name,instrument_model,library_layout,fastq_ftp,fastq_galaxy,submitted_ftp,submitted_galaxy,sra_ftp,sra_galaxy,cram_index_ftp,cram_index_galaxy&download=txt


## 服务器
```bash
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

## 本地...
```bash
下载Vigna_angularis叶绿体以及线粒体的基因组
叶绿体 https://www.ncbi.nlm.nih.gov/nuccore/NC_021091.1
线粒体 https://www.ncbi.nlm.nih.gov/nuccore/NC_021092
之后改名为Vigna_angularis_mt.fasta    Vigna_angularis_pt.fasta
# 上传到超算
rsync -avP \
  ./Vigna_angularis_*.fasta \
  wangq@202.119.37.251:stq/data/anchr/Vigna_angularis/genome
```  
## 超算
```bash
cd ~/stq/data/anchr/Vigna_angularis/genome
cat Vigna_angularis_pt.fasta Vigna_angularis_mt.fasta >genome.fa
# 统计基因组大小
cat genome.fa | perl -MYAML -n -e '
chomp;
if(m/^>/){
  $title = $_;
  next;
}
if(m/^[NAGTCagtcn]{5}/){
  $hash{$title} += length($_);
}
END{print YAML::Dump(\%hash)}
'
# 结果为
'>NC_021091.1 Vigna angularis chloroplast DNA, complete sequence': 151683
'>NC_021092.1 Vigna angularis mitochondrial DNA, complete sequence': 404466

# 建立文件链接
cd ~/stq/data/anchr/Vigna_angularis
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/_.\.fastq.gz//;print $new')
do
  mkdir -p ${name}/1_genome
  cd ${name}/1_genome
  ln -fs ../../genome/genome.fa genome.fa
  cd ${ROOTTMP}
  mkdir -p ${name}/2_illumina
  cd ${name}/2_illumina
  ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
  ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```
```bash
# 运行超算任务
WORKING_DIR=${HOME}/stq/data/anchr/Vigna_angularis
BASE_NAME=SRR2177462

cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 92 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
