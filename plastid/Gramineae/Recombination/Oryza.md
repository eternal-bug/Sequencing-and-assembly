# *Oryza* 稻属
+ *Oryza sativa*[水稻]-(2n=2x=24) x *Oryza glaberrima*[非洲栽培稻]-(2n=2x=24)
+ 亚洲水稻与非洲水稻一般较难杂交。但是也存在一些杂交的情况
+ 非洲水稻品种O. glaberrima是在大约3000年以前由祖先野生稻O. barthii独立驯化而来的，这较亚洲水稻O. sativa驯化晚6000-7000年。非洲水稻驯化摇篮地在内尼日尔三角洲
+ 非洲当地水稻一两百公斤一亩。亚洲杂交水稻八百公斤一亩
+ 非洲当地的非洲水稻产量低但是能防旱和防杂草，亚洲水稻虽然高产需要大量灌溉用水，亦不能防杂草。西非水稻发展协会研制出的一个水稻杂交新种，由亚洲稻和非洲稻两个不同品种杂交而成，命名为NewRiceforAfrica(NERICA)。
+ 目前认为这两个栽培品种源于一系。在冈瓦纳古陆分裂和漂移之前，它们的祖先可能就生长在这片大陆上。

+ ![稻的演化](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/Gramineae/Recombination/pic/Oryza.png)

+ ![通过这种方法杂交亚洲水稻与非洲水稻可以得到可育的后代](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/Gramineae/Recombination/pic/fertile.png)

## 项目信息
+ [PRJNA382477](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA382477)
+ [《Sequencing of bulks of segregants allows dissection of genetic control of amylose content in rice》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5785344/#pbi12752-bib-0009)
+ sampling 1 months old seedlings and sequencing
+ 研究不同水稻中的淀粉含量以及在染色体上的定位与相关的SNP
+ University of Queensland
+ 2017-04-11

## [Run信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA382477&go=go)
| Type | No | Source | SRR | Size | Depth |
| --- | --- | --- | --- | --- | --- |
| Low amylose parent (*O. sativa*) | OSP | 科托努(Cotonou) | SRR5494009 | 1,715,132,292 * 2 | 32 |
| High amylose parent (*O. glaberrima*) | OGP | 科托努(Cotonou) |  SRR54940010 | 1,526,266,324 * 2 | 28 |
| Low amylose bulk(*O. sativa* x *O. glaberrima*) | LAB | 科托努(Cotonou) | SRR54940011 | 4,102,835,647 * 2 | 76 |
| High amylose bulk(*O. sativa* x *O. glaberrima*) | HAB | 科托努(Cotonou) | SRR54940012 | 477,388,765 * 2 | 9 |


## 运行
```bash
function echo_fastq_size {
  SRR=$1
  size=$2
  fold=$3
  format_size=$(echo ${size} | perl -MNumber::Format -n -e 'chomp;print Number::Format::format_number($_)')
  echo -e "| ${SRR} | ${format_size} * 2 | ${fold} |"
}


export genome_size=430000000
genome_file=genome.fa
WORKING_DIR=~/stq/data/anchr/Oryza
cd ${WORKING_DIR}
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
  FOLD=$(echo ${NUMBER} | sed 's/,//g' | perl -n -e 'printf "%.0f",$_*2*4/$ENV{genome_size}')
  echo ${SRR}\|${NUMBER}\|${FOLD}
done | \
sort -k1.4 -t\| > srr_size_cov.txt
# 管道的while是在子shell中的，无法修改父进程的列表。所以不能从管道中读取数据
while read i
do
  num=$( echo ${i} | cut -f3 -d\| | sed 's/,//g' )
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
    --trim2 "--dedupe --cutoff ${fold} --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
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
     bash 
     bash 2_trim.sh
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
     rm *.sam
  '
done
```

## 参考
+ [《Oryza glaberrima: A source for the improvement of Oryza sativa》](https://www.researchgate.net/publication/228623310_Oryza_glaberrima_A_source_for_the_improvement_of_Oryza_sativa)
+ [《The origin, evolution, cultivation, dissemination, and diversification of Asian and African rices》](https://link.springer.com/article/10.1007/BF00041576)
+ [《African rice (Oryza glaberrima): History and future potential》](https://www.pnas.org/content/99/25/16360)
+ [《Oryza glaberrima: A source for the improvement of Oryza sativa》](https://www.researchgate.net/publication/228623310_Oryza_glaberrima_A_source_for_the_improvement_of_Oryza_sativa)
+ [《The Rise and Fall of African Rice Cultivation Revealed by Analysis of 246 New Genomes》](https://www.cell.com/current-biology/fulltext/S0960-9822(18)30702-4)
+ [《The genome sequence of African rice (Oryza glaberrima) and evidence for independent domestication》](https://www.nature.com/articles/ng.3044)
+ [非洲新稻](https://baike.baidu.com/item/非洲新稻/15702350)
+ [水稻的演化——亚洲稻(Oryza sativa)和非洲稻(Oryza glaberrima)](http://www.cnki.com.cn/Article/CJFDTotal-JXND1983S1006.htm)
+ [冈瓦纳古陆](https://baike.baidu.com/item/冈瓦纳古陆/3722456?fr=aladdin&fromid=11180351&fromtitle=Gondwanaland)
