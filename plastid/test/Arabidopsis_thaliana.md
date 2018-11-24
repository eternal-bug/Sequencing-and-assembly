# *Arabidopsis thaliana* 倍数因子测试
+ 因子值 0.5、1、2、4、8、16、32
+ 测试文件 [SRR616966](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRR616966&go=go) （覆盖度 2,485,179,600 * 2 / 120,000,000 ） = 40

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
```text
Title   Coverage_length Coverage_percent        Depth
chr1    19862890        0.65    12
chr2    12976426        0.66    18
chr3    15188988        0.65    16
chr4    12162917        0.65    16
chr5    17472855        0.65    13
mt      367808  1.00    161
pt      154478  1.00    2958
```

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


## 参考
+ [用UCSC提供的Genome Browser工具来可视化customTrack](https://www.plob.org/article/9509.html)
+ [可视化工具之 IGV 使用方法](https://www.cnblogs.com/leezx/p/5603481.html)
+ [【直播】我的基因组（19）:根据比对结果来统计测序深度和覆盖度](http://www.bio-info-trainee.com/2163.html)
