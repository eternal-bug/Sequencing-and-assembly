
# *Glycine max*[大豆]
+ 测序仪器:Illumina HiSeq 2000
+ 测序方式:PAIRED-end
+ 基因组大小:889.33~1118.34Mb
+ 叶绿体 : [NC_007942.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_007942.1) - 152218bp
+ 线粒体 : [NC_020455.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_020455.1) -402558bp
+ 数据来源:[SRP045129](https://www.ebi.ac.uk/ena/data/view/PRJNA257011)

## 出版文章
+ [《Genome-wide association studies dissect the genetic networks underlying agronomical traits in soybean》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5571659/)

## 文件大小
| type | file | size.Bp | coverage | seq len |insert |	seq type |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| IGDB-TZX-011 | SRR1533216 | 14,629,105,900 * 2 | ~29 | 100 | ~260 | Illumina HiSeq 2000 |
| IGDB-TZX-017 | SRR1533217 | 5,378,017,000 * 2 | ~10 | p |
| IGDB-TZX-022 | SRR1533218 | 3,488,938,600 * 2 | ~6  | p |
| IGDB-TZX-027 | SRR1533219 | 7,356,473,200 * 2 | ~14 | p |
| IGDB-TZX-031 | SRR1533220 | 6,479,795,500 * 2 | ~12 | p |
| IGDB-TZX-050 | SRR1533221 | 8,558,788,700 * 2 | ~16 | p |
| IGDB-TZX-412 | SRR1533268 | 18,279,053,000 * 2 | ~36 | 100 | ~340 | Illumina HiSeq 2000 |
| IGDB-TZX-721 | SRR1533313 | 14,839,423,400 * 2 | ~29 | 100 | ~370 | Illumina HiSeq 2000 |
| IGDB-TZX-940 | SRR1533335 | 15,061,368,600 * 2 | ~30 | 100 | ~280 | Illumina HiSeq 2000 |
| IGDB-TZX-890 | SRR1533440 | 14,593,361,800 * 2 | ~29 | 100 | ~220 | Illumina HiSeq 2000 |

## 项目2
+ SRP015830
+ [《Molecular footprints of domestication and improvement in soybean revealed by whole genome re-sequencing》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3844514/)
+ Resequencing of 14 cultivated soybean individuals and 17 wild soybean individuals using Solexa


+ (w) is Glycine soja, otherwise Glycine max.

+ [strains](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA257011&go=go)

## 其他
+ Pseudomonas syringae pv. syringae B728a, complete genome - [CP000075.1](https://www.ncbi.nlm.nih.gov/nuccore/CP000075.1)

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

+ ~29

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
    --genome 1_000_000 \
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

## 项目2
+ [PRJNA294227](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA294227)
+ [《Evaluation of genetic variation among Brazilian soybean cultivars through genome resequencing》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4752768/)
+ 巴西大豆栽培种的重测序

### [Run信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRP062975&go=go)
> **没有多样性**
| type | file | size.Bp | coverage |
| --- | ---: | ---: | ---: |
| BRS 232 | SRR2201977 | 6,102,149,600 * 2 | 11 |
| BR 16 | SRR2202214 | 9,791,438,200 * 2 | 19 |
| BRS 284 | SRR2202255 | 8,550,880,200 * 2 | 17 |
| BRS 360 RR | SRR2202256 | 10,045,581,700 * 2 | 20 |
| BRS Sambaiba | SRR2202257 | 9,579,502,700 * 2 | 19 |
| BRS Valiosa RR | SRR2202258 | 7,790,010,900 * 2 | 15 |
| BR/GO 8660 | SRR2202259 | 7,082,749,000 * 2 | 14 |
| BRSMG 850G RR | SRR2202260 | 10,859,448,800 * 2 | 22 |
| BRSMT Pintado | SRR2202261 | 9,547,334,300 * 2 | 19 |
| CD 201 | SRR2202262 | 11,046,327,200 * 2 | 22 |
| FT Abyara | SRR2202263 | 9,243,759,700 * 2 | 18 | 
| Embrapa 48 | SRR2202264 | 10,526,154,300 * 2 | 21 |
| FT Cristalina | SRR2202265 | 11,130,399,800 * 2 | 22 |
| BRS 361 | SRR2202266 | 9,548,283,600 * 2 | 19 |
| IAC 8 | SRR2202350 | 10,199,629,700 * 2 | 20 |
| IAS 5 | SRR2202351 | 7,513,509,600 * 2 | 15 |
| BR/MG 46 (Conquista) | SRR2202352 | 13,567,241,100 * 2 | 27 |
| NA 5909 RG | SRR2202353 | 9,427,689,100 * 2 | 18 |
| P98Y11 | SRR2202354 | 7,435,448,800 * 2 | 15 |

### 运行
```bash
export genome_size=1000000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Glycine_max
cd ${WORKING_DIR}

# build index
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/${genome_file}

echo -n >srr_size_cov.txt
list=($(ls -d SRR*))
((list_len=${}))

# get cut off fold number
n=0
fold_list=()
parallel -j 20 --ungroup -k --delay 1 "
  bash ~/stq/Applications/my/stat/stat_fastq_size.sh ./sequence_data/{1}_1.fastq.gz | tail -n 1 
" ::: ${list[@]} | \
sed 's/ //g' | \
sed 's/^|//g' | \
sed 's/|$//g' | \
sed 's/|/:/g' | \
while IFS=$':' read -r -a row;
do
  SRR=$(basename ${row[0]} | perl -p -e 's/[._]R?\d+\.f(ast)*q\.gz//')
  NUMBER=${row[1]}
  DEPTH=$(echo ${NUMBER} | sed 's/,//g' | perl -n -e 'printf "%.0f",$_*2/$ENV{genome_size}')
  FOLD=$(echo ${NUMBER} | sed 's/,//g' | perl -n -e 'printf "%.0f",$_*2*4/$ENV{genome_size}')
  echo ${SRR}\|${NUMBER}\|${DEPTH}\|${FOLD}
done | \
sort -k1.4 -t\| > srr_size_cov.txt
# 管道的while是在子shell中的，无法修改父进程的列表。所以不能从管道中读取数据
while read i
do
  num=$( echo ${i} | cut -f4 -d\| | sed 's/,//g' )
  fold_list[${n}]=${num}
  ((n++))
done < srr_size_cov.txt

((max=${#list[@]}-1))
for i in $(seq 0 ${max});
do
  BASE_NAME=${list[$i]}
  fold=${fold_list[$i]}
  cd ${WORKING_DIR}/${BASE_NAME}
  anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff ${fold} --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "120" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24
    
  # align
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     bash 0_master.sh
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.fa \
         ./2_illumina/trim/Q25L60/R1.fq.gz \
         ./2_illumina/trim/Q25L60/R2.fq.gz > ./align/Rp.sam
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.fa \
         ./2_illumina/trim/Q25L60/Rs.fq.gz > ./align/Rs.sam
         
     cp ./align/Rp.sam ./align/R.sam
     cat ./align/Rs.sam | grep -v "^@" >> ./align/R.sam
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
     rm ./align/*.sam
  '
done
```
