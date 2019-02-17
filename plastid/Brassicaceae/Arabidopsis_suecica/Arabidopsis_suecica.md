# Arabidopsis suecica
+ 叶绿体基因组 [LT161986 ](https://www.ncbi.nlm.nih.gov/nucleotide/LT161986.1?report=genbank&log$=nucltop&blast_rank=1&RID=6J3FKXZV014) - 154371 bp

## 项目信息
+ [《Genome Sequencing Reveals the Origin of the Allotetraploid Arabidopsis suecica》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5400380/)
+ [PRJNA309929](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA309929) - Arabidopsis suecica的测序文件
+ [PRJNA284572](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA284572) - 拟南芥属的测序文件

## 序列比对

```bash
n=0
fold_list=()
list=()

echo -n >srr_size_cov.txt
export genome_size=200000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Arabidopsis_suecica
cd ${WORKING_DIR}
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.fa

list=($(ls -d SRR*))

# get cut off fold number
parallel -j 20 --ungroup -k --delay 1 "
  bash ~/stq/Applications/my/stat/stat_fastq_size.sh ./sequence_data/{1}_1.fastq.gz | tail -n 1 
" ::: ${list[@]} | \
sed 's/ //g' | \
sed 's/^|//g' | \
sed 's/|$//g' | \
sed 's/|/:/g' | \
while IFS=$':' read -r -a row;
do
  SRR=$(basename ${row[0]} | perl -p -e 's/[._]R?\d+\.f(ast)*q\.gz//')
  NUMBER=${row[1]}
  DEPTH=$(echo ${NUMBER} | sed 's/,//g' | perl -n -e 'printf "%.0f",$_*2/$ENV{genome_size}')
  FOLD=$(echo ${NUMBER} | sed 's/,//g' | perl -n -e 'printf "%.0f",$_*2*4/$ENV{genome_size}')
  echo ${SRR}\|${NUMBER}\|${DEPTH}\|${FOLD}
done | \
sort -k1.4 -t\| > srr_size_cov.txt
# 管道的while是在子shell中的，无法修改父进程的列表。所以不能从管道中读取数据
while read i
do
  num=$( echo ${i} | cut -f4 -d\| | sed 's/,//g' )
  fold_list[${n}]=${num}
  ((n++))
done < srr_size_cov.txt

((max=${#list[@]}-1))
for i in $(seq 0 ${max});
do
  BASE_NAME=${list[$i]}
  fold=${fold_list[$i]}
  cd ${WORKING_DIR}/${BASE_NAME}
  anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff ${fold} --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     bash 2_trim.sh
     if [ -d ./align ];
     then
       echo -n
     else
       mkdir ./align
     fi
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.fa \
         ./2_illumina/trim/Q25L60/R1.fq.gz \
         ./2_illumina/trim/Q25L60/R2.fq.gz > ./align/Rp.sam
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.fa \
         ./2_illumina/trim/Q25L60/Rs.fq.gz > ./align/Rs.sam
         
     cp ./align/Rp.sam ./align/R.sam
     cat ./align/Rs.sam | grep -v "^@" >> ./align/R.sam
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
     rm ./align/R.bam
     rm ./align/*.sam
  '
done
```
