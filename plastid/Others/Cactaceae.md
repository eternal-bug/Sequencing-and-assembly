
# 数据来源
+ [PRJNA318822](https://www.ebi.ac.uk/ena/data/view/PRJNA318822)

## 出版文章
+ [《Extensive gene tree discordance and hemiplasy shaped the genomes of North American columnar cacti》](http://www.pnas.org/content/114/45/12003.long) - PNAS

## 数据有待挖掘
+ [《Molecular phylogenetics of Echinopsis (Cactaceae): Polyphyly at all levels and convergent evolution of pollination modes and growth forms》](https://onlinelibrary.wiley.com/doi/full/10.3732/ajb.1100288)

# SRR
+ SRR5036292 - Carnegiea_gigantea
+ SRR5036293 - Carnegiea_gigantea
+ SRR5036294 - Carnegiea_gigantea
+ SRR5036295 - Carnegiea_gigantea
+ SRR5036296 - Carnegiea_gigantea
+ SRR5137214 - Pachycereus pringlei
+ SRR5137213 - Stenocereus thurberi
+ SRR5137212 - Pereskia horrida
+ SRR5137211 - Lophocereus schottii

## 数据下载
```bash
cd ~/data/anchr/
mkdir -p ./Carnegiea_gigantea/sequence_data
cd ./Carnegiea_gigantea/sequence_data
PRJ=PRJNA318822
list=(SRR5036292 SRR5036293 SRR5036294 SRR5036295 SRR5036296)
bash ~/Applications/my/download/download_EBI_sequence_data.sh $PRJ ${list[@]}
```
