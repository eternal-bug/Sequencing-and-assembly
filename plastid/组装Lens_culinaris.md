# *Lens_culinaris*[兵豆]
[TOC levels=1-2]: # " "
+ [基本信息](#基本信息)
    + [品系](#品系)
    + [序列大小](#序列大小)
+ [前期处理](#前期处理) 
+ [BD268](#bd268)
+ [BD280](#bd280)
+ [BD308](#bd308)
+ [BD310](#bd310)
+ [BD312](#bd312)

# 基本信息
+ 测序方式: Illumina HiSeq 2000
+ 测序方式: pair-end
+ 兵豆Lentil (Lens culinaris), 2n=2x=14
+ 基因组大小：4063Mbp[科学网](http://blog.sciencenet.cn/blog-3533-766578.html)
+ 叶绿体+线粒体：1.2Mbp(估计值)

## 品系
+ BD268
+ BD280
+ BD308
+ BD310[未组装]
+ BD312[未组装]

## 序列大小

| file | Gbp | Mbp | Kbp | Bp |
| --- | --- | --- | --- | --- |
| BD280_L1_335335.R1.fastq.gz | 3.5 | 3492.0 | 3492032.1 | 3492032100 |
| BD280_L1_335335.R2.fastq.gz | 3.5 | 3492.0 | 3492032.1 | 3492032100 |
| BD308_L1_336336.R1.fastq.gz | 4.7 | 4688.1 | 4688126.2 | 4688126250 |
| BD308_L1_336336.R2.fastq.gz | 4.7 | 4688.1 | 4688126.2 | 4688126250 |
| BD310_L1_344344.R1.fastq.gz | 4.4 | 4436.9 | 4436925.9 | 4436925900 |
| BD310_L1_344344.R2.fastq.gz | 4.4 | 4436.9 | 4436925.9 | 4436925900 |
| BD312_L1_337337.R1.fastq.gz | 4.6 | 4645.2 | 4645214.2 | 4645214250 |
| BD312_L1_337337.R2.fastq.gz | 4.6 | 4645.2 | 4645214.2 | 4645214250 |

**数据说明**：这些文件是将clean、adapter、lowqual合并之后得到的文件

# 前期处理
## 查找叶绿体基因组文件
在NCBI的核酸库中搜索`Lens culinaris plastid, complete genome`，发现有信息
+ KF186232.1
+ 123096 bp
使用本地电脑下载并上传到服务器上

## 上传
```bash
rsync -avP ./raw wangq@202.119.37.251:stq/data/anchr/our_sequence
```

## 新建工作区
```bash
cd ~/stq/data/anchr/our_sequence
mkdir -p ../Lens_culinaris/seuqence_data
mkdir -p ../Lens_culinaris/genome
mv ./raw/BD* ../Lens_culinaris/seuqence_data
cd ~/stq/data/anchr/Lens_culinaris/268_PE400_R/1_genome
cp genome.fa ../../../our_sequence/Lens_culinaris/genome/
```
## 建立文件链接
```bash
cd ~/stq/data/anchr/our_sequence/Lens_culinaris/
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\.R\w+\.fastq\.gz//;print $new')
do
  if [ ! -d ${name} ];
  then
    # 新建文件夹
    mkdir -p ${name}/1_genome
    mkdir -p ${name}/2_illumina
  else
    # 建立链接
    cd ${name}/1_genome
    ln -fs ../../genome/genome.fa genome.fa
    cd ${ROOTTMP}
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}.R1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}.R2.fastq.gz R2.fq.gz
    cd ${ROOTTMP}
  fi
done
```

---
# BD268

## 进行细胞器基因组的大小预测
```bash
WORKING_DIR=${HOME}/~/stq/data/anchr/Lens_culinaris
BASE_NAME=268_PE400_R

cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --parallel 24 \
    --xmx 110g
```
```bash
# 打开vim
vim

# ============ 输入 =============
#!/usr/bin/env bash
BASH_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BASH_DIR}

#----------------------------#
# Illumina QC
#----------------------------#
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
fi

# ============================================
# 存文件为 quality_and_prediction.sh
```

提交超算任务
```bash
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash quality_and_prediction.sh
"
```

## 后台生成的信息
```text
#R.trim
#Matched	195738	0.40818%
#Name	Reads	ReadsPct
Reverse_adapter	48124	0.10036%
```

```text
#R.filter
#Matched	0	0.00000%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	1373473739
#main_peak	435
#genome_size	1217928
#haploid_genome_size	1217928
#fold_coverage	422
#haploid_fold_coverage	422
#ploidy	1
#percent_repeat	96.060
#start	center	stop	max	volume
```
得知预测的大小为1217928

# BD268
## 进行组装
```bash
WORKING_DIR=~/stq/data/anchr/Lens_culinaris
BASE_NAME=268_PE400_R
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_217_928 \
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
  bash 0_bsub.sh
"
```
## BUSCO评估
```bash
# process_busco.sh 在 Sequencing-and-assembly/process/文件夹里
bash process_busco.sh
```

## Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.tadpole.bbtools | 296.6 | 284 | 100.5 | 1.40% |
| R.tadpole.picard | 293.5 | 282 | 102.6 | FR |

## Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Illumina.R | 151 | 7.5G | 49679488 |
| trim.R | 150 | 5.37G | 37058542 |
| Q25L60 | 150 | 4.84G | 34117245 |

## Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 151 | 7.24G | 47953620 |
| highpass | 151 | 5.73G | 37980090 |
| trim | 150 | 5.37G | 37058552 |
| filter | 150 | 5.37G | 37058542 |
| R1 | 150 | 2.76G | 18529271 |
| R2 | 150 | 2.61G | 18529271 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	147643	0.38874%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	5	0.00001%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	830023463
#main_peak	422
#genome_size	1505362
#haploid_genome_size	1505362
#fold_coverage	384
#haploid_fold_coverage	384
#ploidy	1
#percent_repeat	93.095
#start	center	stop	max	volume
```



## Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 150 | 5.36G | 37022454 |
| ecco | 150 | 5.36G | 37022454 |
| eccc | 150 | 5.36G | 37022454 |
| ecct | 150 | 1.37G | 9469146 |
| extended | 170 | 1.57G | 9469146 |
| merged.raw | 342 | 527.43M | 1638539 |
| unmerged.raw | 170 | 1G | 6192068 |
| unmerged.trim | 170 | 1G | 6191858 |
| M1 | 342 | 512.38M | 1589725 |
| U1 | 170 | 518.87M | 3095929 |
| U2 | 166 | 481.36M | 3095929 |
| Us | 0 | 0 | 0 |
| M.cor | 178 | 1.51G | 9371308 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 237.6 | 248 | 40.5 | 10.90% |
| M.ihist.merge.txt | 321.9 | 323 | 81.7 | 34.61% |


## Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 4408.6 | 2161.7 | 50.97% | "105" | 1.22M | 147.89M | 121.43 | 0:09'32'' |
| Q25L60.R | 3976.4 | 2077.9 | 47.74% | "105" | 1.22M | 138.97M | 114.10 | 0:08'45'' |

## Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 3.06% | 2670 | 101.84K | 47 | 1024 | 23.96K | 106 | 9.0 | 1.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'32'' | 0:00'21'' |
| Q0L0X40P001 | 40.0 | 3.45% | 3866 | 103.33K | 38 | 900 | 21.62K | 103 | 10.0 | 1.0 | 3.0 | 19.5 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'21'' |
| Q0L0X80P000 | 80.0 | 3.84% | 6214 | 115.48K | 26 | 2013 | 23.83K | 61 | 18.0 | 1.0 | 5.0 | 31.5 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'20'' |
| Q0L0X80P001 | 80.0 | 4.87% | 8903 | 118.7K | 22 | 1682 | 26.94K | 71 | 19.0 | 1.0 | 5.3 | 33.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'20'' |
| Q0L0X120P000 | 120.0 | 4.14% | 23798 | 122.8K | 9 | 2783 | 14.72K | 34 | 28.0 | 2.5 | 6.8 | 53.2 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'21'' |
| Q0L0X120P001 | 120.0 | 5.28% | 19430 | 126.43K | 8 | 5052 | 14.61K | 43 | 28.0 | 6.0 | 3.3 | 56.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'20'' |
| Q0L0X160P000 | 160.0 | 3.88% | 26177 | 130.07K | 12 | 5076 | 20.81K | 44 | 38.0 | 30.0 | 3.0 | 76.0 | "31,41,51,61,71,81" | 0:01'04'' | 0:00'21'' |
| Q0L0X160P001 | 160.0 | 3.71% | 84481 | 130.16K | 10 | 4982 | 15.26K | 47 | 36.0 | 10.0 | 3.0 | 72.0 | "31,41,51,61,71,81" | 0:01'02'' | 0:00'21'' |
| Q0L0X240P000 | 240.0 | 3.23% | 16671 | 163.85K | 43 | 1186 | 37.59K | 109 | 49.0 | 43.0 | 3.0 | 98.0 | "31,41,51,61,71,81" | 0:01'22'' | 0:00'21'' |
| Q0L0X240P001 | 240.0 | 2.76% | 9356 | 164.18K | 46 | 1060 | 33.22K | 111 | 47.0 | 42.0 | 3.0 | 94.0 | "31,41,51,61,71,81" | 0:01'22'' | 0:00'21'' |
| Q0L0X320P000 | 320.0 | 3.38% | 1500 | 113.58K | 75 | 7554 | 179.76K | 213 | 11.0 | 5.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:01'44'' | 0:00'23'' |
| Q0L0X320P001 | 320.0 | 3.07% | 1614 | 126.01K | 78 | 12038 | 183.33K | 233 | 10.0 | 4.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:01'45'' | 0:00'25'' |
| Q25L60X40P000 | 40.0 | 3.59% | 2710 | 108.28K | 43 | 1091 | 21.94K | 117 | 10.0 | 1.0 | 3.0 | 19.5 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'20'' |
| Q25L60X40P001 | 40.0 | 3.44% | 2602 | 101.39K | 44 | 1100 | 29.57K | 103 | 10.0 | 1.0 | 3.0 | 19.5 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'19'' |
| Q25L60X80P000 | 80.0 | 5.32% | 6291 | 113.51K | 27 | 1257 | 39.26K | 94 | 19.0 | 1.0 | 5.3 | 33.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'20'' |
| Q25L60X80P001 | 80.0 | 4.74% | 5974 | 117.69K | 26 | 1155 | 22.74K | 82 | 19.0 | 1.0 | 5.3 | 33.0 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'20'' |
| Q25L60X120P000 | 120.0 | 3.61% | 22181 | 122.7K | 7 | 1441 | 11.89K | 29 | 29.0 | 3.0 | 6.7 | 57.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'22'' |
| Q25L60X120P001 | 120.0 | 4.46% | 15230 | 124.39K | 10 | 1861 | 13.71K | 43 | 29.0 | 2.0 | 7.7 | 52.5 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'22'' |
| Q25L60X160P000 | 160.0 | 3.14% | 22224 | 134.44K | 17 | 1123 | 13.19K | 47 | 38.0 | 32.0 | 3.0 | 76.0 | "31,41,51,61,71,81" | 0:00'58'' | 0:00'21'' |
| Q25L60X160P001 | 160.0 | 3.78% | 19454 | 128.31K | 12 | 1870 | 12.31K | 38 | 39.0 | 11.5 | 3.0 | 78.0 | "31,41,51,61,71,81" | 0:00'57'' | 0:00'20'' |
| Q25L60X240P000 | 240.0 | 3.19% | 6128 | 184.48K | 64 | 1129 | 39.78K | 150 | 45.0 | 39.0 | 3.0 | 90.0 | "31,41,51,61,71,81" | 0:01'22'' | 0:00'23'' |
| Q25L60X240P001 | 240.0 | 3.03% | 10701 | 177.94K | 57 | 1092 | 36.99K | 132 | 47.0 | 41.0 | 3.0 | 94.0 | "31,41,51,61,71,81" | 0:01'23'' | 0:00'22'' |
| Q25L60X320P000 | 320.0 | 3.23% | 1584 | 141.76K | 86 | 7555 | 175.59K | 238 | 10.0 | 4.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:01'48'' | 0:00'23'' |
| Q25L60X320P001 | 320.0 | 3.22% | 1666 | 132.15K | 80 | 6905 | 181.2K | 232 | 11.0 | 5.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:01'44'' | 0:00'23'' |

## Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 4.52% | 26385 | 130.89K | 14 | 1237 | 34.79K | 47 | 21.0 | 17.0 | 3.0 | 42.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'22'' |
| MRX40P001 | 40.0 | 4.95% | 32266 | 132.05K | 17 | 1210 | 38.23K | 59 | 20.0 | 16.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'22'' |
| MRX80P000 | 80.0 | 5.00% | 1404 | 92.88K | 61 | 2268 | 277.76K | 225 | 6.0 | 2.0 | 3.0 | 12.0 | "31,41,51,61,71,81" | 0:00'41'' | 0:00'20'' |
| MRX80P001 | 80.0 | 4.95% | 1494 | 110.22K | 72 | 3207 | 256.89K | 228 | 6.0 | 2.0 | 3.0 | 12.0 | "31,41,51,61,71,81" | 0:00'42'' | 0:00'20'' |
| MRX120P000 | 120.0 | 5.27% | 2294 | 258.66K | 122 | 1858 | 262.64K | 349 | 7.0 | 2.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'21'' |
| MRX120P001 | 120.0 | 5.28% | 2440 | 253.58K | 113 | 2346 | 257.71K | 321 | 7.0 | 2.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:00'48'' | 0:00'22'' |
| MRX160P000 | 160.0 | 5.44% | 3948 | 330.36K | 109 | 2195 | 256.32K | 349 | 8.0 | 2.0 | 3.0 | 16.0 | "31,41,51,61,71,81" | 0:00'55'' | 0:00'22'' |
| MRX160P001 | 160.0 | 5.99% | 4794 | 341.82K | 107 | 6134 | 245.33K | 326 | 9.0 | 3.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'56'' | 0:00'22'' |
| MRX240P000 | 240.0 | 5.67% | 7713 | 394.93K | 88 | 2408 | 263.84K | 335 | 12.0 | 6.0 | 3.0 | 24.0 | "31,41,51,61,71,81" | 0:01'07'' | 0:00'23'' |
| MRX240P001 | 240.0 | 5.75% | 10278 | 411.15K | 100 | 3279 | 251.36K | 349 | 12.0 | 7.0 | 3.0 | 24.0 | "31,41,51,61,71,81" | 0:01'08'' | 0:00'24'' |
| MRX320P000 | 320.0 | 5.53% | 8101 | 436.24K | 113 | 1665 | 283.29K | 370 | 15.0 | 9.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 0:01'28'' | 0:00'25'' |
| MRX320P001 | 320.0 | 5.34% | 9866 | 426.88K | 115 | 1553 | 270.43K | 352 | 14.0 | 9.0 | 3.0 | 28.0 | "31,41,51,61,71,81" | 0:01'28'' | 0:00'25'' |

## Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 12191 | 836.58K | 265 | 1152 | 1.02M | 853 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 12191 | 826.08K | 259 | 1169 | 1.05M | 818 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 2404 | 611.2K | 268 | 1125 | 347.5K | 292 | 0.0 | 0.0 | 0.0 | 0.0 |  |

## Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 7.27% | 1139 | 129.25K | 111 | 1945 | 14.81M | 7850 | 5.0 | 2.0 | 3.0 | 10.0 | 0:01'22'' |
| 8_spades_MR | 16.28% | 1393 | 1.45M | 1025 | 2121 | 8.02M | 5059 | 9.0 | 5.0 | 3.0 | 18.0 | 0:00'57'' |
| 8_megahit | 4.30% | 1148 | 64.41K | 55 | 1472 | 4.96M | 3113 | 5.0 | 2.0 | 3.0 | 10.0 | 0:00'58'' |
| 8_megahit_MR | 10.00% | 1184 | 501.47K | 411 | 1356 | 7.62M | 5781 | 7.0 | 3.0 | 3.0 | 14.0 | 0:00'54'' |
| 8_platanus | 1.04% | 1468 | 9.94K | 7 | 2225 | 23.29K | 17 | 571.0 | 220.5 | 3.0 | 1142.0 | 0:00'43'' |

## Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| 7_mergeAnchors.anchors | 12191 | 836580 | 265 |
| 7_mergeAnchors.others | 1152 | 1024927 | 853 |
| anchorLong | 16782 | 816343 | 240 |
| anchorFill | 48523 | 814997 | 198 |
| spades.contig | 335 | 59810140 | 208197 |
| spades.scaffold | 339 | 59819804 | 207467 |
| spades.non-contained | 1969 | 14938380 | 7739 |
| spades_MR.contig | 1468 | 15714838 | 27238 |
| spades_MR.scaffold | 1477 | 15718249 | 27185 |
| spades_MR.non-contained | 2514 | 9470828 | 4038 |
| megahit.contig | 398 | 47257359 | 118631 |
| megahit.non-contained | 1491 | 5019922 | 3058 |
| megahit_MR.contig | 494 | 54121719 | 111878 |
| megahit_MR.non-contained | 1409 | 8123213 | 5373 |
| platanus.contig | 164 | 825654 | 4493 |
| platanus.scaffold | 159 | 761452 | 4358 |
| platanus.non-contained | 2225 | 33225 | 16 |

## Table: statBUSCO.md

| File | C | S | D | F | M | Total |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 7_mergeKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeTadpoleAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRTadpoleAnchors | 0 | 0 | 0 | 1 | 1439 | 1440 |
| 7_mergeAnchors | 0 | 0 | 0 | 1 | 1439 | 1440 |
| 7_anchorLong | 0 | 0 | 0 | 1 | 1439 | 1440 |
| 7_anchorFill | 0 | 0 | 0 | 1 | 1439 | 1440 |
| 8_spades | 4 | 2 | 2 | 14 | 1422 | 1440 |
| 8_spades_MR | 4 | 4 | 0 | 5 | 1431 | 1440 |
| 8_megahit | 3 | 3 | 0 | 8 | 1429 | 1440 |
| 8_megahit_MR | 3 | 3 | 0 | 6 | 1431 | 1440 |
| 8_platanus | 0 | 0 | 0 | 0 | 1440 | 1440 |


---
# BD280
## 进行组装
```bash
WORKING_DIR=~/stq/data/anchr/our_sequence/Lens_culinaris
BASE_NAME=BD280_L1_335335
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 4 --cutk 31" \
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

## BUSCO评估
```bash
# 使用process_busco.sh来进行评估
bsub -q mpi -n 24 -J "BD280 BUSCO" "
  bash 9_busco.sh
"
```

## 合并结果
```bash
bash combine_md.sh
```

## 统计表格
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 397.8 | 402 | 445.0 | 0.80% |
| R.tadpole.bbtools | 377.4 | 399 | 69.9 | 1.65% |
| R.genome.picard | 392.8 | 402 | 45.0 | FR |
| R.tadpole.picard | 375.8 | 398 | 69.4 | FR |

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 123096 | 123096 | 1 |
| Illumina.R | 150 | 6.98G | 46560428 |
| trim.R | 150 | 5.7G | 38279936 |
| Q25L60 | 150 | 5.57G | 37626773 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 150 | 6.53G | 43562152 |
| highpass | 150 | 5.77G | 38443116 |
| trim | 150 | 5.7G | 38279950 |
| filter | 150 | 5.7G | 38279936 |
| R1 | 150 | 2.86G | 19139968 |
| R2 | 150 | 2.84G | 19139968 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	95323	0.24796%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	7	0.00002%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	807915198
#main_peak	889
#genome_size	497584
#haploid_genome_size	497584
#fold_coverage	619
#haploid_fold_coverage	619
#ploidy	1
#percent_repeat	96.700
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 150 | 5.7G | 38272186 |
| ecco | 150 | 5.7G | 38272186 |
| eccc | 150 | 5.7G | 38272186 |
| ecct | 150 | 1.62G | 10876526 |
| extended | 170 | 1.85G | 10876526 |
| merged.raw | 433 | 514.28M | 1283465 |
| unmerged.raw | 170 | 1.38G | 8309596 |
| unmerged.trim | 170 | 1.38G | 8309478 |
| M1 | 432 | 472.1M | 1183997 |
| U1 | 170 | 693.56M | 4154739 |
| U2 | 170 | 689.79M | 4154739 |
| Us | 0 | 0 | 0 |
| M.cor | 172 | 1.86G | 10677472 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 218.6 | 227 | 48.2 | 2.71% |
| M.ihist.merge.txt | 400.7 | 428 | 79.0 | 23.60% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 5701.4 | 3015.5 | 47.11% | "105" | 1M | 177.17M | 177.17 | 0:10'08'' |
| Q25L60.R | 5573.4 | 3001.2 | 46.15% | "105" | 1M | 175.36M | 175.36 | 0:09'55'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 3.59% | 1744 | 39.23K | 24 | 1903 | 37.6K | 59 | 12.0 | 4.0 | 3.0 | 24.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'20'' |
| Q0L0X40P001 | 40.0 | 4.21% | 1809 | 42.82K | 25 | 1214 | 29.74K | 60 | 14.0 | 5.0 | 3.0 | 28.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'20'' |
| Q0L0X80P000 | 80.0 | 4.94% | 1876 | 60.65K | 33 | 1427 | 53.11K | 86 | 19.0 | 7.5 | 3.0 | 38.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'19'' |
| Q0L0X80P001 | 80.0 | 4.53% | 1806 | 58.64K | 33 | 2513 | 57.03K | 88 | 18.0 | 8.0 | 3.0 | 36.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'19'' |
| Q0L0X120P000 | 120.0 | 5.15% | 1801 | 69.35K | 40 | 1776 | 61.98K | 106 | 25.0 | 10.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'20'' |
| Q0L0X120P001 | 120.0 | 5.22% | 1994 | 64.99K | 35 | 2029 | 73.94K | 100 | 22.0 | 9.0 | 3.0 | 44.0 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'20'' |
| Q0L0X160P000 | 160.0 | 4.93% | 1878 | 69.89K | 41 | 2020 | 90.14K | 113 | 26.0 | 16.0 | 3.0 | 52.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'20'' |
| Q0L0X160P001 | 160.0 | 4.38% | 1485 | 67.32K | 42 | 1984 | 82.05K | 109 | 24.0 | 15.0 | 3.0 | 48.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'21'' |
| Q0L0X240P000 | 240.0 | 5.37% | 1351 | 85.23K | 59 | 3120 | 161.24K | 172 | 19.0 | 13.5 | 3.0 | 38.0 | "31,41,51,61,71,81" | 0:01'12'' | 0:00'21'' |
| Q0L0X240P001 | 240.0 | 5.49% | 1506 | 88.73K | 58 | 2503 | 137.58K | 165 | 24.0 | 18.0 | 3.0 | 48.0 | "31,41,51,61,71,81" | 0:01'14'' | 0:00'21'' |
| Q0L0X320P000 | 320.0 | 6.02% | 1723 | 139.74K | 82 | 4685 | 226.22K | 243 | 13.0 | 7.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:01'31'' | 0:00'22'' |
| Q0L0X320P001 | 320.0 | 5.84% | 1493 | 124.9K | 76 | 4536 | 216.42K | 241 | 13.0 | 7.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:01'28'' | 0:00'23'' |
| Q25L60X40P000 | 40.0 | 3.48% | 1947 | 35.56K | 19 | 1492 | 33.41K | 49 | 13.0 | 4.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:00'27'' | 0:00'19'' |
| Q25L60X40P001 | 40.0 | 4.11% | 1951 | 41.73K | 24 | 2883 | 37.4K | 62 | 12.0 | 4.0 | 3.0 | 24.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'19'' |
| Q25L60X80P000 | 80.0 | 4.49% | 1745 | 58.17K | 33 | 1848 | 52.05K | 92 | 18.0 | 5.0 | 3.0 | 36.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'20'' |
| Q25L60X80P001 | 80.0 | 4.78% | 1853 | 63.84K | 35 | 2634 | 52.37K | 83 | 19.0 | 7.5 | 3.0 | 38.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'20'' |
| Q25L60X120P000 | 120.0 | 5.32% | 2208 | 68.07K | 34 | 1965 | 69.95K | 100 | 25.0 | 9.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'21'' |
| Q25L60X120P001 | 120.0 | 4.92% | 2190 | 71.11K | 36 | 2101 | 58.31K | 92 | 25.0 | 11.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'46'' | 0:00'21'' |
| Q25L60X160P000 | 160.0 | 5.01% | 2108 | 71.56K | 38 | 1894 | 83.44K | 112 | 28.0 | 15.0 | 3.0 | 56.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'21'' |
| Q25L60X160P001 | 160.0 | 5.69% | 1924 | 78.18K | 43 | 2082 | 88.33K | 111 | 29.0 | 12.0 | 3.0 | 58.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'21'' |
| Q25L60X240P000 | 240.0 | 6.21% | 1471 | 105.8K | 69 | 2659 | 146.82K | 185 | 27.0 | 21.0 | 3.0 | 54.0 | "31,41,51,61,71,81" | 0:01'11'' | 0:00'22'' |
| Q25L60X240P001 | 240.0 | 5.40% | 1533 | 101.34K | 65 | 3213 | 145.3K | 167 | 25.0 | 19.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:01'14'' | 0:00'22'' |
| Q25L60X320P000 | 320.0 | 6.26% | 1621 | 131.72K | 82 | 5490 | 226.86K | 241 | 14.0 | 8.0 | 3.0 | 28.0 | "31,41,51,61,71,81" | 0:01'30'' | 0:00'24'' |
| Q25L60X320P001 | 320.0 | 6.01% | 1573 | 130.4K | 78 | 3722 | 234.79K | 262 | 13.0 | 7.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:01'30'' | 0:00'23'' |

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 5.45% | 1506 | 41.11K | 25 | 1937 | 142.8K | 106 | 11.0 | 8.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'20'' |
| MRX40P001 | 40.0 | 5.37% | 1561 | 43.99K | 29 | 2037 | 140.67K | 107 | 10.0 | 7.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:00'29'' | 0:00'20'' |
| MRX80P000 | 80.0 | 5.99% | 1567 | 109.2K | 68 | 2547 | 249.31K | 223 | 7.0 | 3.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:00'36'' | 0:00'20'' |
| MRX80P001 | 80.0 | 6.84% | 1783 | 113.88K | 68 | 2391 | 268.37K | 235 | 7.0 | 3.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'19'' |
| MRX120P000 | 120.0 | 6.26% | 2501 | 223.99K | 102 | 2678 | 266.96K | 283 | 8.0 | 3.0 | 3.0 | 16.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'21'' |
| MRX120P001 | 120.0 | 6.28% | 2057 | 227.04K | 112 | 3991 | 249.33K | 286 | 8.0 | 3.0 | 3.0 | 16.0 | "31,41,51,61,71,81" | 0:00'43'' | 0:00'21'' |
| MRX160P000 | 160.0 | 6.48% | 3170 | 283.36K | 112 | 5257 | 251.77K | 285 | 9.0 | 3.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'23'' |
| MRX160P001 | 160.0 | 6.13% | 3020 | 286.45K | 108 | 4694 | 215.26K | 257 | 10.0 | 4.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'21'' |
| MRX240P000 | 240.0 | 6.21% | 5641 | 322.77K | 79 | 5257 | 229.42K | 217 | 13.0 | 6.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:01'02'' | 0:00'23'' |
| MRX240P001 | 240.0 | 6.04% | 4351 | 326.82K | 90 | 4676 | 222.72K | 239 | 13.0 | 5.5 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:01'02'' | 0:00'22'' |
| MRX320P000 | 320.0 | 6.20% | 5247 | 347.16K | 98 | 4480 | 248.78K | 260 | 16.0 | 9.0 | 3.0 | 32.0 | "31,41,51,61,71,81" | 0:01'11'' | 0:00'24'' |
| MRX320P001 | 320.0 | 6.54% | 6014 | 339.43K | 80 | 5163 | 268.32K | 238 | 16.0 | 11.0 | 3.0 | 32.0 | "31,41,51,61,71,81" | 0:01'10'' | 0:00'24'' |

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 9787 | 685.64K | 207 | 1492 | 1.38M | 731 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 10984 | 612.2K | 186 | 1516 | 1.33M | 687 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 2868 | 544.46K | 239 | 3755 | 1.65M | 660 | 0.0 | 0.0 | 0.0 | 0.0 |  |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 7.85% | 1050 | 14.05K | 13 | 1663 | 13.58M | 7909 | 4.0 | 1.0 | 3.0 | 8.0 | 0:01'22'' |
| 8_spades_MR | 14.63% | 1295 | 871.07K | 654 | 1895 | 6.38M | 4121 | 10.0 | 5.0 | 3.0 | 20.0 | 0:00'56'' |
| 8_megahit | 5.95% | 1120 | 45.82K | 40 | 1348 | 4.2M | 2818 | 5.0 | 2.0 | 3.0 | 10.0 | 0:00'57'' |
| 8_megahit_MR | 9.39% | 1150 | 193.78K | 163 | 1303 | 5.64M | 4170 | 7.0 | 3.0 | 3.0 | 14.0 | 0:00'51'' |
| 8_platanus | 3.43% | 2483 | 45.15K | 21 | 3848 | 20.3K | 22 | 955.0 | 328.5 | 3.0 | 1910.0 | 0:00'47'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 123096 | 123096 | 1 |
| 7_mergeAnchors.anchors | 9787 | 685637 | 207 |
| 7_mergeAnchors.others | 1492 | 1375053 | 731 |
| anchorLong | 17318 | 651210 | 160 |
| anchorFill | 49144 | 648607 | 118 |
| spades.contig | 330 | 75938288 | 272702 |
| spades.scaffold | 350 | 76027075 | 269619 |
| spades.non-contained | 1667 | 13589362 | 7896 |
| spades_MR.contig | 1312 | 11877244 | 13070 |
| spades_MR.scaffold | 1324 | 11879643 | 13032 |
| spades_MR.non-contained | 2138 | 7250631 | 3479 |
| megahit.contig | 441 | 51756331 | 124476 |
| megahit.non-contained | 1363 | 4243987 | 2778 |
| megahit_MR.contig | 541 | 43614931 | 84334 |
| megahit_MR.non-contained | 1321 | 5838143 | 4013 |
| platanus.contig | 155 | 1213830 | 7035 |
| platanus.scaffold | 263 | 174862 | 712 |
| platanus.non-contained | 2789 | 65454 | 24 |

### Table: statBUSCO.md

| File | C | S | D | F | M | Total |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 7_mergeKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeTadpoleAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRTadpoleAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_anchorLong | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_anchorFill | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 8_spades | 20 | 18 | 2 | 13 | 1407 | 1440 |
| 8_spades_MR | 7 | 7 | 0 | 7 | 1426 | 1440 |
| 8_megahit | 22 | 21 | 1 | 6 | 1412 | 1440 |
| 8_megahit_MR | 2 | 2 | 0 | 5 | 1433 | 1440 |
| 8_platanus | 0 | 0 | 0 | 0 | 1440 | 1440 |

---
# BD308
```bash
WORKING_DIR=~/stq/data/anchr/our_sequence/Lens_culinaris
BASE_NAME=BD308_L1_336336
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 4 --cutk 31" \
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
```

# BD310
```bash
WORKING_DIR=~/stq/data/anchr/our_sequence/Lens_culinaris
BASE_NAME=BD310_L1_344344
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 4 --cutk 31" \
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
    
 # 提交任务
 bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

# BD312
```bash
WORKING_DIR=~/stq/data/anchr/our_sequence/Lens_culinaris
BASE_NAME=BD312_L1_337337
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 4 --cutk 31" \
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
    
 # 提交任务
 bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
