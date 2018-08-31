```bash
# 合并文件adapter、lowqual、clean
# BD280_L1_335335 BD308_L1_336336 BD310_L1_344344 BD312_L1_337337 G06_L1_338338 G211_L1_340340 G2853_L1_343343 G47_L1_339339 G543_L1_341341 G883_L1_342342

parallel -j 20 "
gzip -d -c ./clean/{2}.R{1}.clean.fastq.gz >./raw/{2}.R{1}.fastq
gzip -d -c ./abandon/{2}.R{1}.adapter.fastq.gz >>./raw/{2}.R{1}.fastq
gzip -d -c ./abandon/{2}.R{1}.lowqual.fastq.gz >>./raw/{2}.R{1}.fastq
" ::: 1 2 ::: $(ls ./clean/*.fastq.gz | perl -l -n -e 's#^./clean/([\w_]+).+$#$1#;$hash{$_}++;END{map {print $_} sort keys %hash}')

# 压缩文件
cd ./raw
parallel -j 5 "
gzip {1}
" ::: $(ls)

# fastqc
mkdir -p ./fastqc	
for file in $(ls ./*);
do
  if [ -f ${file} ];
  then
    /Users/ssd/Documents/Applications/FastQC/fastqc -o ./fastqc -f fastq ${file}
  fi
done

# multiqc
multiqc .
```
