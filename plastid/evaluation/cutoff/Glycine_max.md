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
### build index
```bash
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa
```

### align
```bash
for i in 0 0.25 0.5 1 2 4 8 16 32;
do
  BASE_NAME=${SRR}_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  if [ -d ./align ];
  then
    echo -n
  else
    mkdir ./align
  fi
  bsub -q mpi -n 24 -J "${BASE_NAME}" '
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.new.fa \
         ./2_illumina/trim/Q25L60/R1.fq.gz \
         ./2_illumina/trim/Q25L60/R2.fq.gz > ./align/Rp.sam
     ~/stq/Applications/biosoft/bwa-0.7.13/bwa mem \
         -t 20 \
         -M   \
         ../genome/genome.new.fa \
         ./2_illumina/trim/Q25L60/Rs.fq.gz > ./align/Rs.sam
         
     cp ./align/Rp.sam ./align/R.sam
     cat ./align/Rs.sam | grep -v "^@" >> ./align/R.sam
     samtools view -b -o ./align/R.bam ./align/R.sam
     samtools sort -o ./align/R.sort.bam ./align/R.bam
     samtools index ./align/R.sort.bam
  '
  cd ${WORKING_DIR}
done
```

### calculate coverage and depth
```bash
list=(0 0.25 0.5 1 2 4 8 16 32)
WORKING_DIR=${HOME}/stq/data/anchr/Glycine_max
for i in ${list[@]};
do
  BASE_NAME=SRR1533313_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  cd ./align
  export BAMFILE=R.sort.bam
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
      print "Title | Coverage_length | Coverage_percent | Depth";
      print "--- | ---: | ---: | ---: |";
      for my $title (sort {$a cmp $b} keys %info){
        printf "%s | %d | %.2f | %d\n",
                $title,
                    $info{$title}{site},
                          $info{$title}{site}/$info{$title}{length},
                              $info{$title}{depth}/$info{$title}{site};
      }
    }
  ' > ./stat.md
done
```

### combine infomations
```bash
list=(0 0.25 0.5 1 2 4 8 16 32)
genome_list=(chr{1..20} mt pt)
mark_list=("| fold |" "| --- |" "| |")
WORKING_DIR=${HOME}/stq/data/anchr/Glycine_max
cd ${WORKING_DIR}
rm total.md

# generate the totle
n=0
for mark in "${mark_list[@]}";
do
  ((n++))
  echo -n ${mark} >> total.md
  for i in ${genome_list[@]};
  do
    if [ ${n} -eq 1 ];
    then
      echo -n " | ${i} | |" >> total.md
    elif [ ${n} -eq 2 ];
    then
      echo -n " ---: | ---: | ---: | " >> total.md
    else
      echo -n " CL | CP | DP |" >> total.md
    fi
  done
  echo >> total.md
done

# put number in cell
for i in ${list[@]};
do
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  echo -n "| ${i} | "
  cat ./align/temp.sort.md | tail -n+3 | perl -p -e 's/^\w+\s*\|//' |  perl -p -e "s/\n/ | /"
  echo
  cd ${WORKING_DIR}
done >>total.md

# calculate
export sequence_data=5726814332
cat total.md \
| tail -n+4 \
| sed "s/\s//g" \
| perl -p -e 's/^\|//;s/\|$//' \
| perl -nl -a -F"\|" -e '
  BEGIN{
    use vars qw/@order/;
    $\ = "";
    $" = " ";
    @order = qw/chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 mt pt /;
  }
  {
    %info = ();
  }
  my $fold = shift(@F);
  for my $group_v (1..scalar(@F)/3){
    my $name = $order[$group_v - 1];
    my $prefix = ($name =~ s/\d+//r);
    my @list = map {$group_v * 3 - $_} (3,2,1);
    my @group = @F[@list];
    my $len = $group[0];
    my $depth = $group[2];
    $info{$prefix} += $len * $depth;
  }
  my $total = 0;
  my @list = ();
  for my $name (sort {uc($a) cmp uc($b)} keys %info){
    push @list,$info{$name};
    $total += $info{$name};
  }
  print " $fold ";
  print " @list ";
  print " $total ";
  my @ratio = map { sprintf("%.2f",$_ / $total * 100)} @list;
  {
    local $" = "/";
    print " @ratio ";
  }
  printf "%.2f%% ",$total/$ENV{sequence_data} * 100;
  print "\n";
' \
| perl -pe 's/ +/|/g'
```


### 0
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|55454174|0.98|21
chr2|47475352|0.98|21
chr3|43376964|0.95|21
chr4|51316991|0.98|21
chr5|41017272|0.97|21
chr6|48798982|0.95|21
chr7|43387325|0.97|21
chr8|46932060|0.98|21
chr9|48834445|0.97|21
chr10|49986605|0.97|21
chr11|34014714|0.98|21
chr12|38888111|0.97|22
chr13|44462154|0.97|21
chr14|47308969|0.96|21
chr15|48790599|0.94|21
chr16|36001023|0.95|21
chr17|40463693|0.97|21
chr18|54864220|0.95|21
chr19|48504946|0.96|20
chr20|46723047|0.98|21
Pt|152218|1.00|6720
Mt|389424|0.97|733

### 0.25
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|55413703|0.98|23
chr2|47415550|0.98|24
chr3|43343186|0.95|23
chr4|51268641|0.98|23
chr5|40978778|0.97|23
chr6|48755715|0.95|23
chr7|43336531|0.97|23
chr8|46871868|0.98|23
chr9|48788731|0.97|23
chr10|49943844|0.97|23
chr11|33966812|0.98|23
chr12|38849767|0.97|24
chr13|44402879|0.97|24
chr14|47278312|0.96|23
chr15|48772740|0.94|23
chr16|35974910|0.95|23
chr17|40434035|0.97|23
chr18|54826960|0.94|23
chr19|48483398|0.96|22
chr20|46668324|0.97|23
Pt|152218|1.00|7159
Mt|389324|0.97|809

