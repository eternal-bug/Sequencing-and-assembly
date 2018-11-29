# *Brassica rapa*[芜菁]
+ 基因组大小 ： 485 Mb - [《The genome of the mesopolyploid crop species Brassica rapa - nature genetics》](https://www.nature.com/articles/ng.919)
+ 叶绿体基因组[CN_015139.1](https://www.ncbi.nlm.nih.gov/nuccore/323481965) - 153482 bp
+ 线粒体基因组[JF920285](https://www.ncbi.nlm.nih.gov/nuccore/JF920285.1) - 219747 bp

## 相关
+ [Brassica rapa FPsc](https://fpsc.wisc.edu/growguide/Instructions_and_Tips_for_Growing_FPsc.pdf)
+ [fastplants](https://fastplants.org)

## 数据下载
+ Arabidopsis comparative genomics(ACG) - Brassica, Boechera, Arabidopsis 
```
SRX2330877
SRX2330820
SRX2095535
SRX2095530
SRX2095529
SRX2095528
SRX2066845
SRX2066841
SRX2066838
SRX2066836
SRX2066834
SRX2066833
SRX2066832
SRX2066831
SRX2066830
SRX2066829
SRX2066828
SRX2066827
SRX2066826
SRX2066825
```

## SRR文件信息
| type | SRR | size.bp | coverage |
| --- | --- | --- | ---- |
| FPsc S7 B8 | SRR4996371 | 1,412,600,400 * 2 | 6 |
| FPsc S7 D4 | SRR4996316 | 1,108,828,950 * 2 | 5 |
| FPsc S7 B10 | SRR4116114 | 1,168,897,950 * 2 | 5 |
| FPsc S7 E9 | SRR4116071 | 813,978,150 * 2 | 3 |
| FPsc S7 D9 | SRR4116070 | 1,290,799,950 * 2 | 5 |
| FPsc S7 G10 | SRR4116069 | 1,135,376,100 * 2 | 5 |
| FPsc S7 H10 | SRR4098140 | 1,334,516,400 * 2 | 5 |
| FPsc S7 H11 | SRR4098136 | 1,170,578,550 * 2 | 5 |
| FPsc S7 G11 | SRR4098135 | 1,317,606,450 * 2 | 5 |
| FPsc S7 G10 | SRR4098134 | 1,396,111,200 * 2 | 5 |

## 运行

### SRR4996371
+ 6

```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4996371
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
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_master.sh
"
```

### SRR4996316
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4996316
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4116114
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4116114
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4116071
+ 3
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4116071
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
  bash 0_master.sh
"
```

### SRR4116070
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4116070
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4116069
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4116069
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4098140
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4098140
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4098136
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4098136
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4098135
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4098135
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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

### SRR4098134
+ 5
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_rapa
BASE_NAME=SRR4098134
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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
