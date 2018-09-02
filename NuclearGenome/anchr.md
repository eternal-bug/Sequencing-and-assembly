# Nuclear Genome merge
[TOC levels=1-2]: # " "
+ [Ampelopsis grossedentata](#*ampelopsis-grossedentata*[蛇葡萄])
    + [品系](#品系)
    + [序列大小](#序列大小)
+ [前期准备](#前期准备) 
+ [BD268](#bd268)
+ [BD280](#bd280)
+ [BD308](#bd308)
+ [BD310](#bd310)
+ [BD312](#bd312)
+ *Ampelopsis_grossedentata*[蛇葡萄]
+ *Lithocarpus_polystachyus*[多穗石柯]


# *Ampelopsis grossedentata*[蛇葡萄]
+ 测序数据量 9.9G  R1.fq.gz  13G  R2.fq.gz
+ 测序方式 ： Illumina
+ 预测的基因组大小 ： 911749703
 
```bash
# 超算
cd ~/stq/data/anchr/
mkdir -p ./Ampelopsis_grossedentata/sequence_data
mkdir -p ./Ampelopsis_grossedentata/genome

## 转移数据
rsync -avP \
  ~/data/anchr

```bash
## 
cd ~/stq/data/anchr/Ampelopsis_grossedentata/

ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\d\.f(ast)*q.gz//;print $new')
do
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```

## 运行超算任务
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Ampelopsis_grossedentata/
BASE_NAME=Agr_PE400_R

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
# 粘贴如下内容
#!/usr/bin/env bash
BASH_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BASH_DIR}

#----------------------------#
# Colors in term
#----------------------------#
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
GREEN=
RED=
NC=
if tty -s < /dev/fd/1 2> /dev/null; then
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color
fi

log_warn () {
    echo >&2 -e "${RED}==> $@ <==${NC}"
}

log_info () {
    echo >&2 -e "${GREEN}==> $@${NC}"
}

log_debug () {
    echo >&2 -e "==> $@"
}

#----------------------------#
# helper functions
#----------------------------#
set +e

# set stacksize to unlimited
ulimit -s unlimited

signaled () {
    log_warn Interrupted
    exit 1
}
trap signaled TERM QUIT INT

# save environment variables
save () {
    printf ". + {%s: \"%s\"}" $1 $(eval "echo -n \"\$$1\"") > jq.filter.txt

    if [ -e environment.json ]; then
        cat environment.json \
            | jq -f jq.filter.txt \
            > environment.json.new
        rm environment.json
    else
        jq -f jq.filter.txt -n \
            > environment.json.new
    fi

    mv environment.json.new environment.json
    rm jq.filter.txt
}

stat_format () {
    echo $(faops n50 -H -N 50 -S -C $@) \
        | perl -nla -MNumber::Format -e '
            printf qq{%d\t%s\t%d\n}, $F[0], Number::Format::format_bytes($F[1], base => 1000,), $F[2];
        '
}

log_warn 0_master.sh

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

#----------------------------#
# preprocessing
#----------------------------#
if [ -e 2_trim.sh ]; then
    bash 2_trim.sh;
fi

if [ -e 3_trimlong.sh ]; then
    bash 3_trimlong.sh;
fi

if [ -e 9_statReads.sh ]; then
    bash 9_statReads.sh;
fi

# 将文件存储为0_temp.sh
```
```bash
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_temp.sh
"
```
## 查看超算后台的生成文件
```text
#R.filter
#Matched	60	0.00003%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	2903082402
#main_peak	33
#genome_size	911749703
#haploid_genome_size	911749703
#fold_coverage	17
#haploid_fold_coverage	17
#ploidy	1
#percent_repeat	77.506
#start	center	stop	max	volume
```
得到估计的基因组大小 911749703

## 执行清理操作
```bash
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
```
```bash
# 再次进行组装
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 911749703 \
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
    --cov2 "60 80 120 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g
```
```bash
# 提交超算任务
bsub -q largemem -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## 结果评估
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Illumina.R | 151 | 35.55G | 235403430 |
| trim.R | 150 | 31.32G | 218175108 |
| Q25L60 | 150 | 26.92G | 191219189 |
| Q30L60 | 150 | 23.7G | 172729695 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 151 | 34.49G | 228417782 |
| trim | 150 | 31.32G | 218175226 |
| filter | 150 | 31.32G | 218175108 |
| R1 | 150 | 16.22G | 109087554 |
| R2 | 150 | 15.09G | 109087554 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	872747	0.38208%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	60	0.00003%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	2903082402
#main_peak	33
#genome_size	911749703
#haploid_genome_size	911749703
#fold_coverage	17
#haploid_fold_coverage	17
#ploidy	1
#percent_repeat	77.506
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 150 | 31.29G | 217981026 |
| ecco | 150 | 31.29G | 217981026 |
| ecct | 150 | 22.12G | 152814586 |
| extended | 190 | 27.44G | 152814586 |
| merged.raw | 427 | 16.73G | 41349088 |
| unmerged.raw | 188 | 12.13G | 70116410 |
| unmerged.trim | 188 | 12.13G | 70115192 |
| M1 | 427 | 16.1G | 39766806 |
| U1 | 190 | 6.4G | 35057596 |
| U2 | 181 | 5.73G | 35057596 |
| Us | 0 | 0 | 0 |
| M.cor | 338 | 28.27G | 149648804 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 231.2 | 243 | 45.0 | 5.24% |
| M.ihist.merge.txt | 404.6 | 414 | 74.2 | 54.12% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 34.3 | 26.1 | 23.94% | "103" | 911.75M | 552.03M | 0.61 | 0:57'47'' |
| Q25L60.R | 29.5 | 26.0 | 12.09% | "105" | 911.75M | 537.9M | 0.59 | 0:48'56'' |
| Q30L60.R | 26.0 | 24.2 | 6.90% | "97" | 911.75M | 530.53M | 0.58 | 0:44'35'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0XallP000 | 26.1 | 22.52% | 2490 | 173.18M | 77851 | 1012 | 12.51M | 168067 | 30.0 | 6.0 | 4.0 | 60.0 | "31,41,51,61,71,81" | 2:19'58'' | 0:32'13'' |
| Q25L60XallP000 | 26.0 | 20.40% | 2579 | 143.64M | 63035 | 1024 | 16.51M | 137491 | 32.0 | 4.0 | 6.7 | 64.0 | "31,41,51,61,71,81" | 2:09'15'' | 0:22'37'' |
| Q30L60XallP000 | 24.2 | 25.06% | 2549 | 177.83M | 78868 | 1011 | 10.83M | 168692 | 28.0 | 7.0 | 3.0 | 56.0 | "31,41,51,61,71,81" | 2:11'05'' | 0:33'02'' |

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q25L60XallP000 | 26.0 | 33.35% | 2722 | 174.28M | 73800 | 1017 | 14.73M | 174863 | 31.0 | 6.0 | 4.3 | 62.0 | "31,41,51,61,71,81" | 0:57'24'' | 0:35'38'' |
| Q30L60XallP000 | 24.2 | 34.18% | 2662 | 172.9M | 74312 | 1015 | 13.18M | 178688 | 29.0 | 6.0 | 3.7 | 58.0 | "31,41,51,61,71,81" | 0:54'12'' | 0:35'40'' |

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRXallP000 | 31.0 | 24.05% | 2545 | 160.76M | 71040 | 1021 | 11.62M | 148609 | 44.0 | 10.0 | 4.7 | 88.0 | "31,41,51,61,71,81" | 3:04'11'' | 0:24'02'' |

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRXallP000 | 31.0 | 31.32% | 2787 | 167.47M | 69757 | 1022 | 11.27M | 145661 | 45.0 | 10.0 | 5.0 | 90.0 | "31,41,51,61,71,81" | 1:05'42'' | 0:30'45'' |

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 27.69% | 3070 | 165.68M | 65015 | 1052 | 44.65M | 40780 | 31.0 | 4.0 | 6.3 | 62.0 | 0:30'36'' |
| 7_mergeKunitigsAnchors | 25.46% | 2707 | 174.62M | 74413 | 1042 | 20.61M | 19280 | 30.0 | 6.0 | 4.0 | 60.0 | 0:28'51'' |
| 7_mergeMRKunitigsAnchors | 19.74% | 2612 | 144.93M | 62994 | 1047 | 19.31M | 17883 | 31.0 | 4.0 | 6.3 | 62.0 | 0:16'36'' |
| 7_mergeMRTadpoleAnchors | 20.58% | 2870 | 154.9M | 63281 | 1041 | 16.49M | 15030 | 31.0 | 5.0 | 5.3 | 62.0 | 0:17'48'' |
| 7_mergeTadpoleAnchors | 25.07% | 2888 | 166.15M | 67875 | 1036 | 20.8M | 19179 | 31.0 | 5.0 | 5.3 | 62.0 | 0:26'35'' |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_megahit | 44.19% | 3162 | 303.31M | 116113 | 1043 | 42.36M | 221672 | 26.0 | 8.0 | 3.0 | 52.0 | 0:36'23'' |
| 8_megahit_MR | 60.63% | 1965 | 317.67M | 167844 | 2568 | 146.39M | 327170 | 29.0 | 10.0 | 3.0 | 58.0 | 0:49'20'' |
| 8_platanus | 2.23% | 2644 | 18.16M | 7723 | 1055 | 2.8M | 14844 | 25.0 | 5.0 | 3.3 | 50.0 | 0:05'05'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| 7_mergeAnchors.anchors | 3070 | 165676786 | 65015 |
| 7_mergeAnchors.others | 1052 | 44652633 | 40780 |
| spades.non-contained | 0 | 0 | 0 |
| spades_MR.non-contained | 0 | 0 | 0 |
| megahit.contig | 2229 | 515625560 | 515388 |
| megahit.non-contained | 4629 | 345681269 | 106120 |
| megahit_MR.contig | 1863 | 687808147 | 605943 |
| megahit_MR.non-contained | 3300 | 464316421 | 169069 |
| platanus.contig | 1695 | 31505142 | 71813 |
| platanus.scaffold | 2383 | 29152536 | 37164 |
| platanus.non-contained | 3643 | 20968354 | 7137 |

### Table: statBUSCO.md

| File | C | S | D | F | M | Total |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 7_mergeKunitigsAnchors | 388 | 377 | 11 | 162 | 890 | 1440 |
| 7_mergeTadpoleAnchors | 414 | 399 | 15 | 154 | 872 | 1440 |
| 7_mergeMRKunitigsAnchors | 370 | 356 | 14 | 157 | 913 | 1440 |
| 7_mergeMRTadpoleAnchors | 393 | 382 | 11 | 161 | 886 | 1440 |
| 7_mergeAnchors | 415 | 403 | 12 | 147 | 878 | 1440 |
| 8_spades | 1011 | 983 | 28 | 194 | 235 | 1440 |
| 8_spades_MR | 1017 | 984 | 33 | 192 | 231 | 1440 |
| 8_megahit | 922 | 906 | 16 | 256 | 262 | 1440 |
| 8_megahit_MR | 848 | 818 | 30 | 262 | 330 | 1440 |
| 8_platanus | 119 | 111 | 8 | 33 | 1288 | 1440 |

---


# Lithocarpus_polystachyus
+ 测序数据量 9.9G  R1.fq.gz  13G  R2.fq.gz
+ 测序方式 ： Illumina
+ 预测的基因组大小 ： 911749703
 
```bash
# 超算
cd ~/stq/data/anchr/
mkdir -p ./Lithocarpus_polystachyus/sequence_data
mkdir -p ./Lithocarpus_polystachyus/genome

## 转移数据
rsync -avP \
  ~/data/anchr

```bash
## 
cd ~/stq/data/anchr/Lithocarpus_polystachyus/

ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\d\.f(ast)*q.gz//;print $new')
do
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```
```bash
# 运行超算任务
WORKING_DIR=${HOME}/stq/data/anchr/Lithocarpus_polystachyus/
BASE_NAME=Lpa_PE400_R

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
```
输入以下内容
```
#!/usr/bin/env bash

BASH_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BASH_DIR}

#----------------------------#
# Colors in term
#----------------------------#
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
GREEN=
RED=
NC=
if tty -s < /dev/fd/1 2> /dev/null; then
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color
fi

log_warn () {
    echo >&2 -e "${RED}==> $@ <==${NC}"
}

log_info () {
    echo >&2 -e "${GREEN}==> $@${NC}"
}

log_debug () {
    echo >&2 -e "==> $@"
}

#----------------------------#
# helper functions
#----------------------------#
set +e

# set stacksize to unlimited
ulimit -s unlimited

signaled () {
    log_warn Interrupted
    exit 1
}
trap signaled TERM QUIT INT

# save environment variables
save () {
    printf ". + {%s: \"%s\"}" $1 $(eval "echo -n \"\$$1\"") > jq.filter.txt

    if [ -e environment.json ]; then
        cat environment.json \
            | jq -f jq.filter.txt \
            > environment.json.new
        rm environment.json
    else
        jq -f jq.filter.txt -n \
            > environment.json.new
    fi

    mv environment.json.new environment.json
    rm jq.filter.txt
}

stat_format () {
    echo $(faops n50 -H -N 50 -S -C $@) \
        | perl -nla -MNumber::Format -e '
            printf qq{%d\t%s\t%d\n}, $F[0], Number::Format::format_bytes($F[1], base => 1000,), $F[2];
        '
}

log_warn 0_master.sh

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

#----------------------------#
# preprocessing
#----------------------------#
if [ -e 2_trim.sh ]; then
    bash 2_trim.sh;
fi

if [ -e 3_trimlong.sh ]; then
    bash 3_trimlong.sh;
fi

if [ -e 9_statReads.sh ]; then
    bash 9_statReads.sh;
fi
EOF
```
保存为 `0_temp.sh`
```bash
bsub -q largemem -n 24 -J "${BASE_NAME}" "
  bash 0_temp.sh
"
```
# 查看超算后台的生成文件
```text
#R.trim
#Matched	962451	0.41931%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	19	0.00001%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	3519854407
#main_peak	11
#genome_size	818490203
#haploid_genome_size	818490203
#fold_coverage	11
#haploid_fold_coverage	11
#ploidy	1
#percent_repeat	12.171
#start	center	stop	max	volume

# 得到估计的基因组大小 818490203
```
```bash
# 执行清理操作
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

# 再次进行组装
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 818490203 \
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
bsub -q largemem -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
## Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|

## Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Illumina.R | 151 | 35.54G | 235358784 |
| trim.R | 150 | 31.03G | 217333850 |
| Q25L60 | 150 | 26.33G | 187630597 |
| Q30L60 | 150 | 23.07G | 168437601 |

## Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 151 | 34.66G | 229531904 |
| trim | 150 | 31.03G | 217333884 |
| filter | 150 | 31.03G | 217333850 |
| R1 | 150 | 16.13G | 108666925 |
| R2 | 150 | 14.9G | 108666925 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	962451	0.41931%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	19	0.00001%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	3519854407
#main_peak	11
#genome_size	818490203
#haploid_genome_size	818490203
#fold_coverage	11
#haploid_fold_coverage	11
#ploidy	1
#percent_repeat	12.171
#start	center	stop	max	volume
```



## Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 150 | 31G | 217155526 |
| ecco | 150 | 31G | 217155526 |
| ecct | 150 | 20.14G | 139626244 |
| extended | 190 | 24.74G | 139626244 |
| merged.raw | 416 | 13.2G | 33476625 |
| unmerged.raw | 185 | 12.43G | 72672994 |
| unmerged.trim | 185 | 12.43G | 72671338 |
| M1 | 416 | 12.73G | 32236157 |
| U1 | 190 | 6.57G | 36335669 |
| U2 | 178 | 5.86G | 36335669 |
| Us | 0 | 0 | 0 |
| M.cor | 222 | 25.2G | 137143652 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 231.0 | 243 | 46.3 | 5.15% |
| M.ihist.merge.txt | 394.3 | 403 | 74.9 | 47.95% |


## Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 37.9 | 27.8 | 26.74% | "103" | 818.49M | 865.95M | 1.06 | 1:00'38'' |
| Q25L60.R | 32.2 | 27.7 | 13.98% | "103" | 818.49M | 854.57M | 1.04 | 0:51'00'' |
| Q30L60.R | 28.2 | 25.8 | 8.64% | "91" | 818.49M | 844.08M | 1.03 | 0:45'10'' |

## Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0XallP000 | 27.8 | 11.72% | 1408 | 78.4M | 53201 | 1251 | 75.84M | 176793 | 15.0 | 5.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 2:18'17'' | 0:21'20'' |
| Q25L60XallP000 | 27.7 | 12.31% | 1420 | 79.46M | 53501 | 1294 | 77.27M | 175961 | 15.0 | 5.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 2:16'18'' | 0:22'07'' |
| Q30L60XallP000 | 25.8 | 12.55% | 1418 | 83.26M | 56426 | 1252 | 67.67M | 172730 | 15.0 | 5.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 2:07'46'' | 0:20'00'' |

## Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRXallP000 | 30.8 | 11.66% | 1517 | 75.08M | 47660 | 1458 | 70.53M | 143161 | 19.0 | 7.0 | 3.0 | 38.0 | "31,41,51,61,71,81" | 2:51'22'' | 0:16'28'' |

## Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 3.92% | 1587 | 55.25M | 34070 | 1300 | 155.52M | 113389 | 11.0 | 1.0 | 3.0 | 21.0 | 0:10'22'' |
| 7_mergeKunitigsAnchors | 6.85% | 1510 | 60.82M | 38921 | 1309 | 120.69M | 88661 | 12.0 | 3.0 | 3.0 | 24.0 | 0:12'36'' |
| 7_mergeMRKunitigsAnchors | 4.12% | 1630 | 49.29M | 29807 | 1372 | 89.37M | 62491 | 12.0 | 3.0 | 3.0 | 24.0 | 0:08'23'' |

## Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_megahit | 33.55% | 1612 | 229.71M | 141452 | 1637 | 246.81M | 329470 | 14.0 | 4.0 | 3.0 | 28.0 | 0:37'35'' |
| 8_megahit_MR | 47.30% | 1609 | 362.82M | 223230 | 1630 | 285.5M | 527790 | 16.0 | 5.0 | 3.0 | 32.0 | 1:03'10'' |
| 8_platanus | 10.40% | 1903 | 93.91M | 51221 | 1220 | 39.59M | 104542 | 18.0 | 3.0 | 3.0 | 36.0 | 0:10'40'' |

## Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| 7_mergeAnchors.anchors | 1587 | 55245872 | 34070 |
| 7_mergeAnchors.others | 1300 | 155516618 | 113389 |
| spades.non-contained | 0 | 0 | 0 |
| spades_MR.non-contained | 0 | 0 | 0 |
| megahit.contig | 1484 | 786871190 | 936193 |
| megahit.non-contained | 3012 | 476533869 | 188318 |
| megahit_MR.contig | 1271 | 1105839468 | 1183481 |
| megahit_MR.non-contained | 2221 | 648532630 | 310763 |
| platanus.contig | 62 | 1517346293 | 25259433 |
| platanus.scaffold | 279 | 431986158 | 1725867 |
| platanus.non-contained | 2971 | 133492915 | 53596 |

## Table: statBUSCO.md

| File | C | S | D | F | M | Total |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 7_mergeKunitigsAnchors | 7 | 7 | 0 | 4 | 1429 | 1440 |
| 7_mergeMRKunitigsAnchors | 4 | 4 | 0 | 3 | 1433 | 1440 |
| 7_mergeAnchors | 4 | 4 | 0 | 2 | 1434 | 1440 |
| 8_spades | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 8_spades_MR | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 8_megahit | 777 | 760 | 17 | 262 | 401 | 1440 |
| 8_platanus | 618 | 605 | 13 | 264 | 558 | 1440 |
