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
wget -c http://bioinf.uni-greifswald.de/augustus/binaries/augustus.current.tar.gz
rsync -avP ./augustus.current.tar.gz wangq@202.119.37.251:stq/Applications

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
tar -xzvf augustus.current.tar.gz
cd augustus-3.3.1
# 打开common.mk文件，将ZIPINPUT = true注释掉（即在最前面加一#号）
vim common.mk
make

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
```bash
export PATH="~/stq/Applications/augustus-3.3.1/bin:$PATH"
# 需要使用绝对路径
export AUGUSTUS_CONFIG_PATH="/share/home/wangq/stq/Applications/augustus-3.3.1/config"
export PATH="~/stq/Applications/hmmer-3.2.1/src:$PATH"
export PATH="~/stq/Applications/blast+-2.7.1-linux/bin:$PATH"
```

# 修改config.ini
```bash
vim ~/stq/Applications/busco/config
```

```ini
# BUSCO specific configuration
# It overrides default values in code and dataset cfg, and is overridden by arguments in command line
# Uncomment lines when appropriate
[busco]
# Input file
;in = ./sample_data/target.fa
# Run name, used in output files and folder
;out = SAMPLE
# Where to store the output directory
# out_path = /workdir
# Path to the BUSCO dataset
;lineage_path = ./sample_data/example
# Which mode to run (genome / protein / transcriptome)
;mode = genome
# How many threads to use for multithreaded steps
;cpu = 1
# Domain for augustus retraining, eukaryota or prokaryota
# Do not change this unless you know exactly why !!!
;domain = eukaryota
# Force rewrite if files already exist (True/False)
;force = False
# Restart mode (True/False)
;restart = False
# Blast e-value
;evalue = 1e-3
# Species to use with augustus, for old datasets only
;species = fly
# Augustus extra parameters
# Use single quotes, like this: '--param1=1 --param2=2'
;augustus_parameters = ''
# Tmp folder
;tmp_path = ./tmp/
# How many candidate regions (contigs, scaffolds) to consider for each BUSCO
;limit = 3
# Augustus long mode for retraining (True/False)
;long = False
# Quiet mode (True/False)
;quiet = False
# Debug logs (True/False), it needs Quiet to be False
debug = True
# tar gzip output files (True/False)
;gzip = False
# Force single core for the tblastn step
;blast_single_core = True

[tblastn]
# path to tblastn
path = ~/stq/Applications/blast+-2.7.1-linux/bin

[makeblastdb]
# path to makeblastdb
path = ~/stq/Applications/blast+-2.7.1-linux/bin

[augustus]
# path to augustus
path = ~/stq/Applications/augustus-3.3.1/bin

[etraining]
# path to augustus etraining
path = ~/stq/Applications/augustus-3.3.1/bin

# path to augustus perl scripts, redeclare it for each new script
[gff2gbSmallDNA.pl]
path = ~/stq/Applications/augustus-3.3.1/scripts
[new_species.pl]
path = ~/stq/Applications/augustus-3.3.1/scripts
[optimize_augustus.pl]
```

# 运行BUSCO
```
cd ~/stq/data/anchr/Ampelopsis_grossedentata/Agr_PE400_R
# 查看帮助文件
python ~/stq/Applications/busco/scripts/run_BUSCO.py -h

# 新建文件夹
# '7_mergeKunitigsAnchors/anchor.merge.fasta' '7_mergeTadpoleAnchors/anchor.merge.fasta' '7_mergeMRKunitigsAnchors/anchor.merge.fasta' '7_mergeMRTadpoleAnchors/anchor.merge.fasta' '7_mergeMRMegahitAnchors/anchor.merge.fasta' '7_mergeMRSpadesAnchors/anchor.merge.fasta' '7_mergeAnchors/anchor.merge.fasta' '7_anchorLong/contig.fasta' '7_anchorFill/contig.fasta' '8_spades/spades.non-contained.fasta' '8_spades_MR/spades.non-contained.fasta' '8_megahit/megahit.non-contained.fasta' '8_megahit_MR/megahit.non-contained.fasta' '8_platanus/platanus.non-contained.fasta'

ROOTTMP=$(pwd)

GREEN=
RED=
NC=
if tty -s < /dev/fd/1 2> /dev/null; then
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color
fi

log_warn () {
    echo >&2 -e "${RED}==> $@ <==${NC}"
}

log_info () {
    echo >&2 -e "${GREEN}==> $@${NC}"
}

log_debug () {
    echo >&2 -e "==> $@"
}

for path in '7_mergeKunitigsAnchors/anchor.merge.fasta' '7_mergeTadpoleAnchors/anchor.merge.fasta' '7_mergeMRKunitigsAnchors/anchor.merge.fasta' '7_mergeMRTadpoleAnchors/anchor.merge.fasta' '7_mergeMRMegahitAnchors/anchor.merge.fasta' '7_mergeMRSpadesAnchors/anchor.merge.fasta' '7_mergeAnchors/anchor.merge.fasta' '7_anchorLong/contig.fasta' '7_anchorFill/contig.fasta' '8_spades/spades.non-contained.fasta' '8_spades_MR/spades.non-contained.fasta' '8_megahit/megahit.non-contained.fasta' '8_megahit_MR/megahit.non-contained.fasta' '8_platanus/platanus.non-contained.fasta';
do
  cd $ROOTTMP
  if [ -e $path ];
  then
    log_info $path
    BASH_DIR=$( cd "$( dirname "$path" )" && pwd )
    cd ${BASH_DIR}
    
    # 新建文件夹
    if [ -e busco ];
    then
      1
    else
      mkdir busco
    fi
    cd busco
    
    # 去除特殊字符
    if [ -e tmp.fasta ];
    then
      1
    else
      cat ../$(basename $path) | sed "s/\///g" > tmp.fasta
    fi
    
    cd busco
    
    # 这里的-o选项似乎不起效，这个工具的输出路径就是当前目录
    ~/stq/Applications/busco/scripts/run_BUSCO.py \
        -i tmp.fasta \
        -l ~/stq/database/BUSCO/embryophyta_odb9 \
        -o . \
        -m genome \
        --cpu 8
  fi
  cd $ROOTTMP
done
```

## 参考
+ [App-Anchr](https://github.com/eternal-bug/App-Anchr)
+ [基因课-使用BUSCO评价转录本拼接的质量](http://www.genek.tv/article/29)
+ [「干货集市」使用BUSCO评估基因组组装完整性](http://www.sohu.com/a/209241945_464200)
+ [Augustus安装](http://blog.sina.com.cn/s/blog_14552795a0102x57t.html)
+ [hmmer的安装与使用](http://boyun.sh.cn/bio/?p=1753)
+ [Blast+安装和简单使用](http://blog.sciencenet.cn/home.php?mod=space&uid=2506040&do=blog&quickforward=1&id=1088509)
