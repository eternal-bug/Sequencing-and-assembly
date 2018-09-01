# Pisum_sativum[豌豆]
> [《基于流式细胞术的芒果基因组c值测定》](http://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CJFQ&dbname=CJFDLAST2015&filename=RDZX201509014&uid=WEEvREdxOWJmbC9oM1NjYkZCbDZZNTBLeGp2MUFHclRDVGZSYmhNRytCT1c=$R1yZ0H6jyaa0en3RxVUd8df-oHi7XMMDo7mtKT6mSmEvTuk11l2gFA!!&v=MjU0MzRublY3N0pOeW5SZHJHNEg5VE1wbzlFWUlSOGVYMUx1eFlTN0RoMVQzcVRyV00xRnJDVVJMS2ZiK1Z1Rnk=)

+ 1pg = 0.978Gb

> [《De Novo Assembly of the Pea (Pisum sativum L.) Nodule Transcriptome》](https://www.hindawi.com/journals/ijg/2015/695947/)

> [流式细胞术测定的植物基因组大小-kew](http://data.kew.org/cvalues/CvalServlet?querytype=1)

+ 4.88pg(1C)

| item | number |
| -- | -- |
| flow cytometry | 4.88pg(1C) |
| genome | 4.88 * 0.978 = 4772Mb |
| [chloroplast genome](https://www.ncbi.nlm.nih.gov/nuccore/MG859922.1) | 122198 bp |

## 品系
+ G06
+ G211
+ G2853
+ G47
+ G543
+ G883

## 通过fastqc的结果计算得到总的核酸量或者用statistic_fastq_size.sh脚本统计
| file | Gb.size | Mb.size | Kb.size |
| ---  | ---     | ---     | ---     |
| G06_L1_338338.R1.fastq.gz | 5 | 5247 | 5247487 |
| G06_L1_338338.R2.fastq.gz | 5 | 5247 | 5247487 |
| G211_L1_340340.R1.fastq.gz | 4 | 4837 | 4837078 |
| G211_L1_340340.R2.fastq.gz | 4 | 4837 | 4837078 |
| G2853_L1_343343.R1.fastq.gz | 4 | 4336 | 4336699 |
| G2853_L1_343343.R2.fastq.gz | 4 | 4336 | 4336699 |
| G47_L1_339339.R1.fastq.gz | 5 | 5258 | 5258244 |
| G47_L1_339339.R2.fastq.gz | 5 | 5258 | 5258244 |
| G543_L1_341341.R1.fastq.gz | 4 | 4960 | 4960699 |
| G543_L1_341341.R2.fastq.gz | 4 | 4960 | 4960699 |
| G883_L1_342342.R1.fastq.gz | 4 | 4752 | 4752177 |
| G883_L1_342342.R2.fastq.gz | 4 | 4752 | 4752177 |

## 新建工作区
```bash
cd ~/stq/data/anchr/our_sequence
mkdir -p ../Pisum_sativum/seuqence_data
mkdir -p ../Pisum_sativum/genome
mv ./raw/G* ../Pisum_sativum/seuqence_data
```

## 下载基因组文件
在NCBI的核酸库中搜索`Pisum sativum plastid,complete genome`
得到信息
+ GenBank: MG859922.1
+ [Pisum sativum subsp. elatius isolate CE1 chloroplast, complete genome](https://www.ncbi.nlm.nih.gov/nuccore/MG859922.1)
使用浏览器下载之后上传到超算
```
mv sequence.fasta genome.fa
rsync -avP \
./genome.fa \
wangq@202.119.37.251:stq/data/anchr/our_sequence/Pisum_sativum/genome
```

## 建立文件链接
```bash
cd ~/stq/data/anchr/our_sequence/Pisum_sativum/
ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\.R\w+\.fastq\.gz//;print $new')
do
  if [ ! -d ${name} ];
  then
    # 新建文件夹
    mkdir -p ${name}/1_genome
    mkdir -p ${name}/2_illumina
  else
    # 建立链接
    cd ${name}/1_genome
    ln -fs ../../genome/genome.fa genome.fa
    cd ${ROOTTMP}
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}.R1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}.R2.fastq.gz R2.fq.gz
    cd ${ROOTTMP}
  fi
done
```

---
# G06

## 进行组装
```bash
WORKING_DIR=~/stq/data/anchr/our_sequence/Pisum_sativum
BASE_NAME=G06_L1_338338
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 8 --cutk 31" \
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

## BUSCO评估
```
bash process_busco.sh
```

## 合并md统计结果
```bash
combine_md.sh
```

## 统计结果


# G211
