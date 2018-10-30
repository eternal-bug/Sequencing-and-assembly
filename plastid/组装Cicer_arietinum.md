# *Cicer arietinum*[鹰嘴豆]
[TOC levels=1-2]: # " "
+ [基本信息](#基本信息)
    + [数据编号](#数据编号)
    + [数据大小](#数据大小)
+ [前期准备](#前期准备) 
+ [SRR5282968](#srr5282968)
+ [SRR5283017](#srr5283017)
+ [SRR5283074](#srr5283074)
+ [SRR5283111](#srr5283111)
+ [SRR5283160](#srr5283160)
+ [参考文献](#参考文献)

# 基本信息
+ 数据来源: PRJNA375953
+ 测序仪器：Illumina HiSeq 2000
+ 测序方式：paired-end
+ 核基因组大小:740Mbp[科学网](http://blog.sciencenet.cn/blog-3533-766578.html)
+ 细胞器基因组:125Kb(叶绿体)

## 数据编号
+ 第一批
  + SRR5282968
  + SRR5283017
  + SRR5283074
  + SRR5283111
  + SRR5283160[未组装]
+ 第二批
  + SRR5282970
  + SRR5282976
  + SRR5282986
  + SRR5282995
  + SRR5283000

## 数据大小
| file | Bp | cov | insert |
| --- | ---: | ---: | ---: |
| SRR5282968 | 1,679,849,850 * 2 | ~4.3 | p+ |
| SRR5283017 | 1,891,080,600 * 2 | ~4.8 | p+ |
| SRR5283074 | 2,034,718,600 * 2 | ~5.4 | p- |
| SRR5283111 | 2,266,187,200 * 2 | ~5.9 |
| SRR5283160 | 2,501,687,000 * 2 | ~6.7 |
| SRR5282970 |
| SRR5282976 |
| SRR5282986 |
| SRR5282995 |
| SRR5283000 |

# 前期准备
下载鹰嘴豆(Cicer arietinum)的测序Illumina HiSeq 2000 paired-end的测序数据  从其中挑选5个测序数据
```https://trace.ncbi.nlm.nih.gov/Traces/sra/?study=SRP100678```

在EMBL中得到下载网址
https://www.ebi.ac.uk/ena/data/view/PRJNA375953


查看数据下载链接特点
```
# SRR528296
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/008/SRR5282968/SRR5282968_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/008/SRR5282968/SRR5282968_2.fastq.gz
# SRR5282969
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/009/SRR5282969/SRR5282969_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/009/SRR5282969/SRR5282969_2.fastq.gz
# SRR5282970
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/000/SRR5282970/SRR5282970_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/000/SRR5282970/SRR5282970_2.fastq.gz
# SRR5283172
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/002/SRR5283172/SRR5283172_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/002/SRR5283172/SRR5283172_2.fastq.gz
```

## 下载数据
```
for n in 2968 3017 3064 3111 3160
do
for m in 1 2
do

# 根据规律这里可以求余数来得到网址的数值
let a=$n%10
aria2c -x 9 -s 3 -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/00${a}/SRR528${n}/SRR528${n}_${m}.fastq.gz
done
done
```
```
# 得到文件的md5值
cat <<EOF >sra_md5.txt
943169f23fc3826f18a85a884709c2a1 SRR5282968_1.fastq.gz
0237a0b7574205d39f79444c2d00a32d SRR5282968_2.fastq.gz
f378685b29f9f055956ce2427ab33a71 SRR5283017_1.fastq.gz
e2c4bc288eb243d0ddc567f147b11f55 SRR5283017_2.fastq.gz
8abee78fa91bbad217eab0d79000c449 SRR5283074_1.fastq.gz
6ff98e643e0b2c50a59657e8524b3d95 SRR5283074_2.fastq.gz
b58ddcee82f9e038aef970b7716538d7 SRR5283111_1.fastq.gz
a7c41a4a87f564ffe921801f16c8e2ed SRR5283111_2.fastq.gz
5f715497b86a2117dcc29c48bee3b18b SRR5283160_1.fastq.gz
7fdcf1fdb4ba54cb2a6414b8e98a212d SRR5283160_2.fastq.gz
EOF

# 进行md5值校检
md5sum --check sra_md5.txt
```

## 数据上传
```
## 事先在超算建立好对应的文件夹
rsync -avP \
  ./*.gz \
  wangq@202.119.37.251:stq/data/anchr/Cicer_arietinum/sequence_data
```


## 下载基因组到本地
```
https://www.ncbi.nlm.nih.gov/genomes/GenomesGroup.cgi?opt=chloroplast&taxid=33090&sort=Genome#
# NC号为NC_011163
https://www.ncbi.nlm.nih.gov/nuccore/NC_011163
# 改名
mv sequence.fasta.txt Cicer_arietinum_chloroplast.fasta
# 上传到超算
rsync -avP \
  ./Cicer_arietinum_chloroplast.fasta \
  wangq@202.119.37.251:stq/data/anchr/Cicer_arietinum/genome/Cicer_arietinum_cp.fa
```

## 进入超算终端...
```
# 由于鹰嘴豆没有在线的线粒体序列数据，在查看进化树之后选取苜蓿的线粒体作为其参考序列为后续sequencher使用
cd ~/stq/data/dna-seq/cpDNA/Medicago
# 查看标签头信息
cat genome.fa | grep "^>"
# 得到线粒体的序列
cat genome.fa | perl -n -e '
BEGIN{$n = 0}
if(m/^>/){
  $n = 0;
}
if(m/>.*Mt|Mt.*/i){
  $n = 1;
  s/>.+/>Medicago_Mt/;
}
if($n == 1){
  print $_;
}
' > medicago_mt.tmp
```
```
# 进入鹰嘴豆的目录
cd ~/stq/data/anchr/Cicer_arietinum/genome
cat ~/stq/data/dna-seq/cpDNA/Medicago/medicago_mt.tmp ./Cicer_arietinum_cp.fa >genome.fa
rm ~/stq/data/dna-seq/cpDNA/Medicago/medicago_mt.tmp
# 检查fasta中的条目数
cat genome.fa | grep "^>"
```
```
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
'>Medicago_Mt': 271618
'>NC_011163.1 Cicer arietinum chloroplast, complete genome': 125319
```

```
# 建立文件链接
cd ~/stq/data/anchr/Cicer_arietinum
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/_.*\.fastq.gz//;print $new')
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


# SRR5282968
+ 4

### 设定工作区域、创建组装的bash模版文件
```
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282968
cd ${WORKING_DIR}/${BASE_NAME}

# 首先查看质量评估以及其他信息
anchr template \
    . \
    --basename ${BASE_NAME} \
    --fastqc \
    --insertsize \
    --sgapreqc \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "stq" "
if [ -e 2_fastqc.sh ]; then
    bash 2_fastqc.sh;
fi
if [ -e 2_kmergenie.sh ]; then
    bash 2_kmergenie.sh;
fi

if [ -e 2_insertSize.sh ]; then
    bash 2_insertSize.sh;
fi

if [ -e 2_sgaPreQC.sh ]; then
    bash 2_sgaPreQC.sh;
"
```
```
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 150_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 16 --cutk 31" \
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

---
# SRR5283017
+ 5

## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283017
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 150_000 \
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
bash 0_bsub.sh
"
```
# SRR5283074
+ 5.5

## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283074
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 150_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 22 --cutk 31" \
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

---
# SRR5283111
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283111
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 150_000 \
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
```

## 统计结果
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 809.2 | 603 | 2794.4 | 7.95% |
| R.tadpole.bbtools | 476.1 | 529 | 234.9 | 10.77% |
| R.genome.picard | 607.6 | 603 | 147.1 | FR |
| R.tadpole.picard | 496.0 | 541 | 222.6 | FR |
| R.tadpole.picard | 116.5 | 115 | 14.1 | RF |

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 396937 | 2 |
| Illumina.R | 100 | 4.53G | 45323744 |
| trim.R | 100 | 2.12G | 21260300 |
| Q25L60 | 100 | 1.96G | 19877635 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 100 | 4.5G | 44973488 |
| highpass | 100 | 2.15G | 21477836 |
| trim | 100 | 2.12G | 21260312 |
| filter | 100 | 2.12G | 21260300 |
| R1 | 100 | 1.06G | 10630150 |
| R2 | 100 | 1.06G | 10630150 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	27325	0.12722%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	6	0.00003%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	93566579
#main_peak	81
#genome_size	9483703
#haploid_genome_size	9483703
#fold_coverage	81
#haploid_fold_coverage	81
#ploidy	1
#percent_repeat	87.751
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 100 | 2.12G | 21259952 |
| ecco | 100 | 2.12G | 21259952 |
| eccc | 100 | 2.12G | 21259952 |
| ecct | 100 | 1.47G | 14777780 |
| extended | 140 | 1.93G | 14777780 |
| merged.raw | 359 | 102.82M | 348283 |
| unmerged.raw | 140 | 1.84G | 14081214 |
| unmerged.trim | 140 | 1.84G | 14081108 |
| M1 | 361 | 101.31M | 337850 |
| U1 | 140 | 919.68M | 7040554 |
| U2 | 140 | 917.42M | 7040554 |
| Us | 0 | 0 | 0 |
| M.cor | 140 | 1.94G | 14756808 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 132.2 | 136 | 34.4 | 0.91% |
| M.ihist.merge.txt | 295.2 | 319 | 104.3 | 4.71% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 14129.1 | 12251.7 | 13.29% | "71" | 150K | 26.56M | 177.07 | 0:03'56'' |
| Q25L60.R | 13060.0 | 11555.4 | 11.52% | "71" | 150K | 23.99M | 159.93 | 0:03'41'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 45.39% | 5248 | 126.08K | 33 | 397 | 8.29K | 99 | 17.0 | 1.0 | 4.7 | 30.0 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'19'' |
| Q0L0X40P001 | 40.0 | 43.89% | 6119 | 118.94K | 33 | 1047 | 17.73K | 86 | 16.0 | 1.0 | 4.3 | 28.5 | "31,41,51,61,71,81" | 0:00'15'' | 0:00'19'' |
| Q0L0X80P000 | 80.0 | 46.05% | 9444 | 130.42K | 19 | 43 | 2.9K | 71 | 33.0 | 1.0 | 10.0 | 54.0 | "31,41,51,61,71,81" | 0:00'16'' | 0:00'19'' |
| Q0L0X80P001 | 80.0 | 47.27% | 8982 | 126.5K | 21 | 836 | 8.2K | 70 | 33.0 | 1.0 | 10.0 | 54.0 | "31,41,51,61,71,81" | 0:00'16'' | 0:00'18'' |
| Q0L0X120P000 | 120.0 | 49.62% | 19128 | 130.67K | 13 | 37 | 2.41K | 68 | 50.0 | 2.0 | 14.7 | 84.0 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'19'' |
| Q0L0X120P001 | 120.0 | 49.50% | 12194 | 129.45K | 16 | 59 | 4.02K | 71 | 50.0 | 2.5 | 14.2 | 86.2 | "31,41,51,61,71,81" | 0:00'17'' | 0:00'19'' |
| Q0L0X160P000 | 160.0 | 49.38% | 12215 | 131.22K | 17 | 37 | 2.91K | 79 | 67.0 | 3.0 | 19.3 | 114.0 | "31,41,51,61,71,81" | 0:00'19'' | 0:00'19'' |
| Q0L0X160P001 | 160.0 | 44.88% | 9457 | 130.53K | 15 | 43 | 2.19K | 60 | 67.0 | 4.0 | 18.3 | 118.5 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'19'' |
| Q0L0X240P000 | 240.0 | 39.50% | 12090 | 129.41K | 19 | 43 | 2.08K | 54 | 100.0 | 5.0 | 28.3 | 172.5 | "31,41,51,61,71,81" | 0:00'22'' | 0:00'19'' |
| Q0L0X240P001 | 240.0 | 39.45% | 10715 | 134.26K | 18 | 35 | 1.45K | 44 | 100.0 | 6.0 | 27.3 | 177.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'19'' |
| Q0L0X320P000 | 320.0 | 38.09% | 9395 | 129.56K | 22 | 37 | 1.91K | 54 | 134.0 | 7.0 | 37.7 | 232.5 | "31,41,51,61,71,81" | 0:00'22'' | 0:00'20'' |
| Q0L0X320P001 | 320.0 | 37.19% | 9747 | 128.44K | 20 | 31 | 1.46K | 48 | 135.0 | 6.0 | 39.0 | 229.5 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'20'' |
| Q25L60X40P000 | 40.0 | 42.05% | 4190 | 119.92K | 37 | 1060 | 15.38K | 94 | 17.0 | 1.0 | 4.7 | 30.0 | "31,41,51,61,71,81" | 0:00'14'' | 0:00'18'' |
| Q25L60X40P001 | 40.0 | 43.56% | 4277 | 112.67K | 36 | 1206 | 20.25K | 92 | 17.0 | 1.0 | 4.7 | 30.0 | "31,41,51,61,71,81" | 0:00'15'' | 0:00'19'' |
| Q25L60X80P000 | 80.0 | 48.15% | 9464 | 127.78K | 18 | 1030 | 7.95K | 63 | 33.0 | 2.0 | 9.0 | 58.5 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'19'' |
| Q25L60X80P001 | 80.0 | 47.60% | 11022 | 127.4K | 15 | 707 | 4.74K | 68 | 33.0 | 2.0 | 9.0 | 58.5 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'18'' |
| Q25L60X120P000 | 120.0 | 45.28% | 12872 | 131.24K | 16 | 67 | 3.06K | 57 | 51.0 | 2.0 | 15.0 | 85.5 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'19'' |
| Q25L60X120P001 | 120.0 | 50.95% | 12183 | 130.11K | 12 | 34 | 1.97K | 62 | 51.0 | 2.0 | 15.0 | 85.5 | "31,41,51,61,71,81" | 0:00'17'' | 0:00'19'' |
| Q25L60X160P000 | 160.0 | 49.76% | 15074 | 132.07K | 15 | 29 | 1.88K | 64 | 67.0 | 3.5 | 18.8 | 116.2 | "31,41,51,61,71,81" | 0:00'19'' | 0:00'19'' |
| Q25L60X160P001 | 160.0 | 47.41% | 11609 | 129.82K | 17 | 37 | 2.02K | 60 | 67.0 | 3.0 | 19.3 | 114.0 | "31,41,51,61,71,81" | 0:00'19'' | 0:00'19'' |
| Q25L60X240P000 | 240.0 | 43.67% | 12205 | 130.68K | 16 | 38 | 1.81K | 52 | 101.0 | 4.0 | 29.7 | 169.5 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'19'' |
| Q25L60X240P001 | 240.0 | 43.95% | 9529 | 130.13K | 19 | 35 | 2.28K | 66 | 102.0 | 6.0 | 28.0 | 180.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'19'' |
| Q25L60X320P000 | 320.0 | 45.63% | 9404 | 129.91K | 21 | 68 | 4.57K | 68 | 136.0 | 6.0 | 39.3 | 231.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'20'' |
| Q25L60X320P001 | 320.0 | 42.66% | 9459 | 129.15K | 19 | 53 | 3.12K | 59 | 137.0 | 7.0 | 38.7 | 237.0 | "31,41,51,61,71,81" | 0:00'22'' | 0:00'19'' |

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 60.22% | 8875 | 129.04K | 21 | 1037 | 9.56K | 68 | 24.0 | 1.0 | 7.0 | 40.5 | "31,41,51,61,71,81" | 0:00'16'' | 0:00'21'' |
| MRX40P001 | 40.0 | 63.09% | 9542 | 129.47K | 18 | 481 | 5.68K | 63 | 24.0 | 1.0 | 7.0 | 40.5 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'21'' |
| MRX80P000 | 80.0 | 55.38% | 20833 | 130.64K | 14 | 71 | 2.34K | 44 | 48.0 | 1.5 | 14.5 | 78.8 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'18'' |
| MRX80P001 | 80.0 | 62.31% | 19548 | 130.34K | 14 | 398 | 4.35K | 49 | 48.0 | 1.0 | 15.0 | 76.5 | "31,41,51,61,71,81" | 0:00'17'' | 0:00'19'' |
| MRX120P000 | 120.0 | 50.81% | 9578 | 129.83K | 15 | 1037 | 3.82K | 38 | 72.0 | 3.0 | 21.0 | 121.5 | "31,41,51,61,71,81" | 0:00'19'' | 0:00'18'' |
| MRX120P001 | 120.0 | 48.93% | 9569 | 129.72K | 19 | 1026 | 3.61K | 41 | 73.0 | 3.0 | 21.3 | 123.0 | "31,41,51,61,71,81" | 0:00'19'' | 0:00'18'' |
| MRX160P000 | 160.0 | 47.98% | 13456 | 129.07K | 18 | 307 | 3.16K | 41 | 97.0 | 3.0 | 29.3 | 159.0 | "31,41,51,61,71,81" | 0:00'18'' | 0:00'19'' |
| MRX160P001 | 160.0 | 48.63% | 9384 | 130.06K | 19 | 1204 | 4.13K | 42 | 98.0 | 5.0 | 27.7 | 169.5 | "31,41,51,61,71,81" | 0:00'20'' | 0:00'18'' |
| MRX240P000 | 240.0 | 48.71% | 7004 | 128.33K | 23 | 1478 | 18.71K | 68 | 143.0 | 12.0 | 35.7 | 268.5 | "31,41,51,61,71,81" | 0:00'20'' | 0:00'19'' |
| MRX240P001 | 240.0 | 47.64% | 6986 | 126.84K | 24 | 1039 | 9.24K | 59 | 145.0 | 9.0 | 39.3 | 258.0 | "31,41,51,61,71,81" | 0:00'20'' | 0:00'18'' |
| MRX320P000 | 320.0 | 50.66% | 5535 | 158.18K | 45 | 1101 | 15.63K | 77 | 185.0 | 179.0 | 3.0 | 370.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'19'' |
| MRX320P001 | 320.0 | 49.13% | 5880 | 145.49K | 38 | 1158 | 23.41K | 68 | 181.0 | 169.0 | 3.0 | 362.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'19'' |

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 7257 | 11.09M | 2175 | 1285 | 560.37K | 423 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 11739 | 1.11M | 367 | 1273 | 519.22K | 397 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 7231 | 15.63M | 2898 | 1579 | 94.41K | 61 | 0.0 | 0.0 | 0.0 | 0.0 |  |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 40.98% | 2769 | 658.88K | 287 | 2204 | 661.99K | 649 | 70.0 | 49.0 | 3.0 | 140.0 | 0:00'46'' |
| 8_spades_MR | 61.92% | 4438 | 837.45K | 251 | 4337 | 463.76K | 469 | 149.0 | 100.0 | 3.0 | 298.0 | 0:00'44'' |
| 8_megahit | 38.23% | 5575 | 440.04K | 123 | 20678 | 211.13K | 286 | 104.0 | 73.0 | 3.0 | 208.0 | 0:00'45'' |
| 8_megahit_MR | 63.09% | 1867 | 581.58K | 316 | 1529 | 1.15M | 1081 | 98.0 | 63.0 | 3.0 | 196.0 | 0:00'47'' |
| 8_platanus | 36.12% | 11620 | 130.1K | 14 | 3175 | 20.56K | 35 | 5047.0 | 370.0 | 1312.3 | 9235.5 | 0:00'40'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 396937 | 2 |
| 7_mergeAnchors.anchors | 7257 | 11093960 | 2175 |
| 7_mergeAnchors.others | 1285 | 560366 | 423 |
| anchorLong | 7575 | 11020408 | 2072 |
| spades.contig | 241 | 5914913 | 33136 |
| spades.scaffold | 242 | 5934598 | 32997 |
| spades.non-contained | 4961 | 1320869 | 373 |
| spades_MR.contig | 5616 | 1530614 | 1003 |
| spades_MR.scaffold | 5747 | 1531586 | 978 |
| spades_MR.non-contained | 7018 | 1301208 | 279 |
| megahit.contig | 344 | 3496514 | 9075 |
| megahit.non-contained | 7406 | 651173 | 173 |
| megahit_MR.contig | 603 | 5851934 | 9707 |
| megahit_MR.non-contained | 2044 | 1734652 | 813 |
| platanus.contig | 124 | 1560771 | 10966 |
| platanus.scaffold | 129 | 1447838 | 9868 |
| platanus.non-contained | 9571 | 150655 | 21 |

---
# SRR5283074
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283074
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 150_000 \
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
```

## 统计结果
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 813.2 | 610 | 2755.7 | 6.95% |
| R.tadpole.bbtools | 470.6 | 530 | 243.4 | 9.50% |
| R.genome.picard | 617.7 | 610 | 148.1 | FR |
| R.tadpole.picard | 493.4 | 544 | 233.2 | FR |
| R.tadpole.picard | 117.3 | 114 | 17.6 | RF |

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 396937 | 2 |
| Illumina.R | 100 | 4.07G | 40694372 |
| trim.R | 100 | 1.94G | 19445098 |
| Q25L60 | 100 | 1.81G | 18382107 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 100 | 4.04G | 40384066 |
| highpass | 100 | 1.96G | 19627064 |
| trim | 100 | 1.94G | 19445118 |
| filter | 100 | 1.94G | 19445098 |
| R1 | 100 | 969.92M | 9722549 |
| R2 | 100 | 968.67M | 9722549 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	14126	0.07197%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	10	0.00005%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	84626218
#main_peak	76
#genome_size	9322303
#haploid_genome_size	9322303
#fold_coverage	76
#haploid_fold_coverage	76
#ploidy	1
#percent_repeat	91.083
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 100 | 1.94G | 19444760 |
| ecco | 100 | 1.94G | 19444760 |
| eccc | 100 | 1.94G | 19444760 |
| ecct | 100 | 1.31G | 13098904 |
| extended | 140 | 1.7G | 13098904 |
| merged.raw | 359 | 77.71M | 271428 |
| unmerged.raw | 140 | 1.63G | 12556048 |
| unmerged.trim | 140 | 1.63G | 12555954 |
| M1 | 361 | 76.07M | 259872 |
| U1 | 140 | 814.15M | 6277977 |
| U2 | 140 | 811.83M | 6277977 |
| Us | 0 | 0 | 0 |
| M.cor | 140 | 1.7G | 13075698 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 128.5 | 130 | 34.6 | 0.89% |
| M.ihist.merge.txt | 286.3 | 310 | 110.4 | 4.14% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 1938.6 | 1679.8 | 13.35% | "71" | 1M | 23.73M | 23.73 | 0:03'29'' |
| Q25L60.R | 1813.5 | 1600.0 | 11.77% | "71" | 1M | 21.88M | 21.88 | 0:03'14'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 37.06% | 11202 | 122.07K | 16 | 6721 | 10.37K | 49 | 99.0 | 4.5 | 28.5 | 168.8 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'21'' |
| Q0L0X40P001 | 40.0 | 39.42% | 12201 | 124.45K | 15 | 1862 | 8.58K | 51 | 95.0 | 6.0 | 25.7 | 169.5 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'21'' |
| Q0L0X80P000 | 80.0 | 35.33% | 9442 | 122.13K | 27 | 1442 | 19.13K | 80 | 196.0 | 13.0 | 52.3 | 352.5 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'19'' |
| Q0L0X80P001 | 80.0 | 35.40% | 7552 | 121.94K | 27 | 1848 | 9.58K | 72 | 197.0 | 10.0 | 55.7 | 340.5 | "31,41,51,61,71,81" | 0:00'26'' | 0:00'20'' |
| Q0L0X120P000 | 120.0 | 39.82% | 7025 | 121.09K | 29 | 1754 | 31.67K | 109 | 289.0 | 23.0 | 73.3 | 537.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'20'' |
| Q0L0X120P001 | 120.0 | 36.92% | 5841 | 121.07K | 29 | 1350 | 33.93K | 98 | 285.0 | 22.0 | 73.0 | 526.5 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'20'' |
| Q0L0X160P000 | 160.0 | 40.20% | 5766 | 120.73K | 30 | 1603 | 47.08K | 121 | 381.0 | 36.0 | 91.0 | 733.5 | "31,41,51,61,71,81" | 0:00'35'' | 0:00'21'' |
| Q0L0X160P001 | 160.0 | 38.03% | 5285 | 121.55K | 33 | 1613 | 54.34K | 122 | 366.0 | 57.0 | 65.0 | 732.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'21'' |
| Q0L0X240P000 | 240.0 | 37.91% | 4083 | 181.79K | 65 | 4335 | 17.05K | 107 | 517.0 | 500.0 | 3.0 | 1034.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'22'' |
| Q0L0X240P001 | 240.0 | 33.94% | 3891 | 183.05K | 61 | 1061 | 11.89K | 97 | 503.0 | 473.0 | 3.0 | 1006.0 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'22'' |
| Q0L0X320P000 | 320.0 | 34.95% | 4186 | 198.69K | 69 | 1094 | 14.63K | 124 | 551.0 | 530.0 | 3.0 | 1102.0 | "31,41,51,61,71,81" | 0:00'46'' | 0:00'23'' |
| Q0L0X320P001 | 320.0 | 36.69% | 4336 | 198.97K | 68 | 2059 | 12.65K | 131 | 595.0 | 573.0 | 3.0 | 1190.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'23'' |
| Q25L60X40P000 | 40.0 | 42.47% | 21301 | 124.66K | 13 | 3402 | 6.62K | 44 | 99.0 | 4.5 | 28.5 | 168.8 | "31,41,51,61,71,81" | 0:00'22'' | 0:00'19'' |
| Q25L60X40P001 | 40.0 | 44.81% | 21253 | 124.34K | 14 | 1610 | 7.13K | 62 | 97.0 | 6.0 | 26.3 | 172.5 | "31,41,51,61,71,81" | 0:00'20'' | 0:00'20'' |
| Q25L60X80P000 | 80.0 | 35.98% | 8155 | 124.35K | 21 | 1441 | 12.13K | 63 | 195.0 | 13.0 | 52.0 | 351.0 | "31,41,51,61,71,81" | 0:00'25'' | 0:00'20'' |
| Q25L60X80P001 | 80.0 | 35.61% | 9463 | 123.02K | 24 | 1584 | 13.33K | 66 | 199.0 | 10.5 | 55.8 | 345.8 | "31,41,51,61,71,81" | 0:00'27'' | 0:00'19'' |
| Q25L60X120P000 | 120.0 | 36.50% | 7549 | 124.4K | 26 | 1332 | 19.81K | 78 | 291.0 | 24.5 | 72.5 | 546.8 | "31,41,51,61,71,81" | 0:00'29'' | 0:00'20'' |
| Q25L60X120P001 | 120.0 | 36.11% | 6409 | 122.32K | 26 | 1631 | 26.53K | 84 | 293.0 | 25.0 | 72.7 | 552.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'20'' |
| Q25L60X160P000 | 160.0 | 36.12% | 5819 | 122.8K | 32 | 1621 | 51.08K | 105 | 374.0 | 45.0 | 79.7 | 748.0 | "31,41,51,61,71,81" | 0:00'33'' | 0:00'20'' |
| Q25L60X160P001 | 160.0 | 41.61% | 5814 | 123.23K | 31 | 1988 | 64.3K | 118 | 367.0 | 48.0 | 74.3 | 734.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'21'' |
| Q25L60X240P000 | 240.0 | 39.06% | 5839 | 122.43K | 30 | 1925 | 82.01K | 132 | 519.0 | 138.0 | 35.0 | 1038.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'22'' |
| Q25L60X240P001 | 240.0 | 38.89% | 3891 | 192.32K | 68 | 2059 | 9.41K | 123 | 508.0 | 489.0 | 3.0 | 1016.0 | "31,41,51,61,71,81" | 0:00'41'' | 0:00'23'' |
| Q25L60X320P000 | 320.0 | 34.45% | 3962 | 200.39K | 71 | 2141 | 12.05K | 110 | 551.0 | 528.0 | 3.0 | 1102.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'23'' |
| Q25L60X320P001 | 320.0 | 39.81% | 3145 | 205.51K | 74 | 2059 | 10.7K | 119 | 700.0 | 679.0 | 3.0 | 1400.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'23'' |

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 2.69% | 1173 | 5.95K | 5 | 1192 | 1.38K | 11 | 146.0 | 27.0 | 21.7 | 292.0 | "31,41,51,61,71,81" | 0:00'13'' | 0:00'18'' |
| MRX40P001 | 40.0 | 3.97% | 1114 | 6.96K | 6 | 1048 | 6.67K | 18 | 139.0 | 10.0 | 36.3 | 253.5 | "31,41,51,61,71,81" | 0:00'12'' | 0:00'18'' |

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 44.89% | 9477 | 121.65K | 21 | 1567 | 12.04K | 52 | 146.0 | 10.0 | 38.7 | 264.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'21'' |
| MRX40P001 | 40.0 | 45.21% | 9404 | 123.56K | 23 | 1278 | 16.41K | 60 | 144.0 | 11.5 | 36.5 | 267.8 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'21'' |
| MRX80P000 | 80.0 | 49.20% | 5812 | 164K | 47 | 1116 | 17.67K | 84 | 271.0 | 257.0 | 3.0 | 542.0 | "31,41,51,61,71,81" | 0:00'25'' | 0:00'20'' |
| MRX80P001 | 80.0 | 45.52% | 5467 | 162.61K | 48 | 1640 | 14.58K | 69 | 274.0 | 262.5 | 3.0 | 548.0 | "31,41,51,61,71,81" | 0:00'25'' | 0:00'19'' |
| MRX120P000 | 120.0 | 48.54% | 4463 | 197.59K | 66 | 1053 | 18.84K | 117 | 357.0 | 344.5 | 3.0 | 714.0 | "31,41,51,61,71,81" | 0:00'26'' | 0:00'20'' |
| MRX120P001 | 120.0 | 48.83% | 5190 | 202.56K | 66 | 1064 | 18.91K | 122 | 358.0 | 347.0 | 3.0 | 716.0 | "31,41,51,61,71,81" | 0:00'26'' | 0:00'20'' |
| MRX160P000 | 160.0 | 48.00% | 3085 | 204.62K | 73 | 1196 | 39.74K | 135 | 364.0 | 351.0 | 3.0 | 728.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'20'' |
| MRX160P001 | 160.0 | 49.29% | 2305 | 189K | 82 | 2242 | 66.77K | 182 | 345.0 | 332.0 | 3.0 | 690.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'21'' |
| MRX240P000 | 240.0 | 47.91% | 2665 | 131.98K | 59 | 6721 | 169.78K | 197 | 29.0 | 17.0 | 3.0 | 58.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'21'' |
| MRX240P001 | 240.0 | 47.81% | 2379 | 134.95K | 60 | 7003 | 166.27K | 195 | 28.0 | 15.0 | 3.0 | 56.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'21'' |
| MRX320P000 | 320.0 | 49.95% | 2598 | 146.3K | 64 | 6721 | 177.02K | 205 | 37.0 | 22.0 | 3.0 | 74.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'24'' |
| MRX320P001 | 320.0 | 46.28% | 3054 | 149.07K | 62 | 5882 | 161.65K | 214 | 32.0 | 17.0 | 3.0 | 64.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'23'' |

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 4859 | 466.12K | 146 | 1602 | 197K | 141 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 1247 | 197.39K | 153 | 1035 | 77.1K | 71 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 4328 | 418.12K | 143 | 1416 | 141.95K | 107 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 9003 | 337.83K | 86 | 1613 | 197.95K | 126 | 0.0 | 0.0 | 0.0 | 0.0 |  |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 38.59% | 1580 | 421.28K | 263 | 2552 | 811.99K | 652 | 51.0 | 31.0 | 3.0 | 102.0 | 0:00'43'' |
| 8_spades_MR | 53.65% | 2168 | 504.47K | 251 | 2681 | 538.25K | 567 | 91.0 | 57.0 | 3.0 | 182.0 | 0:00'49'' |
| 8_megahit | 34.04% | 2019 | 260.73K | 134 | 3928 | 283.38K | 310 | 59.0 | 34.0 | 3.0 | 118.0 | 0:00'41'' |
| 8_megahit_MR | 60.41% | 1566 | 411.35K | 263 | 1527 | 1.13M | 1016 | 73.0 | 48.0 | 3.0 | 146.0 | 0:00'44'' |
| 8_platanus | 33.41% | 33392 | 130.67K | 7 | 2685 | 4.98K | 6 | 4138.0 | 2184.0 | 3.0 | 8276.0 | 0:00'37'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 396937 | 2 |
| 7_mergeAnchors.anchors | 4859 | 466115 | 146 |
| 7_mergeAnchors.others | 1602 | 196996 | 141 |
| anchorLong | 7117 | 448396 | 118 |
| anchorFill | 7679 | 448467 | 95 |
| spades.contig | 637 | 3108403 | 8415 |
| spades.scaffold | 720 | 3136063 | 8235 |
| spades.non-contained | 4636 | 1233271 | 393 |
| spades_MR.contig | 882 | 2204193 | 6166 |
| spades_MR.scaffold | 1015 | 2214730 | 6065 |
| spades_MR.non-contained | 3628 | 1042719 | 353 |
| megahit.contig | 340 | 3015441 | 7949 |
| megahit.non-contained | 4426 | 544105 | 178 |
| megahit_MR.contig | 611 | 5201604 | 8656 |
| megahit_MR.non-contained | 1841 | 1546284 | 795 |
| platanus.contig | 115 | 570132 | 3686 |
| platanus.scaffold | 117 | 549660 | 3504 |
| platanus.non-contained | 124878 | 135651 | 3 |

# SRR5283160
## 组装

## 统计结果

# 参考文献
《Genome Analysis Identified Novel Candidate Genes for Ascochyta Blight Resistance in Chickpea Using Whole Genome Re-sequencing Data》
Plant Materials and Sequencing
In this study, the plant materials include 48 chickpea varieties released in Australia from 1978 to 2016, 16 advanced breeding lines, four landraces, and one wild chickpea C. reticulatum (Supplementary Table S1). The released varieties and advanced breeding lines are a good representation of the genetic diversity present in the Australian chickpea breeding program. The wild species C. reticulatum and landraces serve as a reference point for investigating genetic diversity. DNA was extracted from young leaf using Qiagen DNeasy Plant Mini Kit according to the manufacturer’s instructions. Pair-end sequencing libraries were constructed for each genotype with insert sizes of ∼500 bp using TruSeq library kit according to the Illumina manufacturer’s instruction. Around 40 million 150 bp paired-end reads for each genotype were generated by the Australian Genome Research Facility in Brisbane, Australia using Illumina HiSeq 2000 platform. Sequence data is available from the NCBI Short Read Archive under BioProject accession PRJNA375953.

《Investigating Drought Tolerance in Chickpea Using Genome-Wide Association Mapping and Genomic Selection Based on Whole-Genome Resequencing Data》

WGRS and SNP Discovery DNA of the 132 genotypes was extracted from young leaf tissues using the Qiagen DNeasy Plant Mini Kit following the manufacturer’s instruction. Paired-end sequencing libraries were constructed using the TruSeq library kit for each genotype with an insert size of 500 bp. The procedure was implemented according to the Illumina manufacturer’s instruction. Paired-end short reads (150 bp) were generated using the Illumina HiSeq 2000 platform. Sequence data is available from the NCBI Short Read Archive under BioProject accession PRJNA375953. Paired-end reads for each genotype were trimmed, filtered, and mapped to the kabuli reference genome 2.6.31 using SOAP2. Homozygous SNPs were called using the SGSautoSNP pipeline (Lorenc et al., 2012).
