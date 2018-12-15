# *Sorghum bicolor* [高粱]
+ C4植物
+ 基因组[《The Sorghum bicolor genome and the diversification of grasses》](https://www.nature.com/articles/nature07723) - 730 Mb
+ 叶绿体[NC_008602.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_008602.1) - 140754 bp
+ 线粒体[NC_008360.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_008360.1) - 468628 bp

## 项目信息
+ [PRJNA374837](https://www.ebi.ac.uk/ena/data/view/PRJNA374837)
+ Whole genome resequencing of Sorghum bicolor lines 100M, 80M, BTx623, BTx642, Hegari, IS3620C, SC170-6-17, Standard Broomcorn, and Tx7000.
+ [《The Sorghum bicolor reference genome: improved assembly, gene annotations, a transcriptome atlas, and signatures of genome organization》](https://onlinelibrary.wiley.com/doi/full/10.1111/tpj.13781)

## Run信息

| type | No | size.bp | coverage |
| --- | --- | --- | --- |
| 100M | SRR5271054 | 26,764,097,875 * 2 | 73 |
| 80M | SRR5271055 | 26,192,973,875 * 2 | 71 |
| BTx623 | SRR5271056 | 28,419,733,500 * 2 | 77 |
| BTx642 | SRR5271057 | 12,797,298,625 * 2 | 35 |
| Hegari | SRR5271058 | 24,744,128,375 * 2 | 67 |
| IS3620C | SRR5271059 | 28,020,115,750 * 2 | 76 |
| Standard Broomcorn | SRR5271060 | 23,616,122,750 * 2 | 64 | 
| SC170-6-17 | SRR5271061 | 25,958,610,625 * 2 | 71 |
| Tx7000 | SRR5271062 | 14,431,409,875 * 2 | 39 |

##

### SRR5271054
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271054
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
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_master.sh
"
```

### SRR5271054
+ 73
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271054
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=73*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271055
+ 71
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271055
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=71*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271056
+ 77
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271056
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=77*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271057
+ 35
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271057
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=35*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271058
+ 67
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271058
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=67*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271059
+ 76
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271059
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=76*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271060
+ 64 
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271060
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=64*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```


### SRR5271061
+ 71
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271061
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=71*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```

### SRR5271062
+ 39
```bash
WORKING_DIR=~/stq/data/anchr/Sorghum_bicolor/
BASE_NAME=SRR5271062
FOLD=
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh
((FOLD=39*4))
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
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
  bash 0_master.sh
"
```
