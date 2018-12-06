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
WORKING_DIR=${HOME}/stq/data/anchr/Glycine_max
cd ${WORKING_DIR}
rm total.md

echo -n "| fold | " > total.md
for i in ${genome_list[@]};
do
  echo -n " | ${i} | |" >> total.md
done
echo >> total.md
echo -n "| --- |" >> total.md
for i in ${genome_list[@]};
do
  echo -n " ---: | ---: | ---: | " >> total.md
done
echo >> total.md
echo -n "| | " >> total.md
for i in ${genome_list[@]};
do
  echo -n " CL | CP | DP |" >> total.md
done
echo >> total.md

for i in ${list[@]};
do
  BASE_NAME=SRR965418_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  echo -n "| ${i} | "
  cat ./align/temp.sort.md | tail -n+3 | perl -p -e 's/^\w+\s*\|//' |  perl -p -e "s/\n/ | /"
  echo
  cd ${WORKING_DIR}
done >>total.md


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
