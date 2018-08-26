# *Lens_culinaris*[兵豆]
基因组大小估计参考[科学网](http://blog.sciencenet.cn/blog-3533-766578.html)
+ 兵豆Lentil (Lens culinaris), 2n=2x=14, 基因组大小：4063Mbp
+ 叶绿体+线粒体：1.2Mbp(估计值)
+ 2.1G	R1.fq.gz  2.6G	R2.fq.gz
+ 1217928

## 查找叶绿体基因组文件
在NCBI的核酸库中搜索`Lens culinaris plastid, complete genome`，发现有信息
+ KF186232.1
+ 123096 bp

使用本地电脑下载并上传到服务器上

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

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
## BUSCO评估
```打开vim
vim
```
输入如下信息
```bash
export PATH="~/stq/Applications/augustus-3.3.1/bin:$PATH"
export AUGUSTUS_CONFIG_PATH="/share/home/wangq/stq/Applications/augustus-3.3.1/config"
export PATH="~/stq/Applications/hmmer-3.2.1/src:$PATH"
export PATH="~/stq/Applications/blast+-2.7.1-linux/bin:$PATH"

cd ~/stq/data/anchr/Lens_culinaris/268_PE400_R
ROOTTMP=$(pwd)

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

# 文件名单来自于 `9_quast.sh`
for path in '7_mergeKunitigsAnchors/anchor.merge.fasta' '7_mergeTadpoleAnchors/anchor.merge.fasta' '7_mergeMRKunitigsAnchors/anchor.merge.fasta' '7_mergeMRTadpoleAnchors/anchor.merge.fasta' '7_mergeMRMegahitAnchors/anchor.merge.fasta' '7_mergeMRSpadesAnchors/anchor.merge.fasta' '7_mergeAnchors/anchor.merge.fasta' '7_anchorLong/contig.fasta' '7_anchorFill/contig.fasta' '8_spades/spades.non-contained.fasta' '8_spades_MR/spades.non-contained.fasta' '8_megahit/megahit.non-contained.fasta' '8_megahit_MR/megahit.non-contained.fasta' '8_platanus/platanus.non-contained.fasta';
do
  cd $ROOTTMP
  if [ -f $path ];
  then
    log_info $path
    BASH_DIR=$( cd "$( dirname "$path" )" && pwd )
    cd ${BASH_DIR}
    
    # 新建文件夹
    if [ -d busco ];
    then
      # do nothing
      echo -n
    else
      mkdir busco
    fi
    cd busco
    
    # 去除特殊字符,busco不允许标签名出线斜线(/),所以将其除去
    if [ -f tmp.fasta ];
    then
      # do nothing
      echo -n
    else
      cat ../$(basename $path) | sed "s/\///g" > tmp.fasta
    fi
    
    # 这里的-o选项似乎不起效，这个工具的输出路径就是当前目录
    ~/stq/Applications/busco/scripts/run_BUSCO.py \
        -i tmp.fasta \
        -l ~/stq/database/BUSCO/embryophyta_odb9 \
        -o  .\
        -m genome \
        --cpu 8
  fi
  cd $ROOTTMP
done

# ============ sample =============
    
# # BUSCO version is: 3.0.2 
# # The lineage dataset is: embryophyta_odb9 (Creation date: 2016-02-13, number of species: 30, number of BUSCOs: 1440)
# # To reproduce this run: python /share/home/wangq/stq/Applications/busco/scripts/run_BUSCO.py -i tmp.fasta -o . -l /share/home/wangq/stq/database/BUSCO/embryophyta_odb9/ -m genome -c 8 -sp arabidopsis
# #
# # Summarized benchmarking in BUSCO notation for file tmp.fasta
# # BUSCO was run in mode: genome
# 
# 	C:0.0%[S:0.0%,D:0.0%],F:0.0%,M:100.0%,n:1440
# 
# 	0	Complete BUSCOs (C)
# 	0	Complete and single-copy BUSCOs (S)
# 	0	Complete and duplicated BUSCOs (D)
# 	0	Fragmented BUSCOs (F)
# 	1440	Missing BUSCOs (M)
# 	1440	Total BUSCO groups searched

cd $ROOTTMP
rm statBUSCO.md

echo '| File | C | S | D | F | M | Total |' > statBUSCO.md
echo '|:--:|:--:|:--:|:--:|:--:|:--:|:--:|' >> statBUSCO.md
  
for path in '7_mergeKunitigsAnchors/anchor.merge.fasta' '7_mergeTadpoleAnchors/anchor.merge.fasta' '7_mergeMRKunitigsAnchors/anchor.merge.fasta' '7_mergeMRTadpoleAnchors/anchor.merge.fasta' '7_mergeMRMegahitAnchors/anchor.merge.fasta' '7_mergeMRSpadesAnchors/anchor.merge.fasta' '7_mergeAnchors/anchor.merge.fasta' '7_anchorLong/contig.fasta' '7_anchorFill/contig.fasta' '8_spades/spades.non-contained.fasta' '8_spades_MR/spades.non-contained.fasta' '8_megahit/megahit.non-contained.fasta' '8_megahit_MR/megahit.non-contained.fasta' '8_platanus/platanus.non-contained.fasta';
do
  cd $ROOTTMP
  export this_dirname=$(dirname $path)
  if [ -d ${this_dirname}/busco/run_./ ];
  then
    BASH_DIR=$( cd "$( dirname "$path" )" && pwd )
    cd ${BASH_DIR}/busco/run_./
    
    if [ -f short_summary_*.txt ];
    then
      cat short_summary_..txt | perl -n -e '
        if (m/(\d+)\s*Complete BUSCOs/){
          $C = $1;
        }
        if (m/(\d+)\s*Complete and single-copy BUSCOs/){
          $S = $1;
        }
        if (m/(\d+)\s*Complete and duplicated BUSCOs/){
          $D = $1;
        }
        if (m/(\d+)\s*Fragmented BUSCOs/){
          $F = $1;
        }
        if (m/(\d+)\s*Missing BUSCOs/){
          $M = $1;
        }
        if (m/(\d+)\s*Total BUSCO groups searched/){
          $T = $1;
        }
        END{
          printf "| %s | %d | %d | %d | %d | %d | %d |\n",$ENV{this_dirname},
                                                         $C || 0,
                                                         $S || 0,
                                                         $D || 0,
                                                         $F || 0,
                                                         $M || 0,
                                                         $T || 0;
        }
      ' >> ../../../statBUSCO.md
    fi
    cd $ROOTTMP
  fi
done
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
| trim.R | 150 | 5.71G | 39395020 |
| Q25L60 | 150 | 5.14G | 36237742 |

## Table: statTrimReads
| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 151 | 7.24G | 47953620 |
| highpass | 151 | 6.1G | 40385204 |
| trim | 150 | 5.71G | 39395030 |
| filter | 150 | 5.71G | 39395020 |
| R1 | 150 | 2.93G | 19697510 |
| R2 | 150 | 2.77G | 19697510 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	155513	0.38507%
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
#unique_kmers	935151118
#main_peak	434
#genome_size	1311205
#haploid_genome_size	1311205
#fold_coverage	383
#haploid_fold_coverage	383
#ploidy	1
#percent_repeat	91.806
#start	center	stop	max	volume
```

## Table: statMergeReads
| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 150 | 5.7G | 39356368 |
| ecco | 150 | 5.7G | 39356368 |
| eccc | 150 | 5.7G | 39356368 |
| ecct | 150 | 1.39G | 9634930 |
| extended | 170 | 1.6G | 9634930 |
| merged.raw | 341 | 531.98M | 1658185 |
| unmerged.raw | 169 | 1.02G | 6318560 |
| unmerged.trim | 169 | 1.02G | 6318348 |
| M1 | 342 | 516.44M | 1607197 |
| U1 | 170 | 528.55M | 3159174 |
| U2 | 165 | 490.29M | 3159174 |
| Us | 0 | 0 | 0 |
| M.cor | 177 | 1.54G | 9532742 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 237.7 | 248 | 40.3 | 10.87% |
| M.ihist.merge.txt | 320.8 | 322 | 82.1 | 34.42% |

## Table: statQuorum
| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 4686.4 | 2270.8 | 51.55% | "105" | 1.22M | 173.86M | 142.75 | 0:10'25'' |
| Q25L60.R | 4223.7 | 2177.4 | 48.45% | "105" | 1.22M | 162.75M | 133.63 | 0:09'24'' |

## Table: statKunitigsAnchors.md
| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statTadpoleAnchors.md
| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0X40P000 | 40.0 | 3.15% | 3010 | 99.2K | 42 | 1064 | 24.29K | 101 | 9.0 | 1.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'21'' |
| Q0L0X40P001 | 40.0 | 2.42% | 2606 | 89.72K | 43 | 1105 | 23.34K | 94 | 9.0 | 1.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'21'' |
| Q0L0X80P000 | 80.0 | 4.24% | 12997 | 122.82K | 15 | 1423 | 15.67K | 72 | 17.0 | 2.0 | 3.7 | 34.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:00'20'' |
| Q0L0X80P001 | 80.0 | 4.47% | 8218 | 117.63K | 24 | 2474 | 27.39K | 87 | 17.0 | 1.0 | 4.7 | 30.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'20'' |
| Q0L0X120P000 | 120.0 | 3.97% | 15312 | 119.96K | 14 | 1081 | 15.79K | 52 | 27.0 | 1.0 | 8.0 | 45.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'21'' |
| Q0L0X120P001 | 120.0 | 3.76% | 74268 | 125.04K | 7 | 1195 | 10.28K | 35 | 26.0 | 5.5 | 3.2 | 52.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'20'' |
| Q0L0X160P000 | 160.0 | 2.91% | 19432 | 129.34K | 14 | 1800 | 16.02K | 39 | 35.0 | 27.0 | 3.0 | 70.0 | "31,41,51,61,71,81" | 0:01'03'' | 0:00'21'' |
| Q0L0X160P001 | 160.0 | 3.20% | 25628 | 127.86K | 10 | 1219 | 10.35K | 37 | 35.0 | 18.0 | 3.0 | 70.0 | "31,41,51,61,71,81" | 0:01'01'' | 0:00'20'' |
| Q0L0X240P000 | 240.0 | 2.82% | 16788 | 160.67K | 41 | 1258 | 31.22K | 105 | 46.0 | 40.0 | 3.0 | 92.0 | "31,41,51,61,71,81" | 0:01'22'' | 0:00'21'' |
| Q0L0X240P001 | 240.0 | 2.89% | 19455 | 161.65K | 36 | 1178 | 30.64K | 91 | 46.0 | 40.0 | 3.0 | 92.0 | "31,41,51,61,71,81" | 0:01'20'' | 0:00'22'' |
| Q0L0X320P000 | 320.0 | 2.99% | 1417 | 112.96K | 77 | 6973 | 183.83K | 217 | 11.0 | 5.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:01'46'' | 0:00'23'' |
| Q0L0X320P001 | 320.0 | 2.85% | 1467 | 90.09K | 60 | 16762 | 162.11K | 165 | 16.0 | 10.0 | 3.0 | 32.0 | "31,41,51,61,71,81" | 0:01'47'' | 0:00'23'' |
| Q25L60X40P000 | 40.0 | 2.99% | 3140 | 100.2K | 36 | 1267 | 25.66K | 93 | 10.0 | 1.0 | 3.0 | 19.5 | "31,41,51,61,71,81" | 0:00'29'' | 0:00'19'' |
| Q25L60X40P001 | 40.0 | 3.24% | 3215 | 95.9K | 36 | 1414 | 34.54K | 99 | 9.0 | 1.0 | 3.0 | 18.0 | "31,41,51,61,71,81" | 0:00'30'' | 0:00'19'' |
| Q25L60X80P000 | 80.0 | 4.73% | 13686 | 122.93K | 12 | 6306 | 10.64K | 53 | 19.0 | 1.5 | 4.8 | 35.2 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'20'' |
| Q25L60X80P001 | 80.0 | 4.56% | 9680 | 114.59K | 19 | 1900 | 22.37K | 64 | 19.0 | 1.0 | 5.3 | 33.0 | "31,41,51,61,71,81" | 0:00'39'' | 0:00'20'' |
| Q25L60X120P000 | 120.0 | 4.18% | 19377 | 123.34K | 11 | 1800 | 11.93K | 41 | 28.0 | 2.0 | 7.3 | 51.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'21'' |
| Q25L60X120P001 | 120.0 | 3.74% | 14391 | 126.31K | 9 | 4331 | 8.25K | 33 | 27.0 | 6.0 | 3.0 | 54.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'20'' |
| Q25L60X160P000 | 160.0 | 3.06% | 23610 | 126.77K | 9 | 1221 | 12.61K | 28 | 36.0 | 22.5 | 3.0 | 72.0 | "31,41,51,61,71,81" | 0:01'00'' | 0:00'21'' |
| Q25L60X160P001 | 160.0 | 3.97% | 19701 | 133.95K | 15 | 4331 | 7.37K | 43 | 36.0 | 14.0 | 3.0 | 72.0 | "31,41,51,61,71,81" | 0:01'01'' | 0:00'21'' |
| Q25L60X240P000 | 240.0 | 2.76% | 19424 | 151.22K | 30 | 1089 | 36.39K | 91 | 48.0 | 42.0 | 3.0 | 96.0 | "31,41,51,61,71,81" | 0:01'20'' | 0:00'22'' |
| Q25L60X240P001 | 240.0 | 3.14% | 19687 | 154.68K | 32 | 1217 | 36.98K | 90 | 49.0 | 43.0 | 3.0 | 98.0 | "31,41,51,61,71,81" | 0:01'21'' | 0:00'22'' |
| Q25L60X320P000 | 320.0 | 2.94% | 1522 | 118.85K | 77 | 12319 | 171.98K | 211 | 10.0 | 4.0 | 3.0 | 20.0 | "31,41,51,61,71,81" | 0:01'45'' | 0:00'23'' |
| Q25L60X320P001 | 320.0 | 2.98% | 1501 | 112.13K | 76 | 12319 | 173.2K | 209 | 11.0 | 5.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:01'46'' | 0:00'24'' |

## Table: statMRKunitigsAnchors.md
| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

## Table: statMRTadpoleAnchors.md
| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| MRX40P000 | 40.0 | 4.54% | 14285 | 132.28K | 19 | 1136 | 36.35K | 61 | 20.0 | 14.0 | 3.0 | 40.0 | "31,41,51,61,71,81" | 0:02'10'' | 0:00'19'' |
| MRX40P001 | 40.0 | 4.85% | 25837 | 125.81K | 9 | 1194 | 36.77K | 42 | 21.0 | 18.0 | 3.0 | 42.0 | "31,41,51,61,71,81" | 0:02'08'' | 0:00'20'' |
| MRX80P000 | 80.0 | 4.76% | 1473 | 104.93K | 71 | 2779 | 258.47K | 220 | 6.0 | 2.0 | 3.0 | 12.0 | "31,41,51,61,71,81" | 0:03'36'' | 0:00'20'' |
| MRX80P001 | 80.0 | 4.73% | 1483 | 92.69K | 61 | 5149 | 242.96K | 201 | 7.0 | 3.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:04'14'' | 0:00'20'' |
| MRX120P000 | 120.0 | 5.18% | 2299 | 243.85K | 115 | 1715 | 282.33K | 349 | 7.0 | 2.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:04'29'' | 0:00'21'' |
| MRX120P001 | 120.0 | 5.11% | 2370 | 237.82K | 114 | 2280 | 265.67K | 332 | 7.0 | 2.0 | 3.0 | 14.0 | "31,41,51,61,71,81" | 0:04'23'' | 0:00'22'' |
| MRX160P000 | 160.0 | 5.37% | 3150 | 332.79K | 125 | 2265 | 256.35K | 382 | 8.0 | 2.0 | 3.0 | 16.0 | "31,41,51,61,71,81" | 0:07'42'' | 0:00'22'' |
| MRX160P001 | 160.0 | 5.36% | 3136 | 324.24K | 123 | 1977 | 273.83K | 392 | 8.0 | 2.0 | 3.0 | 16.0 | "31,41,51,61,71,81" | 0:05'19'' | 0:00'22'' |
| MRX240P000 | 240.0 | 5.48% | 6441 | 400.15K | 106 | 2254 | 251.96K | 379 | 11.0 | 5.0 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:11'04'' | 0:00'24'' |
| MRX240P001 | 240.0 | 5.57% | 6547 | 390.04K | 94 | 2661 | 271.47K | 360 | 11.0 | 5.5 | 3.0 | 22.0 | "31,41,51,61,71,81" | 0:12'10'' | 0:00'24'' |
| MRX320P000 | 320.0 | 5.71% | 6731 | 436.29K | 124 | 1793 | 307.12K | 391 | 14.0 | 8.0 | 3.0 | 28.0 | "31,41,51,61,71,81" | 0:07'34'' | 0:00'25'' |
| MRX320P001 | 320.0 | 5.87% | 11147 | 417.24K | 91 | 1651 | 308.39K | 335 | 15.0 | 10.0 | 3.0 | 30.0 | "31,41,51,61,71,81" | 0:09'55'' | 0:00'25'' |

## Table: statMergeAnchors.md
| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 16769 | 849.74K | 255 | 1161 | 1.06M | 865 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 12459 | 819.75K | 257 | 1196 | 1.15M | 837 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 2643 | 619.39K | 257 | 1099 | 341.12K | 286 | 0.0 | 0.0 | 0.0 | 0.0 |  |

## Table: statOtherAnchors.md
| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 6.99% | 1044 | 18.28K | 17 | 1862 | 17.18M | 9317 | 4.0 | 1.0 | 3.0 | 8.0 | 0:01'26'' |
| 8_spades_MR | 16.19% | 1384 | 1.48M | 1047 | 2091 | 8.28M | 5283 | 9.0 | 5.0 | 3.0 | 18.0 | 0:00'58'' |
| 8_megahit | 4.15% | 1157 | 62.91K | 54 | 1427 | 5.55M | 3588 | 5.0 | 2.0 | 3.0 | 10.0 | 0:00'58'' |
| 8_megahit_MR | 9.62% | 1188 | 508.57K | 415 | 1357 | 7.73M | 5854 | 7.0 | 3.0 | 3.0 | 14.0 | 0:00'53'' |
| 8_platanus | 0.86% | 1075 | 7.45K | 6 | 2128 | 21.5K | 19 | 560.0 | 270.5 | 3.0 | 1120.0 | 0:00'45'' |

## Table: statFinal
| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| 7_mergeAnchors.anchors | 16769 | 849740 | 255 |
| 7_mergeAnchors.others | 1161 | 1063821 | 865 |
| anchorLong | 17882 | 815676 | 233 |
| anchorFill | 30072 | 811645 | 194 |
| spades.contig | 342 | 78957596 | 263092 |
| spades.scaffold | 347 | 78972643 | 261788 |
| spades.non-contained | 1865 | 17196095 | 9300 |
| spades_MR.contig | 1471 | 15884443 | 25976 |
| spades_MR.scaffold | 1484 | 15887548 | 25925 |
| spades_MR.non-contained | 2477 | 9759738 | 4242 |
| megahit.contig | 411 | 57707658 | 142420 |
| megahit.non-contained | 1438 | 5611389 | 3534 |
| megahit_MR.contig | 496 | 55331633 | 114102 |
| megahit_MR.non-contained | 1411 | 8234329 | 5444 |
| platanus.contig | 159 | 1082564 | 6104 |
| platanus.scaffold | 156 | 1009494 | 5965 |
| platanus.non-contained | 2128 | 28949 | 16 |

## Table: BUSCO.md
| File | C | S | D | F | M | Total |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| 7_mergeKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeTadpoleAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeMRKunitigsAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_mergeAnchors | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 7_anchorFill | 0 | 0 | 0 | 0 | 1440 | 1440 |
| 8_spades | 5 | 3 | 2 | 21 | 1414 | 1440 |
| 8_spades_MR | 4 | 4 | 0 | 6 | 1430 | 1440 |
| 8_megahit | 6 | 5 | 1 | 10 | 1424 | 1440 |
| 8_megahit_MR | 4 | 4 | 0 | 6 | 1430 | 1440 |
| 8_platanus | 0 | 0 | 0 | 0 | 1440 | 1440 |

