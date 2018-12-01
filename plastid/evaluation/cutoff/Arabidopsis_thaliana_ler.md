# Arabidopsis thaliana - ler 倍数因子测试
+ 因子值 0、0.25、0.5、1、2、4、8、16、32
+ 测试文件SRR616965（覆盖度 2,543,625,500 * 2 ／ 120,000,000 ）= 42

## 总结

| fold |chr1 |      |      | chr2 |      |      | chr3 |      |      | chr4 |      |      | chr5 |      |   | pt   |    |   | mt |   |   |
| ---- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
|      | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   |
| 0 | 29093138|0.99|21 | 18842554|0.99|20 | 22408909|0.99|20 | 17782699|0.99|19 | 26105942|0.99|19 | 345325|1.00|537 | 154515|1.00|6758 |
| 0.25 | 29076594|0.99|20 | 18830129|0.99|20 | 22396043|0.99|20 | 17772701|0.99|19 | 26094458|0.99|19 | 345325|1.00|537 | 154515|1.00|6757 |
| 0.5 | 12083319|0.41|15 | 7996716|0.42|14 | 9847698|0.44|14 | 7643959|0.43|12 | 10914367|0.41|12 | 345325|1.00|537 | 154515|1.00|6758 |
| 1 | 1850571|0.06|36 | 1634485|0.09|28 | 1766771|0.08|28 | 1562149|0.09|18 | 1853525|0.07|18 | 345325|1.00|537 | 154515|1.00|6759 |
| 2 | 1072014|0.04|52 | 1018536|0.05|37 | 1004656|0.04|40 | 857811|0.05|21 | 1142432|0.04|20 | 345325|1.00|537 | 154515|1.00|6759 |
| 4 | 651357|0.02|76 | 597867|0.03|53 | 609600|0.03|55 | 500539|0.03|26 | 688100|0.03|22 | 345325|1.00|537 | 154515|1.00|6759 |
| 8 | 353026|0.01|129 | 326602|0.02|86 | 338228|0.01|85 | 267645|0.01|35 | 376869|0.01|28 | 342269|0.99|515 | 154515|1.00|6758 |
| 16 | 180394|0.01|237 | 157766|0.01|160 | 175342|0.01|146 | 136204|0.01|46 | 199940|0.01|34 | 59404|0.17|234 | 154515|1.00|6760 |
| 32 | 87435|0.00|467 | 64491|0.00|367 | 85316|0.00|283 | 54604|0.00|76 | 87382|0.00|44 | 12814|0.04|157 | 154515|1.00|6759 |

| fold | nc | mt | pt | total | nc:mt:pt | percent |
| --- | --- | --- | --- | --- | --- | --- |
|0|2269869337|185439525|1044212370|3499521232|64.86/5.30/29.84|68.79%|
|0.25|2239531341|185439525|1044057855|3469028721|64.56/5.35/30.10|68.19%|
|0.5|653771493|185439525|1044212370|1883423388|34.71/9.85/55.44|37.02%|
|1|223337856|185439525|1044366885|1453144266|15.37/12.76/71.87|28.56%|
|2|174479471|185439525|1044366885|1404285881|12.42/13.21/74.37|27.60%|
|4|142870297|185439525|1044366885|1372676707|10.41/13.51/76.08|26.98%|
|8|122297413|176268535|1044212370|1342778318|9.11/13.13/77.77|26.39%|
|16|106659214|13900536|1044521400|1165081150|9.15/1.19/89.65|22.90%|
|32|96639482|2011798|1044366885|1143018165|8.45/0.18/91.37|22.47%|


## 流程

