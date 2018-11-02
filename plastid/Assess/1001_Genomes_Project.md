# *Arabidopsis thaliana* - 拟南芥

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
