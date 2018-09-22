# Medicago[苜蓿]
+ Illumina HiSeq 2000
+ 测序方式: pair-end
+ 基因组 500M
+ Mt	271618
+ Pt	124033

# 文件大小
| type | file | size.Bp | coverage |
| --- | --- | --- | --- |
| Medicago truncatula HM050 | SRR1034293_1.fastq.gz | 11355255600 | ~45.2 |
| Medicago truncatula HM050 | SRR1034293_2.fastq.gz | 11355255600 | ~45.2 |
| Medicago truncatula HM340 | SRR1524305_1.fastq.gz | 16611812400 | ~66 |
| Medicago truncatula HM340 | SRR1524305_2.fastq.gz | 16611812400 | ~66 |
| Medicago truncatula A17 | SRR1542423_1.fastq.gz |  4479178836 | ~18 |
| Medicago truncatula A17 | SRR1542423_2.fastq.gz |  4479178836 | ~18 |
| Medicago truncatula A17 | SRR965418_1.fastq.gz  |  2863407166 | ~11 |
| Medicago truncatula A17 | SRR965418_2.fastq.gz  |  2863407166 | ~11 |
| Medicago truncatula HM022 | SRR2163426_1.fastq.gz | -- | -- |
| Medicago truncatula HM022 | SRR2163426_2.fastq.gz | -- | -- |
| Medicago truncatula HM056 | SRR1552478_1.fastq.gz | 20468900300 | ~80 |
| Medicago truncatula HM056 | SRR1552478_2.fastq.gz | 20468900300 | ~80 |

## 建立工作区以及文件链接

## SRR1034293
+ ~45.2覆盖度

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1034293
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
    --trim2 "--dedupe --cutoff 180 --cutk 31" \
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
```

## SRR1524305
+ ~66

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1524305
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
    --trim2 "--dedupe --cutoff 264 --cutk 31" \
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
```

## SRR1542423
+ ~18

```bash
WORKING_DIR=~/stq/data/anchr/Medicago
BASE_NAME=SRR1542423
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
```
