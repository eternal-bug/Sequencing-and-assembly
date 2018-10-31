# 基本信息
+ 测序仪器:Illumina HiSeq 2000
+ 测序方式:PAIRED-end
+ 基因组大小:889.33~1118.34Mb
+ 细胞器基因组:152218[叶绿体 NC_007942.1] + 402558[线粒体 NC_020455.1]
+ 数据来源:[SRP045129](https://www.ebi.ac.uk/ena/data/view/PRJNA257011)

## 出版文章
+ [《Genome-wide association studies dissect the genetic networks underlying agronomical traits in soybean》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5571659/)

## 文件大小
| type | file | size.Bp | coverage | seq len |insert |	seq type | com |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| | SRR1533216 | 14,629,105,900 * 2 | ~29 | 100 | ~260 | Illumina HiSeq 2000 | + |
| | SRR1533268 | 18,279,053,000 * 2 | ~36 | 100 | ~340 | Illumina HiSeq 2000 | + |
| | SRR1533313 | 14,839,423,400 * 2 | ~29 | 100 | ~370 | Illumina HiSeq 2000 | + |
| | SRR1533335 | 15,061,368,600 * 2 | ~30 | 100 | ~280 | Illumina HiSeq 2000 | + |
| | SRR1533440 | 14,593,361,800 * 2 | ~29 | 100 | ~220 | Illumina HiSeq 2000 | + |
| | SRR1533156 |  2,285,324,500 * 2 | ~4.5| 100 | ~450 | Illumina HiSeq 2000 | p |
| | SRR1533158 |  6,246,197,600 * 2 | ~12 | | | Illumina HiSeq 2000 | p |
| | SRR1533161 |  8,174,320,700 * 2 | ~16 | | | Illumina HiSeq 2000 | p |
| | SRR1533166 |  8,780,802,200 * 2 | ~17 | | | Illumina HiSeq 2000 | p | 
| | SRR1533168 | 13,246,855,100 * 2 | ~26 | | | Illumina HiSeq 2000 | 

## 额外
| file | size.Bp | coverage |
| --- | --- | --- |
| SRR6122814 | 14,074,407,014 | ~14 |
| SRR6122815 | 11,624,172,412 | ~11 |
| SRR6122816 | 12,665,292,986 | ~12 |
| SRR6122817 | 10,918,099,172 | ~10 |
| SRR6122818 | 13,441,274,810 | ~13 |


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
