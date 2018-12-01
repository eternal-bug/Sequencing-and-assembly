# *Glycine max*[大豆]
+ 核基因组：20条染色体
+ 因子值 0.25、0.5、1、2、4、8、16、32、64
+ 测试文件 SRR1533313	（覆盖度 14,839,423,400 * 2 / 1000,000,000 ） = 30

## 前期准备
### 建立工作区
```bash
mkdir ~/stq/data/anchr/Glycine_max
cd ~/stq/data/anchr/Glycine_max
mkdir ./genome
mkdir ./sequence_data
```

### 下载参考序列
+ [Glycine_max_v2.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_000004515.5)
```bash
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/004/515/GCF_000004515.5_Glycine_max_v2.1/GCF_000004515.5_Glycine_max_v2.1_genomic.fna.gz
gzip -d GCF_000004515.5_Glycine_max_v2.1_genomic.fna.gz
mv GCF_000004515.5_Glycine_max_v2.1_genomic.fna genome.fa
cat genome.fa | grep "^>"
```
```
>NC_016088.3 Glycine max cultivar Williams 82 chromosome 1, Glycine_max_v2.1, whole genome shotgun sequence
>NC_016089.3 Glycine max cultivar Williams 82 chromosome 2, Glycine_max_v2.1, whole genome shotgun sequence
>NC_016090.3 Glycine max cultivar Williams 82 chromosome 3, Glycine_max_v2.1, whole genome shotgun sequence
>NC_016091.3 Glycine max cultivar Williams 82 chromosome 4, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038241.1 Glycine max cultivar Williams 82 chromosome 5, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038242.1 Glycine max cultivar Williams 82 chromosome 6, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038243.1 Glycine max cultivar Williams 82 chromosome 7, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038244.1 Glycine max cultivar Williams 82 chromosome 8, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038245.1 Glycine max cultivar Williams 82 chromosome 9, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038246.1 Glycine max cultivar Williams 82 chromosome 10, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038247.1 Glycine max cultivar Williams 82 chromosome 11, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038248.1 Glycine max cultivar Williams 82 chromosome 12, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038249.1 Glycine max cultivar Williams 82 chromosome 13, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038250.1 Glycine max cultivar Williams 82 chromosome 14, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038251.1 Glycine max cultivar Williams 82 chromosome 15, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038252.1 Glycine max cultivar Williams 82 chromosome 16, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038253.1 Glycine max cultivar Williams 82 chromosome 17, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038254.1 Glycine max cultivar Williams 82 chromosome 18, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038255.1 Glycine max cultivar Williams 82 chromosome 19, Glycine_max_v2.1, whole genome shotgun sequence
>NC_038256.1 Glycine max cultivar Williams 82 chromosome 20, Glycine_max_v2.1, whole genome shotgun sequence
.....
```
**说明**：省略号表示还有较多结果，这里没有展示，均为组装的scaffold。
> 改名
```bash
mkdir temp
for i in {1..20};
do
  export num=${i}
  list=(chr{1..20})
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

# 统计长度
cd temp
ls | sort -k1.4n | while read file;
do
  cat ${file} | perl -n -e '
    s/\r?\n//;
    # 得到序列的名称
    if(m/^>(.+?)\s*$/){
        $title = $1;
    }elsif(defined $title){
    # 将这条序列的长度进行累加，直到遇到>或者文件尾
        $title_len{$title} += length($_);
    }
    # 最后打印出信息来
    # 你也可以个性化的输出
    END{
        #
        # for my $title (sort {$title_len{$b} <=> $title_len{$a}} keys %title_len){
        for my $title (sort keys %title_len){
            print "$title","\t","$title_len{$title}","\n";
        }
    }
  '
done
```
| chr  | len      |
| --- | --- |
| chr1 | 56831624 | 
| chr2 | 48577505 |
| chr3 | 45779781 |
| chr4 | 52389146 |
| chr5 | 42234498 |
| chr6 | 51416486 |
| chr7 | 44630646 |
| chr8 | 47837940 |
| chr9 | 50189764 |
| chr10 | 51566898 |
| chr11 | 34766867 |
| chr12 | 40091314 |
| chr13 | 45874162 |
| chr14 | 49042192 |
| chr15 | 51756343 |
| chr16 | 37887014 |
| chr17 | 41641366 |
| chr18 | 58018742 |
| chr19 | 50746916 |
| chr20 | 47904181 |

合并基因组序列与细胞器基因组序列
```bash
for i in $(ls ./temp/*.fa);
do
  cat ${i}
  echo
done > genome.new.fa
```

## 批处理

### cutoff
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Glycine_max
cd ${WORKING_DIR}
SRR=SRR1533313
bash create_sequence_file_link.sh
for i in 0 0.25 0.5 1 2 4 8 16 32;
do
  cp -r ${SRR} ${SRR}_${i}
done

# ============= clean and cutoff ===============
# 0
WORKING_DIR=${HOME}/stq/data/anchr/Glycine_max
BASE_NAME=${SRR}_0
cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24
    
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 2_trim.sh
"

# 0.2 0.5 1 2 4 8 16 32
for i in 0.25 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Glycine_max
  BASE_NAME=${SRR}_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  cutoff=$(echo "${i} * 30" | bc | perl -p -e 's/\..+//')
# anchr
  anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --trim2 "--dedupe --cutoff ${cutoff} --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --xmx 110g \
    --parallel 24
    
    bsub -q mpi -n 24 -J "${BASE_NAME}" "
      bash 2_trim.sh
    "
done
```
