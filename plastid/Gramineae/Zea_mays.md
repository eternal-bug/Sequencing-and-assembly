
# *Zea mays* - [🌽](https://maizegdb.org/)
+ 基因组 - ~2,000Mb
+ 叶绿体 - [NC_001666](https://www.ncbi.nlm.nih.gov/nuccore/NC_001666.2/) - 140384 bp
+ 线粒体 - [AY506529.1](https://www.ncbi.nlm.nih.gov/nuccore/AY506529.1) - 569630 bp

## 细胞器DNA参考序列下载
```bash
# NC_001666
# AY506529.1
```

## 数据来源
+ [PRJNA420919](https://www.ebi.ac.uk/ena/data/view/PRJNA420919) - EMBL下载
+ [PRJNA420919](https://www.ncbi.nlm.nih.gov/bioproject/420919) - NCBI信息

## 项目信息
> we constructed a high-density genetic map using the whole-genome resequencing and specific-locus amplified fragments sequencing (SLAF-seq) techniques for the “G533” and “X224M” elite maize inbred lines, and 196 F2 individuals from a cross between “G533” and “X224M”.

+ [PRJNA420919](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA420919&go=go)

## 下载的文件
+ SRR6360564 - p1
+ SRR6360563 - p2
+ SRR6360403
+ SRR6360390
+ SRR6360385
+ SRR6360370
+ SRR6360363

## 数据下载
```bash
PRJ=PRJNA420919
list=(SRR6360564 SRR6360563 SRR6360403 SRR6360390 SRR6360385 SRR6360370 SRR6360363)
nohup bash ~/Applications/my/download/download_EBI_sequence_data.sh $PRJ ${list[@]} &
```

## 测序文件信息
| ID | size.bp | coverage |
| --- | --- | --- |
| SRR6360564 | 13,747,908,900 * 2 | 1 |
| SRR6360563 | 12,343,162,350 * 2 | 1 |
| SRR6360403 | 869,665,448 * 2 | 0.8 |
| SRR6360390 | 536,906,341 * 2 | 0.5 |
| SRR6360385 | 623,831,920 * 2 | 0.5 |
| SRR6360370 | 541,241,310 * 2 | 0.5 |
| SRR6360363 | 462,410,560 * 2 | 0.5 |

## 采用的倍数因子值
+ **2**

## SRR6360564
+ 1
```bash
WORKING_DIR=~/stq/data/anchr/Zea_mays
BASE_NAME=SRR6360564
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 2 --cutk 31" \
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

bsub -q mpi -n 24 -J "${BASE_NAME}" "
bash 0_master.sh
"
```

### single-microspore
+ 单小孢子测序
+ SRP047362
+ [《Dissecting meiotic recombination based on tetrad analysis by single-microspore sequencing in maize.》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4383000/)

#### 额外
+ PRJNA307529
