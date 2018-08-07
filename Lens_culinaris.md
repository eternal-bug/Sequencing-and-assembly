# *Lens_culinaris*[兵豆]
基因组大小估计参考[科学网](http://blog.sciencenet.cn/blog-3533-766578.html)
+ 兵豆Lentil (Lens culinaris), 2n=2x=14, 基因组大小：4063Mbp
+ 2.1G	R1.fq.gz  2.6G	R2.fq.gz
+ 1217928

## 后台生成的信息
```text
#R.trim
#Matched	195738	0.40818%
#Name	Reads	ReadsPct
Reverse_adapter	48124	0.10036%
```

```text
#R.filter
#Matched	0	0.00000%
#Name	Reads	ReadsPct
```

```text
#R.peaks
#k	31
#unique_kmers	1373473739
#main_peak	435
#genome_size	1217928
#haploid_genome_size	1217928
#fold_coverage	422
#haploid_fold_coverage	422
#ploidy	1
#percent_repeat	96.060
#start	center	stop	max	volume
```
```bash
WORKING_DIR=~/stq/data/anchr/Lens_culinaris
BASE_NAME=268_PE400_R
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

# 再次进行组装
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_217_928 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 10 --cutk 31" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 80 120 160 240 320" \
    --tadpole \
    --splitp 100 \
    --statp 1 \
    --fillanchor \
    --xmx 110g \
    --parallel 24

# 提交超算任务
bsub -q mpi -n 24 -J "${BASE_NAME}" "
  bash 0_bsub.sh
"
```
