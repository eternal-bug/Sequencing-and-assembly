# 下载数据
## 下载鹰嘴豆(Cicer arietinum)的测序Illumina HiSeq 2000 paired-end的测序数据  从其中挑选5个测序数据
```https://trace.ncbi.nlm.nih.gov/Traces/sra/?study=SRP100678```

## 在EMBL中得到下载网址
https://www.ebi.ac.uk/ena/data/view/PRJNA375953


## 查看数据下载链接特点
```
# SRR528296
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/008/SRR5282968/SRR5282968_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/008/SRR5282968/SRR5282968_2.fastq.gz
# SRR5282969
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/009/SRR5282969/SRR5282969_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/009/SRR5282969/SRR5282969_2.fastq.gz
# SRR5282970
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/000/SRR5282970/SRR5282970_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/000/SRR5282970/SRR5282970_2.fastq.gz
# SRR5283172
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/002/SRR5283172/SRR5283172_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/002/SRR5283172/SRR5283172_2.fastq.gz
```

## 挑取其中五个数据 2968 3017 3074 3111 3160，并且确定该文件是否存在，要人工判断
```
for n in 2968 3017 3064 3111 3160
do
for m in 1 2
do

# 根据规律这里可以求余数来得到网址的数值
let a=$n%10
aria2c -x 9 -s 3 -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR528/00${a}/SRR528${n}/SRR528${n}_${m}.fastq.gz
done
done
```
```
# 得到文件的md5值
cat <<EOF >sra_md5.txt
943169f23fc3826f18a85a884709c2a1 SRR5282968_1.fastq.gz
0237a0b7574205d39f79444c2d00a32d SRR5282968_2.fastq.gz
f378685b29f9f055956ce2427ab33a71 SRR5283017_1.fastq.gz
e2c4bc288eb243d0ddc567f147b11f55 SRR5283017_2.fastq.gz
8abee78fa91bbad217eab0d79000c449 SRR5283074_1.fastq.gz
6ff98e643e0b2c50a59657e8524b3d95 SRR5283074_2.fastq.gz
b58ddcee82f9e038aef970b7716538d7 SRR5283111_1.fastq.gz
a7c41a4a87f564ffe921801f16c8e2ed SRR5283111_2.fastq.gz
5f715497b86a2117dcc29c48bee3b18b SRR5283160_1.fastq.gz
7fdcf1fdb4ba54cb2a6414b8e98a212d SRR5283160_2.fastq.gz
EOF

# 进行md5值校检
md5sum --check sra_md5.txt
```

## 数据上传
```
## 事先在超算建立好对应的文件夹
rsync -avP \
  ./*.gz \
  wangq@202.119.37.251:stq/data/anchr/Cicer_arietinum/sequence_data
```

## 下载基因组到本地
```
https://www.ncbi.nlm.nih.gov/genomes/GenomesGroup.cgi?opt=chloroplast&taxid=33090&sort=Genome#
# NC号为NC_011163
https://www.ncbi.nlm.nih.gov/nuccore/NC_011163
# 改名
mv sequence.fasta.txt Cicer_arietinum_chloroplast.fasta
# 上传到超算
rsync -avP \
  ./Cicer_arietinum_chloroplast.fasta \
  wangq@202.119.37.251:stq/data/anchr/Cicer_arietinum/genome/Cicer_arietinum_cp.fa
```

### 进入超算终端...
```
# 由于鹰嘴豆没有在线的线粒体序列数据，在查看进化树之后选取苜蓿的线粒体作为其参考序列为后续sequencher使用
cd ~/stq/data/dna-seq/cpDNA/Medicago
# 查看标签头信息
cat genome.fa | grep "^>"
# 得到线粒体的序列
cat genome.fa | perl -n -e '
BEGIN{$n = 0}
if(m/^>/){
  $n = 0;
}
if(m/>Mt/i){
  $n = 1;
  s/>Mt/>Medicago_Mt/;
}
if($n == 1){
  print $_;
}
' > medicago_mt.tmp
```
```
# 进入鹰嘴豆的目录
cd ~/stq/data/anchr/Cicer_arietinum/genome
cat ~/stq/data/dna-seq/cpDNA/Medicago/medicago_mt.tmp ./Cicer_arietinum_cp.fa >genome.fa
rm ~/stq/data/dna-seq/cpDNA/Medicago/medicago_mt.tmp
# 检查fasta中的条目数
cat genome.fa | grep "^>"
```
```
# 统计基因组大小
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
# 结果为
---
'>Medicago_Mt': 271618
'>NC_011163.1 Cicer arietinum chloroplast, complete genome': 125319
```

```
# 建立文件链接
cd ~/stq/data/anchr/Cicer_arietinum
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/_.\.fastq.gz//;print $new')
do
  mkdir -p ${name}/1_genome
  cd ${name}/1_genome
  ln -fs ../../genome/genome.fa genome.fa
  cd ${ROOTTMP}
  mkdir -p ${name}/2_illumina
  cd ${name}/2_illumina
  ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
  ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```
```
# 创建组装的bash模版文件
# 设定工作区域
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282968
cd ${WORKING_DIR}/${BASE_NAME}

# 首先查看质量评估以及其他信息
anchr template \
    . \
    --basename ${BASE_NAME} \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc

# 提交超算任务
bsub -q mpi -n 24 -J "stq" "
  bash 0_bsub.sh
"
```
