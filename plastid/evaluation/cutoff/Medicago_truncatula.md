# *Medicago truncatula* [蒺藜苜蓿] 倍数因子测试
+ 核基因组：8条染色体
+ 因子值 0.25、0.5、1、2、4、8、16、32、64
+ 测试文件 SRR965418 （覆盖度 2,863,407,166 * 2 / 500,000,000 ） = 10

## 总结

| fold | |chr1 |      |      | chr2 |      |      | chr3 |      |      | chr4 |      |      | chr5 |      |    | chr6 | | | chr7 | | | chr8 | |  | mt   |    |   | pt |   |
| ---- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
|      | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   |
| 0 | 56607546|1.00|10 | 51766811|1.00|10 | 58844716|1.00|10 | 64577948|1.00|12 | 44667255|1.00|11 | 42510250|0.99|11 | 56128727|1.00|11 | 49609154|1.00|10 | 271618|1.00|119 | 124032|1.00|734 | 
| 0.2 | 56609743|1.00|10 | 51765198|1.00|10 | 58842662|1.00|10 | 64576299|1.00|12 | 44665830|1.00|11 | 42509099|0.99|11 | 56128884|1.00|11 | 49608354|1.00|10 | 271618|1.00|119 | 124032|1.00|732 | 
| 0.5 | 56523678|1.00|10 | 51686304|0.99|10 | 58756226|1.00|10 | 64477786|1.00|12 | 44598298|1.00|11 | 42449930|0.99|11 | 56045207|1.00|11 | 49538899|1.00|10 | 271618|1.00|119 | 124031|1.00|732 | 
| 1 | 42807430|0.75|9 | 40142725|0.77|9 | 45986906|0.78|9 | 49544789|0.77|12 | 33917441|0.76|10 | 34406110|0.80|11 | 43891128|0.78|10 | 38181788|0.77|9 | 271618|1.00|119 | 124032|1.00|733 | 
| 2 | 16352627|0.29|9 | 18085264|0.35|9 | 20649943|0.35|9 | 20877905|0.32|17 | 13005941|0.29|13 | 18499238|0.43|12 | 20421613|0.36|11 | 15796035|0.32|9 | 271618|1.00|119 | 124032|1.00|732 | 
| 4 | 12620143|0.22|10 | 14681057|0.28|10 | 16146951|0.27|9 | 16495100|0.25|19 | 10108266|0.23|15 | 14581428|0.34|13 | 16594278|0.30|11 | 12046317|0.24|9 | 271618|1.00|119 | 124032|1.00|731 | 
| 8 | 10384962|0.18|10 | 12606414|0.24|10 | 13521964|0.23|9 | 13873286|0.21|21 | 8252504|0.18|16 | 12347250|0.29|14 | 14039244|0.25|12 | 9853903|0.20|10 | 271150|1.00|116 | 124032|1.00|731 | 
| 16 | 8348093|0.15|11 | 10448104|0.20|10 | 11040629|0.19|9 | 11496815|0.18|24 | 6669480|0.15|18 | 10273399|0.24|15 | 11515440|0.20|12 | 7968435|0.16|10 | 9287|0.03|37 | 124032|1.00|731 | 
| 32 | 6097134|0.11|12 | 8089507|0.16|10 | 8262481|0.14|10 | 8769448|0.14|29 | 4928231|0.11|22 | 8038608|0.19|17 | 8834080|0.16|13 | 5953650|0.12|11 | 1061|0.00|25 | 124032|1.00|732 | 
| 64 | 4287270|0.08|14 | 5928223|0.11|11 | 5905220|0.10|11 | 6278220|0.10|38 | 3443054|0.08|28 | 5983322|0.14|20 | 6311533|0.11|15 | 4198414|0.08|13 | 870|0.00|30 | 124032|1.00|733 | 


|fold|nc|mt|pt|total|nc:mt:pt|percent|
|---|---:|---:|---:|---:|---:|---:|
|0|4519586198|32322542|91039488|4642948228|97.34/0.70/1.96|81.07%|
|0.2|4519517101|32322542|90791424|4642631067|97.35/0.70/1.96|81.07%|
|0.5|4512812287|32322542|90790692|4635925521|97.34/0.70/1.96|80.95%|
|1|3255160009|32322542|90915456|3378398007|96.35/0.96/2.69|58.99%|
|2|1608585038|32322542|90791424|1731699004|92.89/1.87/5.24|30.24%|
|4|1363877924|32322542|90667392|1486867858|91.73/2.17/6.10|25.96%|
|8|1214861964|31453400|90667392|1336982756|90.87/2.35/6.78|23.35%|
|16|1063620539|343619|90667392|1154631550|92.12/0.03/7.85|20.16%|
|32|916410088|26525|90791424|1007228037|90.98/0.00/9.01|17.59%|
|64|794086342|26100|90915456|885027898|89.72/0.00/10.27|15.45%|

