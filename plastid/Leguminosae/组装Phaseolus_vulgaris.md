# *Phaseolus vulgaris* [芸豆] 
+ 基因组 - [《Genome and transcriptome analysis of the Mesoamerican common bean and the role of gene duplications in establishing tissue and temporal specialization of genes》](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-0883-6) - 549.6 Mb
+ 叶绿体 - [NC_009259.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_009259.1) - 150,285 bp
+ 线粒体 - 

## 项目信息
+ PRJNA386820
+ 

### Run信息
| type | SRR	| size.Bp | size | depth |
| --- | --- | --- | --- | --- |
| ICYZ | SRR5628227 | 
| ICYY | SRR5808968 |
| ICYX | SRR5808969 |
| ICYW | SRR5808970 |
| ICYU | SRR5808971 |
| ICYT | SRR5808972 |
| ICYS | SRR5808973 |
| ICYR | SRR5808974 |
| ICYQ | SRR5808975 |
| ICYP | SRR5808976 |
| ICYN | SRR5808977 |
| ICYM | SRR5808978 |
| ICYL | SRR5808979 |
| ICYK | SRR5808980 |
| ICYJ | SRR5808981 |
| ICYI | SRR5808982 |
| ICYH | SRR5808983 |
| ICYH | SRR5808984 |
| ICYG | SRR5808985 |
| ICYF | SRR5808986 |

## 运行

```bash
export genome_size=549600000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Phaseolus_vulgaris
cd ${WORKING_DIR}

# build index
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/${genome_file}

echo -n >srr_size_cov.txt
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
    
  # align
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" '
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
