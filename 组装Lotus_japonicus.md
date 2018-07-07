# 数据来源
《High-resolution genetic maps of Lotus japonicus and L. burttii based on re-sequencing of recombinant inbred lines》
# DRA004729, DRA004730, DRA004731(文章中提供的DRA号DRA002730应该为DRA004730)
# 从三个项目文件中分别下载两个测序文件，共六个文件

================= DRA004729 ===============
# DRR060472
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060472/DRR060472_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060472/DRR060472_2.fastq.gz
# DRR060474
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060474/DRR060474_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060474/DRR060474_2.fastq.gz
# DRR060563
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060563/DRR060563_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060563/DRR060563_2.fastq.gz

# 下载DRR060488
4e269a0230023390624efde245794743
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060488/DRR060488_1.fastq.gz
cee881f303f3ae5d5c9d00675ca91da7
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060488/DRR060488_2.fastq.gz
# 下载DRR060545
2488a3bd67ff75a5601eff436a25ebda
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060545/DRR060545_1.fastq.gz
437c6d7cf74099cb68b001aff67e0c89
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060545/DRR060545_2.fastq.gz

================= DRA002730 ===============
# 下载DRR060585
6476141a0b1dc503368dc960bb0dc5c5
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060585/DRR060585_1.fastq.gz
d75707128e4f3939a08b4fcfc2464af2
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060585/DRR060585_2.fastq.gz
# 下载DRR060617
9269026c7a92672dd5c4d1f8e5eaf46a
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060617/DRR060617_1.fastq.gz
0d0a9c2775ed23b1ee808e69a6c56241
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060617/DRR060617_2.fastq.gz

================= DRA004731 ===============
# 下载DRR060674
f34e634fa692e6e31dfb8f21e4750d11
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060674/DRR060674_1.fastq.gz
90e9e5b76738630b63d194f637793768
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060674/DRR060674_2.fastq.gz

# 下载DRR060746
822aee77c0418546f9e2cca6321118d2
ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060746/DRR060746_1.fastq.gz
7f7933961d3665036b6e5edff3e1f9b1
ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060746/DRR060746_2.fastq.gz

# 服务器...
```
# 下载测序数据数据信息，获得下载序列以及md5值
mkdir ~/data/anchr/Lotus_corniculatus/download_link
cd ~/data/anchr/Lotus_corniculatus/download_link
rm ./*.tsv

# DRA004729 DRA004730 DRA004731
for DRA in DRA004729 DRA004730 DRA004731
do
  wget -O ${DRA}.tsv  -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${DRA}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"
done
```
```
# 要下载的文件列表DRR060488、DRR060545、DRR060585、DRR060617、DRR060674、DRR060746
cat <<EOF >download_list.txt
DRR060488
DRR060545
DRR060585
DRR060617
DRR060674
DRR060746
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
        $DRR_list{$read}++;
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
      if( grep {$run_accession eq $_} keys %DRR_list ){
        my $link = $F[$hash{"fastq_ftp"}];
        my $md5  = $F[$hash{"fastq_md5"}];
        my ($link1,$link2) = split /;/,$link;
        my ($md5_1,$md5_2) = split /;/,$md5;
        my @list = ([$link1,$md5_1],[$link2,$md5_2]);
        for my $link_md5 (@list){
          my $max_download_count = 3;
          my $basename = ($link_md5->[0] =~ s/^.+\/$//r);
          my $md5_value = $link_md5->[1];
          print $md5_fh $link_md5->[1];
          print $md5_fh " ",$link_md5->[0],"\n";
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
            }
          }
        }
      }
    }
  '
done

mv ./*.fastq.gz ../
mv ./sra_md5.txt ../
cd ~/data/anchr/Lotus_corniculatus/
md5sum --check sra_md5.txt
```
```
cat <<EOF >sra_md5.txt
4e269a0230023390624efde245794743 DRR060488_1.fastq.gz
cee881f303f3ae5d5c9d00675ca91da7 DRR060488_2.fastq.gz
2488a3bd67ff75a5601eff436a25ebda DRR060545_1.fastq.gz
437c6d7cf74099cb68b001aff67e0c89 DRR060545_2.fastq.gz
6476141a0b1dc503368dc960bb0dc5c5 DRR060585_1.fastq.gz
d75707128e4f3939a08b4fcfc2464af2 DRR060585_2.fastq.gz
9269026c7a92672dd5c4d1f8e5eaf46a DRR060617_1.fastq.gz
0d0a9c2775ed23b1ee808e69a6c56241 DRR060617_2.fastq.gz
f34e634fa692e6e31dfb8f21e4750d11 DRR060674_1.fastq.gz
90e9e5b76738630b63d194f637793768 DRR060674_2.fastq.gz
822aee77c0418546f9e2cca6321118d2 DRR060746_1.fastq.gz
7f7933961d3665036b6e5edff3e1f9b1 DRR060746_2.fastq.gz
EOF
```

# 本地电脑...
下载Lotus_japonicus叶绿体与线粒体基因组
# 线粒体
# https://www.ncbi.nlm.nih.gov/nuccore/JN872551.2
mv sequence.fasta.txt Lotus_japonicus_mt.fasta
# 叶绿体
# https://www.ncbi.nlm.nih.gov/nuccore/nc_002694
mv sequence.fasta.txt Lotus_japonicus_cp.fasta

# 上传到超算
rsync -avP \
  ./Lotus_japonicus_*.fasta \
  wangq@202.119.37.251:stq/data/anchr/Lotus_corniculatus/genome

# 超算...
cd ~/stq/data/anchr/Lotus_corniculatus/genome
cat Lotus_japonicus_cp.fasta Lotus_japonicus_mt.fasta >genome.fa
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
---
'>JN872551.2 Lotus japonicus strain MG-20 mitochondrion, complete genome': 380861
'>NC_002694.1 Lotus japonicus chloroplast, complete genome': 150519

# 建立文件链接
cd ~/stq/data/anchr/Lotus_corniculatus
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

# 质量评估
WORKING_DIR=${HOME}/stq/data/anchr/Lotus_corniculatus
BASE_NAME=DRR060488
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 160_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 75 --cutk 31" \
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
