
# 数据来源
+ [PRJNA318822](https://www.ebi.ac.uk/ena/data/view/PRJNA318822)

# 出版文章
+ [《Extensive gene tree discordance and hemiplasy shaped the genomes of North American columnar cacti》](http://www.pnas.org/content/114/45/12003.long) - PNAS

# SRR
+ SRR5036292
+ SRR5036293
+ SRR5036294
+ SRR5036295
+ SRR5036296

## 数据下载
```bash
cd ~/data/anchr/
mkdir -p ./Carnegiea_gigantea/sequence_data
cd ./Carnegiea_gigantea/sequence_data
PRJ=PRJNA318822
list=(SRR5036292 SRR5036293 SRR5036294 SRR5036295 SRR5036296)
bash ~/Applications/my/download/download_EBI_sequence_data.sh $PRJ ${list[@]}
```
