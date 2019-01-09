# *Solanum lycopersicum* [西红柿]
+ 12条染色体
+ 基因组 [NATURE - 《The tomato genome sequence provides insights into fleshy fruit evolution》](https://www.nature.com/articles/nature11119) - 900M
+ 叶绿体 [NC_007898](https://www.ncbi.nlm.nih.gov/nuccore/NC_007898.3) - 155461 bp
+ 线粒体 [NC_035963.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_035963.1) - 446257 bp

## 相关
+ 100个番茄基因组研究计划

## 项目信息
+ PRJNA449767
+ [《Sequencing-Based Bin Map Construction of a Tomato Mapping Population, Facilitating High-Resolution Quantitative Trait Loci Detection》](https://dl.sciencesocieties.org/publications/tpg/articles/0/0/180010)

## 可能可用的信息
+ [PRJEB6659](https://www.ebi.ac.uk/ena/data/view/PRJEB6659)

## Run
### Parent
| type | No | source | ID | size.bp | coverage |
| --- | --- | --- | --- | --- | --- |
| USA | SRR7060227 | 1,375,898,117 * 2 | 12 |
| USA | SRR7060228 | 1,089,691,990 * 2 | 10 |

### Filialness
| type | No | source | ID | size.bp | coverage |
| --- | --- | --- | --- | --- | --- |
| F8 Generation | RIL_11 | USA | SRR7060177 | 249,533,278 * 2 | 2 |
| F8 Generation | RIL_12 | USA | SRR7060178 | 391,549,199 * 2 | 3 |
| F8 Generation | RIL_13 | USA | SRR7060179 | 162,410,891 * 2 | 1 |
| F8 Generation | RIL_14 | USA | SRR7060180 | 276,051,092 * 2 | 2 |
| F8 Generation | RIL_15 | USA | SRR7060181 | 322,626,698 * 2 | 3 |
| F8 Generation | RIL_16 | USA | SRR7060182 | 384,683,471 * 2 | 3 |
| F8 Generation | RIL_18 | USA | SRR7060183 | 316,731,463 * 2 | 3 |
| F8 Generation | RIL_19 | USA | SRR7060184 | 358,047,353 * 2 | 3 |
| F8 Generation | RIL_20 | USA | SRR7060185 | 508,052,474 * 2 | 5 |
| F8 Generation | RIL_21 | USA | SRR7060186 | 305,843,639 * 2 | 3 |
| F8 Generation | RIL_22 | USA | SRR7060187 | 168,562,602 * 2 | 1 |
| F8 Generation | RIL_124 | USA | SRR7060188 | 116,734,153 * 2 | 1 |
| F8 Generation | RIL_123 | USA | SRR7060189 | 98,194,089 * 2  | 1 |
| F8 Generation | RIL_122 | USA | SRR7060190 | 175,780,556 * 2 | 2 |
| F8 Generation | RIL_121 | USA | SRR7060191 | 277,621,225 * 2 | 2 |
| F8 Generation | RIL_120 | USA | SRR7060192 | 423,115,119 * 2 | 4 |
| F8 Generation | RIL_118 | USA | SRR7060193 | 269,913,717 * 2 | 2 |
| F8 Generation | RIL_117 | USA | SRR7060194 | 210,276,312 * 2 | 2 |
| F8 Generation | RIL_116 | USA | SRR7060195 | 222,395,562 * 2 | 2 |
| F8 Generation | RIL_105 | USA | SRR7060196 | 215,201,590 * 2 | 2 |
| F8 Generation | RIL_106 | USA | SRR7060197 | 175,159,394 * 2 | 2 |
| F8 Generation | RIL_107 | USA | SRR7060228 | 1,089,691,990 * 2 | 10 |

### 批运行
```
function echo_fastq_size {
  SRR=$1
  size=$2
  fold=$3
  format_size=$(echo ${size} | perl -MNumber::Format -n -e 'chomp;print Number::Format::format_number($_)')
  echo -e "| ${SRR} | ${format_size} * 2 | ${fold} |"
}

echo -n >srr_size_cov.txt
export genome_size=900000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Solanum_Lycopersicon
cd ${WORKING_DIR}
list=($(ls -d SRR*))

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
