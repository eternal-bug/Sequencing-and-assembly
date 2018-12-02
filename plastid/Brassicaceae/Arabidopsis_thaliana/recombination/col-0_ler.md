

## 数据来源1
+ 测序数据：Illumina Hiseq
+ [《Great majority of recombination events in Arabidopsis are gene conversionevents》](http://www.pnas.org/content/109/51/20992)
+ PRJNA178613
+ [补充](http://www.pnas.org/highwire/filestream/611045/field_highwire_adjunct_files/0/sapp.pdf)

## 文件信息
| type | file | size.bp | coverage |
| --- | --- | --- | --- |
|* c1c2 | SRR611078 | 1,398,388,200 * 2 | 23 |
|* l2c2 | SRR611080 | 1,398,418,200 * 2 | 23 |
|* l2l3 | SRR611081 | 1,398,021,200 * 2 | 23 |
|* l4c1 | SRR611082 | 1,398,488,400 * 2 | 23 |
|* l4l3 | SRR611083 | 1,396,477,400 * 2 | 23 |
| Col  | SRR611086 |
| Ler  | SRR611087 |

| type | file | size.bp | coverage |
| --- | --- | --- | --- |
| Sample_c41 | SRR611092 | 2,560,344,145 * 2 | 42 |
| Sample_c42 | SRR611093 | 2,550,524,443 * 2 | 42 |
| Sample_c45 | SRR611094 | 2,557,168,365 * 2 | 42 |


## prepare
```bash
mkdir -p ~/stq/data/anchr/Arabidopsis_thaliana/col_ler/sequence_data
rsync -avP ./SRR611092* ./SRR611093* ./SRR611094* wangq@202.119.37.251:stq/data/anchr/Arabidopsis_thaliana/col_ler/sequence_data
cd ~/stq/data/anchr/Arabidopsis_thaliana/col_ler/
bash 02.create_sequence_file_link.sh
```

## reference
```bash
col
```

## cutoff
```bash
WORKING_DIR=~/stq/data/anchr/Arabidopsis_thaliana/col_ler/

((fold=42*4))
for i in SRR611092 SRR611093 SRR611094;
do
  BASE_NAME=${i}
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
  
  bsub -q mpi -n 24 -J "${BASE_NAME}" "
    bash 2_trim.sh
  "
done
```

## build index
```bash
cd ${WORKING_DIR}
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.fa
```

## map
```bash
for i in SRR611092 SRR611093 SRR611094;
do
  BASE_NAME=${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" '
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
  '
  cd ${WORKING_DIR}
done
```

## SRR611078
+ 23
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/recombination
BASE_NAME=SRR611078
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 46 --cutk 31" \
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

## SRR611080
+ 23
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/recombination
BASE_NAME=SRR611080
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 46 --cutk 31" \
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

## SRR611081
+ 23
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/recombination
BASE_NAME=SRR611081
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 46 --cutk 31" \
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

## SRR611082
+ 23
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/recombination
BASE_NAME=SRR611082
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 46 --cutk 31" \
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

## SRR611083
+ 23
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/recombination
BASE_NAME=SRR611083
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 46 --cutk 31" \
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
