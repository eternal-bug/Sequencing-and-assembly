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

### 0.5
Title | Coverage_length | Coverage_percent | Depth
--- | ---: | ---: | ---: |
chr1|19436559|0.34|3
chr2|16576391|0.34|3
chr3|14960323|0.33|3
chr4|18052224|0.34|3
chr5|14479985|0.34|3
chr6|16761316|0.33|3
chr7|15138020|0.34|3
chr8|16270264|0.34|3
chr9|16999417|0.34|3
chr10|17351275|0.34|3
chr11|11756184|0.34|3
chr12|13659487|0.34|3
chr13|15562204|0.34|3
chr14|16291043|0.33|3
chr15|16637125|0.32|3
chr16|12412577|0.33|3
chr17|13896183|0.33|3
chr18|18854728|0.32|3
chr19|16392401|0.32|3
chr20|16403292|0.34|3
Pt|151895|1.00|402
Mt|322224|0.80|49

### 1

### 2

### 4
 Title | Coverage_length | Coverage_percent | Depth
 --- | ---: | ---: | ---: |
chr1|23431024|0.41|19
chr2|15411746|0.32|21
chr3|15788475|0.34|19
chr4|21394263|0.41|20
chr5|15256051|0.36|20
chr6|16522145|0.32|20
chr7|14883833|0.33|19
chr8|13325980|0.28|21
chr9|18221924|0.36|20
chr10|18497932|0.36|19
chr11|10098011|0.29|19
chr12|13710421|0.34|23
chr13|10459367|0.23|23
chr14|19658399|0.40|19
chr15|18176535|0.35|19
chr16|12658685|0.33|20
chr17|13123411|0.32|19
chr18|21312721|0.37|19
chr19|19147049|0.38|17
chr20|18982538|0.40|20
Pt|75235|0.49|7061
Mt|389102|0.97|809


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
Mt|128505|0.32|558
Pt|152218|1.00|7159
