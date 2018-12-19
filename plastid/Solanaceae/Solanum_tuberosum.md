# *Solanum tuberosum*(potato) * *Solanum chacoense*(Chaco potato)
+ 基因组大小 - [《Genome sequence and analysis of the tuber crop potato》](https://www.nature.com/articles/nature10158) - 组装得到727 Mb，使用流式细胞仪测得844 Mb
+ 叶绿体基因组 - [NC_008096.2 - Desiree](https://www.ncbi.nlm.nih.gov/nuccore/NC_008096.2) - 155296 bp
+ 线粒体基因组 - []
+ *Solanum chacoense* 是茄属野生马铃薯的一种。它原产于南美洲，在巴西、玻利维亚、阿根廷、秘鲁、乌拉圭和巴拉圭都有发现。它是分布最广的野生马铃薯品种之一。为了寻找改良马铃薯的方法，人们对马铃薯进行了广泛的研究。它和普通的土豆在性方面很相配。这一野生物种含有瘦素糖聚kaloids，这使得它对马铃薯作物害虫科罗拉多马铃薯甲虫(Leptinotarsa decemlineata)有抵抗力。对黄萎病和马铃薯叶卷病毒也有一定的抗性。

> 早在2006年，中国农科院副院长屈冬玉博士作为项目发起人之一，组建了由农科院蔬菜花卉所和深圳华大基因研究院的专家组成的中方团队，参与启动了国际马铃薯基因组测序计划。针对马铃薯基因组高度杂合、物理图谱质量不高、测序成本高等难以克服的困难。中方首席科学家黄三文博士提出了以单倍体马铃薯为材料来降低基因组分析的复杂性，并采用快捷的全基因组鸟枪法策略和低成本的新一代DNA测序技术的新策略。这一策略的改变，大大提高了国际马铃薯基因组测序协会（Potato Genome Sequencing Consortium）的研究进程，促使中国团队实现了从参与到主导地位的改变。
> 在这篇新文章中，研究人员沿用了上述策略，他们首先将一种普通四倍体马铃薯栽培种诱导生成了一种纯和的双单倍体植株。随后，研究人员针对这一单倍体植株进行了基因组测序，并拼接了马铃薯844 Mb基因组中的86%的序列，从中研究人员推测马铃薯基因组约包含有39031个蛋白质编码基因。研究结果显示马铃薯至少存在两次基因组复制事件，表明了其古多倍体起源。测序结果还证实马铃薯基因组中包含了被子植物进化枝中2642个特异基因。此外，研究人员还对一个杂合二倍体马铃薯植株进行了测序，发现了一些基因组变异以及一些可能与马铃薯近交衰退有关的高频率的有害突变。研究结果表明基因家族扩增，组织特异性表达，以及新通路中基因的招募导致了马铃薯的进化。

## 项目信息
+ [PRJNA356643](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA335820)
+ [《Meiotic crossovers are associated with open chromatin and enriched with Stowaway transposons in potato》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5663088/)
+ USW4[Solanum tuberosum] * M6[Solanum chacoense]
+ USW4:保持了马铃薯的基因型的一个杂合子二倍体马铃薯群四倍体育种无性系 (Minnesota 20-20-34, 2n = 4x = 48),
+ M6 : 野生马铃薯（*Solanum chacoense*）的七代重组自交系的二倍体品种。 (2n = 2x = 24) 
+ [Run](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA356643&go=go)

## Run

### parent
| type | No | source | ID | size.bp | coverage |
| --- | --- | --- | --- | --- | --- |
| parent(Maternal) | US-W4 | USA | SRR5090798 | 4,117,308,600 * 2 | 9 |
| parent(Paternal) | M6 | USA | SRR5090838 | 6,706,372,500 * 2 | 15 |

### filialness
| type | No | source | ID | size.bp | coverage |
| --- | --- | --- | --- | --- | --- |
| | | | SRR5090750 | 1,154,100,450 * 2 | 11 |
| | | | SRR5090751 | 967,542,600 * 2 | 9 |
| | | | SRR5090752 | 948,214,650 * 2 | 9 |
| | | | SRR5090753 | 1,005,853,650 * 2 | 10 |
| | | | SRR5090754 | 942,049,800 * 2 | 9 |

## 组装

### 亲本
```
list=(9 15)
WORKING_DIR=~/stq/data/anchr/Solanum_tuberosum
cd ${WORKING_DIR}
n=0
FOLD=
for i in $(ls -d SRR*);
do
  ((FOLD=${list[$n]}))
  ((n++))
  BASE_NAME=${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  bash 0_realClean.sh
  
  anchr template \
      . \
      --basename ${BASE_NAME} \
      --queue mpi \
      --genome 1_000_000 \
      --fastqc \
      --kmergenie \
      --insertsize \
      --sgapreqc \
      --trim2 "--dedupe --cutoff ${FOLD} --cutk 31" \
      --qual2 "25" \
      --len2 "60" \
      --filter "adapter,phix,artifact" \
      --mergereads \
      --ecphase "1,2,3" \
      --cov2 "40 80 120 160 240 320" \
      --tadpole \
      --splitp 100 \
      --statp 1 \
      --fillanchor \
      --xmx 110g \
      --parallel 24
  
  # 提交超算任务
  bsub -q mpi -n 24 -J "${BASE_NAME}" "
    bash 0_master.sh
    cd ${WORKING_DIR}/${BASE_NAME}
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
    rm *.sam
  "
done
```

### 子代
```bash
function echo_fastq_size {
  SRR=$1
  size=$2
  fold=$3
  format_size=$(echo ${size} | perl -MNumber::Format -n -e 'chomp;print Number::Format::format_number($_)')
  echo -e "| ${SRR} | ${format_size} * 2 | ${fold} |"
}

echo -n >srr_size_cov.txt
export genome_size=844000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Solanum_tuberosum
cd ${WORKING_DIR}
list=($(ls -d SRR509075*))
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
# 管道的while是在子shell中的，无法修改父进程的列表。
while read i
do
  num=$( echo ${i} | cut -f2 -d\| | sed 's/,//g' )
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
     bash 0_realClean.sh
     bash 2_trim.sh
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/${genome_file} \
         ./2_illumina/trim/Q25L60/R1.fq.gz \
         ./2_illumina/trim/Q25L60/R2.fq.gz > ./align/Rp.sam
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/${genome_file} \
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
