# *Medicago truncatula* [蒺藜苜蓿] 倍数因子测试
+ 因子值 0.25、0.5、1、2、4、8、16、32
+ 测试文件 SRR965418 （覆盖度 2,863,407,166 * 2 / 500,000,000 ） = 10

## 前期准备
### 建立工作区
```bash
# 创建文件链接
mkdir ~/stq/data/anchr/Medicago_truncatula/A17/
cd ~/stq/data/anchr/Medicago_truncatula/A17/
mkdir ./genome
mkdir ./sequence_data
```
### 下载参考序列
```bash
cd ./genome
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/473/485/GCA_003473485.2_MtrunA17r5.0-ANR/GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna.gz
gzip -d GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna.gz
```
里面包含的内容
```text
CM010651.1 Medicago truncatula cultivar Jemalong A17 chromosome 4, whole genome shotgun sequence        64763011
CM010650.1 Medicago truncatula cultivar Jemalong A17 chromosome 3, whole genome shotgun sequence        58931556
CM010648.1 Medicago truncatula cultivar Jemalong A17 chromosome 1, whole genome shotgun sequence        56706830
CM010654.1 Medicago truncatula cultivar Jemalong A17 chromosome 7, whole genome shotgun sequence        56236587
CM010649.1 Medicago truncatula cultivar Jemalong A17 chromosome 2, whole genome shotgun sequence        51972579
CM010655.1 Medicago truncatula cultivar Jemalong A17 chromosome 8, whole genome shotgun sequence        49719271
CM010652.1 Medicago truncatula cultivar Jemalong A17 chromosome 5, whole genome shotgun sequence        44819618
CM010653.1 Medicago truncatula cultivar Jemalong A17 chromosome 6, whole genome shotgun sequence        42866092
PSQE01000009.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c01, whole genome shotgun sequence 1205179
PSQE01000010.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c02, whole genome shotgun sequence 597968
PSQE01000011.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c03, whole genome shotgun sequence 275140
PSQE01000012.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c04, whole genome shotgun sequence 257632
PSQE01000013.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c05, whole genome shotgun sequence 150389
PSQE01000014.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c06, whole genome shotgun sequence 113505
PSQE01000032.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c07, whole genome shotgun sequence 103625
PSQE01000033.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c08, whole genome shotgun sequence 97354
PSQE01000015.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c09, whole genome shotgun sequence 63286
PSQE01000016.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c10, whole genome shotgun sequence 53388
PSQE01000017.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c11, whole genome shotgun sequence 45761
PSQE01000018.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c12, whole genome shotgun sequence 43307
PSQE01000034.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c13, whole genome shotgun sequence 41540
PSQE01000019.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c14, whole genome shotgun sequence 38627
PSQE01000020.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c15, whole genome shotgun sequence 36939
PSQE01000035.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c16, whole genome shotgun sequence 36837
PSQE01000021.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c17, whole genome shotgun sequence 34091
PSQE01000022.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c18, whole genome shotgun sequence 33035
PSQE01000023.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c19, whole genome shotgun sequence 31600
PSQE01000024.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c20, whole genome shotgun sequence 31121
PSQE01000036.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c21, whole genome shotgun sequence 30237
PSQE01000025.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c22, whole genome shotgun sequence 28310
PSQE01000037.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c23, whole genome shotgun sequence 27546
PSQE01000038.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c24, whole genome shotgun sequence 26982
PSQE01000039.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c25, whole genome shotgun sequence 26781
PSQE01000040.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c26, whole genome shotgun sequence 24993
PSQE01000026.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c27, whole genome shotgun sequence 24837
PSQE01000027.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c28, whole genome shotgun sequence 23812
PSQE01000028.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c29, whole genome shotgun sequence 23547
PSQE01000029.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c30, whole genome shotgun sequence 23407
PSQE01000030.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c31, whole genome shotgun sequence 23291
PSQE01000031.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c32, whole genome shotgun sequence 22751
```
下载叶绿体与线粒体序列
```bash

```
需要改名以后需更好的查看
```bash

```

## 0.25
+ 10 * 0.25 = 2.5 ~= 
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_0.25
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 10 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

## 0.5
+ 10 * 0.5 = 5
```bash

```

## 1
+ 10 * 1 = 10

## 2
+ 10 * 2 = 20

## 4
+ 10 * 4 = 40 

## 8
+ 10 * 8 = 80

## 16
+ 10 * 16 = 160

## 32
+ 10 * 32 = 320