### 下载参考序列
```bash
# 下载基因组序列
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/001/651/475/GCA_001651475.1_Ler_Assembly/GCA_001651475.1_Ler_Assembly_genomic.fna.gz
gzip -d GCA_001651475.1_Ler_Assembly_genomic.fna.gz
mv GCA_001651475.1_Ler_Assembly_genomic.fna genome.fa
cat genome.fa | grep "^>"
```
```
>CM004359.1 Arabidopsis thaliana ecotype Landsberg erecta chromosome 1, whole genome shotgun sequence
>CM004360.1 Arabidopsis thaliana ecotype Landsberg erecta chromosome 2, whole genome shotgun sequence
>CM004361.1 Arabidopsis thaliana ecotype Landsberg erecta chromosome 3, whole genome shotgun sequence
>CM004362.1 Arabidopsis thaliana ecotype Landsberg erecta chromosome 4, whole genome shotgun sequence
>CM004363.1 Arabidopsis thaliana ecotype Landsberg erecta chromosome 5, whole genome shotgun sequence
>LUHQ01000006.1 Arabidopsis thaliana scaffold15_Contig142, whole genome shotgun sequence
>LUHQ01000007.1 Arabidopsis thaliana scaffold15_Contig624, whole genome shotgun sequence
>LUHQ01000008.1 Arabidopsis thaliana scaffold18_size294915, whole genome shotgun sequence
>LUHQ01000009.1 Arabidopsis thaliana scaffold24_size307384, whole genome shotgun sequence
>LUHQ01000010.1 Arabidopsis thaliana scaffold26_size238942, whole genome shotgun sequence
>LUHQ01000011.1 Arabidopsis thaliana scaffold27_size282142, whole genome shotgun sequence
>LUHQ01000012.1 Arabidopsis thaliana scaffold29_size187832, whole genome shotgun sequence
>LUHQ01000013.1 Arabidopsis thaliana scaffold32_size196412, whole genome shotgun sequence
>LUHQ01000014.1 Arabidopsis thaliana scaffold35_size131485, whole genome shotgun sequence
>LUHQ01000016.1 Arabidopsis thaliana scaffold37_size112703, whole genome shotgun sequence
>LUHQ01000017.1 Arabidopsis thaliana scaffold38_size104578, whole genome shotgun sequence
>LUHQ01000018.1 Arabidopsis thaliana scaffold39_size130710, whole genome shotgun sequence
>LUHQ01000020.1 Arabidopsis thaliana scaffold41_size78703, whole genome shotgun sequence
>LUHQ01000022.1 Arabidopsis thaliana scaffold44_size66369, whole genome shotgun sequence
>LUHQ01000023.1 Arabidopsis thaliana scaffold46_size62883, whole genome shotgun sequence
>LUHQ01000024.1 Arabidopsis thaliana scaffold48_size56796, whole genome shotgun sequence
>LUHQ01000025.1 Arabidopsis thaliana scaffold49_size55398, whole genome shotgun sequence
>LUHQ01000026.1 Arabidopsis thaliana scaffold50_size53549, whole genome shotgun sequence
>LUHQ01000027.1 Arabidopsis thaliana scaffold52_size52344, whole genome shotgun sequence
>LUHQ01000028.1 Arabidopsis thaliana scaffold55_size51175, whole genome shotgun sequence
>LUHQ01000029.1 Arabidopsis thaliana scaffold68_size61837, whole genome shotgun sequence
>LUHQ01000030.1 Arabidopsis thaliana scaffold81_size50669, whole genome shotgun sequence
>LUHQ01000019.1 Arabidopsis thaliana scaffold40_size268640 mitochondrial, whole genome shotgun sequence
>LUHQ01000021.1 Arabidopsis thaliana scaffold43_size213235 mitochondrial, whole genome shotgun sequence
>LUHQ01000015.1 Arabidopsis thaliana scaffold36_size139747 chloroplast, whole genome shotgun sequence
```
改名
```bash
mkdir temp
for i in {1..5};
do
  export num=${i}
  list=(chr1 chr2 chr3 chr4 chr5)
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
```
下载ler对应的细胞器DNA序列
+ 线粒体  JF729202.1
+ 叶绿体  KX551970.1

合并
```bash
for i in $(ls ./temp/*.fa);
do
  cat ${i}
  echo
done > ./genome.new.fa
```


后续步骤与Arabidopsis thaliana - col-0相似

```bash
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/ler
cd ${WORKING_DIR}
bash create_sequence_file_link.sh
list=(0 0.25 0.5 1 2 4 8 16 32)
for i in ${list[@]};
do
  cp -r SRR616965 SRR616965_${i}
done

# 0
BASE_NAME=SRR616965_0
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

for i in ${list[@]};
do
  if [ ${i} -eq 0 ];
  then
    echo
  else
    BASE_NAME=SRR616965_${i}
    cd ${WORKING_DIR}/${BASE_NAME}
    cutoff=$(echo "${i} * 42" | bc | perl -p -e 's/\..+//')
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
  fi
done

cd ${WORKING_DIR}
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa

for i in ${list[@]};
do
  WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/ler
  BASE_NAME=SRR616965_${i}
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
done
```


```bash
for i in 0 0.25 0.5 1 2 4 8 16 32;
do
  WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/ler
  BASE_NAME=SRR616965_${i}
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
      for my $title (sort {uc($a) cmp uc($b)} keys %info){
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

```
list=(0 0.25 0.5 1 2 4 8 16 32)
WORKING_DIR=${HOME}/stq/data/anchr/Arabidopsis_thaliana/ler
cd ${WORKING_DIR}
rm total.md
echo "| fold |chr1 |      |      | chr2 |      |      | chr3 |      |      | chr4 |      |      | chr5 |      |   | pt   |    |   | mt |   |   | " >>total.md
echo "| ---- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |" >>total.md
echo "|      | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   | CL   | CP   | DP   |">>total.md
for i in ${list[@]};
do
  BASE_NAME=SRR616965_${i}
  cd ${WORKING_DIR}/${BASE_NAME}
  echo -n "| ${i} | "
  cat ./align/temp.sort.md | tail -n+3 | perl -p -e 's/^\w+\s*\|//' |  perl -p -e "s/\n/ | /"
  echo
  cd ${WORKING_DIR}
done >>total.md


export sequence_data=5087251000
cat total.md \
| tail -n+4 \
| sed "s/\s//g" \
| perl -p -e 's/^\|//;s/\|$//' \
| perl -nl -a -F"\|" -e '
  BEGIN{
    use vars qw/@order/;
    $\ = "";
    $" = " ";
    @order = qw/chr1 chr2 chr3 chr4 chr5 mt pt /;
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
