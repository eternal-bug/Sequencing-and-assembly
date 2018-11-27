# *Arabidopsis thaliana* 倍数因子测试

`cutoff值 = 倍数因子 * 覆盖深度`

+ 因子值 0、0.25、0.5、1、2、4、8、16、32
+ 测试文件 [SRR616966](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRR616966&go=go) （覆盖度 2,485,179,600 * 2 / 120,000,000 ） = 40
+ 
+ chr1 30427671
+ chr2 19698289
+ chr3 23459830
+ chr4 18585056
+ chr5 26975502
+ mt 367808
+ pt 154478

## 总结 

### 比对到参考序列的read的深度以及覆盖度
+ CP => coverage percent
+ CL => coverage length
+ DP => depth

| fold |          | chr1 |      |          | chr2 |      |          | chr3 |      |          | chr4 |      |          | chr5 |      |        |   mt |      |        |   pt |      |
| ---- | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -----: | ---: | ---: | -----: | ---: | ---: |
|      |       CL |   CP |   DP |       CL |   CP |   DP |       CL |   CP |   DP |       CL |   CP |   DP |       CL |   CP |   DP |     CL |   CP |   DP |     CL |   CP |   DP |
| 0 | 30236633 | 0.99 | 20 |  19685146 | 1.00 | 24 |  23439703 | 1.00 | 23 |  18571725 | 1.00 | 22 |  26944288 | 1.00 | 21 |  367808 | 1.00 | 171 |  154478 | 1.00 | 3113 |
| 0.25 | 30201936 | 0.99 | 20 |  19656780 | 1.00 | 24 |  23412184 | 1.00 | 23 |  18547856 | 1.00 | 22 |  26911124 | 1.00 | 21 |  367808 | 1.00 | 171 |  154478 | 1.00 | 3106 |
| 0.50 | 19909384 | 0.65 | 13 |  13005218 | 0.66 | 19 |  15223584 | 0.65 | 17 |  12191928 | 0.66 | 16 |  17515514 | 0.65 | 14 |  367808 | 1.00 | 171 |  154478 | 1.00 | 3106 |
| 1    | 3176185 | 0.10 | 15 |  2425205 | 0.12 | 47 |  2551170 | 0.11 | 43 |  2394888 | 0.13 | 33 |  2832002 | 0.10 | 24 |  367808 | 1.00 | 171 |  154478 | 1.00 | 3106 |
| 2    | 2062472 | 0.07 | 17 |  1589057 | 0.08 | 65 |  1557980 | 0.07 | 63 |  1501282 | 0.08 | 45 |  1873533 | 0.07 | 30 |  367808 | 1.00 | 171 |  154478 | 1.00 | 3106 |
| 4    |  1374032 | 0.05 | 18 |  1094509 | 0.06 | 88 |  1068548 | 0.05 | 86 |  1028231 | 0.06 | 60 |  1286160 | 0.05 | 36 |  362435 | 0.99 | 164 |  154478 | 1.00 | 3106 |
| 8    | 857392 | 0.03 | 20 |  446156 | 0.02 | 151 |  599996 | 0.03 | 143 |  484066 | 0.03 | 112 |  797324 | 0.03 | 51 |  85142 | 0.23 | 92 |  154478 | 1.00 | 3106 |
| 16   |  559988 | 0.02 | 23 |  218298 | 0.01 | 282 |  387598 | 0.02 | 211 |  286580 | 0.02 | 180 |  486207 | 0.02 | 73 |  12192 | 0.03 | 65 |  154478 | 1.00 | 3106 |
| 32   | 193577 | 0.01 | 42 |  97829 | 0.00 | 603 |  245974 | 0.01 | 321 |  147637 | 0.01 | 325 |  248242 | 0.01 | 124 |  9731 | 0.03 | 73 |  154478 | 1.00 | 3104 |

**注**：这里深度计算的为平均值。当后面高筛选倍数下核基因组在深度增加为重复序列或者与叶绿体或者线粒体同源序列。

### 计算read分布总量
通过覆盖长度与深度大致计算测序的read在核基因组与细胞器基因组中的分布

