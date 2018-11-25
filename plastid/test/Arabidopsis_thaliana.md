# *Arabidopsis thaliana* 倍数因子测试
+ 因子值 0.5、1、2、4、8、16、32
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

| 倍数 | | chr1 | | | chr2 | | | chr3 | | | chr4 | | | chr5|  | | mt|  | | pt|  |
| --- | ---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |---: |
| |CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|CL|CP|DP|
| 0.25 |30198077|0.99|19|19655003|1.00|23|23410636|1.00|22|18546711|1.00|21|26909006|1.00|20|367808|1.00|160|154478|1.00|2958|
| 0.50 |19862890|0.65|12|12976426|0.66|18|15188988|0.65|16|12162917|0.65|16|17472855|0.65|13|367808|1.00|161|154478|1.00|2958|
| 1 |3138189|0.10|15|2400980|0.12|45|2522557|0.11|41|2371076|0.13|32|2798974|0.10|23|367808|1.00|161|154478|1.00|2958|
| 2 |2027961|0.07|16|1565677|0.08|62|1531344|0.07|60|1479811|0.08|44|1844022|0.07|29|367808|1.00|161|154478|1.00|2958|
| 4 |1340687|0.04|17|1073681|0.05|84|1044383|0.04|82|1007353|0.05|59|1256402|0.05|35|362252|0.98|155|154478|1.00|2958|
| 8 |828543|0.03|20|427467|0.02|147|580208|0.02|138|466652|0.03|113|770919|0.03|50|82658|0.22|90|154478|1.00|2957|
|16 |532115|0.02|23|369102|0.02|208|369102|0.02|208|270559|0.01|185|460473|0.02|73|10115|0.03|70|154478|1.00|2957|
|32 |166437|0.01|47|80745|0.00|683|227252|0.01|325|131802|0.01|354|221619|0.01|131|7964|0.02|79|154478|1.00|2956|

**注**：这里深度计算的为平均值。当后面高筛选倍数下核基因组在深度增加为重复序列或者与叶绿体或者线粒体同源序列。

### 计算read分布
通过覆盖长度与深度大致计算测序的read在核基因组与细胞器基因组中的分布

| 倍数 | 核基因组 | 线粒体 | 叶绿体 | 总计 | 核:线:叶 | 占总测序数据比 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 0.25 |2468523575|58849280|456945924| 2984318779 | 8.27:0.20:1.53 | 60.04% |
| 0.5 |1136707943|59217088|456945924| 1652870955 | 6.88:0.36:2.76 | 33.25% |
| 1 |398792606|59217088|456945924| 914955618 | 4.36:0.65:4.99 | 18.41% |
| 2 |339988312|59217088|456945924| 856151324 | 3.97:0.69:5.34 | 17.23% |
| 4 |302028186|56149060|456945924| 815123170 | 3.71:0.69:5.60 | 16.40% |
| 8 |250754839|7439220|456791446| 714985505 | 3.51:0.10:6.39 | 14.38% |
| 16 |249453021|708050|456791446| 706952517 | 3.53:0.01:6.46 | 14.22% |
| 32 |212518271|629156|456636968| 669784395 | 3.17:0.01:6.82 | 13.48% |

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
| ![all](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/test/pic/all.svg) | ![nc](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/test/pic/nc.svg) | ![mt](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/test/pic/mt.svg) | ![pt](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/test/pic/pt.svg)


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
bash create_sequence_file_link.sh

# 复制不同倍数的文件夹
for i in 0.5 1 2 4 8 16;
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

### 1. 序列修建
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
   ~stq/Applications/biosoft/bwa-0.7.13/bwa mem \
       -t 20 \
       -M   \
       ../genome/genome.new.fa \
       ./2_illumina/trim/Q25L60/Rs.fq.gz > ./align/Rs.sam
