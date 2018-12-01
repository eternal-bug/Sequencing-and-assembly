# *Brassica oleracea*[甘蓝]
+ 基因组大小 - 630 Mb [《The Brassica oleracea genome reveals the asymmetrical evolution of polyploid genomes》](https://www.nature.com/articles/ncomms4930)
+ 叶绿体 - [KR233156.1](https://www.ncbi.nlm.nih.gov/nuccore/KR233156.1) - 153366 bp
+ 线粒体 - [NC_016118.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_016118.1) - 360271 bp

## 项目
+ [PRJNA312457](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA312457)
+ [Run 信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA312457&go=go)
+ [《Subgenome parallel selection is associated with morphotype diversification and convergent crop domestication in Brassica rapa and Brassica oleracea》](http://agri.ckcest.cn/ass/NK002-20160919001.pdf)

## Run信息
| type | ID | size | coverage |
| --- | --- | --- | --- |
| SamC_001 | SRR3202000 |
| SamC_002 | SRR3202020 | 3,595,665,600 * 2 | 11 |
| SamC_003 | SRR3202029 | 3,526,454,100 * 2 | 11 |
| SamC_004 | SRR3202031 | 3,577,760,600 * 2 | 11 |
| SamC_005 | SRR3202032 | 3,088,236,700 * 2 | 10 |
| SamC_006 | SRR3202033 | 3,528,418,200 * 2 | 11 |
| SamC_007 | SRR3202040 | 
| SamC_008 | SRR3202041 | 
| SamC_009 | SRR3202042 | 
| SamC_010 | SRR3202043 | 
| SamC_011 | SRR3202044 |

## SRR3202020
+ 11
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_oleracea
BASE_NAME=SRR3202020
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
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

## SRR3202029
+ 11
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_oleracea
BASE_NAME=SRR3202029
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
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

## SRR3202031
+ 11
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_oleracea
BASE_NAME=SRR3202031
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
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

## SRR3202032
+ 10
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_oleracea
BASE_NAME=SRR3202032
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

## SRR3202033
+ 11
```bash
WORKING_DIR=~/stq/data/anchr/Brassica_oleracea
BASE_NAME=SRR3202033
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
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