| fold | nc | mt | pt | total | nc:mt:pt | percent |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
|0|2590697331|62895168|480890014|3134482514|82.65/2.01/15.34|63.06%|
|0.25|2587468108|62895168|479808668|3130171945|82.66/2.01/15.33|62.98%|
|0.5|1205010106|62895168|479808668|1747713943|68.95/3.60/27.45|35.16%|
|1|418327072|62895168|479808668|961030909|43.53/6.54/49.93|19.34%|
|2|360267149|62895168|479808668|902970986|39.90/6.97/53.14|18.17%|
|4|320940116|59439340|479808668|860188125|37.31/6.91/55.78|17.31%|
|8|265195740|7833064|479808668|752837473|35.23/1.04/63.73|15.15%|
|16|243300449|792480|479808668|723901598|33.61/0.11/66.28|14.56%|
|32|224842808|710363|479499712|705052884|31.89/0.10/68.01|14.19%|

### 可视化
```R
library(ggplot2)

fold_list <- c(0.25,0.5,1,2,4,8,16,32)
name <- c("nucleus","mitochondria","chloroplast")
nc   <- c(2468523575,1136707943,398792606,339988312,302028186,250754839,249453021,212518271)
mt   <- c(58849280,59217088,59217088,59217088,56149060,7439220,708050,629156)
pt   <- c(456945924,456945924,456945924,456945924,456945924,456791446,456791446,456636968)

data <- data.frame(
  genome = factor(rep(name,each=8)),
  fold = c(rep(fold_list,times=3)),
  num = c(nc,mt,pt)
)
options(scipen=200)
plot(fold_list,nc,type="b",ylab = "num",xlab = "fold",col="blue",main="nucleus",ylim=c(0,2500000000))
plot(fold_list,mt,type="b",ylab = "num",xlab = "fold",col="green",main="mitochondria")
plot(fold_list,pt,type="b",ylab = "num",xlab = "fold",col="red",main="chloroplast",ylim=c(0,456950000))
ggplot(data,aes(x=fold,y=num,group=genome,colour=genome,shape=genome)) + geom_line() + geom_point()
```
| all | nc | mt | pt |
| --- | --- | --- | --- |
| ![all](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/pic/all.svg) | ![nc](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/pic/nc.svg) | ![mt](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/pic/mt.svg) | ![pt](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/evaluation/pic/pt.svg)


## 流程
```text
修剪 -> 比对 -> 转换 -> 深度与覆盖度 -> 可视化
```

## 前期准备

### 建立工作区
```bash
# 创建文件链接
mkdir ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
cd ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
mkdir ./genome
cd genome
# 下载哥伦比亚的参考序列
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/735/GCF_000001735.4_TAIR10.1/GCF_000001735.4_TAIR10.1_genomic.fna.gz
gzip -d GCF_000001735.4_TAIR10.1_genomic.fna.gz
mv GCF_000001735.4_TAIR10.1_genomic.fna genome.fa
# 查看包含的序列以及序列名称
cat ./genome.fa | grep "^>" 
# >NC_003070.9 Arabidopsis thaliana chromosome 1 sequence
# >NC_003071.7 Arabidopsis thaliana chromosome 2 sequence
# >NC_003074.8 Arabidopsis thaliana chromosome 3 sequence
# >NC_003075.7 Arabidopsis thaliana chromosome 4 sequence
# >NC_003076.8 Arabidopsis thaliana chromosome 5 sequence
# >NC_037304.1 Arabidopsis thaliana ecotype Col-0 mitochondrion, complete genome
# >NC_000932.1 Arabidopsis thaliana chloroplast, complete genome

# 其中包含了基因组序列以及细胞器基因组序列
# 这里序列名进行更改
mkdir temp
for i in {1..7};
do
  export num=${i}
  list=(chr1 chr2 chr3 chr4 chr5 mt pt)
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

cd temp
cat *.fa > ../genome.new.fa

# 创建文件链接
cd ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
bash create_sequence_file_link.sh

# 复制不同倍数的文件夹
for i in 0.25 0.5 1 2 4 8 16;
do
  cp -r SRR616966 SRR616966_${i}
done
```

### 下载安装bwa
> 将read比对到参考序列上

