# 🌾*Oryza sativa* [水稻]
+ SRR063598 16倍


## 前期准备

### 建立工作区

```bash
mkdir ~/stq/data/anchr/Oryza_sativa
cd ~/stq/data/anchr/Oryza_sativa
mkdir ./genome
mkdir ./sequence_data
```

### 下载参考序列

+ [Oryza sativa Japonica Group (Japanese rice) - IRGSP-1.0](https://www.ncbi.nlm.nih.gov/assembly/GCF_001433935.1)
+ 
```bash
cd ./genome
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/433/935/GCF_001433935.1_IRGSP-1.0/GCF_001433935.1_IRGSP-1.0_genomic.fna.gz
gzip -d GCF_001433935.1_IRGSP-1.0_genomic.fna.gz
```
```
cat GCF_001433935.1_IRGSP-1.0_genomic.fna | grep "^>" | nl
```
包含的内容
```text
     1	>NC_029256.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 1, IRGSP-1.0
     2	>NC_029257.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 2, IRGSP-1.0
     3	>NC_029258.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 3, IRGSP-1.0
     4	>NC_029259.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 4, IRGSP-1.0
     5	>NC_029260.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 5, IRGSP-1.0
     6	>NC_029261.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 6, IRGSP-1.0
     7	>NC_029262.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 7, IRGSP-1.0
     8	>NC_029263.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 8, IRGSP-1.0
     9	>NC_029264.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 9, IRGSP-1.0
    10	>NC_029265.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 10, IRGSP-1.0
    11	>NC_029266.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 11, IRGSP-1.0
    12	>NC_029267.1 Oryza sativa Japonica Group cultivar Nipponbare chromosome 12, IRGSP-1.0
    13	>NW_015379186.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_050
    14	>NW_015379187.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_049
    15	>NW_015379188.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_048
    16	>NW_015379189.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_047
    17	>NW_015379190.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_046
    18	>NW_015379191.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_045
    19	>NW_015379192.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_044
    20	>NW_015379193.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_043
    21	>NW_015379194.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_042
    22	>NW_015379195.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_041
    23	>NW_015379196.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_039
    24	>NW_015379197.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_038
    25	>NW_015379198.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_037
    26	>NW_015379199.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_036
    27	>NW_015379200.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_035
    28	>NW_015379201.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_034
    29	>NW_015379202.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_033
    30	>NW_015379203.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_032
    31	>NW_015379204.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_031
    32	>NW_015379205.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_030
    33	>NW_015379206.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_029
    34	>NW_015379207.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_028
    35	>NW_015379208.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_027
    36	>NW_015379209.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_026
    37	>NW_015379210.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_024
    38	>NW_015379211.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_023
    39	>NW_015379212.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_022
    40	>NW_015379213.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_021
    41	>NW_015379214.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_020
    42	>NW_015379215.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_019
    43	>NW_015379216.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_016
    44	>NW_015379217.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_015
    45	>NW_015379218.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_014
    46	>NW_015379219.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_013
    47	>NW_015379220.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_012
    48	>NW_015379221.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_011
    49	>NW_015379222.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_010
    50	>NW_015379223.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_009
    51	>NW_015379224.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_008
    52	>NW_015379225.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_007
    53	>NW_015379226.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_005
    54	>NW_015379227.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_004
    55	>NW_015379228.1 Oryza sativa Japonica Group cultivar Nipponbare unplaced genomic scaffold, IRGSP-1.0 Syng_TIGR_002
    56	>NC_001320.1 Oryza sativa Japonica Group plastid, complete genome
    57	>NC_011033.1 Oryza sativa Japonica Group mitochondrion, complete genome
    58	>NC_001751.1 Oryza sativa (japonica cultivar-group) mitochondrial plasmid B1, complete sequence
```
改名
```bash
mv GCF_001433935.1_IRGSP-1.0_genomic.fna genome.fa
mkdir temp
n=0
for i in {1..12} 56 57;
do
  export num=${i}
  list=(chr{1..12} Pt Mt)
  export title=${list[$n]}
  ((n++))
  cat ./genome.fa | perl -n -e '
    BEGIN{
      use vars qw/$n $flag/;
      $n = 0;
      $flag = 0;
    }
    if(index($_,">")==0){
      $flag = 1;
      $n++;
    }
    if($n == $ENV{num}){
      if($flag == 1){
        print ">",$ENV{title},"\n";
      }else{
        print $_;
      }
      $flag = 0;
    }
  ' > ./temp/${title}.fa
done
```
合并文件
```bash
for i in $(ls ./temp/*.fa | sort -k1.11n );
do
  cat ${i} 
done >genome.new.fa
```
查看序列长度
```bash
cat genome.new.fa | perl -n -e '
    s/\r?\n//;
    if(m/^>(.+?)\s*$/){
        $title = $1;
    }elsif(defined $title){
        $title_len{$title} += length($_);
    }
    END{
        # 
        # for my $title (sort {$title_len{$b} cmp $title_len{$a}} keys %title_len){
        for my $title (sort keys %title_len){
            print "$title","\t","$title_len{$title}","\n";
        }
    }
'
```
| chr | len |
| --- | --- |
| Mt	 | 490520 |
| Pt	 | 134525 |
| chr1 | 43270923 |
| chr2 | 35937250 |
| chr3 | 36413819 |
| chr4 | 35502694 |
| chr5 | 29958434 |
| chr6 | 31248787 |
| chr7 | 29697621 |
| chr8 | 28443022 |
| chr9 | 23012720 |
| chr10| 23207287 |
| chr11| 29021106 |
| chr12| 27531856 |

## 批处理
### 1. clean and cutoff
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Oryza_sativa
cd ${WORKING_DIR}
SRR=SRR063598
FOLD=16
bash create_sequence_file_link.sh
for i in 0 0.25 0.5 1 2 4 8 16 32 64;
do
  cp -r ${SRR} ${SRR}_${i}
done

# ============= clean and cutoff ===============
# 0

BASE_NAME=${SRR}_0
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24
    
    bsub -q mpi -n 24 -J "${BASE_NAME}" "
      bash 2_trim.sh
    "

# 0.2 0.5 1 2 4 8 16 32
for i in 0.2 0.5 1 2 4 8 16 32 64;
do
  BASE_NAME=${SRR}_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  cutoff=$(echo "${i} * ${FOLD}" | bc | perl -p -e 's/\..+//')
  
  # anchr
  anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff ${cutoff} --cutk 31" \
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

### 2. build genome file index
```bash
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa
```

### 3. align

```bash
for i in 0 0.25 0.5 1 2 4 8 16 32;
do
  BASE_NAME=${SRR}_${i}
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
         ../genome/genome.new.fa \
         ./2_illumina/trim/Q25L60/R1.fq.gz \
         ./2_illumina/trim/Q25L60/R2.fq.gz > ./align/Rp.sam
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.new.fa \
         ./2_illumina/trim/Q25L60/Rs.fq.gz > ./align/Rs.sam
         
     cp ./align/Rp.sam ./align/R.sam
     cat ./align/Rs.sam | grep -v "^@" >> ./align/R.sam
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
     rm ./align/*.sam
  '
  cd ${WORKING_DIR}
done
```
