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
for i in 0.25 0.5 1 2 4 8 16 32 64;
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
cd ${WORKING_DIR}
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa
```

### 3. align

```bash
for i in 0 0.25 0.5 1 2 4 8 16 32 64;
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

### 4. calculate coverage and depth

```bash
for i in 0 0.25 0.5 1 2 4 8 16 32 64;
do
  BASE_NAME=${SRR}_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  cd ./align
  export BAMFILE=R.sort.bam
  samtools mpileup ${BAMFILE} | perl -M"IO::Scalar" -nale '
    BEGIN {
      use vars qw/%info/;
      my $cmd = qq{samtools view -h $ENV{BAMFILE} |};
      $cmd   .= qq{head -n 100 |};
      $cmd   .= qq{grep "^@SQ"};
      my $database_len = readpipe $cmd;
      my $handle = IO::Scalar->new(\$database_len);
      while(<$handle>){
        if(m/SN:([\w.]+)\s+LN:(\d+)/){
          $info{$1}{length} = $2;
        }
      }
      close $handle;
    }
    # 比对到每一个参考位置点的总和
    $info{$F[0]}{site}++;
    # 比对到每一个位点的覆盖深度
    $info{$F[0]}{depth} += $F[3];
    END{
      print "Title | Coverage_length | Coverage_percent | Depth";
      print "--- | ---: | ---: | ---: |";
      for my $title (sort {$a cmp $b} keys %info){
        printf "%s | %d | %.2f | %d\n",
                $title,
                     $info{$title}{site},
                          $info{$title}{site}/$info{$title}{length},
                                 $info{$title}{depth}/$info{$title}{site};
      }
    }
  ' > ./stat.md
done
```

### 5. 排序
```bash
for i in 0 0.25 0.5 1 2 4 8 16 32 64;
do
  BASE_NAME=${SRR}_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  md=./align/stat.md
  cat ${md} | head -n 2 >./align/temp.sort.md
  cat ${md} | tail -n+3 | sed "s/ //g" | sort -d -t '|' -k 1.4n >> ./align/temp.sort.md
done
```

### 6. combine infomations
```bash
cd ${WORKING_DIR}
list=(0 0.25 0.5 1 2 4 8 16 32 64)
genome_list=(chr{1..12} pt mt)
mark_list=("| fold |" "| --- |" "| |")
rm total.md

# generate the totle
n=0
for mark in "${mark_list[@]}";
do
  ((n++))
  echo -n ${mark} >> total.md
  for i in ${genome_list[@]};
  do
    if [ ${n} -eq 1 ];
    then
      echo -n " | ${i} | |" >> total.md
    elif [ ${n} -eq 2 ];
    then
      echo -n " ---: | ---: | ---: | " >> total.md
    else
      echo -n " CL | CP | DP |" >> total.md
    fi
  done
  echo >> total.md
done

for i in ${list[@]};
do
  BASE_NAME=${SRR}_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  echo -n "| ${i} | "
  cat ./align/temp.sort.md | tail -n+3 | perl -p -e 's/^\w+\s*\|//' |  perl -p -e "s/\n/ | /"
  echo
  cd ${WORKING_DIR}
done >>total.md


export sequence_data=5726814332
cat total.md \
| tail -n+4 \
| sed "s/\s//g" \
| perl -p -e 's/^\|//;s/\|$//' \
| perl -nl -a -F"\|" -e '
  BEGIN{
    use vars qw/@order/;
    $\ = "";
    $" = " ";
    @order = qw/chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 mt pt /;
  }
  {
    %info = ();
  }
  my $fold = shift(@F);
  for my $group_v (1..scalar(@F)/3){
    my $name = $order[$group_v - 1];
    my $prefix = ($name =~ s/\d+//r);
    my @list = map {$group_v * 3 - $_} (3,2,1);
    my @group = @F[@list];
    my $len = $group[0];
    my $depth = $group[2];
    $info{$prefix} += $len * $depth;
  }
  my $total = 0;
  my @list = ();
  for my $name (sort {uc($a) cmp uc($b)} keys %info){
    push @list,$info{$name};
    $total += $info{$name};
  }
  print " $fold ";
  print " @list ";
  print " $total ";
  my @ratio = map { sprintf("%.2f",$_ / $total * 100)} @list;
  {
    local $" = "/";
    print " @ratio ";
  }
  printf "%.2f%% ",$total/$ENV{sequence_data} * 100;
  print "\n";
' \
| perl -pe 's/ +/|/g'
```

### 7. visualization
```bash
cd ${WORKING_DIR}
for i in 0 0.25 0.5 1 2 4 8 16 32 64;
do
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  mkdir ./depth
  ~/stq/Applications/biosoft/deepTools-3.1.0/bin/bamCoverage -b ./align/R.sort.bam --outFileFormat bigwig -o ./deepth/Rp.bw
done
```

### 8. plot
```bash
library(ggplot2)

fold_list <- c(0,0.2,0.5,1,2,4,8,16,32,64)
name <- c("nucleus","mitochondria","chloroplast")
nc   <- c(4519586198,4519517101,4512812287,3255160009,1608585038,1363877924,1214861964,1063620539,916410088,794086342)
mt   <- c(32322542,32322542,32322542,32322542,32322542,32322542,31453400,343619,26525,26100)
pt   <- c(91039488,90791424,90790692,90915456,90791424,90667392,90667392,90667392,90791424,90915456)

len_f    = length(fold_list)
len_n    = length(name)
data <- data.frame(
  genome = factor(rep(name,each=len_f)),
  fold = c(rep(fold_list,times=len_n)),
  num = c(nc,mt,pt)
)
options(scipen=200)
plot(fold_list,nc,type="b",ylab = "num",xlab = "fold",col="blue",main="nucleus",ylim=c(0,5000000000))
plot(fold_list,mt,type="b",ylab = "num",xlab = "fold",col="green",main="mitochondria")
plot(fold_list,pt,type="b",ylab = "num",xlab = "fold",col="red",main="chloroplast",ylim=c(0,100000000))
ggplot(data,aes(x=fold,y=num,group=genome,colour=genome,shape=genome)) + geom_line() + geom_point()
```

