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

### SRR
| type | ID | size.bp | coverage |
|--- | --- | --- | --- |
| | SRR3032026 | 9,435,796,200 * 2 | 22 |
| | SRR3032027 | 6,459,874,000 * 2 | 15 |
| | SRR3032028 | 6,471,655,700 * 2 | 15 |
| | SRR3032029 | 6,349,392,300 * 2 | 15 |
| | SRR3032030 | 8,280,906,900 * 2 | 20 |

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
