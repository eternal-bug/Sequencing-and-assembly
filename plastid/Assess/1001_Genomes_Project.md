![1001 genomes](http://1001genomes.org/layout_files/logo_1001genomes_v5.png)
# 🌱*Arabidopsis thaliana* - [1️⃣0️⃣0️⃣1️⃣](http://1001genomes.org/index.html) - 🔬

## 基本信息
+ Genome: GCF_000001735.3, TAIR10,  119.668 Mb
+ Chloroplast: [NC_000932](https://www.ncbi.nlm.nih.gov/nuccore/NC_000932), **Columbia**, 154478 bp , [文章](https://watermark.silverchair.com/dnares_6_5_283.pdf?token=AQECAHi208BE49Ooan9kkhW_Ercy7Dm3ZL_9Cf3qfKAc485ysgAAAj4wggI6BgkqhkiG9w0BBwagggIrMIICJwIBADCCAiAGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMd-POKnyXwGAWhHWtAgEQgIIB8WoNwMNhBQ1od7x9NaALzl6cSMYfg4xVmK_xbRh3ETRPw9pvfC13CR0v5mMquc0q5zqxJ_ReGAOUV919FPGAtlj82CxuUcwUJmEcNZknOWpPIKDkrP-2dEsg1Rn5z3O5kSmgP8JieTaLGMP8WvX-N1_NDKyyzz9chGmXgUI4y43EeY-iRz5djjlE2S4glv027DDD-MNYDdpojxiaOm4rw5ZT8EsOodOXbo0-BTqB_qP5sFRhDIz8-2og0P_Zbt2ssb0MEvmsvvu9sv0TC0HGiyuwJpuqgDPm0QEgUPbQyzy3_rIDfdvz2d4wODnBKnt-sVvuyip6-wOKrOu0-eVTUc2j5VkPPV7hW8WmBZtJrCn5vEhaA78VdCrBrhTtkzDNfBqPRMsiRk3wYaT3nwWf-t1Ovf1sp52Yi2SW2I8l7pAxF3kYVMrRQyrcIWSR5SOiLfPIAYz8gq5YCluH6JZ1RlM3908VnIuH-LxggE0k0OvFquCKF7hd_tzB96kTMBmqHj_EVmcFurwhwGusI1jiGG7veEShdB1HRB75oibs6OTd0p9wXdjw8zXobGTg0Du2f0327yEWXF2prVI6Qva5ACib-ksQrWe_dW25yIlWjKPL-le09RsCPLpKZBa2uZSKJg7h-s9mMLTww18eBc8cJXnN)
+ Chloroplast: [KX551970.1](https://www.ncbi.nlm.nih.gov/nuccore/KX551970.1), **Landsberg erecta**, 154515 bp
+ Mitochondrion: Y08501, 366924 bp

## 数据下载
```bash
mkdir -p  ~/data/anchr/Arabidopsis_thaliana/1001_project/sequence_data
cd ~/data/anchr/Arabidopsis_thaliana/1001_project/sequence_data
PRJ=PRJNA273563
list=(ALL)
nohup bash ~/Applications/my/download/download_EBI_sequence_data.sh $PRJ ${list[@]} &
```

## 项目信息 - PRJNA273563
> The 1001 Genomes Project was launched at the beginning of 2008 to discover the whole-genome sequence variation in 1001 accessions of the reference plant Arabidopsis thaliana. The resulting information is paving the way for a new era of genetics that identifies alleles underpinning phenotypic diversity across the entire genome and the entire species. Each of the accessions in the 1001 Genomes project is an inbred line with seeds that are freely available from the stock centre to all our colleagues. Unlimited numbers of plants with identical genotype can be grown and phenotyped for each accession, in as many environments as desired, and so the sequence information we collect can be used directly in association studies at biochemical, metabolic, physiological, morphological, and whole plant-fitness levels. The analyses enabled by this project will have broad implications for areas as diverse as evolutionary sciences, plant breeding and human genetics.

> 1001基因组计划于2008年初启动，旨在发现参考植物拟南芥中1001个基因组序列的变异。由此产生的信息正在为一个新的遗传学时代铺平道路，该时代将识别支撑整个基因组和整个物种表型多样性的等位基因。1001基因组计划的每一项研究都是一种自交系，种子可以从库存中心免费获得给我们所有的同事。无限数量的具有相同基因型的植物可以在任意多的环境中生长和表型，因此我们收集的序列信息可以直接用于生物化学、代谢、生理、形态学和整个植物适应性水平的关联研究。该项目的分析将对进化科学、植物育种和人类遗传学等不同领域产生广泛的影响。

+ [PRJNA273563 - Run信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA273563&go=go)
+ [每个SRR号对应的采样的信息(编号、名称、国家、纬度、经度、收集人、测序机构)](http://1001genomes.org/accessions.html)

| name | tg_ecotypeid | country | file | Bp | coverage | insert | read.len | seq type |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CYR | 88 | France |SRR1945435 | 1,502,278,600 * 2 | 25 |
| LDV-18 | 108 | France |SRR1945436 | 2,559,169,200 * 2 | 41 |
| LDV-46 | 139 | France |SRR1945437 | 1,891,946,300 * 2 | 30 |
| MAR2-3 | 159 | France |SRR1945438 | 2,072,913,300 * 2 | 33 |
| PYL-6 | 265 | France |SRR1945439 | 2,755,694,800 * 2 | 45 |
| TOU-A1-88 | 350 | France |SRR1945440 | 2,155,222,900 * 2 | 33 |
| TOU-A1-89 | 351 | France |SRR1945441 | 2,843,167,900 * 2 | 46 |
| Zdarec3 | 403 | Czech Republic |SRR1945442 |2,435,607,600 * 2 | 40 |
| Czech Republic 410|SRR1945443 |1,880,793,300 * 2 | 30 |
| Czech Republic 424|SRR1945444 |2,114,375,000 * 2 | 33 |
| Czech Republic 428|SRR1945445 |1,859,573,600 * 2 | 30 |
| Austria 430 |SRR1945446 |1,005,676,291 * 2 | 16 |
| USA 506 | SRR1945451 | 7,496,089,101 | 62 |
| USA 544 | SRR1945453 | 9,040,260,397 * 2 | 150|
| USA 546 | SRR1945454 | 6,182,362,720 * 2 | 103|
| USA 628 | SRR1945455 | 4,813,817,322 * 2 | 80 |
| USA 630 | SRR1945456 | 2,399,727,800 * 2 | 40 |
| USA 680 | SRR1945457 | 5,088,049,405 * 2 | 84 |
| USA 681 | SRR1945458 | 3,317,471,497 * 2 | 55 |
| USA 685 | SRR1945459 | 5,759,895,951 * 2 | 95 |
| Kyrgyzstan 763 | SRR1945463 | 1,910,796,780 * 2 | 31.8 |
| Kyrgyzstan 765 | SRR1945464 | 839,089,820 * 2 | 14 |
| Kyrgyzstan 766 | SRR1945465 | 1,029,582,082 * 2 | 17 |
| Kyrgyzstan 768 | SRR1945466 | 955,265,474 * 2 | 16 |
| United Kingdom 4779 | SRR1945544 | 1,766,284,700 * 2 | 29 |
| United Kingdom 4807 | SRR1945545 | 1,515,271,500 * 2 | 25 |
| United Kingdom 4826 | SRR1945546 | 1,028,655,700 * 2 | 17 |
| United Kingdom 4840 | SRR1945547 | 4,413,054,394 * 2 | 73 |
| United Kingdom 4857 | SRR1945548 | 4,497,166,475 * 2 | 73 |
| United Kingdom 4807 | SRR1945549 | 1,307,150,600 * 2 | 22 |
| Belgium 6898 | SRR1945750 | 882,620,416 * 2 | 14 |
| Cape Verde 6922 | SRR1945758 | 3,722,000,086 | 62 |
| Germany 6919 | SRR1945763 | 1,040,021,846 * 2 | 17 |
| Germany 6920 | SRR1945764 | 4,854,939,407 * 2 | 81 |
| Tajikistan 6929 | SRR1945770 | 1,183,025,120  * 2 | 19 |
| Spain 6933 | SRR1945773 | 10,100,000,000 * 2 | 168 |
| Russia 6938 | SRR1945774 | 1,632,820,237 * 2 | 27 |
| Netherlands 6945 | SRR1945778 | 2,058,382,929 * 2 | 34 |
| Italy 7025 | SRR1945813 | 1,045,951,556 * 2 | 17 |
| Finland 6968 | SRR1945789	| 1,438,061,688 * 2 | 24 |
| Finland 6969 | SRR1945790 | 2,436,723,576 * 2 | 40 |
| Austria 6975 | SRR1945795	|
| Austria 6976 | SRR1945796	|
| Ireland 7058 | SRR1945819 |
| Portugal 7077 | SRR1945828 |
| Portugal 7081 | SRR1945829 |
| Estonia 7127 | SRR1945844 |
| Denmark 7164 | SRR1945855 |
| India 7183 | SRR1945860 |
| Lithuania 7186 | SRR1945861 |
| Japan 7207 | SRR1945866 |
| Poland 7209 | SRR1945868 |

## 采用的倍数因子值
+ 2

## SRR1945435
+ 25

```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945435
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
    --trim2 "--dedupe --cutoff 50 --cutk 31" \
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

## SRR1945436
+ 41
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945436
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
    --trim2 "--dedupe --cutoff 82 --cutk 31" \
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

## SRR1945437
+ 30
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945437
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

## SRR1945438
+ 33
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945438
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
    --trim2 "--dedupe --cutoff 66 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945439
+ 45
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945439
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
    --trim2 "--dedupe --cutoff 90 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945440
+ 33
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945440
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
    --trim2 "--dedupe --cutoff 66 --cutk 31" \
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
  bash 0_bsub.sh
"
```

## SRR1945441
+ 46
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945441
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
    --trim2 "--dedupe --cutoff 92 --cutk 31" \
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
  bash 0_bsub.sh
"
```

## SRR1945442
+ 40
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945442
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
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945443
+ 30
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945443
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
    --trim2 "--dedupe --cutoff 60 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945444
+ 33
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945444
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
    --trim2 "--dedupe --cutoff 66 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945445
+ 30
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945445
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
  bash 0_bsub.sh
"
```

## SRR1945446
+ 16
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945446
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
    --trim2 "--dedupe --cutoff 32 --cutk 31" \
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
  bash 0_bsub.sh
"
```

## SRR1945451
+ 62
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945451
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
    --trim2 "--dedupe --cutoff 124 --cutk 31" \
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
  bash 0_bsub.sh
"
```

## SRR1945552
+ 28
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945552
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
    --trim2 "--dedupe --cutoff 56 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945453
+ 150
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945453
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
    --trim2 "--dedupe --cutoff 300 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945454
+ 103
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945454
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
    --trim2 "--dedupe --cutoff 206 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945455
+ 80
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945455
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
    --trim2 "--dedupe --cutoff 160 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945456
+ 40
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945456
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
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945457
+ 84
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945457
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
    --trim2 "--dedupe --cutoff 168 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945458
+ 55
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945458
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
    --trim2 "--dedupe --cutoff 110 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945459
+ 95
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945459
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
    --trim2 "--dedupe --cutoff 190 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 110 180 250 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```

## SRR1945463
+ 31.8
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945463
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
    --trim2 "--dedupe --cutoff 64 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945464
+ 14
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945464
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
    --trim2 "--dedupe --cutoff 28 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945465
+ 17
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945465
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
    --trim2 "--dedupe --cutoff 34 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945466
+ 16
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945466
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
    --trim2 "--dedupe --cutoff 32 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945544
+ 29
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945544
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
    --trim2 "--dedupe --cutoff 58 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945545
+ 25
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945545
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
    --trim2 "--dedupe --cutoff 50 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945546
+ 17
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945546
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
    --trim2 "--dedupe --cutoff 34 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945547
+ 73
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945547
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
    --trim2 "--dedupe --cutoff 146 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945548
+ 73
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945548
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
    --trim2 "--dedupe --cutoff 146 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945549
+ 22
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945549
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
    --trim2 "--dedupe --cutoff 44 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945750
+ 14
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945750
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
    --trim2 "--dedupe --cutoff 28 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945758
+ 62
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945758
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
    --trim2 "--dedupe --cutoff 124 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945763
+ 17
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945763
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
    --trim2 "--dedupe --cutoff 34 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945764
+ 81
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945764
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
    --trim2 "--dedupe --cutoff 162 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945770
+ 19
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945770
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
    --trim2 "--dedupe --cutoff 38 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320" \
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

## SRR1945773
+ 168
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945773
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
    --trim2 "--dedupe --cutoff 336 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320 390" \
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

## SRR1945774
+ 27
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945774
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
    --trim2 "--dedupe --cutoff 34 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320 390" \
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

## SRR1945778
+ 34
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945778
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
    --trim2 "--dedupe --cutoff 68 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320 390" \
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

## SRR1945813
+ 17
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945813
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
    --trim2 "--dedupe --cutoff 34 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320 390" \
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

## SRR1945789
+ 24
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945789
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
    --trim2 "--dedupe --cutoff 48 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320 390" \
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

## SRR1945790
+ 40
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945790
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
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 110 180 250 320 390" \
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
