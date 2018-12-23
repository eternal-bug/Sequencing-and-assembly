# *Nelumbo_nucifera* [莲]
+ 基因组 [《Improving Nelumbo nucifera genome assemblies using high‐resolution genetic maps and BioNano genome mapping reveals ancient chromosome rearrangements》](https://onlinelibrary.wiley.com/doi/full/10.1111/tpj.13894) - 879 Mb
+ 叶绿体 [NC_025339.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_025339.1) - 163330 bp


## 项目信息
+ PRJNA308152 - RAD-seq


## 运行

```bash
function echo_fastq_size {
  SRR=$1
  size=$2
  fold=$3
  format_size=$(echo ${size} | perl -MNumber::Format -n -e 'chomp;print Number::Format::format_number($_)')
  echo -e "| ${SRR} | ${format_size} * 2 | ${fold} |"
}

echo -n >srr_size_cov.txt
export genome_size=879000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/Nelumbo_nucifera
cd ${WORKING_DIR}
list=($(ls -d SRR*))
((list_len=${}))

# get cut off fold number
n=0
fold_list=()
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
  FOLD=$(echo ${NUMBER} | sed 's/,//g' | perl -n -e 'printf "%.0f",$_*2*4/$ENV{genome_size}')
  echo ${SRR}\|${NUMBER}\|${FOLD}
done | \
sort -k1.4 -t\| > srr_size_cov.txt
# 管道的while是在子shell中的，无法修改父进程的列表。所以不能从管道中读取数据
while read i
do
  num=$( echo ${i} | cut -f3 -d\| | sed 's/,//g' )
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
    
  # align
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     bash 
     bash 2_trim.sh
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
     rm *.sam
  '
done
```
