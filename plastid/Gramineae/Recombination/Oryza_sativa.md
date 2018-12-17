# *Oryza sativa*[水稻]
+ 基因组[《A Draft Sequence of the Rice Genome (Oryza sativa L. ssp. indica)》](http://science.sciencemag.org/content/296/5565/79) - 430 Mb
+ 叶绿体[NC_001320.1](https://www.ncbi.nlm.nih.gov/nuccore/11466763) - 134525 bp
+ 线粒体[NC_007886.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_007886.1) - 491515 bp

## 项目信息
+ [《Genome sequencing of rice subspecies and genetic analysis of recombinant lines reveals regional yield- and quality-associated loci》](https://bmcbiol.biomedcentral.com/articles/10.1186/s12915-018-0572-x#Sec1)
+ PRJNA486425
+ Oryza sativa indica[籼稻] * Oryza sativa japonica[粳稻]
+ Recombinant inbred lines (RILs) derived from a cross between SN265 and R99 (indica) 

> + 籼稻的米粒淀粉粘性较弱，胀性较大，谷粒狭长，颖毛短稀，叶绿、色较淡，叶面多茸毛，耐肥性较弱，叶片弯长，株型较松散，并有耐湿、耐热、耐强光、易落粒和对稻瘟病抵抗性较强等特征特性。
> + 粳稻的米粒淀粉粘性较强，胀性较小，谷粒短圆，颖毛长密，叶绿、色较浓，叶面较光滑，耐肥性较强，叶片短直，株型紧凑，并有耐寒、耐弱光、不易落粒和对稻瘟病抵抗性较弱等特征特性

## [Run信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA486425&go=go)


| type | No | szie.bp | depth |
| --- | --- | --- | --- |
| parent(male)     | SRR7750269 | 6,521,979,122 * 2 | 30 |
| parent(Female)   | SRR7750271 | 6,687,761,564 * 2 | 30 |
| filialness(R155) | SRR7750270 |
| filialness(R81) | SRR7750272 |
| filialness(R82) | SRR7750273 |
| filialness(R8) | SRR7750274 |
| filialness(R77) | SRR7750275 |
| filialness(R78) | SRR7750276 |
| filialness(R79) | SRR7750277 |
| filialness(R80) | SRR7750278 |
| filialness(R73) | SRR7750279 |

## parent

### SRR7750269
+ 30
```bash
WORKING_DIR=~/stq/data/anchr/Oryza_sativa/Recombination
BASE_NAME=SRR7750269
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
    --trim2 "--dedupe --cutoff 120 --cutk 31" \
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
"
```

### 
```bash
WORKING_DIR=~/stq/data/anchr/Oryza_sativa/Recombination
BASE_NAME=SRR7750271
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
    --trim2 "--dedupe --cutoff 120 --cutk 31" \
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
"
```

## filialness
```bash
list=($(seq 69 79))
WORKING_DIR=~/stq/data/anchr/Oryza_sativa/Recombination
BASE_NAME=SRR77502
for i in ${list[@]};
do
  if [ ${i} -eq 69 ] || [ ${i} -eq 71 ];
  then
    echo -n
  else
    cd ${WORKING_DIR}/${BASE_NAME}${i}
    bsub -q mpi -n 24 -J "${i}" "
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
          ./2_illumina/R1.fq.gz \
          ./2_illumina/R2.fq.gz > ./align/Rp.sam
          
      cp ./align/Rp.sam ./align/R.sam
      cat ./align/Rs.sam | grep -v "^@" >> ./align/R.sam
      samtools view -b -o ./align/R.bam ./align/R.sam
      samtools sort -o ./align/R.sort.bam ./align/R.bam
      samtools index ./align/R.sort.bam
    "
  fi
done
```
