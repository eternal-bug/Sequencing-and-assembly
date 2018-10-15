# *Medicago truncatula*[蒺藜苜蓿]
+ Illumina HiSeq 2000
+ 测序方式: pair-end
+ 基因组 500M
+ Mt	271618
+ Pt	124033

# 文件信息
| type | file | size.Bp | coverage | insert | read.len |seq type | com | other |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| HM050 | SRR1034293 | 11,355,255,600 * 2 | ~45.2 | ~360 | 100 | HiSeq 2000 | p |
| HM340 | SRR1524305 | 16,611,812,400 * 2 | ~66 | ~150 | 100 | HiSeq 2000 | p | BAD!!!|
| A17 | SRR1542423 |  4,479,178,836 * 2 | ~18 | 150~400 | 151 | HiSeq 2000 | + |
| A17 | SRR965418  |  2,863,407,166 * 2 | ~11 | ~210 | 101 | HiSeq 2000 | - |
| A17 | SRR965430  | 7,874,692,452 * 2 | ~30 |  |  | HiSeq 2000 | - |
| HM022 | SRR2163426 | 12,271,924,800 * 2 | ~30 |  |  | HiSeq 2000 | p- | BAD!!!|
| HM056 | SRR1552478 | 20,468,900,300 * 2 | ~80 | ~160 |  | HiSeq 2000 | p- |
| A17 | SRR1664358 | 10,220,581,300 * 2 | ~40 | | | HiSeq 2000 | |
| A17 | SRR1542420 |
| A17 | SRR1542421 |
| A17 | SRR965432 |
| A17 | SRR965441 |
| A17 | SRR965443 |
| A17 | SRR965451 |


## 建立工作区以及文件链接

## SRR1034293
+ ~45.2覆盖度

**注**：按照之前的4倍计算似乎无法组装出来东西，所以将倍数调低

### 4倍
```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1034293
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
    --trim2 "--dedupe --cutoff 180 --cutk 31" \
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

### 8倍
```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1034293
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
    --trim2 "--dedupe --cutoff 360 --cutk 31" \
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

## SRR1524305
+ ~66

### 4倍
+ 这个倍数下组装的情况极差

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1524305
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
    --trim2 "--dedupe --cutoff 264 --cutk 31" \
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

### 8倍
```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1524305
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
    --trim2 "--dedupe --cutoff 528 --cutk 31" \
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

## SRR1542423
+ ~18

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1542423
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
    --trim2 "--dedupe --cutoff 72 --cutk 31" \
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

## 统计结果
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 314.7 | 343 | 692.7 | 2.26% |
| R.tadpole.bbtools | 285.2 | 326 | 89.6 | 16.03% |
| R.genome.picard | 307.1 | 345 | 79.8 | FR |
| R.tadpole.picard | 292.6 | 332 | 85.7 | FR |
| R.tadpole.picard | 155.6 | 156 | 19.2 | RF |

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 395651 | 2 |
| Illumina.R | 151 | 8.96G | 59326872 |
| trim.R | 139 | 2.43G | 18913594 |
| Q25L60 | 133 | 2.15G | 17602619 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 151 | 8.95G | 59247114 |
| highpass | 151 | 3.71G | 24543986 |
| trim | 139 | 2.43G | 18913598 |
| filter | 139 | 2.43G | 18913594 |
| R1 | 143 | 1.25G | 9456797 |
| R2 | 135 | 1.18G | 9456797 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	1317917	5.36961%
#Name	Reads	ReadsPct
pcr_dimer	608564	2.47948%
TruSeq_Adapter_Index_1_6	211005	0.85970%
PCR_Primers	133057	0.54212%
TruSeq_Universal_Adapter	116003	0.47263%
Nextera_LMP_Read2_External_Adapter	90371	0.36820%
Reverse_adapter	76890	0.31327%
PhiX_read1_adapter	74122	0.30200%
```

