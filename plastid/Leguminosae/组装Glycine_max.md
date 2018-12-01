
# *Glycine max*[大豆]
+ 测序仪器:Illumina HiSeq 2000
+ 测序方式:PAIRED-end
+ 基因组大小:889.33~1118.34Mb
+ 细胞器基因组:152218[叶绿体 NC_007942.1] + 402558[线粒体 NC_020455.1]
+ 数据来源:[SRP045129](https://www.ebi.ac.uk/ena/data/view/PRJNA257011)

## 出版文章
+ [《Genome-wide association studies dissect the genetic networks underlying agronomical traits in soybean》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5571659/)

## 文件大小
| type | file | size.Bp | coverage | seq len |insert |	seq type |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| IGDB-TZX-062(w) | SRR1533156 |  2,285,324,500 * 2 | ~4.5| 100 | ~450 | Illumina HiSeq 2000 |
| IGDB-TZX-0991(w) | SRR1533158 |  6,246,197,600 * 2 | ~12 | | | Illumina HiSeq 2000 |
| IGDB-TZX-152(w) | SRR1533161 |  8,174,320,700 * 2 | ~16 | | | Illumina HiSeq 2000 |
| IGDB-TZX-232(w) | SRR1533166 |  8,780,802,200 * 2 | ~17 | | | Illumina HiSeq 2000 |
| IGDB-TZX-262(w) | SRR1533168 | 13,246,855,100 * 2 | ~26 | | | Illumina HiSeq 2000 |
| IGDB-TZX-272(w) | SRR1533169 | 11,069,937,000 * 2 | ~22 | p |
| IGDB-TZX-282(w) | SRR1533170 | 8,126,501,814 * 2 | ~16 | p |
| IGDB-TZX-2991(w) | SRR1533171 | 8,746,432,900 * 2 | ~17 | p |
| IGDB-TZX-322(w) | SRR1533172 | 6,263,427,800 * 2 | ~12 | p |
| IGDB-TZX-332(w) | SRR1533173 | 9,547,507,200 * 2 | ~19 | p |
| IGDB-TZX-011 | SRR1533216 | 14,629,105,900 * 2 | ~29 | 100 | ~260 | Illumina HiSeq 2000 |
| IGDB-TZX-017 | SRR1533217 | 5,378,017,000 * 2 | ~10 | p |
| IGDB-TZX-022 | SRR1533218 | 3,488,938,600 * 2 | ~6  | p |
| IGDB-TZX-027 | SRR1533219 | 7,356,473,200 * 2 | ~14 | p |
| IGDB-TZX-031 | SRR1533220 | 6,479,795,500 * 2 | ~12 | p |
| IGDB-TZX-050 | SRR1533221 | 8,558,788,700 * 2 | ~16 | p |
| IGDB-TZX-412 | SRR1533268 | 18,279,053,000 * 2 | ~36 | 100 | ~340 | Illumina HiSeq 2000 |
| IGDB-TZX-721 | SRR1533313 | 14,839,423,400 * 2 | ~29 | 100 | ~370 | Illumina HiSeq 2000 |
| IGDB-TZX-940 | SRR1533335 | 15,061,368,600 * 2 | ~30 | 100 | ~280 | Illumina HiSeq 2000 |
| IGDB-TZX-890 | SRR1533440 | 14,593,361,800 * 2 | ~29 | 100 | ~220 | Illumina HiSeq 2000 |


+ (w) is Glycine soja, otherwise Glycine max.

+ [strains](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA257011&go=go)

## 其他
+ Pseudomonas syringae pv. syringae B728a, complete genome - [CP000075.1](https://www.ncbi.nlm.nih.gov/nuccore/CP000075.1)

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

+ ~29


## 组装
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533216
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

# SRR1533268
+ ~36

```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533268
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

```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533313
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

# SRR1533335
+ ~30

```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533335
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

# 提交超算任务
bash 0_bsub.sh
```

# SRR1533440
+ ~29

```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533440
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
    --trim2 "--dedupe --cutoff 126 --cutk 31" \
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

## SRR1533156
+ ~4.5

```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533156
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
    --trim2 "--dedupe --cutoff 18 --cutk 31" \
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

# SRR1533158
+ ~12
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533158
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
    --trim2 "--dedupe --cutoff 48 --cutk 31" \
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


SRR1533161
+ ~16
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533161
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
    --trim2 "--dedupe --cutoff 64 --cutk 31" \
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

# SRR1533166
+ ~17
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533166
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
    --trim2 "--dedupe --cutoff 68 --cutk 31" \
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

# SRR1533168
+ ~26
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533168
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
    --trim2 "--dedupe --cutoff 104 --cutk 31" \
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

# SRR1533169
+ ~22
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533169
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
    --trim2 "--dedupe --cutoff 88 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533170
+ ~16
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533170
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
    --trim2 "--dedupe --cutoff 64 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533171
+ ~17
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533171
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
    --trim2 "--dedupe --cutoff 68 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533172
+ ~12
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533172
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
    --trim2 "--dedupe --cutoff 48 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533173
+ ~19
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533173
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
    --trim2 "--dedupe --cutoff 76 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533217
+ ~10
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533217
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
    --trim2 "--dedupe --cutoff 40 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533218
+ ~6
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533218
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
    --trim2 "--dedupe --cutoff 24 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533219
+ ~14
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533219
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
    --trim2 "--dedupe --cutoff 56 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533220
~12
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533220
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
    --trim2 "--dedupe --cutoff 48 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

# SRR1533221
~16
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533221
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
    --trim2 "--dedupe --cutoff 64 --cutk 31" \
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
bsub -q mpi -n 24 -J "${BASE_NAME}" '
  bash 0_master.sh
'
```

