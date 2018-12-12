# *B.oleracea* and *B.rapa*

## 数据来源
+ PRJEB2715
+ [《Use of mRNA-seq to discriminate contributions to the transcriptome from the constituent genomes of the polyploid crop species Brassica napus》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3428664/)

## 测序文件信息

+ RNA-Seq

| type | source | ID | size.bp | coverage |
| --- | --- | --- | --- | --- |
| Brassica napus 1 replicate 1, doubled haploid progeny from B. rapa Ro18 X B.oleracea A12DH cross (B. rapa maternal) | TGAC | ERR049700 | 
| Brassica napus 1 replicate 2, doubled haploid progeny from B. rapa Ro18 X B.oleracea A12DH cross (B. rapa maternal) | TGAC | ERR049701 |
| Brassica napus 1 replicate 3, doubled haploid progeny from B. rapa Ro18 X B.oleracea A12DH cross (B. rapa maternal) | TGAC |  ERR049702 |
| Brassica napus 1 replicate 4, doubled haploid progeny from B. rapa Ro18 X B.oleracea A12DH cross (B. rapa maternal) | TGAC |  ERR049703 |
| Brassica napus 2 replicate 1, doubled haploid progeny from B. oleracea A12DH x B. rapa Ro18 cross (B. oleracea maternal) | TGAC |  ERR049704 |
| Brassica napus 2 replicate 2, doubled haploid progeny from B. oleracea A12DH x B. rapa Ro18 cross (B. oleracea maternal) | TGAC |  ERR049705 |
| Brassica napus 2 replicate 3, doubled haploid progeny from B. oleracea A12DH x B. rapa Ro18 cross (B. oleracea maternal) | TGAC |  ERR049706 |
| Brassica napus 2 replicate 4, doubled haploid progeny from B. oleracea A12DH x B. rapa Ro18 cross (B. oleracea maternal) | TGAC |  ERR049707 |
| B. rapa Ro18 replicate 2 | TGAC |  ERR049708 |
| B. rapa Ro18 replicate 2 | TGAC |  ERR049709 |
| B. oleracea A12DH replicate 2 | TGAC |  ERR049710 |
| B. oleracea A12DH replicate 2 | TGAC | ERR049711 |
| Brassica napus 1 replicate 1, doubled haploid progeny from B. rapa Ro18 X B.oleracea A12DH cross (B. rapa maternal) | ERR049712 | TGAC
| Cultivar 'Ceska' | TGAC | ERR049713 |
| Aphid resistant rape | TGAC | ERR049714 |


## 查看亲本是否为异质的可能
+ 以B.napus的叶绿体序列作为参考序列，查看亲本的测序序列的map情况

### 建立文件链接
```bash
WORKING_DIR=${HOME}/stq/data/anchr/oleracea_and_rapa
cd ${WORKING_DIR}
mkdir ERR049708
mkdir ERR049710
for BASE_NAME in $(ls -d ERR*);
do
  cd ${WORKING_DIR}/${BASE_NAME}
  mkdir 2_illumina
  cd 2_illumina
  ln -fs ../../sequence_data/${BASE_NAME}.fastq.gz ./R1.fq.gz
done
```

### 序列修剪

```bash
for BASE_NAME in $(ls -d ERR*);
do
  cd ${WORKING_DIR}/${BASE_NAME}
  anchr template \
    . \
    --se \
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
done
```

### 建立索引
```bash
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/*.fa
```

### 比对
```bash
cd ${WORKING_DIR}
for BASE_NAME in $(ls -d ERR*);
do
  cd ${WORKING_DIR}/${BASE_NAME}
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" "
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/*.fa \
         ./2_illumina/trim/Q25L60/R1.fq.gz > ./align/R.sam
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
  "
done
```

### 
