# 🍅 *Solanum lycopersicum* [番茄]


## 项目信息
+ PRJNA353161
+ [《Rewiring of the Fruit Metabolome in Tomato Breeding》](https://www.sciencedirect.com/science/article/pii/S009286741731499X?via%3Dihub)
+ [《Genomic analyses provide insights into the history of tomato breeding》](https://www.nature.com/articles/ng.3117)

### Run信息
|type|No|szie.bp|depth
|---|---|---|---|
|SRR5079859|2,872,470,900*2|6|
|SRR5079860|2,740,968,000*2|6|
|SRR5079861|2,452,204,100*2|5|
|SRR5079862|3,480,624,700*2|8|
|SRR5079863|3,420,357,900*2|8|
|SRR5079865|2,696,514,875*2|6|
|SRR5079866|2,414,748,700*2|5|
|SRR5079867|2,697,922,250*2|6|
|SRR5079868|3,960,478,100*2|9|
|SRR5079869|2,864,586,200*2|6|
|SRR5079870|5,786,579,400*2|13|
|SRR5079871|3,349,260,700*2|7|
|SRR5079872|2,417,976,800*2|5|


### 运行
```bash
n=0
fold_list=()
list=()

echo -n >srr_size_cov.txt
export genome_size=900000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Solanum_lycopersicum
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
