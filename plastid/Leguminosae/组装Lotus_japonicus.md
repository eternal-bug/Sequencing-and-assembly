
# *Lotus japonicus*[百脉根]
[TOC levels=1-2]: # " "
+ [基本信息](#基本信息)
    + [测序文件](#测序文件)
    + [序列大小](#序列大小)
+ [数据来源](#数据来源)
+ [前期准备](#前期准备) 
+ [DRR060488](#drr060488)
+ [DRR060545](#drr060545)
+ [DRR060585](#drr060585)
+ [DRR060617](#drr060617)
+ [DRR060674](#drr060674)
+ [DRR060746](#drr060746)

# 相关站点
+ [Kazusa resource](http://www.kazusa.or.jp/lotus/)

# 基本信息
+ 数据来源: DRA004729, DRA004730, DRA004731
+ 测序方式: Illumina HiSeq 2000
+ 测序方式: pair-end
+ 核基因组大小: 470Mb
+ 细胞器基因组:380Kb[线粒体] + 150Kb[叶绿体]

## 测序文件
+ DRR060488
+ DRR060545
+ DRR060585
+ DRR060617
+ DRR060674
+ DRR060746

## 序列大小
| project | type | file | Bp | coverage | insert | read.len | seq type |
| --- | --- |--- | --- | --- | --- | --- | --- |
| PRJDB4841 | lotus_RI-043 | DRR060488 | 2,433,092,146 | 5 | | | Illumina HiSeq 2000 |
| PRJDB4841 | lotus_RI-173 | DRR060545 | 2,402,654,146 | 5 | | | Illumina HiSeq 2000 |
| PRJDB4841 | lotus_RI-016 | DRR060585 | 1,626,841,002 | 3 | | | Illumina HiSeq 2000 |
| PRJDB4841 | lotus_C037 | DRR060674 | 3,621,080,550 | 7 | | | Illumina HiSeq 2000 |
| PRJDB4841 | lotus_C160 | DRR060746 | 2,799,390,024 | 5 | | | Illumina HiSeq 2000 |

# 项目信息
+ [《High-resolution genetic maps of Lotus japonicus and L. burttii based on re-sequencing of recombinant inbred lines》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5066174/)
+ [百脉根RIL群体高密度遗传图谱](http://www.genepioneer.com/case_view.aspx?TypeId=129&Id=463&Fid=t4:129:4)
+ DRA004729, DRA004730, DRA004731(文章中提供的DRA号DRA002730应该为DRA004730)
+ [PRJDB4841 - sample](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJDB4841&go=go)

# 服务器...
```
# 下载测序数据数据信息，获得下载序列以及md5值
mkdir ~/data/anchr/Lotus_japonicus/download_link
cd ~/data/anchr/Lotus_japonicus/download_link
rm ./*.tsv

download_EBI.sh PRJDB4841 (DRR060488 DRR060545 DRR060585 DRR060617 DRR060674 DRR060746)
```

## 本地电脑...
```
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
  wangq@202.119.37.251:stq/data/anchr/Lotus_japonicus/genome
```
## 超算...
```
cd ~/stq/data/anchr/Lotus_japonicus/genome
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
```
```
# 建立文件链接
cd ~/stq/data/anchr/Lotus_japonicus
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\.R\w+\.fastq.gz//;print $new')
do
  if [ ! -d ${name} ];
  then
    mkdir -p ${name}/1_genome
    cd ${name}/1_genome
    ln -fs ../../genome/genome.fa genome.fa
    cd ${ROOTTMP}
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}.R1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}.R2.fastq.gz R2.fq.gz
    cd ${ROOTTMP}
  fi
done
```

# 测试倍数因子



## DRR060488 
+ 5
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Lotus_japonicus
BASE_NAME=DRR060488 
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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
  bash 0_master.sh
"
```

## DRR060545
+ 5
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Lotus_japonicus
BASE_NAME=DRR060545
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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
  bash 0_master.sh
"
```


## DRR060585
+ 3
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Lotus_japonicus
BASE_NAME=DRR060585
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 12 --cutk 31" \
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
  bash 0_master.sh
"
```

## DRR060674
+ 7
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Lotus_japonicus
BASE_NAME=DRR060674
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 28 --cutk 31" \
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
  bash 0_master.sh
"
```

## DRR060746
+ 5
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Lotus_japonicus
BASE_NAME=DRR060746
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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
  bash 0_master.sh
"
```
