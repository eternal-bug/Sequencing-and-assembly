# 🌾*Oryza sativa* [水稻]
+ 430 Mb

## 项目信息
+ SRP003189
+ [《》]()

## Run
|type|No|size.bp|coverage|
|---|---|---|---|
|SRR063590|2,451,879,750 * 2 |11|
|SRR063591|2,349,176,025 * 2 |11|
|SRR063592|2,557,755,800 * 2 |12|
|SRR063593|2,228,485,400 * 2 |10|
|SRR063594|3,219,148,000 * 2 |15|
|SRR063595|3,454,267,500 * 2 |16|
|SRR063596|3,107,322,000 * 2 |14|
|SRR063597|3,245,849,800 * 2 |15|
|SRR063598|3,535,018,700 * 2 |16|
|SRR063599|3,340,483,100 * 2 |16|
|SRR063600|3,277,036,900 * 2 |15|
|SRR063601|3,242,578,600 * 2 |15|
|SRR063602|3,405,918,200 * 2 |16|
|SRR063603|3,536,009,600 * 2 |16|
|SRR063604|3,292,899,000 * 2 |15|
|SRR063605|3,345,220,300 * 2 |16|
|SRR063606|3,612,901,200 * 2 |17|
|SRR063607|3,539,768,700 * 2 |16|
|SRR063608|2,917,645,100 * 2 |14|
|SRR063609|3,286,674,400 * 2 |15|
|SRR063610|3,065,335,000 * 2 |14|
|SRR063611|2,888,127,700 * 2 |13|
|SRR063612|2,947,826,600 * 2 |14|
|SRR063613|2,991,371,400 * 2 |14|
|SRR063614|3,051,295,800 * 2 |14|
|SRR063615|3,187,524,800 * 2 |15|
|SRR063616|3,394,902,600 * 2 |16|
|SRR063617|3,411,784,400 * 2 |16|
|SRR063618|3,180,601,200 * 2 |15|
|SRR063619|3,489,072,900 * 2 |16|
|SRR063620|3,338,451,800 * 2 |16|
|SRR063621|3,191,037,400 * 2 |15|
|SRR063622|3,345,185,900 * 2 |16|
|SRR063623|2,736,541,000 * 2 |13|
|SRR063624|2,386,706,200 * 2 |11|
|SRR063625|3,540,120,400 * 2 |16|
|SRR063626|3,366,331,600 * 2 |16|
|SRR063627|3,458,134,800 * 2 |16|
|SRR063628|3,400,513,500 * 2 |16|
|SRR063629|3,383,380,800 * 2 |16|
|SRR063630|3,375,189,500 * 2 |16|
|SRR063631|3,386,104,700 * 2 |16|
|SRR063632|3,220,955,100 * 2 |15|
|SRR063633|3,158,614,800 * 2 |15|
|SRR063634|3,073,919,900 * 2 |14|
|SRR063635|3,148,370,400 * 2 |15|
|SRR063636|3,122,698,500 * 2 |15|
|SRR063637|3,112,508,900 * 2 |14|
|SRR063638|2,978,401,100 * 2 |14|
|SRR063639|3,212,328,700 * 2 |15|
|SRR063640|343,561,328 * 2 |2|
|SRR063641|349,371,924 * 2 |2|
|SRR063642|269,055,204 * 2 |1|
|SRR063643|315,919,032 * 2 |1|
|SRR063644|312,759,964 * 2 |1|
|SRR063645|463,410,728 * 2 |2|
|SRR063646|547,947,708 * 2 |3|
|SRR063647|329,299,124 * 2 |2|

## 运行

```bash
n=0
fold_list=()
list=()

echo -n >srr_size_cov.txt
export genome_size=430000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Oryza_sativa
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
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${fold} --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "120" \
    --tadpole \
    --splitp 10 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     bash 0_cleanup.sh
     bash 0_master.sh
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
     rm ./align/*.sam
  '
done
```
