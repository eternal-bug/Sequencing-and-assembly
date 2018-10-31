## 参考序列
+ KR336549.1 - 《Complete chloroplast genome sequence of MD-2 pineapple and its comparative analysis among nine other plants from the subclass Commelinidae.》

## 测序数据
+ unavailable - [《The pineapple genome and the evolution of CAM photosynthesis》](https://www.nature.com/articles/ng.3435) - https://genomevolution.org/CoGe/NotebookView.pl?nid=937. 
+ available - [《Complete chloroplast genome sequence of pineapple (Ananas comosus)》](https://link.springer.com/article/10.1007/s11295-015-0892-8) - [DRA002476](https://www.ebi.ac.uk/ena/data/view/DRA002476)

## 数据下载
```
cd ~/data/anchr/
mkdir -p ./Ananas_comosus/sequence_data
cd ./Ananas_comosus/sequence_data
PRJ=DRA002476
list=(DRR022930)
nohup bash ~/Applications/my/download/download_EBI_sequence_data.sh $PRJ ${list[@]} &
```