| all | nc | mt | pt |
| --- | ---| ---| ---|
| ![all](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/cutoff/pic/all.medicago.svg)| ![nc](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/cutoff/pic/nc.medicago.svg) | ![mt](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/cutoff/pic/mt.medicago.svg) | ![pt](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/cutoff/pic/pt.medicago.svg) |

## 前期准备
### 建立工作区
```bash
mkdir ~/stq/data/anchr/Medicago_truncatula/A17/
cd ~/stq/data/anchr/Medicago_truncatula/A17/
mkdir ./genome
mkdir ./sequence_data
```
### 下载参考序列
```bash
cd ./genome
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/003/473/485/GCA_003473485.2_MtrunA17r5.0-ANR/GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna.gz
gzip -d GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna.gz
```
里面包含的内容
```text
>CM010648.1 Medicago truncatula cultivar Jemalong A17 chromosome 1, whole genome shotgun sequence
>CM010649.1 Medicago truncatula cultivar Jemalong A17 chromosome 2, whole genome shotgun sequence
>CM010650.1 Medicago truncatula cultivar Jemalong A17 chromosome 3, whole genome shotgun sequence
>CM010651.1 Medicago truncatula cultivar Jemalong A17 chromosome 4, whole genome shotgun sequence
>CM010652.1 Medicago truncatula cultivar Jemalong A17 chromosome 5, whole genome shotgun sequence
>CM010653.1 Medicago truncatula cultivar Jemalong A17 chromosome 6, whole genome shotgun sequence
>CM010654.1 Medicago truncatula cultivar Jemalong A17 chromosome 7, whole genome shotgun sequence
>CM010655.1 Medicago truncatula cultivar Jemalong A17 chromosome 8, whole genome shotgun sequence
>PSQE01000009.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c01, whole genome shotgun sequence
>PSQE01000032.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c07, whole genome shotgun sequence
>PSQE01000010.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c02, whole genome shotgun sequence
>PSQE01000033.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c08, whole genome shotgun sequence
>PSQE01000011.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c03, whole genome shotgun sequence
>PSQE01000034.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c13, whole genome shotgun sequence
>PSQE01000012.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c04, whole genome shotgun sequence
>PSQE01000035.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c16, whole genome shotgun sequence
>PSQE01000013.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c05, whole genome shotgun sequence
>PSQE01000036.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c21, whole genome shotgun sequence
>PSQE01000014.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c06, whole genome shotgun sequence
>PSQE01000037.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c23, whole genome shotgun sequence
>PSQE01000015.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c09, whole genome shotgun sequence
>PSQE01000038.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c24, whole genome shotgun sequence
>PSQE01000016.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c10, whole genome shotgun sequence
>PSQE01000039.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c25, whole genome shotgun sequence
>PSQE01000017.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c11, whole genome shotgun sequence
>PSQE01000040.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c26, whole genome shotgun sequence
>PSQE01000018.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c12, whole genome shotgun sequence
>PSQE01000019.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c14, whole genome shotgun sequence
>PSQE01000020.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c15, whole genome shotgun sequence
>PSQE01000021.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c17, whole genome shotgun sequence
>PSQE01000022.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c18, whole genome shotgun sequence
>PSQE01000023.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c19, whole genome shotgun sequence
>PSQE01000024.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c20, whole genome shotgun sequence
>PSQE01000025.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c22, whole genome shotgun sequence
>PSQE01000026.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c27, whole genome shotgun sequence
>PSQE01000027.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c28, whole genome shotgun sequence
>PSQE01000028.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c29, whole genome shotgun sequence
>PSQE01000029.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c30, whole genome shotgun sequence
>PSQE01000030.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c31, whole genome shotgun sequence
>PSQE01000031.1 Medicago truncatula cultivar Jemalong A17 MtrunA17Chr0c32, whole genome shotgun sequence
```
改名
```bash
mv GCA_003473485.2_MtrunA17r5.0-ANR_genomic.fna genome.fa
mkdir temp
for i in {1..8};
do
  export num=${i}
  list=(chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8)
  export title=${list[((${i} - 1))]}
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

下载叶绿体与线粒体序列
+ pt:NC_003119
+ mt:NC_029641
```bash
pt.fa
mt.fa
```
合并基因组序列与细胞器基因组序列
```bash
for i in $(ls ./temp/*.fa);
do
  cat ${i}
  echo
done > genome.new.fa
```

## 批处理

### 1. clean and cutoff
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
cd ${WORKING_DIR}
bash create_sequence_file_link.sh
for i in 0 0.2 0.5 1 2 4 8 16 32 64;
do
  cp -r SRR965418 SRR965418_${i}
done

# ============= clean and cutoff ===============
# 0
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
BASE_NAME=SRR965418_0
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
for i in 0.2 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  cutoff=$(echo "${i} * 10" | bc | perl -p -e 's/\..+//')
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

# 64
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
BASE_NAME=SRR965418_64
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 640 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24
    
    bsub -q mpi -n 24 -J "${BASE_NAME}" "
      bash 2_trim.sh
    "
```

### 2. build genome file index
```bash
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa
```


### 3. align

```bash
for i in 0 0.2 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
  BASE_NAME=SRR965418_${i}
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
  '
  cd ${WORKING_DIR}
done
```

### 4. calculate coverage and depth
```bash
for i in 0 0.2 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
  BASE_NAME=SRR965418_${i}
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

### 5. combine infomations
```bash
list=(0 0.2 0.5 1 2 4 8 16 32 64)
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
cd ${WORKING_DIR}
rm total.md
echo "| fold |chr1 |      |      | chr2 |      |      | chr3 |      |      | chr4 |      |      | chr5 |      |    | chr6 | | | chr7 | | | chr8 | |  | pt   |    |   | mt |   |   | " >>total.md
echo "| ---- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |" >>total.md
echo "|      | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   |">>total.md
for i in ${list[@]};
do
  BASE_NAME=SRR965418_${i}
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

### 6. visualization
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
cd ${WORKING_DIR}
for i in 0 0.2 0.5 1 2 4 8 16 32;
do
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  mkdir ./depth
  ~/stq/Applications/biosoft/deepTools-3.1.0/bin/bamCoverage -b ./align/R.sort.bam --outFileFormat bigwig -o ./deepth/Rp.bw
done
```
将文件拿到本地IGV查看

### 7. plot
```R
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

### 00. 其他
+ 将md文件重新排序
```bash
md=

cat ${md} | head -n 2 >temp.sort.md
cat ${md} | tail -n+3 | sed "s/ //g" | sort -d -t '|' -k 1.1,1.4 >> temp.sort.md
```

## 0
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|56607546|1.00|10
chr2|51766811|1.00|10
chr3|58844716|1.00|10
chr4|64577948|1.00|12
chr5|44667255|1.00|11
chr6|42510250|0.99|11
chr7|56128727|1.00|11
chr8|49609154|1.00|10
Mt|271618|1.00|119
Pt|124032|1.00|734

## 0.2
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|56609743|1.00|10
chr2|51765198|1.00|10
chr3|58842662|1.00|10
chr4|64576299|1.00|12
chr5|44665830|1.00|11
chr6|42509099|0.99|11
chr7|56128884|1.00|11
chr8|49608354|1.00|10
Mt|271618|1.00|119
Pt|124032|1.00|732

## 0.5
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|56523678|1.00|10
chr2|51686304|0.99|10
chr3|58756226|1.00|10
chr4|64477786|1.00|12
chr5|44598298|1.00|11
chr6|42449930|0.99|11
chr7|56045207|1.00|11
chr8|49538899|1.00|10
Mt|271618|1.00|119
Pt|124031|1.00|732


## 1
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|42807430|0.75|9
chr2|40142725|0.77|9
chr3|45986906|0.78|9
chr4|49544789|0.77|12
chr5|33917441|0.76|10
chr6|34406110|0.80|11
chr7|43891128|0.78|10
chr8|38181788|0.77|9
Mt|271618|1.00|119
Pt|124032|1.00|733


## 2
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|16352627|0.29|9
chr2|18085264|0.35|9
chr3|20649943|0.35|9
chr4|20877905|0.32|17
chr5|13005941|0.29|13
chr6|18499238|0.43|12
chr7|20421613|0.36|11
chr8|15796035|0.32|9
Mt|271618|1.00|119
Pt|124032|1.00|732


## 4
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|12620143|0.22|10
chr2|14681057|0.28|10
chr3|16146951|0.27|9
chr4|16495100|0.25|19
chr5|10108266|0.23|15
chr6|14581428|0.34|13
chr7|16594278|0.30|11
chr8|12046317|0.24|9
Mt|271618|1.00|119
Pt|124032|1.00|731


## 8
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|10384962|0.18|10
chr2|12606414|0.24|10
chr3|13521964|0.23|9
chr4|13873286|0.21|21
chr5|8252504|0.18|16
chr6|12347250|0.29|14
chr7|14039244|0.25|12
chr8|9853903|0.20|10
Mt|271150|1.00|116
Pt|124032|1.00|731


## 16
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|8348093|0.15|11
chr2|10448104|0.20|10
chr3|11040629|0.19|9
chr4|11496815|0.18|24
chr5|6669480|0.15|18
chr6|10273399|0.24|15
chr7|11515440|0.20|12
chr8|7968435|0.16|10
Mt|9287|0.03|37
Pt|124032|1.00|731


## 32
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|6097134|0.11|12
chr2|8089507|0.16|10
chr3|8262481|0.14|10
chr4|8769448|0.14|29
chr5|4928231|0.11|22
chr6|8038608|0.19|17
chr7|8834080|0.16|13
chr8|5953650|0.12|11
Mt|1061|0.00|25
Pt|124032|1.00|732

## 64
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|4287270|0.08|14
chr2|5928223|0.11|11
chr3|5905220|0.10|11
chr4|6278220|0.10|38
chr5|3443054|0.08|28
chr6|5983322|0.14|20
chr7|6311533|0.11|15
chr8|4198414|0.08|13
Mt|870|0.00|30
Pt|124032|1.00|733
