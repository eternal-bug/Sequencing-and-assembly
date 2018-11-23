# Arabidopsis_thaliana 倍数因子测试
+ 因子值 0.5、1、2、4、8、16
+ 测试文件 SRR616966 （覆盖度 2,485,179,600 * 2 / 120,000,000 ） = 40

## 建立工作区
```bash
# 创建文件链接
mkdir ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
cd ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
mkdir ./genome
cd genome
# 下载哥伦比亚的参考序列
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/735/GCF_000001735.4_TAIR10.1/GCF_000001735.4_TAIR10.1_genomic.fna.gz
gzip -d GCF_000001735.4_TAIR10.1_genomic.fna.gz
mv GCF_000001735.4_TAIR10.1_genomic.fna genome.fa
# 创建文件链接
bash create_sequence_file_link.sh

# 复制不同倍数的文件夹
for i in 0.5 1 2 4 8 16;
do
  cp -r SRR616966 SRR616966_${i}
done
```

## 下载安装bwa
```bash
cd ~/stq/Applications/biosoft
# 下载bwa
wget https://github.com/lh3/bwa/releases/download/v0.7.13/bwakit-0.7.13_x64-linux.tar.bz2
tar -xjvf bwakit-0.7.13_x64-linux.tar.bz2
# 更改文件名
mv bwa.kit bwa-0.7.13
# 查看mem算法的使用说明
./bwa-0.7.13/bwa mem
```

## 建立参考序列索引
```
cd ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
bsub -q mpi -n 24 -J "bwa-index" '
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.fa
'
```

## 0.5
+ 40 * 0.5 = 20

### 进行修剪
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_0.5
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

### 比对
```bash
bsub -q mpi -n 24 -J "SRR616966_0.5" '
   ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
       -t 5 \
       
'
```

## 1
+ 40 * 1 = 40
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_1
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 40 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

## 2
+ 40 * 2 = 80
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_2
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

## 4
+ 40 * 4 = 160
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_4
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 160 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

## 8
+ 40 * 8 = 320
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_8
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 320 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

## 16
+ 40 * 16 = 640
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_16
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 640 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```
