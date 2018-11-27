# *Medicago truncatula* [蒺藜苜蓿] 倍数因子测试
+ 因子值 0.25、0.5、1、2、4、8、16、32
+ 测试文件 SRR965418 （覆盖度 2,863,407,166 * 2 / 500,000,000 ） = 10

## 前期准备
### 建立工作区
```bash
# 创建文件链接
mkdir ~/stq/data/anchr/Medicago_truncatula/A17/
cd ~/stq/data/anchr/Medicago_truncatula/A17/
mkdir ./genome
mkdir ./sequence_data
```
### 下载参考序列
```bash
cd ./genome
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/473/485/GCA_003473485.2_MtrunA17r5.0-ANR/GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna.gz
gzip -d GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna.gz
```
里面包含的内容
```text
>CM010648.1 Medicago truncatula cultivar Jemalong A17 chromosome 1, whole genome shotgun sequence
>CM010649.1 Medicago truncatula cultivar Jemalong A17 chromosome 2, whole genome shotgun sequence
>CM010650.1 Medicago truncatula cultivar Jemalong A17 chromosome 3, whole genome shotgun sequence
>CM010651.1 Medicago truncatula cultivar Jemalong A17 chromosome 4, whole genome shotgun sequence
>CM010652.1 Medicago truncatula cultivar Jemalong A17 chromosome 5, whole genome shotgun sequence
>CM010653.1 Medicago truncatula cultivar Jemalong A17 chromosome 6, whole genome shotgun sequence
>CM010654.1 Medicago truncatula cultivar Jemalong A17 chromosome 7, whole genome shotgun sequence
>CM010655.1 Medicago truncatula cultivar Jemalong A17 chromosome 8, whole genome shotgun sequence
>PSQE01000009.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c01, whole genome shotgun sequence
>PSQE01000032.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c07, whole genome shotgun sequence
>PSQE01000010.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c02, whole genome shotgun sequence
>PSQE01000033.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c08, whole genome shotgun sequence
>PSQE01000011.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c03, whole genome shotgun sequence
>PSQE01000034.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c13, whole genome shotgun sequence
>PSQE01000012.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c04, whole genome shotgun sequence
>PSQE01000035.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c16, whole genome shotgun sequence
>PSQE01000013.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c05, whole genome shotgun sequence
>PSQE01000036.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c21, whole genome shotgun sequence
>PSQE01000014.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c06, whole genome shotgun sequence
>PSQE01000037.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c23, whole genome shotgun sequence
>PSQE01000015.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c09, whole genome shotgun sequence
>PSQE01000038.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c24, whole genome shotgun sequence
>PSQE01000016.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c10, whole genome shotgun sequence
>PSQE01000039.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c25, whole genome shotgun sequence
>PSQE01000017.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c11, whole genome shotgun sequence
>PSQE01000040.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c26, whole genome shotgun sequence
>PSQE01000018.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c12, whole genome shotgun sequence
>PSQE01000019.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c14, whole genome shotgun sequence
>PSQE01000020.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c15, whole genome shotgun sequence
>PSQE01000021.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c17, whole genome shotgun sequence
>PSQE01000022.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c18, whole genome shotgun sequence
>PSQE01000023.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c19, whole genome shotgun sequence
>PSQE01000024.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c20, whole genome shotgun sequence
>PSQE01000025.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c22, whole genome shotgun sequence
>PSQE01000026.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c27, whole genome shotgun sequence
>PSQE01000027.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c28, whole genome shotgun sequence
>PSQE01000028.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c29, whole genome shotgun sequence
>PSQE01000029.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c30, whole genome shotgun sequence
>PSQE01000030.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c31, whole genome shotgun sequence
>PSQE01000031.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c32, whole genome shotgun sequence
```
改名
```bash
mv GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna genome.fa
mkdir temp
for i in {1..8};
do
  export num=${i}
  list=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8)
  export title=${list[((${i} - 1))]}
  cat ./genome.fa | perl -n -e '
    BEGIN{
      use vars qw/$n $flag/;
      $n = 0;
      $flag = 0;
    }
    if(index($_,">")==0){
      $flag = 1;
      $n++;
    }
    if($n == $ENV{num}){
      if($flag == 1){
        print ">",$ENV{title},"\n";
      }else{
        print $_;
      }
      $flag = 0;
    }
  ' > ./temp/${title}.fa
done
```

下载叶绿体与线粒体序列
+ pt:NC_003119
+ mt:NC_029641
```bash
pt.fa
mt.fa
```
合并基因组序列与细胞器基因组序列
```bash
cd temp
cat *.fa > genome.new.fa
```

## 批处理
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
cd ${WORKING_DIR}
bash create_sequence_file_link.sh
for i in 0 0.2 0.5 1 2 4 8 16 32;
do
  cp -r SRR965418 SRR965418_${i}
done

# ============= clean and cutoff ===============
# 0
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
BASE_NAME=SRR965418_0
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24
    
    bsub -q mpi -n 24 -J "${BASE_NAME}" "
      bash 2_trim.sh
    "

# 0.2 0.5 1 2 4 8 16 32
for i in 0.2 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  cutoff=$(echo "${i} * 10" | bc | perl -p -e 's/\..+//')
# anchr
  anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff ${cutoff} --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24
    
    bsub -q mpi -n 24 -J "${BASE_NAME}" "
      bash 2_trim.sh
    "
done

# ========= build genome file index =========
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa

# ============== align ======================


for i in 0 0.2 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.new.fa \
         ./2_illumina/trim/Q25L60/R1.fq.gz \
         ./2_illumina/trim/Q25L60/R2.fq.gz > ./align/Rp.sam
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.new.fa \
         ./2_illumina/trim/Q25L60/Rs.fq.gz > ./align/Rs.sam
         
     cp ./align/Rp.sam ./align/R.sam
     cat ./align/Rs.sam | grep -v "^@" >> ./align/R.sam
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
  '
  cd ${WORKING_DIR}
done
```


## 0.25


## 0.5


## 1


## 2


## 4


## 8


## 16


## 32