### 0.5
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|54629629|0.96|23
chr2|46577169|0.96|23
chr3|42609628|0.93|23
chr4|50507969|0.96|23
chr5|40298973|0.95|23
chr6|47898037|0.93|23
chr7|42608409|0.95|23
chr8|46001730|0.96|23
chr9|48023393|0.96|23
chr10|49122443|0.95|22
chr11|33286706|0.96|23
chr12|38171035|0.95|24
chr13|43470640|0.95|24
chr14|46570254|0.95|23
chr15|47968331|0.93|23
chr16|35387368|0.93|23
chr17|39710510|0.95|23
chr18|53962823|0.93|22
chr19|47735700|0.94|22
chr20|45956932|0.96|23
Pt|152218|1.00|7159
Mt|389213|0.97|809

### 1
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|35406793|0.62|18
chr2|26257403|0.54|19
chr3|25947373|0.57|18
chr4|32405646|0.62|19
chr5|24540630|0.58|18
chr6|28202342|0.55|18
chr7|25197343|0.56|18
chr8|25026679|0.52|18
chr9|29601786|0.59|18
chr10|30471533|0.59|18
chr11|18893188|0.54|17
chr12|22902463|0.57|20
chr13|22136407|0.48|19
chr14|30009956|0.61|18
chr15|29204420|0.56|18
chr16|21233264|0.56|18
chr17|22885023|0.55|18
chr18|33814460|0.58|18
chr19|29633920|0.58|17
chr20|29544181|0.62|19
Pt|152218|1.00|7159
Mt|389224|0.97|809

### 2
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|26539824|0.47|19
chr2|17613327|0.36|21
chr3|18372956|0.40|19
chr4|23999959|0.46|20
chr5|17215707|0.41|20
chr6|19187765|0.37|20
chr7|17106702|0.38|20
chr8|15411076|0.32|21
chr9|20728774|0.41|20
chr10|21433846|0.42|19
chr11|11756232|0.34|19
chr12|15731061|0.39|23
chr13|12529308|0.27|22
chr14|22314266|0.46|19
chr15|20874845|0.40|19
chr16|14897881|0.39|20
chr17|15244058|0.37|19
chr18|24701326|0.43|19
chr19|21653683|0.43|18
chr20|21612587|0.45|20
Pt|152218|1.00|7159
Mt|389199|0.97|809

### 4
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|23430827|0.41|19
chr2|15412326|0.32|21
chr3|15788089|0.34|19
chr4|21392818|0.41|20
chr5|15256503|0.36|20
chr6|16521694|0.32|20
chr7|14884564|0.33|19
chr8|13325740|0.28|21
chr9|18221495|0.36|20
chr10|18499747|0.36|19
chr11|10097243|0.29|19
chr12|13710668|0.34|23
chr13|10459625|0.23|23
chr14|19658070|0.40|19
chr15|18178432|0.35|19
chr16|12658340|0.33|20
chr17|13125892|0.32|19
chr18|21314950|0.37|19
chr19|19145305|0.38|17
chr20|18983042|0.40|20
Pt|152218|1.00|7159
Mt|389123|0.97|809

### 8 
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|21224572|0.37|19
chr2|13855498|0.29|21
chr3|13929039|0.30|19
chr4|19466100|0.37|20
chr5|13780105|0.33|20
chr6|14766548|0.29|19
chr7|13382377|0.30|19
chr8|11991866|0.25|21
chr9|16221488|0.32|19
chr10|16321987|0.32|18
chr11|9034359|0.26|19
chr12|12378837|0.31|23
chr13|9233151|0.20|24
chr14|17784304|0.36|19
chr15|16222094|0.31|19
chr16|11228089|0.30|19
chr17|11688044|0.28|19
chr18|18884792|0.33|18
chr19|17220164|0.34|17
chr20|17252117|0.36|20
Pt|152218|1.00|7159
Mt|389103|0.97|809


### 16
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|19055977|0.34|18
chr2|12162011|0.25|20
chr3|12300678|0.27|18
chr4|17494857|0.33|19
chr5|12469461|0.30|19
chr6|13079980|0.25|19
chr7|12077553|0.27|19
chr8|10790015|0.23|20
chr9|14320743|0.29|19
chr10|14111302|0.27|17
chr11|8079076|0.23|18
chr12|11172580|0.28|23
chr13|8250725|0.18|24
chr14|15992522|0.33|18
chr15|14363345|0.28|18
chr16|10020289|0.26|18
chr17|10516071|0.25|19
chr18|16787766|0.29|17
chr19|15404516|0.30|16
chr20|15614060|0.33|19
Pt|152218|1.00|7158
Mt|389190|0.97|808


### 32
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|16755657|0.29|18
chr2|10499505|0.22|20
chr3|10699494|0.23|18
chr4|15429445|0.29|19
chr5|10977623|0.26|19
chr6|11561168|0.22|18
chr7|10648071|0.24|18
chr8|9499306|0.20|20
chr9|12452250|0.25|19
chr10|12115002|0.23|17
chr11|7065740|0.20|18
chr12|9818526|0.24|23
chr13|7202245|0.16|24
chr14|13968816|0.28|17
chr15|12525423|0.24|16
chr16|8717712|0.23|18
chr17|9182582|0.22|18
chr18|14233482|0.25|16
chr19|13517223|0.27|15
chr20|13825645|0.29|19
Pt|152218|1.00|7159
Mt|128505|0.32|558

