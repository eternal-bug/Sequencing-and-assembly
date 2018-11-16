![1001 genomes](http://1001genomes.org/layout_files/logo_1001genomes_v5.png)
# 🌱*Arabidopsis thaliana* - [1001基因组计划](http://1001genomes.org/index.html) - 🔬

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

| NO | name | tg_ecotypeid | country | file | Bp | coverage | insert | read.len | seq type |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | CYR | 88 | France | [SRR1945435](#srr1945435) | 1,502,278,600 * 2 | 25 |
| 2 | LDV-18 | 108 | France |SRR1945436 | 2,559,169,200 * 2 | 41 |
| 3 | LDV-46 | 139 | France |SRR1945437 | 1,891,946,300 * 2 | 30 |
| 4 | MAR2-3 | 159 | France |SRR1945438 | 2,072,913,300 * 2 | 33 |
| 5 | PYL-6 | 265 | France |SRR1945439 | 2,755,694,800 * 2 | 45 |
| 6 | TOU-A1-88 | 350 | France |SRR1945440 | 2,155,222,900 * 2 | 33 |
| 7 | TOU-A1-89 | 351 | France |SRR1945441 | 2,843,167,900 * 2 | 46 |
| 8 | Zdarec3 | 403 | Czech Republic |SRR1945442 |2,435,607,600 * 2 | 40 |
| 9 | Doubravnik7 | 410 | Czech Republic |SRR1945443 |1,880,793,300 * 2 | 30 |
| 10 | Draha2 | 424 | Czech Republic |SRR1945444 |2,114,375,000 * 2 | 33 |
| --- |
| 11 | Borky1 | 428 | Czech Republic |SRR1945445 |1,859,573,600 * 2 | 30 |
| 12 | Gr-1 | 430 | Austria |SRR1945446 |1,005,676,291 * 2 | 16 |
| 13 | BRR60 | 506 | USA | SRR1945451 | 7,496,089,101 | 62 |
| 14 | LI-WP-039 | 544 | USA | SRR1945453 | 9,040,260,397 * 2 | 150|
| 15 | LI-WP-041 | 546 | USA | SRR1945454 | 6,182,362,720 * 2 | 103|
| 16 | LI-OF-061 | 628 | USA | SRR1945455 | 4,813,817,322 * 2 | 80 |
| 17 | LI-OF-065 | 630 | USA | SRR1945456 | 2,399,727,800 * 2 | 40 |
| 18 | LI-RR-096 | 680 | USA | SRR1945457 | 5,088,049,405 * 2 | 84 |
| 19 | LI-RR-097 | 681 | USA | SRR1945458 | 3,317,471,497 * 2 | 55 |
| 20 | LI-EF-011 | 685 | USA | SRR1945459 | 5,759,895,951 * 2 | 95 |
| --- |
| 21 | Kar-1 | 763 | Kyrgyzstan | SRR1945463 | 1,910,796,780 * 2 | 31.8 |
| 22 | Sus-1 | 765 | Kyrgyzstan | SRR1945464 | 839,089,820 * 2 | 14 |
| 23 | Dja-1 | 766 | Kyrgyzstan | SRR1945465 | 1,029,582,082 * 2 | 17 |
| 24 | Zal-1 | 768 | Kyrgyzstan | SRR1945466 | 955,265,474 * 2 | 16 |
| 25 | KYC-33 | 801 | USA | SRR1945468 | 2,122,994,300 * 2 | 35 | ~260 | 100 |
| 26 | MIA-1 | 853 | USA | SRR1945469 | 6,086,325,773 * 2 | 101 |
| 27 | CHA-41 | 932 | USA | SRR1945475 | 1,539,234,600 * 2 | 25 | ~260 | 100 |
| 28 | Ale-Stenar-41-1 & root | 991 | Sweden | SRR1945476 | 3,416,265,400 * 2 | 56 | ~350 | 100 |
| 29 | Brösarp-11-135 & root | 1061 | Sweden | SRR1945481 | 982,748,800 * 2 | 16 | ~350 | 100 |
| 30 | Aledal-6-49 & root | 1158 | Sweden | SRR1945486 | 2,627,887,200 * 2 | 44 | ~300 | 100 |
| --- |
| 31 | Tos-82-387 $ root | 1254 | Sweden | SRR1945488 | 1,933,310,100 * 2 | 32 | ~300 | 100 |
| 32 | Ängsö-59-422 & root | 1313 | Sweden | SRR1945490 | 1,689,223,200 * 2 | 28 | ~300 | 100 |
| 33 | Sku-30 | 1552 & root | Sweden | SRR1945492 | 4,560,486,300 * 2 | 76 |
| 34 | Brn-10 | 1612 | Sweden | SRR1945493 | 2,812,152,199 * 2 | 47 |
| 35 | DuckLkSP38 | 1651 | USA | SRR1945495 | 3,015,921,821 * 2 | 50 |
| 36 | Haz-2 | 1676 | USA | SRR1945497 | 3,278,366,298 * 2 | 55 |
| 37 | Ker-4 | 1756 | USA | SRR1945501 | 2,602,947,897 * 2 | 43 |
| 38 | L-R-5 | 1793 | USA | SRR1945503 | 5,027,106,911 * 2 | 84 |
| 39 | Lak-12 | 1819 | USA | SRR1945505 | 3,066,548,484 * 2 | 51 |
| 40 | Mdn-1 | 1829 | USA | SRR1945507 | 2,569,538,100 * 2 | 43 |
| --- |
| 41 | MNF-Pot-10 | 1851 | USA | SRR1945510 | 4,994,310,631 * 2 | 83 |
| 42 | Map-8 | 2031 | USA | SRR1945521 | 2,468,332,736 * 2 | 41 |
| 43 | Pent-7 | 2191 | USA | SRR1945532 | 4,556,001,002 * 2 | 76 |
| 44 | Riv-25 | 2239 | USA | SRR1945535 | 3,095,601,171 * 2 | 51 |
| 45 | SLSP-31 | 2276 | USA | SRR1945537 | 1,368,690,100 * 2 | 23 |
| 46 | Ste-40 | 2317 | USA | SRR1945541 | 1,723,758,400 * 2 | 29 |
| 47 | UKSW06-179 | 4779 | United Kingdom | SRR1945544 | 1,766,284,700 * 2 | 29 |
| 48 | Bra-1 | 5717 | United Kingdom | SRR1945570 | 3,855,462,860 * 2 | 64 |
| 49 | UKID11 | 5718 | United Kingdom | SRR1945571 | 5,437,975,566 * 2 | 90 |
| 50 | Cal-2 | 5720 | United Kingdom | SRR1945572 | 1,627,814,900 * 2 | 27 |
| --- |
| 51 | Cnt-1 | 5726 | United Kingdom | SRR1945573 | 1,815,377,600 * 2 | 30 |
| 52 | For-2 | 5741 | United Kingdom | SRR1945574 | 1,289,959,300 * 2 | 21 |
| 53 | Kil-0 | 5748 | United Kingdom | SRR1945575 | 1,908,521,600 * 2 | 31 |
| 54 | Mc-1 | 5757 | United Kingdom | SRR1945576 | 1,774,000,300 * 2 | 30 |
| 55 | UKID63 | 5768 | United Kingdom | SRR1945577 | 2,628,940,000 * 2 | 44 |
| 56 | Set-1 | 5772 | United Kingdom | SRR1945578 | 2,748,865,900 * 2 | 45 |
| 57 | Ty-1 | 5784 | United Kingdom | SRR1945581 | 2,000,266,200 * 2 | 33 |
| 58 | App1-12 & Root | 5830 | Sweden | SRR1945586 | 1,914,840,596 * 2 | 32 | 
| 59 | Bor-1 | 5837 | Czech Republic | SRR1945590 | 1,128,842,155 * 2 | 19 |
| 60 | DraII-6 | 5874 | Czech Republic | SRR1945595 | 1,950,086,100 * 2 | 32 |
| --- |
| 61 | Duk | 6008 | Czech Republic | SRR1945603 | 2,442,009,714 * 2 | 40 |
| *** |
| 62 | UduI 1-11 | 6296 | Czech Republic | SRR1945732 | 1,976,260,700 * 2 | 33 |
| 63 | ZdrI 1-23 | 6424 | Czech Republic | SRR1945736 | 2,204,689,500 * 2 | 36 |
| 64 | ANH-1 | 6680 | Germany | SRR1945739 | 1,089,147,943 * 2 | 18 |
| 65 | CSHL-15 | 6739 | USA | SRR1945740 | 3,317,385,649 * 2 | 55 |
| 66 | FM-10 | 6749 | USA | SRR1945743 | 3,631,451,345 * 2 | 60 |
| 67 | HS-12	| 6805 | USA | SRR1945745 | 3,978,858,983 * 2 | 66 |
| 68 | KNO-15 | 6814 | USA | SRR1945747 | 3,436,338,850 * 2 | 57 |
| 69 | Kz-13 | 6830 | Kazakhstan | SRR1945748 | 5,469,207,697 * 2 | 91 |
| 70 | Ag-0 | 6897 | France | SRR1945749 | 1,024,262,917 * 2 | 17 |
| *** |
| --- |
| 71 | An-1 | 6898 | Belgium | SRR1945750 | 882,620,416 * 2 | 14 |
| 72 | Cvi-0 | 6911 | Cape Verde | SRR1945758 | 3,722,000,086 | 62 |
| 73 | Ga-0 | 6919 | Germany | SRR1945763 | 1,040,021,846 * 2 | 17 |
| 74 | Got-22 | 6920 | Germany | SRR1945764 | 4,854,939,407 * 2 | 81 |
| 75 | Kondara | 6929 | Tajikistan | SRR1945770 | 1,183,025,120  * 2 | 19 |
| 76 | LL-0 | 6933 | Spain | SRR1945773 | 10,100,000,000 * 2 | 168 |
| 77 | Ms-0 | 6938 | Russia | SRR1945774 | 1,632,820,237 * 2 | 27 |
| 78 | Nok-3 | 6945 | Netherlands | SRR1945778 | 2,058,382,929 * 2 | 34 |
| 79 | Tamm-2 | 6968 | Finland | SRR1945789	| 1,438,061,688 * 2 | 24 |
| 80 | Tamm-27 | 6969 | Finland | SRR1945790 | 2,436,723,576 * 2 | 40 |
| --- |
| 81 | Uod-1 | 6975 | Austria | SRR1945795	| 
| 82 | Bl-1 | 7025 | Italy | SRR1945813 | 1,045,951,556 * 2 | 17 |
| 83 | Bur-0 | 7058 | Ireland | SRR1945819 |
| 84 | Co-1 | 7077 | Portugal | SRR1945828 |
| 85 | Co | 7081 | Portugal | SRR1945829 |
| 86 | Est | 7127 | Estonia | SRR1945844 |
| 87 | Hau-0 | 7164 | Denmark | SRR1945855 |
| 88 | Kas-1 | 7183 | India | SRR1945860 |
| 89 | Kn-0 | 7186 | Lithuania | SRR1945861 |
| 90 | Kyoto | 7207 | Japan | SRR1945866 |
| --- |
| 91 | La-0 | 7209 | Poland | SRR1945868 |
| 92 | Ler-0 | 7213 | Germany | SRR1945869 | 
| 93 | Lm-2 | 7217 | France | SRR1945870 |
| 94 | Le-0 | 7218 | Netherlands | SRR1945871 |
| 95 | Li-7 | 7231 | Germany | SRR1945873 |
| 96 | Litva | 7236	| Lithuania | SRR1945874 |
| 97 | Mnz-0 | 7244	| Germany | SRR1945875 |
| 98 | Mv-0 | 7248 | USA | SRR1945876 |
| 99 | Me-0 | 7250 | Germany | SRR1945877 |
| 99 | Mh-0 | 7255 | Germany | SRR1945878 |
| 100| Nw-0 | 7258 | Germany | SRR1945879 |

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

## SRR1945468
+ 35
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945468
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
    --trim2 "--dedupe --cutoff 70 --cutk 31" \
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

## SRR1945469
+ 101
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945469
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
    --trim2 "--dedupe --cutoff 202 --cutk 31" \
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

## SRR1945475
+ 25
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945475
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

## SRR1945476
+ 56
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945476
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
    --trim2 "--dedupe --cutoff 112 --cutk 31" \
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

## SRR1945481
+ 16
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945481
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

## SRR1945486
+ 44
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945486
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

## SRR1945488
+ 32
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945488
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

## SRR1945490
+ 28
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945490
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

## SRR1945492
+ 76
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945492
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
    --trim2 "--dedupe --cutoff 152 --cutk 31" \
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

## SRR1945493
+ 47
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945493
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
    --trim2 "--dedupe --cutoff 94 --cutk 31" \
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

## SRR1945495
+ 50
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945495
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
    --trim2 "--dedupe --cutoff 100 --cutk 31" \
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

## SRR1945497
+ 55
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945497
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

## SRR1945501
+ 43
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945501
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
    --trim2 "--dedupe --cutoff 86 --cutk 31" \
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

## SRR1945503
+ 84
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945503
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

## SRR1945505
+ 51
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945505
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
    --trim2 "--dedupe --cutoff 102 --cutk 31" \
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

## SRR1945507
+ 43
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945507
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
    --trim2 "--dedupe --cutoff 86 --cutk 31" \
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

## SRR1945510
+ 83
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945510
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
    --trim2 "--dedupe --cutoff 166 --cutk 31" \
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

## SRR1945521
+ 41
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945521
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

## SRR1945532
+ 76
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945532
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
    --trim2 "--dedupe --cutoff 152 --cutk 31" \
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

## SRR1945535
+ 51
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945535
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
    --trim2 "--dedupe --cutoff 102 --cutk 31" \
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

## SRR1945537
+ 23
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945537
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
    --trim2 "--dedupe --cutoff 46 --cutk 31" \
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

## SRR1945541
+ 29
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945541
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

## SRR1945570
+ 64
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945570
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
    --trim2 "--dedupe --cutoff 128 --cutk 31" \
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

## SRR1945571
+ 90
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945571
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
    --trim2 "--dedupe --cutoff 180 --cutk 31" \
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

## SRR1945572
+ 27
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945572
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
    --trim2 "--dedupe --cutoff 54 --cutk 31" \
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

## SRR1945573
+ 30
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945573
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

## SRR1945574
+ 21
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945574
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
    --trim2 "--dedupe --cutoff 42 --cutk 31" \
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

## SRR1945575
+ 31
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945575
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
    --trim2 "--dedupe --cutoff 62 --cutk 31" \
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

## SRR1945576
+ 30
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945576
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

## SRR1945577
+ 44
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945577
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
    --trim2 "--dedupe --cutoff 88 --cutk 31" \
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

## SRR1945578
+ 45
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945578
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

## SRR1945581
+ 33
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945581
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

## SRR1945586
+ 32
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945586
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

## SRR1945590
+ 19
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945590
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

## SRR1945595
+ 32
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945595
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

## SRR1945603
+ 40
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945603
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

## SRR1945732
+ 33
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945732
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

## SRR1945736
+ 36
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945736
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
    --trim2 "--dedupe --cutoff 72 --cutk 31" \
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

## SRR1945739
+ 18
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945739
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
    --trim2 "--dedupe --cutoff 36 --cutk 31" \
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

## SRR1945740
+ 55
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945740
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

## SRR1945743
+ 60
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945743
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
    --trim2 "--dedupe --cutoff 120 --cutk 31" \
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

## SRR1945745
+ 66
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945745
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
    --trim2 "--dedupe --cutoff 132 --cutk 31" \
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


## SRR1945747
+ 57
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945747
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
    --trim2 "--dedupe --cutoff 114 --cutk 31" \
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

## SRR1945748
+ 91
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945748
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
    --trim2 "--dedupe --cutoff 182 --cutk 31" \
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

## SRR1945749
+ 17
```
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/1001_project
BASE_NAME=SRR1945749
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
