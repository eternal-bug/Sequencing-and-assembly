# *Medicago truncatula* [蒺藜苜蓿] 倍数因子测试
+ 因子值 0.25、0.5、1、2、4、8、16、32
+ 测试文件 SRR965418 （覆盖度 2,863,407,166 * 2 / 500,000,000 ） = 10

## 总结
| fold |     | pt   |    |   | mt |   |   | chr1 |      |      | chr2 |      |      | chr3 |      |      | chr4 |      |      | chr5 |      |    | chr6 | | | chr7 | | | chr8 | |
| ---- | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -----: | ---: | ---: | -----: | ---: | ---: |
|      | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   |
| 0 |  124032 | 1.00 | 734 |  271618 | 1.00 | 119 |  49609154 | 1.00 | 10 |  56128727 | 1.00 | 11 |  42510250 | 0.99 | 11 |  44667255 | 1.00 | 11 |  64577948 | 1.00 | 12 |  58844716 | 1.00 | 10 |  51766811 | 1.00 | 10 |  56607546 | 1.00 | 10 | 
| 0.2 |  124032 | 1.00 | 732 |  271618 | 1.00 | 119 |  49608354 | 1.00 | 10 |  56128884 | 1.00 | 11 |  42509099 | 0.99 | 11 |  44665830 | 1.00 | 11 |  64576299 | 1.00 | 12 |  58842662 | 1.00 | 10 |  51765198 | 1.00 | 10 |  56609743 | 1.00 | 10 | 
| 0.5 |  124031 | 1.00 | 732 |  271618 | 1.00 | 119 |  49538899 | 1.00 | 10 |  56045207 | 1.00 | 11 |  42449930 | 0.99 | 11 |  44598298 | 1.00 | 11 |  64477786 | 1.00 | 12 |  58756226 | 1.00 | 10 |  51686304 | 0.99 | 10 |  56523678 | 1.00 | 10 | 
| 1 |  124032 | 1.00 | 733 |  271618 | 1.00 | 119 |  38181788 | 0.77 | 9 |  43891128 | 0.78 | 10 |  34406110 | 0.80 | 11 |  33917441 | 0.76 | 10 |  49544789 | 0.77 | 12 |  45986906 | 0.78 | 9 |  40142725 | 0.77 | 9 |  42807430 | 0.75 | 9 | 
| 2 |  124032 | 1.00 | 732 |  271618 | 1.00 | 119 |  15796035 | 0.32 | 9 |  20421613 | 0.36 | 11 |  18499238 | 0.43 | 12 |  13005941 | 0.29 | 13 |  20877905 | 0.32 | 17 |  20649943 | 0.35 | 9 |  18085264 | 0.35 | 9 |  16352627 | 0.29 | 9 | 
| 4 |  124032 | 1.00 | 731 |  271618 | 1.00 | 119 |  12046317 | 0.24 | 9 |  16594278 | 0.30 | 11 |  14581428 | 0.34 | 13 |  10108266 | 0.23 | 15 |  16495100 | 0.25 | 19 |  16146951 | 0.27 | 9 |  14681057 | 0.28 | 10 |  12620143 | 0.22 | 10 | 
| 8 |  124032 | 1.00 | 731 |  271150 | 1.00 | 116 |  9853903 | 0.20 | 10 |  14039244 | 0.25 | 12 |  12347250 | 0.29 | 14 |  8252504 | 0.18 | 16 |  13873286 | 0.21 | 21 |  13521964 | 0.23 | 9 |  12606414 | 0.24 | 10 |  10384962 | 0.18 | 10 | 
| 16 |  124032 | 1.00 | 731 |  9287 | 0.03 | 37 |  7968435 | 0.16 | 10 |  11515440 | 0.20 | 12 |  10273399 | 0.24 | 15 |  6669480 | 0.15 | 18 |  11496815 | 0.18 | 24 |  11040629 | 0.19 | 9 |  10448104 | 0.20 | 10 |  8348093 | 0.15 | 11 


