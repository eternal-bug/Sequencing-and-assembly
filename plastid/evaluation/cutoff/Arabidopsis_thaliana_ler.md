# Arabidopsis thaliana - ler 倍数因子测试
+ 因子值 0、0.25、0.5、1、2、4、8、16、32
+ 测试文件SRR616965（覆盖度 2,543,625,500 * 2 ／ 120,000,000 ）= 42

## 总结


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
```
for i in $(ls ./temp/*.fa);
do
  cat ${i}
  echo
done > ./genome.new.fa
```


后续步骤与Arabidopsis thaliana - col-0相似

```
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

cd cd ${WORKING_DIR}
~/stq/Applications/biosoft/bwa-0.7.13/bwa index ./genome/genome.new.fa

for i in ${list[@]};
do
WORKING_DIR=${HOME}/stq/data/anchr/Medicago_truncatula/A17
  BASE_NAME=SRR965418_${i}
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
    # 
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
  '
done
```