```bash
cd ~/stq/Applications/biosoft
# 下载bwa
wget https://github.com/lh3/bwa/releases/download/v0.7.13/bwakit-0.7.13_x64-linux.tar.bz2
tar -xjvf bwakit-0.7.13_x64-linux.tar.bz2
# 更改文件名
mv bwa.kit bwa-0.7.13
# 查看mem算法的使用说明
./bwa-0.7.13/bwa mem
```

### 下载安装deeptools
> 转换得到bedwig，使用IGV查看比对图

```bash
cd ~/stq/Applications/biosoft
wget https://github.com/deeptools/deepTools/archive/3.1.0.zip
unzip 3.1.0.zip
cd deepTools-3.1.0
# python setup.py install --user
python setup.py install
# 最后执行文件位于~/stq/Applications/biosoft/deepTools-3.1.0/bin
```

### 下载安装bamdst [不可用]
> 计算bam文件比对的深度与覆盖度信息

```bash
cd ~/stq/Applications/biosoft
git clone https://github.com/eternal-bug/bamdst.git
make
```

---
---

### 0. 建立参考序列索引
```
cd ~/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
bsub -q mpi -n 24 -J "bwa-index" '
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa
'
```

### 1. 序列修剪与筛选
```bash
WORKING_DIR=
BASE_NAME=
fold=
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
```

### 2. 比对
```bash
WORKING_DIR=
BASE_NAME=
cd ${WORKING_DIR}/${BASE_NAME}
mkdir ./align
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
' 
```

### 3. 格式转换、排序、建立索引
```bash
cp Rp.sam ./R.sam
cat Rs.sam | grep -v "^@" >> ./R.sam
samtools view -b -o ./align/R.bam ./align/R.sam
samtools sort -o ./align/R.sort.bam ./align/R.bam
samtools index ./align/R.sort.bam
```

### 4. 得到比对深度图数据
```bash
mkdir ./deep
# bamCoverage 是deeptools工具中的一个子方法

# --normalizeUsing {RPKM,CPM,BPM,RPGC,None} 使用哪种方式去标准化
#                  * RPKM = Reads Per Kilobase per Million mapped reads; 
#                  * CPM = Counts Per Million mapped reads,same as CPM in RNA-seq; 
#                  * BPM = Bins Per Million mapped reads, same as TPM in RNA-seq; 
#                  * RPGC = reads per genomic content (1x normalization);
# -b bam文件
# --outFileFormat 输出文件格式，可以输出bedgraph或者bigwig的格式
# -o 输出
~/Applications/biosoft/deepTools-3.1.0/bin/bamCoverage -b ./align/R.sort.bam --outFileFormat bigwig -o ./deepth/Rp.bw
```

### 5. 使用perl计算具体信息
```bash
export BAMFILE=*.sort.bam
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
    print "Title\tCoverage_length\tCoverage_percent\tDepth";
    for my $title (sort {$a cmp $b} keys %info){
      printf "%s\t%d\t%.2f\t%d\n",
              $title,
                  $info{$title}{site},
                        $info{$title}{site}/$info{$title}{length},
                            $info{$title}{depth}/$info{$title}{site};
    }
  }
'
```

### 6. 后续整合
+ 将所有结果整合到一个表格中
```bash
rm total.md
echo "| fold |          | chr1 |      |          | chr2 |      |          | chr3 |      |          | chr4 |      |          | chr5 |      |        |   mt |      |        |   pt |      |" >>total.md
echo "| ---- | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -------: | ---: | ---: | -----: | ---: | ---: | -----: | ---: | ---: |" >>total.md
echo "| |CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|">>total.md
for i in 0 0.25 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
  BASE_NAME=SRR616966_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  echo -n "| ${i} | "
  cat ./align/stat.md | tail -n+3 | perl -p -e 's/^\w+\s*\|//' |  perl -p -e "s/\n/ | /"
  echo
  cd ${WORKING_DIR}
done >>total.md
```
+ 计算占比
```bash
export sequence_data=4970359200
cat total.md \
| tail -n+4 \
| sed "s/\s//g" \
| perl -p -e 's/^\|//;s/\|$//' \
| perl -nl -a -F"\|" -e '
  BEGIN{
    use vars qw/@order/;
    $\ = "";
    $" = " ";
    @order = qw/chr1 chr2 chr3 chr4 chr5 mt pt/;
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
  my $total = 1;
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

---
---
## 0
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_0
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
```
### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 30236633 | 0.99 | 20
chr2 | 19685146 | 1.00 | 24
chr3 | 23439703 | 1.00 | 23
chr4 | 18571725 | 1.00 | 22
chr5 | 26944288 | 1.00 | 21
mt | 367808 | 1.00 | 171
pt | 154478 | 1.00 | 3113

