# *Cicer arietinum*[鹰嘴豆]
[TOC levels=1-2]: # " "
+ [基本信息](#基本信息)
    + [数据编号](#数据编号)
    + [数据大小](#数据大小)
+ [前期准备](#前期准备) 
+ [SRR5282968](#srr5282968)
+ [SRR5283017](#srr5283017)
+ [SRR5283074](#srr5283074)
+ [SRR5283111](#srr5283111)
+ [SRR5283160](#srr5283160)
+ [参考文献](#参考文献)

# 基本信息
+ 数据来源: PRJNA375953
+ 测序仪器：Illumina HiSeq 2000
+ 测序方式：paired-end
+ 核基因组大小:740Mbp[科学网](http://blog.sciencenet.cn/blog-3533-766578.html)
+ 细胞器基因组:125Kb(叶绿体)

## 数据编号
+ 第一批
  + SRR5282968
  + SRR5283017
  + SRR5283074
  + SRR5283111
  + SRR5283160[未组装]
+ 第二批
  + SRR5282970
  + SRR5282976
  + SRR5282986
  + SRR5282995
  + SRR5283000

## 数据大小
| type | file | Bp | cov | insert | seq.len |
| --- | --- | ---: | ---: | ---: | ---: |
| YORKER_A    | SRR5282968 | 1,679,849,850 * 2 | ~4.3 | ~450 | 150 | p+ |
| Garnet      | SRR5283017 | 1,891,080,600 * 2 | ~4.8 | ~600 | 150 | p+ |
| DICC8236    | SRR5283074 | 2,034,718,600 * 2 | ~5.4 | ~600 | 100 |p+ |
| DICC8115    | SRR5283111 | 2,266,187,200 * 2 | ~5.9 | ~600 | 100 | p+ |
| AB013       | SRR5283160 | 2,501,687,000 * 2 | ~6.7 | p+ |
| WACPE2160.  | SRR5282970 | 4,625,841,900 * 2 | ~12.5| p+ |
| Semsen      | SRR5282976 | 2,317,602,000 * 2 | ~6.2 | p+ |
| PBABoundary | SRR5282986 | 2,328,268,500 * 2 | ~6.2 | p+ |
| Kyabra      | SRR5282995 | 2,979,627,900 * 2 | ~8   | p+ |
| ICC8261     | SRR5283000 | 3,365,227,000 * 2 | ~9   | 

# 前期准备
下载鹰嘴豆(Cicer arietinum)的测序Illumina HiSeq 2000 paired-end的测序数据  从其中挑选5个测序数据
```https://trace.ncbi.nlm.nih.gov/Traces/sra/?study=SRP100678```

在EMBL中得到下载网址
https://www.ebi.ac.uk/ena/data/view/PRJNA375953


查看数据下载链接特点
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

## 下载数据
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

## 进入超算终端...
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
if(m/>.*Mt|Mt.*/i){
  $n = 1;
  s/>.+/>Medicago_Mt/;
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
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/_.*\.fastq.gz//;print $new')
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


# SRR5282968
+ 4

### 设定工作区域、创建组装的bash模版文件
```
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282968
cd ${WORKING_DIR}/${BASE_NAME}

# 首先查看质量评估以及其他信息
anchr template \
    . \
    --basename ${BASE_NAME} \
    --fastqc \
    --insertsize \
    --sgapreqc \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "stq" "
if [ -e 2_fastqc.sh ]; then
    bash 2_fastqc.sh;
fi
if [ -e 2_kmergenie.sh ]; then
    bash 2_kmergenie.sh;
fi

if [ -e 2_insertSize.sh ]; then
    bash 2_insertSize.sh;
fi

if [ -e 2_sgaPreQC.sh ]; then
    bash 2_sgaPreQC.sh;
"
```
```
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 16 --cutk 31" \
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
bash 0_bsub.sh
"
```

---
# SRR5283017
+ 5

## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283017
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 20 --cutk 31" \
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
bash 0_bsub.sh
"
```
# SRR5283074
+ 5.5

## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283074
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 22 --cutk 31" \
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
bash 0_bsub.sh
"
```

---
# SRR5283111
+ 5.9
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283111
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 24 --cutk 31" \
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
bash 0_bsub.sh
"
```

# SRR5283160
+ 6.7
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283160
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 27 --cutk 31" \
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
bash 0_bsub.sh
"
```

# SRR5282970
+ 12.5
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282970
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 50 --cutk 31" \
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
bash 0_bsub.sh
"
```

# SRR5282976
+ 6.2
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282976
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 25 --cutk 31" \
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
bash 0_bsub.sh
"
```

# SRR5282986
+ 6.2
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282986
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 25 --cutk 31" \
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
"
```

# SRR5282995
+ 8
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5282995
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 32 --cutk 31" \
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
"
```

# SRR5283000
+ 9
## 组装
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Cicer_arietinum
BASE_NAME=SRR5283000
cd ${WORKING_DIR}/${BASE_NAME}
rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 36 --cutk 31" \
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
"
```

# 参考文献
《Genome Analysis Identified Novel Candidate Genes for Ascochyta Blight Resistance in Chickpea Using Whole Genome Re-sequencing Data》
Plant Materials and Sequencing
In this study, the plant materials include 48 chickpea varieties released in Australia from 1978 to 2016, 16 advanced breeding lines, four landraces, and one wild chickpea C. reticulatum (Supplementary Table S1). The released varieties and advanced breeding lines are a good representation of the genetic diversity present in the Australian chickpea breeding program. The wild species C. reticulatum and landraces serve as a reference point for investigating genetic diversity. DNA was extracted from young leaf using Qiagen DNeasy Plant Mini Kit according to the manufacturer’s instructions. Pair-end sequencing libraries were constructed for each genotype with insert sizes of ∼500 bp using TruSeq library kit according to the Illumina manufacturer’s instruction. Around 40 million 150 bp paired-end reads for each genotype were generated by the Australian Genome Research Facility in Brisbane, Australia using Illumina HiSeq 2000 platform. Sequence data is available from the NCBI Short Read Archive under BioProject accession PRJNA375953.

《Investigating Drought Tolerance in Chickpea Using Genome-Wide Association Mapping and Genomic Selection Based on Whole-Genome Resequencing Data》

WGRS and SNP Discovery DNA of the 132 genotypes was extracted from young leaf tissues using the Qiagen DNeasy Plant Mini Kit following the manufacturer’s instruction. Paired-end sequencing libraries were constructed using the TruSeq library kit for each genotype with an insert size of 500 bp. The procedure was implemented according to the Illumina manufacturer’s instruction. Paired-end short reads (150 bp) were generated using the Illumina HiSeq 2000 platform. Sequence data is available from the NCBI Short Read Archive under BioProject accession PRJNA375953. Paired-end reads for each genotype were trimmed, filtered, and mapped to the kabuli reference genome 2.6.31 using SOAP2. Homozygous SNPs were called using the SGSautoSNP pipeline (Lorenc et al., 2012).