```text
#R.filter
#Matched	3	0.00002%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	120412246
#main_peak	738
#genome_size	462351
#haploid_genome_size	462351
#fold_coverage	466
#haploid_fold_coverage	466
#ploidy	1
#percent_repeat	92.944
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 139 | 2.43G | 18905200 |
| ecco | 139 | 2.42G | 18905200 |
| eccc | 139 | 2.42G | 18905200 |
| ecct | 138 | 1.49G | 11765128 |
| extended | 165 | 1.83G | 11765128 |
| merged.raw | 357 | 975.62M | 3676705 |
| unmerged.raw | 160 | 673.79M | 4411718 |
| unmerged.trim | 160 | 673.73M | 4411036 |
| M1 | 367 | 821.37M | 2870894 |
| U1 | 164 | 348.03M | 2205518 |
| U2 | 156 | 325.7M | 2205518 |
| Us | 0 | 0 | 0 |
| M.cor | 190 | 1.5G | 10152824 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 162.5 | 164 | 43.6 | 25.33% |
| M.ihist.merge.txt | 265.4 | 238 | 109.4 | 62.50% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 2431.2 | 1894.9 | 22.06% | "83" | 1M | 20.95M | 20.95 | 0:04'00'' |
| Q25L60.R | 2151.1 | 1775.1 | 17.48% | "77" | 1M | 17.79M | 17.79 | 0:03'42'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 16.23% | 2084 | 71.3K | 38 | 1745 | 66.69K | 125 | 21.0 | 6.0 | 3.0 | 42.0 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'20'' |
| Q0L0X40P001 | 40.0 | 14.02% | 1969 | 64.86K | 34 | 18




| 70.91K | 109 | 20.0 | 5.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'20'' |
| Q0L0X80P000 | 80.0 | 16.97% | 1402 | 93.56K | 63 | 1637 | 127.02K | 212 | 25.0 | 16.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'20'' |
| Q0L0X80P001 | 80.0 | 13.35% | 1445 | 79.05K | 49 | 2078 | 117.51K | 152 | 27.0 | 17.0 | 3.0 | 54.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'20'' |
| Q0L0X120P000 | 120.0 | 17.73% | 1467 | 127.89K | 85 | 2576 | 197.2K | 267 | 20.0 | 11.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'21'' |
| Q0L0X120P001 | 120.0 | 16.34% | 1647 | 125.71K | 78 | 2664 | 186.88K | 248 | 18.0 | 9.0 | 3.0 | 36.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'21'' |
| Q0L0X160P000 | 160.0 | 17.23% | 1812 | 179.2K | 102 | 2620 | 220.1K | 325 | 19.0 | 7.5 | 3.0 | 38.0 | "31,41,51,61,71,81" | 0:00'35'' | 0:00'22'' |
| Q0L0X160P001 | 160.0 | 17.59% | 2124 | 171.8K | 87 | 2458 | 221.44K | 282 | 20.0 | 8.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'36'' | 0:00'20'' |
| Q0L0X240P000 | 240.0 | 19.86% | 2603 | 220.98K | 100 | 2313 | 247.49K | 393 | 25.0 | 8.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'43'' | 0:00'22'' |
| Q0L0X240P001 | 240.0 | 19.00% | 2309 | 226.85K | 108 | 2896 | 250.99K | 384 | 25.0 | 9.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'23'' |
| Q0L0X320P000 | 320.0 | 18.70% | 2837 | 235.54K | 103 | 2463 | 262.32K | 383 | 32.0 | 11.0 | 3.0 | 64.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'23'' |
| Q0L0X320P001 | 320.0 | 20.35% | 2779 | 235.31K | 106 | 2267 | 258.17K | 400 | 31.0 | 9.0 | 3.0 | 62.0 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'23'' |
| Q25L60X40P000 | 40.0 | 18.01% | 2273 | 70.95K | 35 | 2669 | 65.5K | 104 | 23.0 | 7.0 | 3.0 | 46.0 | "31,41,51,61,71,81" | 0:00'20'' | 0:00'19'' |
| Q25L60X40P001 | 40.0 | 17.48% | 2299 | 76.15K | 37 | 2077 | 58.53K | 104 | 23.0 | 7.5 | 3.0 | 46.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'19'' |
| Q25L60X80P000 | 80.0 | 21.92% | 1435 | 103.65K | 69 | 2327 | 142.94K | 194 | 26.0 | 17.0 | 3.0 | 52.0 | "31,41,51,61,71,81" | 0:00'26'' | 0:00'20'' |
| Q25L60X80P001 | 80.0 | 18.22% | 1694 | 111.22K | 67 | 2202 | 129.91K | 187 | 32.0 | 23.0 | 3.0 | 64.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'20'' |
| Q25L60X120P000 | 120.0 | 20.10% | 1783 | 144.79K | 82 | 2936 | 193.71K | 244 | 21.0 | 11.0 | 3.0 | 42.0 | "31,41,51,61,71,81" | 0:00'32'' | 0:00'21'' |
| Q25L60X120P001 | 120.0 | 19.08% | 1752 | 152.7K | 90 | 3772 | 207.11K | 274 | 22.0 | 11.0 | 3.0 | 44.0 | "31,41,51,61,71,81" | 0:00'32'' | 0:00'20'' |
| Q25L60X160P000 | 160.0 | 20.90% | 2022 | 187.08K | 99 | 3252 | 220.86K | 299 | 21.0 | 8.0 | 3.0 | 42.0 | "31,41,51,61,71,81" | 0:00'35'' | 0:00'22'' |
| Q25L60X160P001 | 160.0 | 18.67% | 1979 | 192.38K | 102 | 3762 | 240.46K | 327 | 22.0 | 9.0 | 3.0 | 44.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'21'' |
| Q25L60X240P000 | 240.0 | 24.77% | 2387 | 226.81K | 107 | 3046 | 250.17K | 375 | 28.0 | 9.0 | 3.0 | 56.0 | "31,41,51,61,71,81" | 0:00'41'' | 0:00'22'' |
| Q25L60X240P001 | 240.0 | 17.84% | 2641 | 211.87K | 87 | 2126 | 239.59K | 351 | 26.0 | 8.0 | 3.0 | 52.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'23'' |
| Q25L60X320P000 | 320.0 | 21.64% | 2389 | 248.96K | 118 | 2889 | 238.26K | 401 | 35.0 | 10.5 | 3.0 | 70.0 | "31,41,51,61,71,81" | 0:00'46'' | 0:00'23'' |
| Q25L60X320P001 | 320.0 | 19.23% | 3115 | 231.45K | 92 | 2501 | 244.91K | 368 | 35.0 | 10.0 | 3.0 | 70.0 | "31,41,51,61,71,81" | 0:00'47'' | 0:00'24'' |

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 23.56% | 2440 | 194.71K | 87 | 3077 | 218.06K | 241 | 10.0 | 4.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'22'' |
| MRX40P001 | 40.0 | 23.80% | 2749 | 172.26K | 76 | 3757 | 214.48K | 223 | 10.0 | 4.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'22'' |
| MRX80P000 | 80.0 | 25.91% | 5971 | 265.21K | 76 | 5591 | 196.9K | 240 | 17.0 | 7.0 | 3.0 | 34.0 | "31,41,51,61,71,81" | 0:00'25'' | 0:00'21'' |
| MRX80P001 | 80.0 | 23.42% | 4768 | 256.69K | 80 | 4879 | 173.45K | 213 | 17.0 | 6.0 | 3.0 | 34.0 | "31,41,51,61,71,81" | 0:00'25'' | 0:00'20'' |
| MRX120P000 | 120.0 | 24.83% | 4954 | 281.28K | 76 | 4871 | 174.75K | 204 | 25.0 | 13.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'27'' | 0:00'21'' |
| MRX120P001 | 120.0 | 24.86% | 5059 | 279.4K | 71 | 6185 | 180.27K | 189 | 25.0 | 12.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'22'' |
| MRX160P000 | 160.0 | 24.35% | 7731 | 282.83K | 66 | 4879 | 169.92K | 173 | 34.0 | 21.0 | 3.0 | 68.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'21'' |
| MRX160P001 | 160.0 | 24.30% | 5371 | 284.06K | 71 | 4845 | 168.86K | 175 | 33.0 | 23.0 | 3.0 | 66.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'22'' |
| MRX240P000 | 240.0 | 23.76% | 5910 | 285.93K | 73 | 4891 | 166.6K | 175 | 49.0 | 27.0 | 3.0 | 98.0 | "31,41,51,61,71,81" | 0:00'35'' | 0:00'22'' |
| MRX240P001 | 240.0 | 23.63% | 6289 | 289.47K | 72 | 4764 | 160.44K | 174 | 50.0 | 31.5 | 3.0 | 100.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'23'' |
| MRX320P000 | 320.0 | 22.89% | 5195 | 283.59K | 78 | 4879 | 150.99K | 181 | 65.0 | 33.0 | 3.0 | 130.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'22'' |
| MRX320P001 | 320.0 | 23.83% | 7045 | 280.24K | 66 | 4693 | 168.16K | 162 | 68.0 | 44.0 | 3.0 | 136.0 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'23'' |

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 15702 | 537.57K | 125 | 8275 | 656.07K | 234 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 22752 | 423.33K | 93 | 8799 | 623.75K | 217 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 5431 | 480.5K | 139 | 3197 | 895.39K | 323 | 0.0 | 0.0 | 0.0 | 0.0 |  |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 9.47% | 1409 | 254.02K | 181 | 3435 | 604.21K | 570 | 72.0 | 52.0 | 3.0 | 144.0 | 0:00'43'' |
| 8_spades_MR | 24.00% | 1307 | 384.81K | 284 | 3204 | 795.08K | 835 | 79.0 | 51.0 | 3.0 | 158.0 | 0:00'35'' |
| 8_megahit | 8.35% | 2945 | 284.41K | 110 | 7898 | 198.13K | 198 | 151.0 | 110.0 | 3.0 | 302.0 | 0:00'40'' |
| 8_megahit_MR | 31.07% | 1256 | 306.03K | 228 | 11860 | 571.64K | 536 | 133.0 | 103.0 | 3.0 | 266.0 | 0:00'36'' |
| 8_platanus | 10.78% | 3107 | 60.57K | 23 | 1934 | 26.91K | 26 | 1189.0 | 437.0 | 3.0 | 2378.0 | 0:00'40'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 395651 | 2 |
| 7_mergeAnchors.anchors | 15702 | 537571 | 125 |
| 7_mergeAnchors.others | 8275 | 656068 | 234 |
| anchorLong | 23747 | 516715 | 103 |
| anchorFill | 41335 | 518227 | 82 |
| spades.contig | 90 | 88391759 | 899276 |
| spades.scaffold | 90 | 88392739 | 899241 |
| spades.non-contained | 2067 | 858225 | 392 |
| spades_MR.contig | 177 | 16861607 | 86641 |
| spades_MR.scaffold | 177 | 16862413 | 86631 |
| spades_MR.non-contained | 1785 | 1179886 | 583 |
| megahit.contig | 342 | 3160991 | 8456 |
| megahit.non-contained | 18070 | 482541 | 92 |
| megahit_MR.contig | 431 | 10742364 | 25503 |
| megahit_MR.non-contained | 2236 | 877666 | 377 |
| platanus.contig | 138 | 1357222 | 8746 |
| platanus.scaffold | 136 | 1298219 | 8666 |
| platanus.non-contained | 6404 | 87482 | 21 |


## SRR965418

+ ~11
```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR965418
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
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

