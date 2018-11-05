# *Arabidopsis thaliana* - 拟南芥

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

## 项目信息 - PRJNA273563 - 1001 Genomes Project
> The 1001 Genomes Project was launched at the beginning of 2008 to discover the whole-genome sequence variation in 1001 accessions of the reference plant Arabidopsis thaliana. The resulting information is paving the way for a new era of genetics that identifies alleles underpinning phenotypic diversity across the entire genome and the entire species. Each of the accessions in the 1001 Genomes project is an inbred line with seeds that are freely available from the stock centre to all our colleagues. Unlimited numbers of plants with identical genotype can be grown and phenotyped for each accession, in as many environments as desired, and so the sequence information we collect can be used directly in association studies at biochemical, metabolic, physiological, morphological, and whole plant-fitness levels. The analyses enabled by this project will have broad implications for areas as diverse as evolutionary sciences, plant breeding and human genetics.

> 1001基因组计划于2008年初启动，旨在发现参考植物拟南芥中1001个基因组序列的变异。由此产生的信息正在为一个新的遗传学时代铺平道路，该时代将识别支撑整个基因组和整个物种表型多样性的等位基因。1001基因组计划的每一项研究都是一种自交系，种子可以从库存中心免费获得给我们所有的同事。无限数量的具有相同基因型的植物可以在任意多的环境中生长和表型，因此我们收集的序列信息可以直接用于生物化学、代谢、生理、形态学和整个植物适应性水平的关联研究。该项目的分析将对进化科学、植物育种和人类遗传学等不同领域产生广泛的影响。

+ [PRJNA273563 - Run信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA273563&go=go)

| type | file | Bp | coverage | insert | read.len | seq type |
| --- | --- | --- | --- | --- | --- | --- |
| France 88 |SRR1945435 | 1,502,278,600 * 2 | 25 |
| France 265|SRR1945436 | 2,559,169,200 * 2 | 41 |
| France 350|SRR1945437 | 1,891,946,300 * 2 | 30 |
| France 351|SRR1945438 | 2,072,913,300 * 2 | 33 |
| Czech Republic 403|SRR1945439 | 2,755,694,800 * 2 | 45 |

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
