# 🌱*Brassica napus*[欧洲油菜]
+ 基因组大小 849 Mb [《Early allopolyploid evolution in the post-Neolithic Brassica napus oilseed genome》](http://science.sciencemag.org/content/345/6199/950)
+ 叶绿体基因组[NC_016734](https://www.ncbi.nlm.nih.gov/nuccore/383930428) - 152860 bp
+ 线粒体基因组[NC_008285](https://www.ncbi.nlm.nih.gov/nuccore/NC_008285.1) - 221853 bp

## 相关站点
+ [CEA](http://www.genoscope.cns.fr/brassicanapus/)

## 数据下载
### 项目信息
+ [PRJNA305854](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA305854&go=go)
+ [《Dissection of the genetic architecture of three seed-quality traits and consequences for breeding in Brassica napus》](https://onlinelibrary.wiley.com/doi/pdf/10.1111/pbi.12873)

### 其他可能可用的数据
+ PRJNA476657

### SRR
| type | No | source | ID | size.bp | coverage |
| --- |--- | --- | --- | --- | --- |
| Zhongshuang2 | g001 | Hubei (China) | SRR3032026 | 9,435,796,200 * 2 | 22 |
| Zhongza-H8002 | g002 | Hubei (China) | SRR3032027 | 6,459,874,000 * 2 | 15 |
| Quantum(oo) | g024 | Canada | SRR3032028 | 6,471,655,700 * 2 | 15 |
| Bugle(TT) | g033 | Canada | SRR3032029 | 6,349,392,300 * 2 | 15 |
| G1044 | g042 | Europe | SRR3032030 | 8,280,906,900 * 2 | 20 |
| --- |
| Chuan91 | g050 | Sichuan (China) | SRR3032031 | 5,454,564,000 * 2 | 12 |
| G1085 | g081 | Hubei (China) | SRR3032032 | 7,844,623,000 * 2 | 18 |
| G1087 | g083 | Hubei (China) | SRR3032033 | 5,780,927,000 * 2 | 13 |
| 84001 | g094 | Hubei (China) | SRR3032034 | 8,552,708,300 * 2 | 20 |
| Baihua | g097 | Hubei (China) | SRR3032035 | 7,447,260,500 * 2 | 17 |
| --- | 

### 运行

#### SRR3032026
+ 22

```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032026
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
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_master.sh
"
```

#### SRR3032027
+ 15
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032027
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
    --trim2 "--dedupe --cutoff 60 --cutk 31" \
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

#### SRR3032028
+ 15
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032028
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
    --trim2 "--dedupe --cutoff 60 --cutk 31" \
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

#### SRR3032029
+ 15
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032029
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
    --trim2 "--dedupe --cutoff 60 --cutk 31" \
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

#### SRR3032030
+ 20
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032030
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
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
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

#### SRR3032031
+ 12
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032031
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
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_master.sh
"
```

#### SRR3032032
+ 18
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032032
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

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_master.sh
"
```

#### SRR3032033
+ 13
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032033
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
    --trim2 "--dedupe --cutoff 52 --cutk 31" \
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

#### SRR3032034
+ 20
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032034
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
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
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

#### SRR3032035
+ 17
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_napus
BASE_NAME=SRR3032035
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
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_master.sh
"
```
