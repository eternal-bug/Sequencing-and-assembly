# 🌾*Oryza sativa* [水稻]
+ SRR063598 16倍


## 前期准备

### 建立工作区

```bash
mkdir ~/stq/data/anchr/Oryza_sativa
cd ~/stq/data/anchr/Oryza_sativa
mkdir ./genome
mkdir ./sequence_data
```

### 下载参考序列

+ [Oryza sativa Japonica Group (Japanese rice) - IRGSP-1.0](https://www.ncbi.nlm.nih.gov/assembly/GCF_001433935.1)
+ 
```bash
cd ./genome
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/433/935/GCF_001433935.1_IRGSP-1.0/GCF_001433935.1_IRGSP-1.0_genomic.fna.gz
gzip -d GCF_001433935.1_IRGSP-1.0_genomic.fna.gz
```
