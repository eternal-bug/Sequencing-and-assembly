# *Oryza* 稻属
+ *Oryza sativa*[水稻]-(2n=2x=24) x *Oryza glaberrima*[非洲栽培稻]-(2n=2x=24)
+ 亚洲水稻与非洲水稻一般较难杂交。但是也存在一些杂交的情况
+ 非洲水稻品种O. glaberrima是在大约3000年以前由祖先野生稻O. barthii独立驯化而来的，这较亚洲水稻O. sativa驯化晚6000-7000年。非洲水稻驯化摇篮地在内尼日尔三角洲
+ 非洲当地水稻一两百公斤一亩。亚洲杂交水稻八百公斤一亩
+ 非洲当地的非洲水稻产量低但是能防旱和防杂草，亚洲水稻虽然高产需要大量灌溉用水，亦不能防杂草。西非水稻发展协会研制出的一个水稻杂交新种，由亚洲稻和非洲稻两个不同品种杂交而成，命名为NewRiceforAfrica(NERICA)。
+ 目前认为这两个栽培品种源于一系。在冈瓦纳古陆分裂和漂移之前，它们的祖先可能就生长在这片大陆上。

+ ![稻的演化](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/Gramineae/Recombination/pic/Oryza.png)

+ ![通过这种方法杂交亚洲水稻与非洲水稻可以得到可育的后代](https://github.com/eternal-bug/Sequencing-and-assembly/blob/master/plastid/Gramineae/Recombination/pic/fertile.png)

## 项目1信息
+ [PRJNA382477](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA382477)
+ [《Sequencing of bulks of segregants allows dissection of genetic control of amylose content in rice》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5785344/#pbi12752-bib-0009)
+ sampling 1 months old seedlings and sequencing
+ 研究不同水稻中的淀粉含量以及在染色体上的定位与相关的SNP
+ University of Queensland
+ 2017-04-11

## [Run信息](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA382477&go=go)
| Relationship | Type | No | Source | SRR | Size | Depth |
| --- | --- | --- | --- | --- | --- | --- |
| 轮回亲本(recurrent parent) | Low amylose parent (*O. sativa*) | CG14(OSP) | 科托努(Cotonou) | SRR5494009 | 1,715,132,292 * 2 | 32 |
| 非轮回亲本(nocurrent parent) | High amylose parent (*O. glaberrima*) | WAB 56-104(OGP) | 科托努(Cotonou) |  SRR54940010 | 1,526,266,324 * 2 | 28 |
| BC2F8 | Low amylose bulk(*O. sativa* x *O. glaberrima*) | LAB | 科托努(Cotonou) | SRR54940011 | 4,102,835,647 * 2 | 76 |
| BC2F8 | High amylose bulk(*O. sativa* x *O. glaberrima*) | HAB | 科托努(Cotonou) | SRR54940012 | 477,388,765 * 2 | 9 |

+ 非轮回亲本(nocurrent parent)：在回交过程中，只参加一次杂交的亲本称为供体亲本，供体亲本(donor parent)，**有利性状的提供者**。
+ 轮回亲本(recurrent parent)：在回交过程中，参加多次回交的亲本称为轮回亲本，也叫受体亲本(receptor parent)，**有利性状的接受者**。一般在第一次杂交时选具有优良特性的品种作母本，而在以后各次回交时作父本

```text
R : recurrent parent
N : nocurrent parent

BCF:BackCrossingFilialness

P   R(♀) x N(♂)
         |
         v
F      F1(♀) x R(♂)
             |
             v
F         BC1F1(♀) x R(♂)
           ⓧ|     |
             v     v
F          BC1F2 BC2F1
                   |ⓧ
                   v
F                BC2F2
                   |ⓧ
                   v
F                .....
``` 

> 典型的回交育种方法是将缺少某一二个有利性状的优良品种重复用作亲本，称轮回亲本。又因是有利性状的接受者，也称受体。轮回亲本应是综合性状较好，预计有发展前途的品种。用另一具有某一二个受体所缺少的有利性状的品种作亲本，只在开始回交时用1次，称非轮回亲本。因是有利性状的提供者，故称供体。所提供的有利性状最好是显性单基因控制的。回交过程中，从回交一代开始，每代都从杂种中选择具有供体的有利性状的个体与轮回亲本杂交。如此继续进行多次，直到最后得到所有性状与受体相似，但增加了从供体转来的有利性状的后代时为止。然后再进行1～2次自交，选出被转移性状为纯合的个体，进而育成新品种。在理论上每回交1次，杂种后代所含轮回亲本的遗传成分将递增一半。一般经5～6次回交，其后代的主要性状已接近轮回亲本。但如轮回亲本的主要性状涉及的基因数较多，则回交次数要适当增多。

> 回交育种法主要应用于：
> + ①常规育种中有利性状的转育。
> + ②选育近等基因系。即除了一个性状的基因型不同外，其他所有基因型都相同的一类品系。利用近等基因系可在同一遗传背景下比较某些基因的作用，并可把抵抗不同病菌生理小种的近等基因系混合成多系品种，以控制某些病害的流行。
> + ③单体、缺体、三体的转育。
> + ④细胞质雄性不育系及核不育系的转育。
> + ⑤克服远缘杂种不育性。

## 项目2信息
+ PRJDB6967
+ [《Comparative whole genome re-sequencing analysis in upland New Rice for Africa: insights into the breeding history and respective genome compositions》](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5953909/)

## Run信息
| Relationship | Type | No | Source | SRR | Size | Depth |
| --- | --- | --- | --- | --- | --- | --- |
| 轮回亲本(recurrent parent) | WAB56–104 |
| 非轮回亲本(nocurrent parent) | CG14 |
| NERICA | Oryza glaberrima x Oryza sativa | NERICA 3 |
| NERICA | Oryza glaberrima x Oryza sativa | NERICA 4 |
| NERICA | Oryza glaberrima x Oryza sativa | NERICA 5 |
| NERICA | Oryza glaberrima x Oryza sativa | NERICA 7 |

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
+ [《Interspecific Oryza Sativa L. X O. Glaberrima Steud. progenies in upland rice improvement》](https://link.springer.com/article/10.1023/A%3A1002969932224)
+ [《Oryza glaberrima: A source for the improvement of Oryza sativa》](https://www.researchgate.net/publication/228623310_Oryza_glaberrima_A_source_for_the_improvement_of_Oryza_sativa)
+ [《The origin, evolution, cultivation, dissemination, and diversification of Asian and African rices》](https://link.springer.com/article/10.1007/BF00041576)
+ [《African rice (Oryza glaberrima): History and future potential》](https://www.pnas.org/content/99/25/16360)
+ [《Oryza glaberrima: A source for the improvement of Oryza sativa》](https://www.researchgate.net/publication/228623310_Oryza_glaberrima_A_source_for_the_improvement_of_Oryza_sativa)
+ [《The Rise and Fall of African Rice Cultivation Revealed by Analysis of 246 New Genomes》](https://www.cell.com/current-biology/fulltext/S0960-9822(18)30702-4)
+ [《The genome sequence of African rice (Oryza glaberrima) and evidence for independent domestication》](https://www.nature.com/articles/ng.3044)
+ [非洲新稻](https://baike.baidu.com/item/非洲新稻/15702350)
+ [水稻的演化——亚洲稻(Oryza sativa)和非洲稻(Oryza glaberrima)](http://www.cnki.com.cn/Article/CJFDTotal-JXND1983S1006.htm)
+ [冈瓦纳古陆](https://baike.baidu.com/item/冈瓦纳古陆/3722456?fr=aladdin&fromid=11180351&fromtitle=Gondwanaland)
+ [回交育种](https://wenku.baidu.com/view/41b8e627a36925c52cc58bd63186bceb19e8ed30.html)
+ [第五章杂交育种2015](https://wenku.baidu.com/view/96c40bbd77232f60dccca19f.html)
