# Assemble nuclear genome
+ *Ampelopsis_grossedentata*[蛇葡萄]
+ *Lithocarpus_polystachyus*[多穗石柯]



# *Ampelopsis_grossedentata*
+ 测序数据量 9.9G  R1.fq.gz  13G  R2.fq.gz
+ 测序方式 ： Illumina
+ 预测的基因组大小 ： 911749703
 
```bash
# 超算
cd ~/stq/data/anchr/
mkdir -p ./Ampelopsis_grossedentata/sequence_data
mkdir -p ./Ampelopsis_grossedentata/genome

## 转移数据
rsync -avP \
  ~/data/anchr

```bash
## 
cd ~/stq/data/anchr/Ampelopsis_grossedentata/

ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\d\.f(ast)*q.gz//;print $new')
do
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```

# 运行超算任务
```bash
WORKING_DIR=${HOME}/stq/data/anchr/Ampelopsis_grossedentata/
BASE_NAME=Agr_PE400_R

cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --parallel 24 \
    --xmx 110g
```

```bash
# 打开vim
vim
# 粘贴如下内容
#!/usr/bin/env bash
BASH_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BASH_DIR}

#----------------------------#
# Colors in term
#----------------------------#
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
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

#----------------------------#
# helper functions
#----------------------------#
set +e

# set stacksize to unlimited
ulimit -s unlimited

signaled () {
    log_warn Interrupted
    exit 1
}
trap signaled TERM QUIT INT

# save environment variables
save () {
    printf ". + {%s: \"%s\"}" $1 $(eval "echo -n \"\$$1\"") > jq.filter.txt

    if [ -e environment.json ]; then
        cat environment.json \
            | jq -f jq.filter.txt \
            > environment.json.new
        rm environment.json
    else
        jq -f jq.filter.txt -n \
            > environment.json.new
    fi

    mv environment.json.new environment.json
    rm jq.filter.txt
}

stat_format () {
    echo $(faops n50 -H -N 50 -S -C $@) \
        | perl -nla -MNumber::Format -e '
            printf qq{%d\t%s\t%d\n}, $F[0], Number::Format::format_bytes($F[1], base => 1000,), $F[2];
        '
}

log_warn 0_master.sh

#----------------------------#
# Illumina QC
#----------------------------#
if [ -e 2_fastqc.sh ]; then
    bash 2_fastqc.sh;
fi
if [ -e 2_kmergenie.sh ]; then
    bash 2_kmergenie.sh;
fi

if [ -e 2_insertSize.sh ]; then
    bash 2_insertSize.sh;
fi

if [ -e 2_sgaPreQC.sh ]; then
    bash 2_sgaPreQC.sh;
fi

#----------------------------#
# preprocessing
#----------------------------#
if [ -e 2_trim.sh ]; then
    bash 2_trim.sh;
fi

if [ -e 3_trimlong.sh ]; then
    bash 3_trimlong.sh;
fi

if [ -e 9_statReads.sh ]; then
    bash 9_statReads.sh;
fi

# 将文件存储为0_temp.sh
```
```bash
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_temp.sh
"
```
# 查看超算后台的生成文件
```text
#R.filter
#Matched	60	0.00003%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	2903082402
#main_peak	33
#genome_size	911749703
#haploid_genome_size	911749703
#fold_coverage	17
#haploid_fold_coverage	17
#ploidy	1
#percent_repeat	77.506
#start	center	stop	max	volume
```
# 得到估计的基因组大小 911749703

# 执行清理操作
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

```bash
# 再次进行组装
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 911749703 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25 30" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "60 80 120 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g
```
```bash
# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
---


# Lithocarpus_polystachyus
+ 测序数据量 9.9G  R1.fq.gz  13G  R2.fq.gz
+ 测序方式 ： Illumina
+ 预测的基因组大小 ： 911749703
 
```bash
# 超算
cd ~/stq/data/anchr/
mkdir -p ./Lithocarpus_polystachyus/sequence_data
mkdir -p ./Lithocarpus_polystachyus/genome

## 转移数据
rsync -avP \
  ~/data/anchr

```bash
## 
cd ~/stq/data/anchr/Lithocarpus_polystachyus/

ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/\d\.f(ast)*q.gz//;print $new')
do
    mkdir -p ${name}/2_illumina
    cd ${name}/2_illumina
    ln -fs ../../sequence_data/${name}_1.fastq.gz R1.fq.gz
    ln -fs ../../sequence_data/${name}_2.fastq.gz R2.fq.gz
  cd ${ROOTTMP}
done
```
```bash
# 运行超算任务
WORKING_DIR=${HOME}/stq/data/anchr/Lithocarpus_polystachyus/
BASE_NAME=Lpa_PE400_R

cd ${WORKING_DIR}/${BASE_NAME}
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --parallel 24 \
    --xmx 110g
```
```bash
# 打开vim
vim
```
输入以下内容
```
#!/usr/bin/env bash

BASH_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BASH_DIR}

#----------------------------#
# Colors in term
#----------------------------#
# http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
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

#----------------------------#
# helper functions
#----------------------------#
set +e

# set stacksize to unlimited
ulimit -s unlimited

signaled () {
    log_warn Interrupted
    exit 1
}
trap signaled TERM QUIT INT

# save environment variables
save () {
    printf ". + {%s: \"%s\"}" $1 $(eval "echo -n \"\$$1\"") > jq.filter.txt

    if [ -e environment.json ]; then
        cat environment.json \
            | jq -f jq.filter.txt \
            > environment.json.new
        rm environment.json
    else
        jq -f jq.filter.txt -n \
            > environment.json.new
    fi

    mv environment.json.new environment.json
    rm jq.filter.txt
}

stat_format () {
    echo $(faops n50 -H -N 50 -S -C $@) \
        | perl -nla -MNumber::Format -e '
            printf qq{%d\t%s\t%d\n}, $F[0], Number::Format::format_bytes($F[1], base => 1000,), $F[2];
        '
}

log_warn 0_master.sh

#----------------------------#
# Illumina QC
#----------------------------#
if [ -e 2_fastqc.sh ]; then
    bash 2_fastqc.sh;
fi
if [ -e 2_kmergenie.sh ]; then
    bash 2_kmergenie.sh;
fi

if [ -e 2_insertSize.sh ]; then
    bash 2_insertSize.sh;
fi

if [ -e 2_sgaPreQC.sh ]; then
    bash 2_sgaPreQC.sh;
fi

#----------------------------#
# preprocessing
#----------------------------#
if [ -e 2_trim.sh ]; then
    bash 2_trim.sh;
fi

if [ -e 3_trimlong.sh ]; then
    bash 3_trimlong.sh;
fi

if [ -e 9_statReads.sh ]; then
    bash 9_statReads.sh;
fi
EOF
```
保存为 `0_temp.sh`
```bash
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_temp.sh
"
```
# 查看超算后台的生成文件
```text
#R.trim
#Matched	962451	0.41931%
#Name	Reads	ReadsPct
```

```text
#R.filter
#Matched	19	0.00001%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	3519854407
#main_peak	11
#genome_size	818490203
#haploid_genome_size	818490203
#fold_coverage	11
#haploid_fold_coverage	11
#ploidy	1
#percent_repeat	12.171
#start	center	stop	max	volume

# 得到估计的基因组大小 818490203
```
```bash
# 执行清理操作
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

# 再次进行组装
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 818490203 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25 30" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 50 60 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g
    
# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
