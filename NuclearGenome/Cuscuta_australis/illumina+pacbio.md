# *Cuscuta_australis*[南方菟丝子]
> [《Large-scale gene losses underlie the genome evolution of parasitic plant Cuscuta australis》](https://www.nature.com/articles/s41467-018-04721-8)

**[PRJNA394036](https://www.ebi.ac.uk/ena/data/view/PRJNA394036)**

+ **Illumina** HiSeq 2000 PAIRED
+ **PacBio** RS II SINGLE 
+ **HiSeq** X Ten PAIRED
---
## 数据下载

```bash
# 在服务器端
mkdir -p ~/data/anchr/Cuscuta_australis/sequence_data
cd ~/data/anchr/Cuscuta_australis/sequence_data
rm ./*.tsv

SRP=PRJNA394036
wget -O ${SRP}.tsv  -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${SRP}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"

cat <<EOF >download_list.txt
ALL
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
```
```bash
# 移动到相应文件夹中

# Hiseq_X_Ten
for i in SRR{6664647..6664654};
do
  if [ ! -e ../Hiseq_X_Ten ];
    then
    mkdir -p ../Hiseq_X_Ten;
  fi;
  mv ./${i}* ../Hiseq_X_Ten;
done

# illumina
for i in SRR{5851367..5851369};
do
  if [ ! -e ../illumina ];
    then
    mkdir -p ../illumina;
  fi;
  mv ./${i}* ../illumina;
done

# pacbio
if [ ! -e ../pacbio ];
  then
  mkdir -p ../pacbio;
fi;
mv ./* ../pacbio;
done

# combine pacbio

```
## 分析流程[参考](https://github.com/wang-q/App-Anchr/blob/master/doc/model_organisms.md#arabidopsis-thaliana-col-0)
```bash
# 建立文件链接
cd ~/stq/data/anchr/Cuscuta_australis
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./illumina/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/_.\.fastq.gz//;print $new')
do
    mkdir -p ${name}/1_genome
    cd ${name}/1_genome
    ln -fs ../../genome/genome.fa genome.fa
  cd ${ROOTTMP}
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../illumina/${name}_1.fastq.gz R1.fq.gz
    ln -fs ../../illumina/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```

基因组大小来自[Large-scale gene losses underlie the genome evolution of parasitic plant Cuscuta australis](https://www.nature.com/articles/s41467-018-04721-8)
+ 264.83Mbp

```
WORKING_DIR=${HOME}/stq/stq/data/anchr/Cuscuta_australis/
BASE_NAME=SRR5851368
cd ${WORKING_DIR}/${BASE_NAME}

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 264_830_000 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25 30" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 50 60 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g
    
# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