' 
```

### 3. 格式转换、排序、建立索引
```bash
samtools view -b -o ./align/Rp.bam ./align/Rp.sam
samtools sort -o ./align/Rp.sort.bam ./align/Rp.bam
samtools index ./align/Rp.sort.bam
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
~/Applications/biosoft/deepTools-3.1.0/bin/bamCoverage -b ./align/Rp.sort.bam --outFileFormat bigwig -o ./deepth/Rp.bw
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

---
---

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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 30198077 | 0.99 | 19 |
| chr2 | 19655003 | 1.00 | 23 |
| chr3 | 23410636 | 1.00 | 22 |
| chr4 | 18546711 | 1.00 | 21 |
| chr5 | 26909006 | 1.00 | 20 |
| mt | 367808 | 1.00 | 160 |
| pt | 154478 | 1.00 | 2958 |


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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 19862890 | 0.65 | 12 |
| chr2 | 12976426 | 0.66 | 18 |
| chr3 | 15188988 | 0.65 | 16 |
| chr4 | 12162917 | 0.65 | 16 |
| chr5 | 17472855 | 0.65 | 13 |
| mt | 367808 | 1.00 | 161 |
| pt | 154478 | 1.00 | 2958 |


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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 3138189 | 0.10 | 15 |
| chr2 | 2400980 | 0.12 | 45 |
| chr3 | 2522557 | 0.11 | 41 |
| chr4 | 2371076 | 0.13 | 32 |
| chr5 | 2798974 | 0.10 | 23 |
| mt | 367808 | 1.00 | 161 |
| pt | 154478 | 1.00 | 2958 |


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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 2027961 | 0.07 | 16 |
| chr2 | 1565677 | 0.08 | 62 |
| chr3 | 1531344 | 0.07 | 60 |
| chr4 | 1479811 | 0.08 | 44 |
| chr5 | 1844022 | 0.07 | 29 |
| mt | 367808 | 1.00 | 161 |
| pt | 154478 | 1.00 | 2958 |



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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 1340687 | 0.04 | 17 |
| chr2 | 1073681 | 0.05 | 84 |
| chr3 | 1044383 | 0.04 | 82 |
| chr4 | 1007353 | 0.05 | 59 |
| chr5 | 1256402 | 0.05 | 35 |
| mt | 362252 | 0.98 | 155 |
| pt | 154478 | 1.00 | 2958 |


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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 828543 | 0.03 | 20 |
| chr2 | 427467 | 0.02 | 147 |
| chr3 | 580208 | 0.02 | 138 |
| chr4 | 466652 | 0.03 | 113 |
| chr5 | 770919 | 0.03 | 50 |
| mt | 82658 | 0.22 | 90 |
| pt | 154478 | 1.00 | 2957 |


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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 532115 | 0.02 | 23 |
| chr2 | 200427 | 0.01 | 287 |
| chr3 | 369102 | 0.02 | 208 |
| chr4 | 270559 | 0.01 | 185 |
| chr5 | 460473 | 0.02 | 73 |
| mt | 10115 | 0.03 | 70 |
| pt | 154478 | 1.00 | 2957 |

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
| Title | Coverage_length | Coverage_percent | Depth |
| --- | --- | --- | --- |
| chr1 | 166437 | 0.01 | 47 |
| chr2 | 80745 | 0.00 | 683 |
| chr3 | 227252 | 0.01 | 325 |
| chr4 | 131802 | 0.01 | 354 |
| chr5 | 221619 | 0.01 | 131 |
| mt | 7964 | 0.02 | 79 |
| pt | 154478 | 1.00 | 2956 |

## 参考
+ [用UCSC提供的Genome Browser工具来可视化customTrack](https://www.plob.org/article/9509.html)
+ [可视化工具之 IGV 使用方法](https://www.cnblogs.com/leezx/p/5603481.html)
+ [【直播】我的基因组（19）:根据比对结果来统计测序深度和覆盖度](http://www.bio-info-trainee.com/2163.html)
+ [利用samtools mpileup和bcftools进行SNP calling](https://www.plob.org/article/11380.html)
+ [ggplot2-条形图和折线图](https://blog.csdn.net/tanzuozhev/article/details/50822204)
