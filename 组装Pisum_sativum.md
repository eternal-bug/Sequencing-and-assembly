# Pisum_sativum[豌豆]
> [《基于流式细胞术的芒果基因组c值测定》](http://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CJFQ&dbname=CJFDLAST2015&filename=RDZX201509014&uid=WEEvREdxOWJmbC9oM1NjYkZCbDZZNTBLeGp2MUFHclRDVGZSYmhNRytCT1c=$R1yZ0H6jyaa0en3RxVUd8df-oHi7XMMDo7mtKT6mSmEvTuk11l2gFA!!&v=MjU0MzRublY3N0pOeW5SZHJHNEg5VE1wbzlFWUlSOGVYMUx1eFlTN0RoMVQzcVRyV00xRnJDVVJMS2ZiK1Z1Rnk=)

+ 1pg = 0.978Gb

> [《De Novo Assembly of the Pea (Pisum sativum L.) Nodule Transcriptome》](https://www.hindawi.com/journals/ijg/2015/695947/)

> [流式细胞术测定的植物基因组大小-kew](http://data.kew.org/cvalues/CvalServlet?querytype=1)

+ 4.88pg(1C)

| item | number |
| -- | -- |
| flow cytometry | 4.88pg(1C) |
| genome | 4.88 * 0.978 = 4772Mb |
| [chloroplast genome](https://www.ncbi.nlm.nih.gov/nuccore/MG859922.1) | 122198 bp |

## 品系
+ G06
+ G211
+ G2853
+ G47
+ G543
+ G883

## 通过fastqc的结果计算得到总的核酸量或者用statistic_fastq_size.sh脚本统计
| file | Gb.size | Mb.size | Kb.size |
| ---  | ---     | ---     | ---     |
| G06_L1_338338.R1.fastq.gz | 5 | 5247 | 5247487 |
| G06_L1_338338.R2.fastq.gz | 5 | 5247 | 5247487 |
| G211_L1_340340.R1.fastq.gz | 4 | 4837 | 4837078 |
| G211_L1_340340.R2.fastq.gz | 4 | 4837 | 4837078 |
| G2853_L1_343343.R1.fastq.gz | 4 | 4336 | 4336699 |
| G2853_L1_343343.R2.fastq.gz | 4 | 4336 | 4336699 |
| G47_L1_339339.R1.fastq.gz | 5 | 5258 | 5258244 |
| G47_L1_339339.R2.fastq.gz | 5 | 5258 | 5258244 |
| G543_L1_341341.R1.fastq.gz | 4 | 4960 | 4960699 |
| G543_L1_341341.R2.fastq.gz | 4 | 4960 | 4960699 |
| G883_L1_342342.R1.fastq.gz | 4 | 4752 | 4752177 |
| G883_L1_342342.R2.fastq.gz | 4 | 4752 | 4752177 |

## 新建工作区
```bash
cd ~/stq/data/anchr/our_sequence
mkdir -p ../Pisum_sativum/seuqence_data
mkdir -p ../Pisum_sativum/genome
mv ./raw/G* ../Pisum_sativum/seuqence_data
```

## 下载基因组文件
在NCBI的核酸库中搜索`Pisum sativum plastid,complete genome`
得到信息
+ GenBank: MG859922.1
+ [Pisum sativum subsp. elatius isolate CE1 chloroplast, complete genome](https://www.ncbi.nlm.nih.gov/nuccore/MG859922.1)
使用浏览器下载之后上传到超算
```
mv sequence.fasta genome.fa
rsync -avP \
./genome.fa \
wangq@202.119.37.251:stq/data/anchr/our_sequence/Pisum_sativum/genome
```

## 建立文件链接
```bash
cd ~/stq/data/anchr/our_sequence/Pisum_sativum/
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
# G06

## 进行组装
```bash
WORKING_DIR=~/stq/data/anchr/our_sequence/Pisum_sativum
BASE_NAME=G06_L1_338338
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
    --trim2 "--dedupe --cutoff 8 --cutk 31" \
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
```
bash process_busco.sh
```

## 合并md统计结果
```bash
combine_md.sh
```

## 统计结果
## Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 432.9 | 406 | 1102.4 | 1.46% |
| R.tadpole.bbtools | 390.7 | 402 | 53.5 | 2.09% |
| R.genome.picard | 401.7 | 406 | 35.8 | FR |
| R.tadpole.picard | 389.7 | 402 | 53.7 | FR |

## Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 122198 | 122198 | 1 |
| Illumina.R | 150 | 10.49G | 69966506 |
| trim.R | 150 | 7.54G | 50574976 |
| Q25L60 | 150 | 7.4G | 49855455 |

## Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 150 | 9.76G | 65071662 |
| highpass | 150 | 7.61G | 50745546 |
| trim | 150 | 7.54G | 50574990 |
| filter | 150 | 7.54G | 50574976 |
| R1 | 150 | 3.78G | 25287488 |
| R2 | 150 | 3.76G | 25287488 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	90046	0.17745%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	7	0.00001%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	774656306
#main_peak	1468
#genome_size	2006689
#haploid_genome_size	1003344
#fold_coverage	584
#haploid_fold_coverage	1003
#ploidy	2
#het_rate	0.00844
#percent_repeat	51.154
#start	center	stop	max	volume
```



## Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 150 | 7.54G | 50564482 |
| ecco | 150 | 7.54G | 50564482 |
| eccc | 150 | 7.54G | 50564482 |
| ecct | 150 | 2.82G | 18890176 |
| extended | 175 | 3.28G | 18890176 |
| merged.raw | 438 | 1.03G | 2451905 |
| unmerged.raw | 170 | 2.37G | 13986366 |
| unmerged.trim | 170 | 2.37G | 13986296 |
| M1 | 437 | 952.37M | 2268851 |
| U1 | 170 | 1.19G | 6993148 |
| U2 | 170 | 1.18G | 6993148 |
| Us | 0 | 0 | 0 |
| M.cor | 178 | 3.33G | 18523998 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 212.8 | 225 | 55.3 | 1.23% |
| M.ihist.merge.txt | 420.4 | 435 | 61.3 | 25.96% |


## Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 7542.0 | 4609.7 | 38.88% | "105" | 1M | 184.37M | 184.37 | 0:13'12'' |
| Q25L60.R | 7398.6 | 4590.0 | 37.96% | "105" | 1M | 182.4M | 182.40 | 0:12'59'' |

## Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 6.98% | 4865 | 105.91K | 29 | 2056 | 34.92K | 73 | 15.0 | 2.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'21'' |
| Q0L0X40P001 | 40.0 | 6.59% | 4614 | 105.97K | 29 | 1405 | 26.4K | 76 | 15.0 | 2.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 0:00'29'' | 0:00'21'' |
| Q0L0X80P000 | 80.0 | 8.26% | 7866 | 112.87K | 20 | 1451 | 18.8K | 54 | 31.0 | 4.0 | 6.3 | 62.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'20'' |
| Q0L0X80P001 | 80.0 | 7.25% | 3653 | 83.27K | 27 | 1962 | 55.59K | 58 | 29.0 | 1.0 | 8.7 | 48.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'18'' |
| Q0L0X120P000 | 120.0 | 8.19% | 9738 | 110.58K | 15 | 1451 | 22.03K | 50 | 47.0 | 6.0 | 9.7 | 94.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'20'' |
| Q0L0X120P001 | 120.0 | 7.86% | 7354 | 113.67K | 20 | 1123 | 20.47K | 56 | 48.0 | 7.0 | 9.0 | 96.0 | "31,41,51,61,71,81" | 0:00'46'' | 0:00'20'' |
| Q0L0X160P000 | 160.0 | 8.13% | 9993 | 116.51K | 18 | 1337 | 23.94K | 62 | 61.0 | 19.5 | 3.0 | 122.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'20'' |
| Q0L0X160P001 | 160.0 | 6.77% | 8453 | 114.22K | 20 | 1546 | 20.99K | 50 | 62.0 | 9.0 | 11.7 | 124.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'20'' |
| Q0L0X240P000 | 240.0 | 7.55% | 5872 | 132.9K | 42 | 1218 | 43.03K | 115 | 83.0 | 76.0 | 3.0 | 166.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:00'21'' |
| Q0L0X240P001 | 240.0 | 6.90% | 6011 | 133.26K | 40 | 1294 | 39.71K | 104 | 85.0 | 79.0 | 3.0 | 170.0 | "31,41,51,61,71,81" | 0:01'11'' | 0:00'21'' |
| Q0L0X320P000 | 320.0 | 8.06% | 2423 | 161.32K | 78 | 1285 | 86.54K | 206 | 90.0 | 84.0 | 3.0 | 180.0 | "31,41,51,61,71,81" | 0:01'23'' | 0:00'22'' |
| Q0L0X320P001 | 320.0 | 7.43% | 1333 | 100.35K | 74 | 4259 | 201.73K | 228 | 48.0 | 43.0 | 3.0 | 96.0 | "31,41,51,61,71,81" | 0:01'22'' | 0:00'25'' |
| Q25L60X40P000 | 40.0 | 7.51% | 5139 | 104.37K | 27 | 1633 | 25.93K | 69 | 15.0 | 2.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'20'' |
| Q25L60X40P001 | 40.0 | 7.91% | 6769 | 111.17K | 27 | 3040 | 20.26K | 79 | 16.0 | 3.0 | 3.0 | 32.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'19'' |
| Q25L60X80P000 | 80.0 | 8.89% | 11191 | 119.86K | 17 | 1451 | 19.29K | 52 | 33.0 | 8.0 | 3.0 | 66.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'20'' |
| Q25L60X80P001 | 80.0 | 7.52% | 8497 | 112.28K | 18 | 1451 | 19.85K | 57 | 31.0 | 6.0 | 4.3 | 62.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'20'' |
| Q25L60X120P000 | 120.0 | 7.21% | 11084 | 116.46K | 18 | 1355 | 15.22K | 49 | 48.0 | 10.0 | 6.0 | 96.0 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'20'' |
| Q25L60X120P001 | 120.0 | 8.64% | 9043 | 114.88K | 18 | 1117 | 23K | 60 | 47.0 | 7.5 | 8.2 | 94.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'19'' |
| Q25L60X160P000 | 160.0 | 6.47% | 7938 | 119.85K | 26 | 1355 | 21.39K | 66 | 60.0 | 27.0 | 3.0 | 120.0 | "31,41,51,61,71,81" | 0:00'52'' | 0:00'21'' |
| Q25L60X160P001 | 160.0 | 8.15% | 10571 | 112.7K | 14 | 1451 | 24.09K | 56 | 63.0 | 11.0 | 10.0 | 126.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'20'' |
| Q25L60X240P000 | 240.0 | 7.34% | 5513 | 136.07K | 43 | 1327 | 34.35K | 115 | 85.0 | 74.0 | 3.0 | 170.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:00'21'' |
| Q25L60X240P001 | 240.0 | 7.30% | 4056 | 130.2K | 46 | 1294 | 53.03K | 129 | 81.0 | 72.0 | 3.0 | 162.0 | "31,41,51,61,71,81" | 0:01'10'' | 0:00'21'' |
| Q25L60X320P000 | 320.0 | 8.31% | 1773 | 159.51K | 87 | 1378 | 108.78K | 231 | 86.0 | 80.0 | 3.0 | 172.0 | "31,41,51,61,71,81" | 0:01'20'' | 0:00'22'' |
| Q25L60X320P001 | 320.0 | 8.06% | 1494 | 131.93K | 89 | 1672 | 164.14K | 257 | 72.0 | 66.0 | 3.0 | 144.0 | "31,41,51,61,71,81" | 0:01'22'' | 0:00'22'' |

## Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 6.87% | 11091 | 118.72K | 26 | 1162 | 36.85K | 65 | 31.0 | 23.5 | 3.0 | 62.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'22'' |
| MRX40P001 | 40.0 | 8.05% | 10821 | 119.07K | 17 | 1447 | 35.69K | 53 | 35.0 | 23.0 | 3.0 | 70.0 | "31,41,51,61,71,81" | 0:00'29'' | 0:00'22'' |
| MRX80P000 | 80.0 | 7.16% | 1285 | 40.1K | 29 | 5391 | 260.35K | 158 | 11.0 | 8.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:00'19'' |
| MRX80P001 | 80.0 | 8.62% | 1289 | 59.69K | 44 | 4078 | 270.87K | 174 | 29.0 | 26.0 | 3.0 | 58.0 | "31,41,51,61,71,81" | 0:00'36'' | 0:00'21'' |
| MRX120P000 | 120.0 | 7.26% | 1533 | 127.28K | 81 | 1917 | 339.84K | 292 | 6.0 | 2.0 | 3.0 | 12.0 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'22'' |
| MRX120P001 | 120.0 | 7.54% | 1671 | 153.54K | 93 | 1836 | 334.36K | 310 | 6.0 | 2.0 | 3.0 | 12.0 | "31,41,51,61,71,81" | 0:00'43'' | 0:00'20'' |
| MRX160P000 | 160.0 | 7.33% | 2266 | 245.89K | 118 | 2101 | 306.87K | 350 | 7.0 | 2.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'21'' |
| MRX160P001 | 160.0 | 7.53% | 2429 | 247.45K | 115 | 1829 | 322.26K | 349 | 7.0 | 3.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:00'48'' | 0:00'22'' |
| MRX240P000 | 240.0 | 7.07% | 5621 | 362.33K | 96 | 1762 | 279.78K | 335 | 9.0 | 3.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'58'' | 0:00'28'' |
| MRX240P001 | 240.0 | 6.94% | 4393 | 351.63K | 106 | 1850 | 274.56K | 322 | 9.0 | 3.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'59'' | 0:00'24'' |
| MRX320P000 | 320.0 | 7.03% | 10077 | 389.23K | 83 | 1494 | 294.4K | 311 | 11.0 | 6.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:01'08'' | 0:00'24'' |
| MRX320P001 | 320.0 | 7.02% | 5688 | 406.22K | 120 | 1698 | 285.18K | 349 | 11.0 | 6.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:00'25'' |

## Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 7346 | 1.07M | 352 | 1360 | 1.84M | 1341 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 7346 | 941.29K | 325 | 1281 | 1.57M | 1121 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 2831 | 878.04K | 374 | 1970 | 2.66M | 1393 | 0.0 | 0.0 | 0.0 | 0.0 |  |

## Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 9.87% | 1227 | 644.41K | 516 | 1862 | 10.96M | 6387 | 7.0 | 3.0 | 3.0 | 14.0 | 0:01'31'' |
| 8_spades_MR | 16.41% | 1344 | 2.59M | 1864 | 1559 | 8.66M | 8083 | 12.0 | 6.0 | 3.0 | 24.0 | 0:01'22'' |
| 8_megahit | 7.63% | 1240 | 289.02K | 230 | 1527 | 3.68M | 2506 | 7.0 | 2.0 | 3.0 | 14.0 | 0:01'14'' |
| 8_megahit_MR | 11.65% | 1223 | 870.61K | 686 | 1314 | 7.2M | 6098 | 9.0 | 4.0 | 3.0 | 18.0 | 0:01'09'' |
| 8_platanus | 6.97% | 5670 | 150.53K | 38 | 1419 | 66.55K | 67 | 1363.0 | 953.0 | 3.0 | 2726.0 | 0:01'03'' |

## Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 122198 | 122198 | 1 |
| 7_mergeAnchors.anchors | 7346 | 1067507 | 352 |
| 7_mergeAnchors.others | 1360 | 1839335 | 1341 |
| anchorLong | 9393 | 1026817 | 305 |
| anchorFill | 15988 | 996962 | 234 |
| spades.contig | 290 | 51860647 | 192011 |
| spades.scaffold | 296 | 51919122 | 190187 |
| spades.non-contained | 1978 | 11606478 | 5872 |
| spades_MR.contig | 228 | 52903062 | 214977 |
| spades_MR.scaffold | 228 | 52907017 | 214900 |
| spades_MR.non-contained | 1772 | 11251291 | 6246 |
| megahit.contig | 371 | 39298202 | 103501 |
| megahit.non-contained | 1622 | 3973150 | 2277 |
| megahit_MR.contig | 516 | 54715093 | 109198 |
| megahit_MR.non-contained | 1377 | 8071364 | 5433 |
| platanus.contig | 156 | 2146818 | 11721 |
| platanus.scaffold | 1393 | 383312 | 869 |
| platanus.non-contained | 121884 | 217080 | 47 |

## Table: statBUSCO.md

| File | C | S | D | F | M | Total |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 7_mergeKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeTadpoleAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRTadpoleAnchors | 2 | 2 | 0 | 0 | 1438 | 1440 |
| 7_mergeAnchors | 2 | 2 | 0 | 0 | 1438 | 1440 |
| 7_anchorLong | 2 | 2 | 0 | 0 | 1438 | 1440 |
| 7_anchorFill | 2 | 1 | 1 | 0 | 1438 | 1440 |
| 8_spades | 16 | 15 | 1 | 9 | 1415 | 1440 |
| 8_spades_MR | 9 | 8 | 1 | 2 | 1429 | 1440 |
| 8_megahit | 9 | 9 | 0 | 3 | 1428 | 1440 |
| 8_megahit_MR | 6 | 6 | 0 | 2 | 1432 | 1440 |
| 8_platanus | 0 | 0 | 0 | 0 | 1440 | 1440 |

# G211
