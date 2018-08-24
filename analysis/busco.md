# 下载BUSCO以及数据库文件

## 服务器
```bash
# 下载BUSCO
cd ~/Applications/download
wget -c https://gitlab.com/ezlab/busco/-/archive/master/busco-master.zip -O busco.zip
# 上传到超算
rsync -avP ./busco.zip wangq@202.119.37.251:stq/Applications

# 下载数据库文件
cd cd cd asd s dac as 23w
wget -c https://busco.ezlab.org/datasets/embryophyta_odb9.tar.gz
# 上传到超算
rsync -avP ./busco.zip wangq@202.119.37.251:stq/Applications
```
## 超算
```bash
unzip busco.zip
mv busco-master busco
mv busco ../
cd ../busco
```
