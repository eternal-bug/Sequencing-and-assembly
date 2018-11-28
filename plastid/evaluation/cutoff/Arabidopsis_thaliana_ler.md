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

```
