# *Vigna angularis*（赤豆）的组装
[TOC levels=1-2]: # " "
+ [基本信息](#基本信息)
    + [测序文件](#测序文件)
    + [序列大小](#序列大小)
+ [前期准备](#前期准备) 
+ [SRR2177462](#srr2177462)
+ [SRR2177479](#srr2177479)
+ [SRR2177503](#srr2177503)
+ [SRR2177505](#srr2177505)
+ [SRR2177511](#srr2177511)

## 基本信息
+ **数据来源**：SRP062694
+ **测序仪器**：Illumina Genome Analyzer II
+ **测序方式**：paired-end
+ **核基因组大小**： 542Mb
+ **细胞器基因组**：404Kb[线粒体.NC_021092.1] + 151Kb[叶绿体.NC_021091.1]

## 项目信息
+ [SRP062694](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRP062694&go=go)

## 测序文件
+ SRR2177462
+ SRR2177479[需要调低倍数]
+ SRR2177503
+ SRR2177505
+ SRR2177511

## 序列大小
| type | file | Bp | cov |
| --- | --- | --- | --- |
| wHAIPI012488-24 | SRR2177462 | 2,913,127,740 * 2 | ~10.7 |
| wHAIPI013828-83 | SRR2177479 | 2,595,320,730 * 2 | ~9.25 |
| wHAIPI008881-16 | SRR2177503 | 4,424,826,000 * 2 | ~16.2 |
| wHAIPI008885-20 | SRR2177505 | 4,868,887,100 * 2 | ~17.7 |
| wHAIPI008887-22 | SRR2177511 | 4,189,891,000 * 2 | ~15.1 |

## 前期准备
### 下载数据来源
+ [SRP062694](https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=SRP062694&result=read_run&fields=study_accession,sample_accession,secondary_sample_accession,experiment_accession,run_accession,tax_id,scientific_name,instrument_model,library_layout,fastq_ftp,fastq_galaxy,submitted_ftp,submitted_galaxy,sra_ftp,sra_galaxy,cram_index_ftp,cram_index_galaxy&download=txt)

## 数据下载

### 下载测序数据
===> 服务器 <===
```bash
mkdir ~/data/anchr/Vigna_angularis/download_link
cd ~/data/anchr/Vigna_angularis/download_link
rm ./*.tsv

SRP=SRP062694
down_list=(SRR2177511 SRR2177503 SRR2177505 SRR2177479 SRR2177462)

bash 00.download_EBI_sequence_data.sh ${SRP} ${down_list[@]}
```

### 下载参考序列

===> 本地桌面 <===
```bash
下载Vigna_angularis叶绿体以及线粒体的基因组
叶绿体 https://www.ncbi.nlm.nih.gov/nuccore/NC_021091.1
线粒体 https://www.ncbi.nlm.nih.gov/nuccore/NC_021092
之后改名为Vigna_angularis_mt.fasta    Vigna_angularis_pt.fasta
# 上传到超算
rsync -avP \
  ./Vigna_angularis_*.fasta \
  wangq@202.119.37.251:stq/data/anchr/Vigna_angularis/genome
```  

### 基因组序列大小
===> 超算 <===
```bash
cd ~/stq/data/anchr/Vigna_angularis/genome
cat Vigna_angularis_pt.fasta Vigna_angularis_mt.fasta >genome.fa
# 统计基因组大小
cat genome.fa | perl -MYAML -n -e '
chomp;
if(m/^>/){
  $title = $_;
  next;
}
if(m/^[NAGTCagtcn]{5}/){
  $hash{$title} += length($_);
}
END{print YAML::Dump(\%hash)}
'
# 结果为
'>NC_021091.1 Vigna angularis chloroplast DNA, complete sequence': 151683
'>NC_021092.1 Vigna angularis mitochondrial DNA, complete sequence': 404466
```

### 工作区建立
```bash
# 建立文件链接
cd ~/stq/data/anchr/Vigna_angularis
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/_.\.fastq.gz//;print $new')
do
    mkdir -p ${name}/1_genome
    cd ${name}/1_genome
    ln -fs ../../genome/genome.fa genome.fa
  cd ${ROOTTMP}
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```

## SRR2177462
+ 10.7
```bash
WORKING_DIR=~/stq/data/anchr/Vigna_angularis
BASE_NAME=SRR2177462
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
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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
"
```

## SRR2177479
+ ~9.25
```bash
WORKING_DIR=~/stq/data/anchr/Vigna_angularis
BASE_NAME=SRR2177479
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
    --trim2 "--dedupe --cutoff 18 --cutk 31" \
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
"
```

## SRR2177503
# ~16.2
```bash
WORKING_DIR=~/stq/data/anchr/Vigna_angularis
BASE_NAME=SRR2177503
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
    --trim2 "--dedupe --cutoff 32 --cutk 31" \
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
"
```

## SRR2177505
+ ~17.7
```bash
WORKING_DIR=~/stq/data/anchr/Vigna_angularis
BASE_NAME=SRR2177505
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
    --trim2 "--dedupe --cutoff 34 --cutk 31" \
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
"
```

## SRR2177511
+ ~15.1
```bash
WORKING_DIR=~/stq/data/anchr/Vigna_angularis
BASE_NAME=SRR2177511
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
    --trim2 "--dedupe --cutoff 30 --cutk 31" \
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
"
```

```bash
export genome_size=542000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Vigna_angularis
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
