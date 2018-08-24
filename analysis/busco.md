# 下载BUSCO以及数据库文件

# 服务器
```bash
# 下载BUSCO
cd ~/Applications/download
wget -c https://gitlab.com/ezlab/busco/-/archive/master/busco-master.zip -O busco.zip
# 上传到超算
rsync -avP ./busco.zip wangq@202.119.37.251:stq/Applications

# 下载数据库文件
cd ~/download
wget -c https://busco.ezlab.org/datasets/embryophyta_odb9.tar.gz
# 上传到超算
rsync -avP ./embryophyta_odb9.tar.gz wangq@202.119.37.251:stq/database/BUSCO
```
# 下载依赖的工具
+ Augustus (> 3.2.1)
+ HMMER (HMMER v3.1b2)
+ NCBI BLAST+
```bash
cd ~/Applications/download
# 下载Augustus
wget -c https://codeload.github.com/Gaius-Augustus/Augustus/zip/master -O Augustus.zip
rsync -avP ./Augustus.zip wangq@202.119.37.251:stq/Applications

# 下载HMMER
wget -c http://eddylab.org/software/hmmer/hmmer.tar.gz -O hmmer.tar.gz
rsync -avP ./hmmer.tar.gz wangq@202.119.37.251:stq/Applications

# 下载Blast+
wget -c ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz
rsync -avP ./ncbi-blast-2.7.1+-x64-linux.tar.gz wangq@202.119.37.251:stq/Applications
```

# 超算
## 安装工具
```bash
cd ~/stq/Applications
# 安装busco
unzip busco.zip
mv busco-master busco
mv busco ../
cd ../busco
python setup.py install

# 安装Augustus
unzip Augustus.zip

# 安装HMMER
tar -xzvf hmmer.tar.gz
./configure
make

# 安装blast+
tar -xzvf ncbi-blast-2.7.1+-x64-linux.tar.gz
rm ncbi-blast-2.7.1+-x64-linux.tar.gz
mv ncbi-blast-2.7.1+ blast+-2.7.1-linux
```

# 导入临时环境变量

# 运行BUSCO
```
cd ~/stq/data/anchr/Ampelopsis_grossedentata/Agr_PE400_R
# 查看帮助文件
python ~/stq/Applications/busco/scripts/run_BUSCO.py -h

# 新建文件夹
mkdir 9_busco
~/stq/Applications/busco/scripts/run_BUSCO.py \
        -i ./7_mergeAnchors/anchor.merge.fasta \
        -l ~/stq/database/busco/euarchontoglires_odb9 \
        -o 9_busco \
        -m geno \
        --cpu 8
```
