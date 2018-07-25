使用process中的screen.pl程序对blast结果进行筛选

```bash
# 创建临时环境变量
program_path=
export PATH="$program_path:$PATH"
```

```bash
cd /Volumes/HDD/stq/data/anchr/col_0/Miseq/SRR5216995
for i in ./7_mergeAnchors/anchor.merge.fasta ./7_mergeAnchors/others.non-contained.fasta ./8_megahit/anchor/anchor.fasta ./8_megahit/megahit.non-contained.fasta ./8_megahit_MR/megahit.non-contained.fasta ./8_megahit_MR/anchor/anchor.fasta ./8_platanus/anchor/anchor.fasta ./8_platanus/platanus.non-contained.fasta ./8_spades/anchor/anchor.fasta ./8_spades/spades.non-contained.fasta ./8_spades_MR/anchor/anchor.fasta ./8_spades_MR/spades.non-contained.fasta
do
perl screen.pl  -d ./1_genome/ -t 400 -o ./screen/ --threads 3 -q ${i}
done

# 生成svg图片
for i in ./8_megahit/anchor/contig.proper.yml ./8_megahit_MR/anchor/contig.proper.yml ./8_platanus/anchor/contig.proper.yml ./8_spades/anchor/contig.proper.yml ./8_spades_MR/anchor/contig.proper.yml;
do
  perl yml_to_svg.pl -y ${i}  -o ./screen
done
```