## SRR2163426
+ ~30

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR2163426
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
    --trim2 "--dedupe --cutoff 120 --cutk 31" \
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

## SRR1552478
+ ~80
```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1552478
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
    --trim2 "--dedupe --cutoff 320 --cutk 31" \
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

## SRR965418
```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR965418
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
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

### 统计结果
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 247.7 | 208 | 1230.5 | 3.19% |
| R.tadpole.bbtools | 205.8 | 207 | 22.0 | 24.79% |
| R.genome.picard | 208.1 | 208 | 10.0 | FR |
| R.tadpole.picard | 204.0 | 207 | 15.9 | FR |

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 395651 | 2 |
| Illumina.R | 101 | 5.73G | 56701132 |
| trim.R | 100 | 1.5G | 15099138 |
| Q25L60 | 100 | 1.45G | 14660468 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 101 | 5.64G | 55853764 |
| highpass | 101 | 1.63G | 16139528 |
| trim | 100 | 1.5G | 15099138 |
| filter | 100 | 1.5G | 15099138 |
| R1 | 100 | 746.91M | 7549569 |
| R2 | 100 | 749.37M | 7549569 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	62564	0.38764%
#Name	Reads	ReadsPct
Reverse_adapter	49865	0.30896%
```

```text
#R.filter
#Matched	0	0.00000%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	44709565
#main_peak	98
#genome_size	4685256
#haploid_genome_size	4685256
#fold_coverage	98
#haploid_fold_coverage	98
#ploidy	1
#percent_repeat	78.529
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 100 | 1.5G | 15090038 |
| ecco | 100 | 1.49G | 15090038 |
| eccc | 100 | 1.49G | 15090038 |
| ecct | 100 | 1.15G | 11746902 |
| extended | 137 | 1.5G | 11746902 |
| merged.raw | 242 | 960.31M | 4175358 |
| unmerged.raw | 122 | 410.19M | 3396186 |
| unmerged.trim | 122 | 409.94M | 3389788 |
| M1 | 243 | 892.29M | 3766371 |
| U1 | 122 | 204.69M | 1694894 |
| U2 | 122 | 205.24M | 1694894 |
| Us | 0 | 0 | 0 |
| M.cor | 233 | 1.31G | 10922530 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 115.1 | 152 | 68.6 | 2.62% |
| M.ihist.merge.txt | 230.0 | 241 | 44.0 | 71.09% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 1496.3 | 1377.1 | 7.96% | "71" | 1M | 18.99M | 18.99 | 0:02'41'' |
| Q25L60.R | 1448.3 | 1339.2 | 7.54% | "71" | 1M | 18.52M | 18.52 | 0:02'38'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 34.52% | 17350 | 125.81K | 11 | 6314 | 12.56K | 68 | 62.0 | 2.0 | 18.7 | 102.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'27'' |
| Q0L0X40P001 | 40.0 | 33.18% | 14305 | 130.3K | 15 | 1440 | 13.48K | 76 | 61.0 | 2.0 | 18.3 | 100.5 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'27'' |
| Q0L0X80P000 | 80.0 | 27.70% | 6272 | 210.18K | 64 | 1806 | 12.72K | 149 | 112.0 | 103.0 | 3.0 | 224.0 | "31,41,51,61,71,81" | 0:00'27'' | 0:00'24'' |
| Q0L0X80P001 | 80.0 | 26.31% | 8115 | 209.36K | 64 | 1067 | 15.86K | 147 | 110.0 | 101.0 | 3.0 | 220.0 | "31,41,51,61,71,81" | 0:00'27'' | 0:00'24'' |
| Q0L0X120P000 | 120.0 | 29.11% | 3296 | 160.2K | 63 | 6842 | 172.76K | 208 | 18.0 | 7.0 | 3.0 | 36.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'26'' |
| Q0L0X120P001 | 120.0 | 25.35% | 2834 | 159.05K | 67 | 8946 | 143.97K | 198 | 17.0 | 6.0 | 3.0 | 34.0 | "31,41,51,61,71,81" | 0:00'33'' | 0:00'25'' |
| Q0L0X160P000 | 160.0 | 28.64% | 3779 | 191.58K | 67 | 6278 | 166.25K | 254 | 20.0 | 6.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'28'' |
| Q0L0X160P001 | 160.0 | 30.87% | 4195 | 193.53K | 65 | 6522 | 186.09K | 228 | 21.0 | 7.0 | 3.0 | 42.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'26'' |
| Q0L0X240P000 | 240.0 | 30.94% | 4133 | 211.68K | 63 | 4551 | 181.72K | 257 | 28.0 | 8.5 | 3.0 | 56.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'28'' |
| Q0L0X240P001 | 240.0 | 30.58% | 4440 | 209.81K | 63 | 5120 | 187.93K | 269 | 29.0 | 9.0 | 3.0 | 58.0 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'29'' |
| Q0L0X320P000 | 320.0 | 30.46% | 4135 | 216.73K | 63 | 4114 | 189.6K | 236 | 38.0 | 14.0 | 3.0 | 76.0 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'30'' |
| Q0L0X320P001 | 320.0 | 30.48% | 6885 | 220.11K | 66 | 4482 | 188.28K | 252 | 38.0 | 13.0 | 3.0 | 76.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'29'' |
| Q25L60X40P000 | 40.0 | 34.03% | 13144 | 125.32K | 13 | 6979 | 9K | 75 | 62.0 | 2.0 | 18.7 | 102.0 | "31,41,51,61,71,81" | 0:00'21'' | 0:00'23'' |
| Q25L60X40P001 | 40.0 | 34.96% | 27084 | 126.58K | 12 | 2168 | 10.7K | 62 | 62.0 | 2.0 | 18.7 | 102.0 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'24'' |
| Q25L60X80P000 | 80.0 | 32.27% | 8044 | 203.72K | 61 | 1080 | 14.73K | 142 | 118.0 | 109.0 | 3.0 | 236.0 | "31,41,51,61,71,81" | 0:00'25'' | 0:00'25'' |
| Q25L60X80P001 | 80.0 | 27.41% | 4273 | 201.81K | 70 | 1035 | 20.2K | 161 | 113.0 | 104.0 | 3.0 | 226.0 | "31,41,51,61,71,81" | 0:00'27'' | 0:00'25'' |
| Q25L60X120P000 | 120.0 | 27.73% | 2439 | 156.14K | 70 | 9369 | 156.74K | 225 | 17.0 | 6.0 | 3.0 | 34.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'26'' |
| Q25L60X120P001 | 120.0 | 30.29% | 2387 | 165.19K | 78 | 9270 | 186.89K | 229 | 18.0 | 7.0 | 3.0 | 36.0 | "31,41,51,61,71,81" | 0:00'31'' | 0:00'26'' |
| Q25L60X160P000 | 160.0 | 27.03% | 3656 | 186.72K | 66 | 5624 | 148.23K | 238 | 20.0 | 6.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'27'' |
| Q25L60X160P001 | 160.0 | 29.52% | 4135 | 192.01K | 66 | 6673 | 176.59K | 222 | 20.0 | 6.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'27'' |
| Q25L60X240P000 | 240.0 | 29.47% | 5554 | 213.06K | 66 | 4879 | 167.47K | 270 | 28.0 | 8.0 | 3.0 | 56.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'27'' |
| Q25L60X240P001 | 240.0 | 28.84% | 4319 | 210.66K | 66 | 4844 | 161.25K | 260 | 28.0 | 8.0 | 3.0 | 56.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'28'' |
| Q25L60X320P000 | 320.0 | 28.18% | 4210 | 223.07K | 73 | 4470 | 157.46K | 267 | 37.0 | 11.0 | 3.0 | 74.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'29'' |
| Q25L60X320P001 | 320.0 | 31.07% | 3894 | 225.29K | 75 | 5364 | 184.3K | 271 | 38.0 | 12.0 | 3.0 | 76.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'35'' |

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 25.87% | 1528 | 90.18K | 55 | 8513 | 180.39K | 162 | 16.0 | 11.0 | 3.0 | 32.0 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'21'' |
| MRX40P001 | 40.0 | 25.52% | 1752 | 106.67K | 58 | 6185 | 199.4K | 181 | 9.0 | 4.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'23'' | 0:00'21'' |
| MRX80P000 | 80.0 | 26.59% | 7250 | 210.13K | 53 | 8443 | 156.68K | 182 | 13.0 | 4.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'21'' |
| MRX80P001 | 80.0 | 25.72% | 5490 | 206.09K | 56 | 8443 | 154.9K | 176 | 13.0 | 5.0 | 3.0 | 26.0 | "31,41,51,61,71,81" | 0:00'28'' | 0:00'20'' |
| MRX120P000 | 120.0 | 25.60% | 12450 | 224.46K | 53 | 9183 | 143.41K | 151 | 19.0 | 6.0 | 3.0 | 38.0 | "31,41,51,61,71,81" | 0:00'32'' | 0:00'21'' |
| MRX120P001 | 120.0 | 26.20% | 8520 | 223.68K | 52 | 8443 | 148.45K | 155 | 20.0 | 8.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:00'32'' | 0:00'21'' |
| MRX160P000 | 160.0 | 27.13% | 12587 | 232.07K | 53 | 9183 | 151.31K | 146 | 26.0 | 11.0 | 3.0 | 52.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'22'' |
| MRX160P001 | 160.0 | 25.72% | 16475 | 231.08K | 53 | 9199 | 140.02K | 152 | 25.0 | 9.0 | 3.0 | 50.0 | "31,41,51,61,71,81" | 0:00'34'' | 0:00'22'' |
| MRX240P000 | 240.0 | 26.56% | 14532 | 229.64K | 51 | 9265 | 145.44K | 128 | 39.0 | 17.0 | 3.0 | 78.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'22'' |
| MRX240P001 | 240.0 | 27.00% | 5874 | 231.35K | 55 | 11070 | 146.41K | 141 | 38.0 | 14.0 | 3.0 | 76.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'22'' |
| MRX320P000 | 320.0 | 25.68% | 5825 | 227.93K | 57 | 9199 | 137.73K | 136 | 51.0 | 20.0 | 3.0 | 102.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'28'' |
| MRX320P001 | 320.0 | 25.37% | 4536 | 229K | 63 | 9199 | 135.99K | 144 | 50.0 | 18.0 | 3.0 | 100.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'23'' |

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 17555 | 417.57K | 87 | 1108 | 178.7K | 118 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 5768 | 284.31K | 76 | 23336 | 339.36K | 106 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 11904 | 397.64K | 90 | 1048 | 76.36K | 53 | 0.0 | 0.0 | 0.0 | 0.0 |  |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 31.00% | 3044 | 690.51K | 273 | 1935 | 384.1K | 622 | 98.0 | 45.0 | 3.0 | 196.0 | 0:00'37'' |
| 8_spades_MR | 33.36% | 2018 | 657.2K | 346 | 8107 | 530.81K | 697 | 97.0 | 49.0 | 3.0 | 194.0 | 0:00'34'' |
| 8_megahit | 26.27% | 5896 | 292.71K | 80 | 74752 | 141.7K | 163 | 146.0 | 55.0 | 3.0 | 292.0 | 0:00'37'' |
| 8_megahit_MR | 41.69% | 1664 | 497.87K | 248 | 1612 | 279.54K | 484 | 134.0 | 90.5 | 3.0 | 268.0 | 0:00'34'' |
| 8_platanus | 24.75% | 20575 | 177.96K | 39 | 1501 | 29.31K | 54 | 2000.0 | 1719.0 | 3.0 | 4000.0 | 0:00'34'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 271618 | 395651 | 2 |
| 7_mergeAnchors.anchors | 17555 | 417567 | 87 |
| 7_mergeAnchors.others | 1108 | 178704 | 118 |
| anchorLong | 19158 | 408452 | 73 |
| anchorFill | 28371 | 403610 | 63 |
| spades.contig | 297 | 4565368 | 19191 |
| spades.scaffold | 297 | 4565478 | 19189 |
| spades.non-contained | 3463 | 1074616 | 376 |
| spades_MR.contig | 1638 | 1895109 | 2645 |
| spades_MR.scaffold | 1638 | 1895209 | 2644 |
| spades_MR.non-contained | 2925 | 1188005 | 429 |
| megahit.contig | 361 | 2285656 | 5864 |
| megahit.non-contained | 15218 | 434404 | 93 |
| megahit_MR.contig | 451 | 9258686 | 19477 |
| megahit_MR.non-contained | 1687 | 777412 | 366 |
| platanus.contig | 111 | 2281639 | 17483 |
| platanus.scaffold | 814 | 472800 | 920 |
| platanus.non-contained | 9059 | 207271 | 54 |


# SRR2163426
+ ~80

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR2163426
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
    --trim2 "--dedupe --cutoff 120 --cutk 31" \
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
