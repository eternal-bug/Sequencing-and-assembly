# *Hordeum vulgare* [大麦] 
+ 基因组大小 - 4.79Gb - [《A chromosome conformation capture ordered sequence of the barley genome》](https://www.nature.com/articles/nature22043)
+ 叶绿体基因组 - [NC_008590.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_008590.1) - 136462 bp
+ 线粒体基因组 - []()

## 项目信息
+ PRJEB21630
+ [《Sequencing of Single Pollen Nuclei Reveals Meiotic Recombination Events at Megabase Resolution and Circumvents Segregation Distortion Caused by Postmeiotic Processes》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5623100/)
+ 来自于“Morex” (♂) and “Barke” (♀) 杂交的F1代的花粉。

### Run


## 运行
```bash
n=0
fold_list=()
list=()

echo -n >srr_size_cov.txt
export genome_size=4800000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Hordeum_vulgare
cd ${WORKING_DIR}
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.fa
list=($(ls -d ERR*))

((max=${#list[@]}-1))
for i in $(seq 0 ${max});
do
  BASE_NAME=${list[$i]}
  fold=${fold_list[$i]}
  cd ${WORKING_DIR}/${BASE_NAME}

  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     if [ -d align ];
     then
       echo -n
     else
       mkdir align
     fi
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.fa \
         ./2_illumina/R1.fq.gz \
         ./2_illumina/R2.fq.gz > ./align/R.sam
      
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
     rm ./align/*.sam
  '
done
```
