# *Glycine soja* [野大豆] 🌱
+ 测序仪器:Illumina HiSeq 2000
+ 测序方式:PAIRED-end 
+ 数据来源:SRP045129
+ 基因组大小 [《De novo assembly of soybean wild relatives for pan-genome analysis of diversity and agronomic traits》](https://www.nature.com/articles/nbt.2979) -  889.33 Mbp ~ 1,118.34 Mbp
+ 叶绿体[NC_022868.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_022868.1) - 152217 bp
+ 线粒体[NC_039768.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_039768.1) - 402545 bp

## 出版文章
+ [《Genome-wide association studies dissect the genetic networks underlying agronomical traits in soybean》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5571659/)

## 文件大小

| type | file | size.Bp | coverage | seq len |insert |	seq type |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| IGDB-TZX-0002| SRR1533152 |
| IGDB-TZX-032 | SRR1533153 |
| IGDB-TZX-042 | SRR1533154 |
| IGDB-TZX-052 | SRR1533155 |
| IGDB-TZX-062 | SRR1533156 |  2,285,324,500 * 2 | ~4.5| 100 | ~450 | Illumina HiSeq 2000 |
| IGDB-TZX-082 | SRR1533157 | 
| IGDB-TZX-0991 | SRR1533158 |  6,246,197,600 * 2 | ~12 | | | Illumina HiSeq 2000 |
| IGDB-TZX-082 | SRR1533159 |
| IGDB-TZX-152 | SRR1533161 |  8,174,320,700 * 2 | ~16 | | | Illumina HiSeq 2000 |
| IGDB-TZX-232 | SRR1533166 |  8,780,802,200 * 2 | ~17 | | | Illumina HiSeq 2000 |
| IGDB-TZX-262 | SRR1533168 | 13,246,855,100 * 2 | ~26 | | | Illumina HiSeq 2000 |
| IGDB-TZX-272 | SRR1533169 | 11,069,937,000 * 2 | ~22 | p |
| IGDB-TZX-282 | SRR1533170 | 8,126,501,814 * 2 | ~16 | p |
| IGDB-TZX-2991 | SRR1533171 | 8,746,432,900 * 2 | ~17 | p |
| IGDB-TZX-322 | SRR1533172 | 6,263,427,800 * 2 | ~12 | p |
| IGDB-TZX-332 | SRR1533173 | 9,547,507,200 * 2 | ~19 | p |


## SRR1533156
+ ~4.5

```bash
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
WORKING_DIR=~/stq/data/anchr/Glycine_soja
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