## 0.25
+ 40 * 0.25 = 10
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_0.25
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 10 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```
### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 30201936 | 0.99 | 20
chr2 | 19656780 | 1.00 | 24
chr3 | 23412184 | 1.00 | 23
chr4 | 18547856 | 1.00 | 22
chr5 | 26911124 | 1.00 | 21
mt | 367808 | 1.00 | 171
pt | 154478 | 1.00 | 3106


## 0.5
+ 40 * 0.5 = 20

```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_0.5
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 19909384 | 0.65 | 13
chr2 | 13005218 | 0.66 | 19
chr3 | 15223584 | 0.65 | 17
chr4 | 12191928 | 0.66 | 16
chr5 | 17515514 | 0.65 | 14
mt | 367808 | 1.00 | 171
pt | 154478 | 1.00 | 3106


## 1
+ 40 * 1 = 40

```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_1
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 40 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 3176185 | 0.10 | 15
chr2 | 2425205 | 0.12 | 47
chr3 | 2551170 | 0.11 | 43
chr4 | 2394888 | 0.13 | 33
chr5 | 2832002 | 0.10 | 24
mt | 367808 | 1.00 | 171
pt | 154478 | 1.00 | 3106


## 2
+ 40 * 2 = 80
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_1
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 80 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 2062472 | 0.07 | 17
chr2 | 1589057 | 0.08 | 65
chr3 | 1557980 | 0.07 | 63
chr4 | 1501282 | 0.08 | 45
chr5 | 1873533 | 0.07 | 30
mt | 367808 | 1.00 | 171
pt | 154478 | 1.00 | 3106



## 4
+ 40 * 4 = 160
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_4
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 160 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```
### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 1374032 | 0.05 | 18
chr2 | 1094509 | 0.06 | 88
chr3 | 1068548 | 0.05 | 86
chr4 | 1028231 | 0.06 | 60
chr5 | 1286160 | 0.05 | 36
mt | 362435 | 0.99 | 164
pt | 154478 | 1.00 | 3106


## 8
+ 40 * 8 = 320
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_8
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 320 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 857392 | 0.03 | 20
chr2 | 446156 | 0.02 | 151
chr3 | 599996 | 0.03 | 143
chr4 | 484066 | 0.03 | 112
chr5 | 797324 | 0.03 | 51
mt | 85142 | 0.23 | 92
pt | 154478 | 1.00 | 3106


## 16
+ 40 * 16 = 640
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_16
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

### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 559988 | 0.02 | 23
chr2 | 218298 | 0.01 | 282
chr3 | 387598 | 0.02 | 211
chr4 | 286580 | 0.02 | 180
chr5 | 486207 | 0.02 | 73
mt | 12192 | 0.03 | 65
pt | 154478 | 1.00 | 3106

## 32
+ 40 * 32 = 1280
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/col_0/Hiseq
BASE_NAME=SRR616966_32
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff 1280 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24

bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"
```

### 结果
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1 | 193577 | 0.01 | 42
chr2 | 97829 | 0.00 | 603
chr3 | 245974 | 0.01 | 321
chr4 | 147637 | 0.01 | 325
chr5 | 248242 | 0.01 | 124
mt | 9731 | 0.03 | 73
pt | 154478 | 1.00 | 3104

## 参考
+ [用UCSC提供的Genome Browser工具来可视化customTrack](https://www.plob.org/article/9509.html)
+ [可视化工具之 IGV 使用方法](https://www.cnblogs.com/leezx/p/5603481.html)
+ [【直播】我的基因组（19）:根据比对结果来统计测序深度和覆盖度](http://www.bio-info-trainee.com/2163.html)
+ [利用samtools mpileup和bcftools进行SNP calling](https://www.plob.org/article/11380.html)
+ [ggplot2-条形图和折线图](https://blog.csdn.net/tanzuozhev/article/details/50822204)