## 结果

### FOLD * 0

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|37008542|0.86|12
chr2|31191138|0.87|12
chr3|31670494|0.87|12
chr4|28814658|0.81|13
chr5|25823435|0.86|12
chr6|25951019|0.83|12
chr7|23793909|0.80|12
chr8|23525135|0.83|12
chr9|19510739|0.85|12
chr10|18975618|0.82|14
chr11|23743752|0.82|12
chr12|23687578|0.86|13
Pt|133028|0.99|539
Mt|476901|0.97|77


### FOLD * 0.25
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|36941285|0.85|12
chr2|31139713|0.87|12
chr3|31607744|0.87|12
chr4|28764387|0.81|13
chr5|25782590|0.86|12
chr6|25910723|0.83|12
chr7|23755437|0.80|12
chr8|23480738|0.83|12
chr9|19475285|0.85|12
chr10|18945623|0.82|14
chr11|23714502|0.82|12
chr12|23660613|0.86|13
Pt|133079|0.99|539
Mt|476913|0.97|77

### FOLD * 0.5
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|36158714|0.84|13
chr2|30538669|0.85|13
chr3|30918668|0.85|12
chr4|28230002|0.80|13
chr5|25319394|0.85|12
chr6|25454455|0.81|12
chr7|23339612|0.79|12
chr8|23088877|0.81|12
chr9|19124124|0.83|12
chr10|18612440|0.80|15
chr11|23351405|0.80|12
chr12|23314613|0.85|13
Pt|133143|0.99|539
Mt|476956|0.97|77

### FOLD * 1

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|25626509|0.59|11
chr2|21773328|0.61|11
chr3|21670274|0.60|11
chr4|20998453|0.59|12
chr5|18558996|0.62|11
chr6|18463360|0.59|11
chr7|16996574|0.57|10
chr8|17001192|0.60|11
chr9|14028062|0.61|11
chr10|13637120|0.59|14
chr11|17514933|0.60|11
chr12|17818576|0.65|12
Pt|132982|0.99|538
Mt|477101|0.97|77

### FOLD * 2

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|9513815|0.22|11
chr2|7959766|0.22|11
chr3|7532010|0.21|9
chr4|9623264|0.27|13
chr5|8303114|0.28|10
chr6|7918361|0.25|10
chr7|7069113|0.24|9
chr8|7618595|0.27|10
chr9|6186244|0.27|11
chr10|6027799|0.26|17
chr11|7932545|0.27|9
chr12|8690932|0.32|11
Pt|133052|0.99|539
Mt|476886|0.97|77

### FOLD * 4

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|7563797|0.17|12
chr2|6108476|0.17|11
chr3|5815022|0.16|9
chr4|7726707|0.22|14
chr5|6757261|0.23|10
chr6|6246493|0.20|10
chr7|5652412|0.19|9
chr8|6014632|0.21|10
chr9|4910645|0.21|11
chr10|4777790|0.21|19
chr11|6041217|0.21|9
chr12|6830652|0.25|12
Pt|133133|0.99|539
Mt|476382|0.97|77

### FOLD * 8

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|6259002|0.14|12
chr2|4972910|0.14|12
chr3|4700515|0.13|9
chr4|6600430|0.19|15
chr5|5716947|0.19|10
chr6|5105080|0.16|10
chr7|4731127|0.16|9
chr8|5015686|0.18|11
chr9|4147879|0.18|11
chr10|4008225|0.17|21
chr11|4942219|0.17|9
chr12|5775511|0.21|12
Pt|132948|0.99|540
Mt|440399|0.90|76

### FOLD * 16

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|5005381|0.12|13
chr2|3937852|0.11|13
chr3|3643866|0.10|9
chr4|5459573|0.15|16
chr5|4737152|0.16|10
chr6|4165208|0.13|11
chr7|3769408|0.13|9
chr8|4098915|0.14|11
chr9|3325359|0.14|11
chr10|3272421|0.14|24
chr11|3957811|0.14|9
chr12|4569985|0.17|12
Mt|74177|0.15|83
Pt|132985|0.99|540

### FOLD * 32

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|3707100|0.09|14
chr2|2907840|0.08|14
chr3|2577631|0.07|9
chr4|4109097|0.12|18
chr5|3625553|0.12|10
chr6|3128618|0.10|12
chr7|2828476|0.10|9
chr8|3048221|0.11|12
chr9|2455170|0.11|12
chr10|2494105|0.11|30
chr11|2983665|0.10|9
chr12|3526630|0.13|12
Mt|36527|0.07|104
Pt|132987|0.99|539

### FOLD * 64

Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|2498630|0.06|17
chr2|1944665|0.05|17
chr3|1672239|0.05|10
chr4|2825911|0.08|23
chr5|2548615|0.09|10
chr6|2154837|0.07|13
chr7|1898883|0.06|10
chr8|2072423|0.07|14
chr9|1704923|0.07|14
chr10|1744491|0.08|39
chr11|2039562|0.07|10
chr12|2482471|0.09|13
Mt|30419|0.06|122
Pt|133036|0.99|540
