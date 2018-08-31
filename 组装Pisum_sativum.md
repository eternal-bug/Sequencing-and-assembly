# Pisum_sativum[豌豆]
> [《基于流式细胞术的芒果基因组c值测定》](http://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CJFQ&dbname=CJFDLAST2015&filename=RDZX201509014&uid=WEEvREdxOWJmbC9oM1NjYkZCbDZZNTBLeGp2MUFHclRDVGZSYmhNRytCT1c=$R1yZ0H6jyaa0en3RxVUd8df-oHi7XMMDo7mtKT6mSmEvTuk11l2gFA!!&v=MjU0MzRublY3N0pOeW5SZHJHNEg5VE1wbzlFWUlSOGVYMUx1eFlTN0RoMVQzcVRyV00xRnJDVVJMS2ZiK1Z1Rnk=)

+ 1pg = 0.978Gb

> [流式细胞术测定的植物基因组大小-kew](http://data.kew.org/cvalues/CvalServlet?querytype=1)
> [《De Novo Assembly of the Pea (Pisum sativum L.) Nodule Transcriptome》](https://www.hindawi.com/journals/ijg/2015/695947/)

+ 4.88pg(1C)

| item | number |
| -- | -- |
| flow cytometry | 4.88pg(1C) |
| genome | 4.88 * 0.978 = 4772Mb |
| [chloroplast genome](https://www.ncbi.nlm.nih.gov/nuccore/MG859922.1) | 122198 bp |

## 通过fastqc的结果计算得到总的核酸量
| strain | sequence size |
| --- | --- |
| | |

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

## 进行组装
