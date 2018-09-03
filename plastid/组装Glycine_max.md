# 基本信息
+ 测序仪器:Illumina HiSeq 2000
+ 测序方式:PAIRED-end
+ 基因组大小:889.33~1118.34Mb
+ 细胞器基因组:152218[叶绿体] + 402558[线粒体]
+ 数据来源:[SRP045129](https://www.ebi.ac.uk/ena/data/view/PRJNA257011)

## 测序文件
+ SRR1533216
+ SRR1533268
+ SRR1533313
+ SRR1533335
+ SRR1533440

## 文件大小
wangq@c01n01:~/stq/data/anchr/Glycine_max/sequence_data$ cat output.715981 
| file | size.Bp |
| --- | --- |
| SRR1533216_1.fastq.gz | 14629105900 |
| SRR1533216_2.fastq.gz | 14629105900 |
| SRR1533268_1.fastq.gz | 18279053000 |
| SRR1533268_2.fastq.gz | 18279053000 |
| SRR1533313_1.fastq.gz | 14839423400 |
| SRR1533313_2.fastq.gz | 14839423400 |
| SRR1533335_1.fastq.gz | 15061368600 |
| SRR1533335_2.fastq.gz | 15061368600 |
| SRR1533440_1.fastq.gz | 14593361800 |
| SRR1533440_2.fastq.gz | 14593361800 |


# 前期准备
## 新建工作区
```bash
cd ~/stq/data/anchr/
mkdir -p ../Glycine_max/sequence_data
mkdir -p ../Glycine_max/genome
mv ./*.fastq.gz ../Glycine_max/seuqence_data
mv ./*.fa ../Glycine_max/genome
```

## 查看参考文件的基因组大小
```bash
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

# 结果
'>NC_007942.1 Glycine max chloroplast, complete genome': 152218
'>NC_020455.1 Glycine max mitochondrion, complete genome': 402558
```

# SRR1533216
## 组装
```bash
WORKING_DIR=~/stq/data/anchr/Glycine_max
BASE_NAME=SRR1533216
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 116 --cutk 31" \
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
bash 0_bsub.sh
```