## 前期准备
### 建立工作区
```bash
# 创建文件链接
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
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
cd ${WORKING_DIR}
bash create_sequence_file_link.sh
for i in 0 0.2 0.5 1 2 4 8 16 32;
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

# ========= build genome file index =========
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa

# ============== align ======================


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


# ======
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
      for my $title (sort {uc($b) cmp uc($a)} keys %info){
        printf "%s | %d | %.2f | %d\n",
                $title,
                    $info{$title}{site},
                          $info{$title}{site}/$info{$title}{length},
                              $info{$title}{depth}/$info{$title}{site};
      }
    }
  ' > ./stat.md
done

# =======
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
cd ${WORKING_DIR}
rm total.md
echo "| fold |     | pt   |    |   | mt |   |   | chr1 |      |      | chr2 |      |      | chr3 |      |      | chr4 |      |      | chr5 |      |    | chr6 | | | chr7 | | | chr8 | |" >>total.md
echo "| ---- | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -----: | ---: | ---: | -----: | ---: | ---: |" >>total.md
echo "|      | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   |">>total.md
for i in 0 0.2 0.5 1 2 4 8 16 32;
do
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  echo -n "| ${i} | "
  cat ./align/stat.md | tail -n+3 | perl -p -e 's/^\w+\s*\|//' |  perl -p -e "s/\n/ | /"
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
    @order = qw/mt pt chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8/;
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
  for my $name (sort {$a cmp $b} keys %info){
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

## 0
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271618 | 1.00 | 119
Pt | 124032 | 1.00 | 734
chr1 | 56607546 | 1.00 | 10
chr2 | 51766811 | 1.00 | 10
chr3 | 58844716 | 1.00 | 10
chr4 | 64577948 | 1.00 | 12
chr5 | 44667255 | 1.00 | 11
chr6 | 42510250 | 0.99 | 11
chr7 | 56128727 | 1.00 | 11
chr8 | 49609154 | 1.00 | 10

## 0.2
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271618 | 1.00 | 119
Pt | 124032 | 1.00 | 732
chr1 | 56609743 | 1.00 | 10
chr2 | 51765198 | 1.00 | 10
chr3 | 58842662 | 1.00 | 10
chr4 | 64576299 | 1.00 | 12
chr5 | 44665830 | 1.00 | 11
chr6 | 42509099 | 0.99 | 11
chr7 | 56128884 | 1.00 | 11
chr8 | 49608354 | 1.00 | 10


## 0.5
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271618 | 1.00 | 119
Pt | 124031 | 1.00 | 732
chr1 | 56523678 | 1.00 | 10
chr2 | 51686304 | 0.99 | 10
chr3 | 58756226 | 1.00 | 10
chr4 | 64477786 | 1.00 | 12
chr5 | 44598298 | 1.00 | 11
chr6 | 42449930 | 0.99 | 11
chr7 | 56045207 | 1.00 | 11
chr8 | 49538899 | 1.00 | 10


## 1
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271618 | 1.00 | 119
Pt | 124032 | 1.00 | 733
chr1 | 42807430 | 0.75 | 9
chr2 | 40142725 | 0.77 | 9
chr3 | 45986906 | 0.78 | 9
chr4 | 49544789 | 0.77 | 12
chr5 | 33917441 | 0.76 | 10
chr6 | 34406110 | 0.80 | 11
chr7 | 43891128 | 0.78 | 10
chr8 | 38181788 | 0.77 | 9


## 2
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271618 | 1.00 | 119
Pt | 124032 | 1.00 | 732
chr1 | 16352627 | 0.29 | 9
chr2 | 18085264 | 0.35 | 9
chr3 | 20649943 | 0.35 | 9
chr4 | 20877905 | 0.32 | 17
chr5 | 13005941 | 0.29 | 13
chr6 | 18499238 | 0.43 | 12
chr7 | 20421613 | 0.36 | 11
chr8 | 15796035 | 0.32 | 9


## 4
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271618 | 1.00 | 119
Pt | 124032 | 1.00 | 731
chr1 | 12620143 | 0.22 | 10
chr2 | 14681057 | 0.28 | 10
chr3 | 16146951 | 0.27 | 9
chr4 | 16495100 | 0.25 | 19
chr5 | 10108266 | 0.23 | 15
chr6 | 14581428 | 0.34 | 13
chr7 | 16594278 | 0.30 | 11
chr8 | 12046317 | 0.24 | 9


## 8
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 271150 | 1.00 | 116
Pt | 124032 | 1.00 | 731
chr1 | 10384962 | 0.18 | 10
chr2 | 12606414 | 0.24 | 10
chr3 | 13521964 | 0.23 | 9
chr4 | 13873286 | 0.21 | 21
chr5 | 8252504 | 0.18 | 16
chr6 | 12347250 | 0.29 | 14
chr7 | 14039244 | 0.25 | 12
chr8 | 9853903 | 0.20 | 10


## 16
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 9287 | 0.03 | 37
Pt | 124032 | 1.00 | 731
chr1 | 8348093 | 0.15 | 11
chr2 | 10448104 | 0.20 | 10
chr3 | 11040629 | 0.19 | 9
chr4 | 11496815 | 0.18 | 24
chr5 | 6669480 | 0.15 | 18
chr6 | 10273399 | 0.24 | 15
chr7 | 11515440 | 0.20 | 12
chr8 | 7968435 | 0.16 | 10


## 32
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
Mt | 1061 | 0.00 | 25
Pt | 124032 | 1.00 | 732
chr1 | 6097134 | 0.11 | 12
chr2 | 8089507 | 0.16 | 10
chr3 | 8262481 | 0.14 | 10
chr4 | 8769448 | 0.14 | 29
chr5 | 4928231 | 0.11 | 22
chr6 | 8038608 | 0.19 | 17
chr7 | 8834080 | 0.16 | 13
chr8 | 5953650 | 0.12 | 11

