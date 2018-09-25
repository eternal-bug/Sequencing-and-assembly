# 基本信息
+ 测序仪器:Illumina HiSeq 2000
+ 测序方式:PAIRED-end
+ 基因组大小:889.33~1118.34Mb
+ 细胞器基因组:152218[叶绿体] + 402558[线粒体]
+ 数据来源:[SRP045129](https://www.ebi.ac.uk/ena/data/view/PRJNA257011)

## 测序文件
+ SRR1533216
+ SRR1533268
+ SRR1533313
+ SRR1533335
+ SRR1533440

## 文件大小
| type | file | size.Bp | coverage | insert |	seq type |
| --- | ---: | ---: | ---: | ---: | ---: |
| | SRR1533216 | 14,629,105,900 * 2 | ~29 | | Illumina HiSeq 2000 |
| | SRR1533268 | 18,279,053,000 * 2 | ~36 | | Illumina HiSeq 2000 |
| | SRR1533313 | 14,839,423,400 * 2 | ~29 | | Illumina HiSeq 2000 |
| | SRR1533335 | 15,061,368,600 * 2 | ~30 | | Illumina HiSeq 2000 |
| | SRR1533440 | 14,593,361,800 * 2 | ~29 | | Illumina HiSeq 2000 |


# 前期准备
## 新建工作区
```bash
cd ~/stq/data/anchr/
mkdir -p ../Glycine_max/sequence_data
mkdir -p ../Glycine_max/genome
mv ./*.fastq.gz ../Glycine_max/seuqence_data
mv ./*.fa ../Glycine_max/genome
```

## 查看参考文件的基因组大小
```bash
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

# 结果
'>NC_007942.1 Glycine max chloroplast, complete genome': 152218
'>NC_020455.1 Glycine max mitochondrion, complete genome': 402558
```

# SRR1533216
## 参数为（--genome 1_000_000_000 # --cutoff 116）
### 组装
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533216
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 116 --cutk 31" \
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
bash 0_bsub.sh
```

### 统计结果
### Table: statInsertSize

| Group | Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:--|--:|--:|--:|--:|
| R.genome.bbtools | 332.5 | 270 | 1551.0 | 12.37% |
| R.tadpole.bbtools | 266.3 | 267 | 34.7 | 21.21% |
| R.genome.picard | 271.0 | 270 | 28.6 | FR |
| R.tadpole.picard | 265.6 | 267 | 34.3 | FR |

### Table: statReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 402558 | 554776 | 2 |
| Illumina.R | 100 | 29.26G | 292582118 |
| trim.R | 100 | 9.23G | 93369642 |
| Q25L60 | 100 | 8.63G | 87686255 |

### Table: statTrimReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumpify | 100 | 26G | 260009450 |
| highpass | 100 | 9.64G | 96360908 |
| trim | 100 | 9.23G | 93369642 |
| filter | 100 | 9.23G | 93369642 |
| R1 | 100 | 4.64G | 46684821 |
| R2 | 100 | 4.59G | 46684821 |
| Rs | 0 | 0 | 0 |


```text
#R.trim
#Matched	39892	0.04140%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	0	0.00000%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	223951645
#main_peak	1137
#genome_size	1605477
#haploid_genome_size	1605477
#fold_coverage	637
#haploid_fold_coverage	637
#ploidy	1
#percent_repeat	90.820
#start	center	stop	max	volume
```



### Table: statMergeReads

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| clumped | 100 | 9.22G | 93296614 |
| ecco | 100 | 9.22G | 93296614 |
| eccc | 100 | 9.22G | 93296614 |
| ecct | 100 | 7.38G | 74704664 |
| extended | 140 | 9.59G | 74704664 |
| merged.raw | 317 | 5.81G | 18662721 |
| unmerged.raw | 122 | 4.52G | 37379222 |
| unmerged.trim | 122 | 4.52G | 37375794 |
| M1 | 318 | 4.66G | 14967229 |
| U1 | 122 | 2.27G | 18687897 |
| U2 | 122 | 2.25G | 18687897 |
| Us | 0 | 0 | 0 |
| M.cor | 217 | 9.19G | 67310252 |

| Group | Mean | Median | STDev | PercentOfPairs |
|:--|--:|--:|--:|--:|
| M.ihist.merge1.txt | 138.7 | 144 | 34.5 | 1.06% |
| M.ihist.merge.txt | 311.4 | 312 | 43.0 | 49.96% |


### Table: statQuorum

| Name | CovIn | CovOut | Discard% | Kmer | RealG | EstG | Est/Real | RunTime |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
| Q0L0.R | 9.2 | 8.7 | 6.07% | "71" | 1G | 108.84M | 0.11 | 0:16'55'' |
| Q25L60.R | 8.6 | 8.2 | 5.14% | "71" | 1G | 103.81M | 0.10 | 0:15'55'' |

### Table: statKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMRKunitigsAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMRTadpoleAnchors.md

| Name | CovCor | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | Kmer | RunTimeKU | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

### Table: statMergeAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 7_mergeAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRKunitigsAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeMRTadpoleAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |
| 7_mergeTadpoleAnchors | 0.00% | 0 | 0 | 0 | 0 | 0 | 0 | 0.0 | 0.0 | 0.0 | 0.0 |  |

### Table: statOtherAnchors.md

| Name | Mapped% | N50Anchor | Sum | # | N50Others | Sum | # | median | MAD | lower | upper | RunTimeAN |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 8_spades | 15.75% | 1166 | 1.42M | 1171 | 1262 | 3.82M | 4963 | 21.0 | 6.0 | 3.0 | 42.0 | 0:02'37'' |
| 8_spades_MR | 34.58% | 1265 | 1.41M | 1081 | 2485 | 3.27M | 3168 | 50.0 | 28.0 | 3.0 | 100.0 | 0:02'01'' |
| 8_megahit | 13.73% | 2686 | 404.04K | 183 | 1241 | 358.41K | 430 | 930.0 | 904.0 | 3.0 | 1860.0 | 0:01'54'' |
| 8_megahit_MR | 31.83% | 1156 | 389.22K | 327 | 1201 | 3.58M | 3120 | 41.0 | 30.0 | 3.0 | 82.0 | 0:01'57'' |
| 8_platanus | 27.23% | 4848 | 173.55K | 54 | 5132 | 257.69K | 111 | 2127.0 | 996.0 | 3.0 | 4254.0 | 0:01'57'' |

### Table: statFinal

| Name | N50 | Sum | # |
|:--|--:|--:|--:|
| Genome | 402558 | 554776 | 2 |
| 7_mergeAnchors.anchors | 0 | 0 | 0 |
| 7_mergeAnchors.others | 0 | 0 | 0 |
| anchorLong | 0 | 0 | 0 |
| anchorFill | 0 | 0 | 0 |
| spades.contig | 122 | 222542252 | 1709604 |
| spades.scaffold | 122 | 222573665 | 1708314 |
| spades.non-contained | 1274 | 5242878 | 3841 |
| spades_MR.contig | 823 | 12192820 | 14884 |
| spades_MR.scaffold | 824 | 12194770 | 14853 |
| spades_MR.non-contained | 1934 | 4673378 | 2360 |
| megahit.contig | 340 | 24362105 | 69791 |
| megahit.non-contained | 3207 | 762448 | 350 |
| megahit_MR.contig | 525 | 48648701 | 96392 |
| megahit_MR.non-contained | 1223 | 3964467 | 2866 |
| platanus.contig | 157 | 1485189 | 8798 |
| platanus.scaffold | 5949 | 485160 | 338 |
| platanus.non-contained | 6279 | 431243 | 95 |

# SRR1533268
+ ~36

### 组装
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533268
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 144 --cutk 31" \
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
bash 0_bsub.sh
```

# SRR1533313
+ ~29

### 组装
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533313
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 116 --cutk 31" \
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
bash 0_bsub.sh
```
