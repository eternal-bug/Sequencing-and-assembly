# Assemble genomes of model organisms by ANCHR
<!-- MarkdownTOC -->

- More tools on downloading and preprocessing data
    - Extra external executables
    - Other leading assemblers
    - PacBio specific tools
- *Escherichia coli* str. K-12 substr. MG1655
    - e_coli: download
    - e_coli: template
    - e_coli: run
- *Saccharomyces cerevisiae* S288c
    - s288c: download
    - s288c_MiSeq: symlink
    - s288c_MiSeq: template
    - s288c_MiSeq: run
    - s288c_HiSeq: symlink
    - s288c_HiSeq: template
    - s288c_HiSeq: run
- *Drosophila melanogaster* iso-1
    - iso_1: download
    - iso_1_HiSeq_2000: symlink
    - iso_1_HiSeq_2000: template
    - iso_1_HiSeq_2000: run
    - iso_1_HiSeq_2500: symlink
    - iso_1_HiSeq_2500: template
    - iso_1_HiSeq_2500: run
- *Caenorhabditis elegans* N2
    - n2: download
    - n2_pe120: symlink
    - n2_pe120: template
    - n2_pe120: run
    - n2_pe100: symlink
    - n2_pe100: template
    - n2_pe100: run
- *Arabidopsis thaliana* Col-0
    - col_0: download
    - col_0_MiSeq: symlink
    - col_0_MiSeq: template
    - col_0_MiSeq: run
    - col_0_HiSeq: symlink
    - col_0_HiSeq: template
    - col_0_HiSeq: run
- *Oryza sativa* Japonica Group Nipponbare
    - nip: download
    - nip_pe300: symlink
    - nip_pe300: template
    - nip_pe300: run
    - nip_pe180: run

<!-- /MarkdownTOC -->

# More tools on downloading and preprocessing data

## Extra external executables

```bash
brew install aria2 curl                     # downloading tools

brew tap brewsci/bio
brew tap brewsci/science

brew install sratoolkit    # NCBI SRAToolkit

brew reinstall --build-from-source --without-webp gd # broken, can't find libwebp.so.6
brew reinstall --build-from-source lua@5.1
brew reinstall --build-from-source gnuplot@4
brew install mummer        # mummer need gnuplot4

brew install openblas                       # numpy

brew install python
brew install quast         # assembly quality assessment
quast --test                                # may recompile the bundled nucmer

# canu requires gnuplot 5 while mummer requires gnuplot 4
brew install --build-from-source canu

brew unlink gnuplot@4
brew install gnuplot
brew unlink gnuplot

brew link gnuplot@4 --force

brew install r
brew install kmergenie --with-maxkmer=200

brew install kmc --HEAD

brew install picard-tools
```

## Other leading assemblers

```bash
brew install spades
brew install megahit
brew install wang-q/tap/platanus

```

## PacBio specific tools

PacBio is switching its data format from `hdf5` to `bam`, but at now (early 2017) the majority of
public available PacBio data are still in formats of `.bax.h5` or `hdf5.tgz`. For dealing with these
files, PacBio releases some tools which can be installed by another specific tool, named
`pitchfork`.

Their tools *can* be compiled under macOS with Homebrew.

* Install some third party tools

```bash
brew install md5sha1sum
brew install zlib boost openblas
brew install python cmake ccache hdf5
brew install samtools

brew cleanup --force # only keep the latest version
```

* Compiling with `pitchfork`

```bash
mkdir -p ~/share/pitchfork
git clone https://github.com/PacificBiosciences/pitchfork ~/share/pitchfork
cd ~/share/pitchfork

cat <<EOF > settings.mk
HAVE_ZLIB     = $(brew --prefix)/Cellar/$(brew list --versions zlib     | sed 's/ /\//')
HAVE_BOOST    = $(brew --prefix)/Cellar/$(brew list --versions boost    | sed 's/ /\//')
HAVE_OPENBLAS = $(brew --prefix)/Cellar/$(brew list --versions openblas | sed 's/ /\//')

HAVE_PYTHON   = $(brew --prefix)/bin/python
HAVE_CMAKE    = $(brew --prefix)/bin/cmake
HAVE_CCACHE   = $(brew --prefix)/Cellar/$(brew list --versions ccache | sed 's/ /\//')/bin/ccache
HAVE_HDF5     = $(brew --prefix)/Cellar/$(brew list --versions hdf5   | sed 's/ /\//')

EOF

# fix several Makefiles
sed -i".bak" "/rsync/d" ~/share/pitchfork/ports/python/virtualenv/Makefile

sed -i".bak" "s/-- third-party\/cpp-optparse/--remote/" ~/share/pitchfork/ports/pacbio/bam2fastx/Makefile
sed -i".bak" "/third-party\/gtest/d" ~/share/pitchfork/ports/pacbio/bam2fastx/Makefile
sed -i".bak" "/ccache /d" ~/share/pitchfork/ports/pacbio/bam2fastx/Makefile

cd ~/share/pitchfork
make pip
deployment/bin/pip install --upgrade pip setuptools wheel virtualenv

make bax2bam
```

* Compiled binary files are in `~/share/pitchfork/deployment`. Run `source
  ~/share/pitchfork/deployment/setup-env.sh` will bring this path to your `$PATH`. This action would
  also pollute your bash environment, if anything went wrong, restart your terminal.

```bash
source ~/share/pitchfork/deployment/setup-env.sh

bax2bam --help
```


# *Escherichia coli* str. K-12 substr. MG1655

* Genome: INSDC [U00096.3](https://www.ncbi.nlm.nih.gov/nuccore/U00096.3)
* Taxonomy ID: [511145](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=511145)
* Proportion of paralogs (> 1000 bp): 0.0323

## e_coli: download

* Reference genome

```bash
mkdir -p ${HOME}/data/anchr/e_coli
cd ${HOME}/data/anchr/e_coli

mkdir -p 1_genome
cd 1_genome

curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=U00096.3&rettype=fasta&retmode=txt" \
    > U00096.fa
# simplify header, remove .3
cat U00096.fa |
    perl -nl -e '
        /^>(\w+)/ and print qq{>$1} and next;
        print;
    ' \
    > genome.fa

cp ${HOME}/data/anchr/paralogs/model/Results/e_coli/e_coli.multi.fas paralogs.fas
```

* Illumina

```bash
cd ${HOME}/data/anchr/e_coli

mkdir -p 2_illumina
cd 2_illumina

aria2c -x 9 -s 3 -c ftp://webdata:webdata@ussd-ftp.illumina.com/Data/SequencingRuns/MG1655/MiSeq_Ecoli_MG1655_110721_PF_R1.fastq.gz
aria2c -x 9 -s 3 -c ftp://webdata:webdata@ussd-ftp.illumina.com/Data/SequencingRuns/MG1655/MiSeq_Ecoli_MG1655_110721_PF_R2.fastq.gz

ln -s MiSeq_Ecoli_MG1655_110721_PF_R1.fastq.gz R1.fq.gz
ln -s MiSeq_Ecoli_MG1655_110721_PF_R2.fastq.gz R2.fq.gz

```

* PacBio

    [Here](https://github.com/PacificBiosciences/DevNet/wiki/E.-coli-Bacterial-Assembly) PacBio
    provides a 7 GB file for *E. coli* (20 kb library), which is gathered with RS II and the P6C4
    reagent.

```bash
cd ${HOME}/data/anchr/e_coli

mkdir -p 3_pacbio
cd 3_pacbio

aria2c -x 9 -s 3 -c https://s3.amazonaws.com/files.pacb.com/datasets/secondary-analysis/e-coli-k12-P6C4/p6c4_ecoli_RSII_DDR2_with_15kb_cut_E01_1.tar.gz

tar xvfz p6c4_ecoli_RSII_DDR2_with_15kb_cut_E01_1.tar.gz

# Optional, a human readable .metadata.xml file
#xmllint --format E01_1/m141013_011508_sherri_c100709962550000001823135904221533_s1_p0.metadata.xml \
#    > m141013.metadata.xml

# convert .bax.h5 to .subreads.bam
mkdir -p ~/data/anchr/e_coli/3_pacbio/bam
cd ~/data/anchr/e_coli/3_pacbio/bam

source ~/share/pitchfork/deployment/setup-env.sh
bax2bam ../E01_1/Analysis_Results/*.bax.h5

# convert .subreads.bam to fasta
mkdir -p ~/data/anchr/e_coli/3_pacbio/fasta

samtools fasta \
    ~/data/anchr/e_coli/3_pacbio/bam/m141013*.subreads.bam \
    > ~/data/anchr/e_coli/3_pacbio/fasta/m141013.fasta

cd ~/data/anchr/e_coli/3_pacbio
cat fasta/m141013.fasta |
    faops dazz -l 0 -p long stdin stdout |
    pigz > pacbio.fasta.gz

```

## e_coli: template

* Rsync to hpcc

```bash
rsync -avP \
    --exclude="p6c4_ecoli_RSII_DDR2_with_15kb_cut_E01_1.tar.gz" \
    ~/data/anchr/e_coli/ \
    wangq@202.119.37.251:data/anchr/e_coli

# rsync -avP wangq@202.119.37.251:data/anchr/e_coli/ ~/data/anchr/e_coli

```

* template

`--cov2 "40 60 80 100"` introduced ~10 SNPs and 1 misassembly.

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=e_coli

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 4641652 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --sgastats \
    --trim2 "--dedupe --tile --cutoff 5 --cutk 31" \
    --qual2 "20 25 30" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 80" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --cov3 "80 all" \
    --qual3 "trim" \
    --parallel 24 \
    --xmx 110g

```

## e_coli: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=e_coli

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

三代 reads 里有一个常见的错误, 即单一 ZMW 里的测序结果中, 接头序列部分的测序结果出现了较多的错误,
因此并没有将接头序列去除干净, 形成的 subreads 里含有多份基因组上同一片段, 它们之间以接头序列为间隔.

`anchr group` 命令默认会将这种三代的 reads 去除. `--keep` 选项会留下这种 reads, 这适用于组装好的三代序列.

```text
      ===
------------>
             )
  <----------
      ===
```


Table: statInsertSize

| Group             |  Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|------:|-------------------------------:|
| R.genome.bbtools  | 321.9 |    298 | 968.5 |                         47.99% |
| R.tadpole.bbtools | 295.6 |    296 |  21.1 |                         40.60% |
| R.genome.picard   | 298.2 |    298 |  18.0 |                             FR |
| R.tadpole.picard  | 294.9 |    296 |  21.7 |                             FR |


Table: statSgaStats

| Library | incorrectBases | perfectReads | overlapDepth |
|:--------|---------------:|-------------:|-------------:|
| R       |          0.26% |       79.72% |       356.41 |


Table: statReads

| Name       |     N50 |     Sum |        # |
|:-----------|--------:|--------:|---------:|
| Genome     | 4641652 | 4641652 |        1 |
| Paralogs   |    1934 |  195673 |      106 |
| Illumina.R |     151 |   1.73G | 11458940 |
| trim.R     |     149 |   1.43G | 10363942 |
| Q20L60     |     149 |   1.41G | 10224942 |
| Q25L60     |     148 |   1.32G |  9939581 |
| Q30L60     |     128 |   1.11G |  9311358 |
| PacBio     |   13982 | 748.51M |    87225 |
| X80.raw    |   13990 | 371.34M |    44005 |
| X80.trim   |   13632 | 339.51M |    38725 |
| Xall.raw   |   13982 | 748.51M |    87225 |
| Xall.trim  |   13646 | 689.43M |    77693 |


Table: statTrimReads

| Name           | N50 |     Sum |        # |
|:---------------|----:|--------:|---------:|
| clumpify       | 151 |   1.73G | 11439000 |
| filteredbytile | 151 |   1.67G | 11060132 |
| highpass       | 151 |   1.66G | 10989512 |
| trim           | 149 |   1.43G | 10364442 |
| filter         | 149 |   1.43G | 10363942 |
| R1             | 150 |    736M |  5181971 |
| R2             | 144 | 690.42M |  5181971 |
| Rs             |   0 |       0 |        0 |


```text
#R.trim
#Matched    17666   0.16075%
#Name   Reads   ReadsPct
```

```text
#R.filter
#Matched    499 0.00481%
#Name   Reads   ReadsPct
```

```text
#R.peaks
#k  31
#unique_kmers   20719894
#main_peak  239
#genome_size    4602129
#haploid_genome_size    4602129
#fold_coverage  239
#haploid_fold_coverage  239
#ploidy 1
#percent_repeat 2.092
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |    Sum |        # |
|:--------------|----:|-------:|---------:|
| clumped       | 149 |  1.43G | 10362762 |
| ecco          | 149 |  1.43G | 10362762 |
| eccc          | 149 |  1.43G | 10362762 |
| ecct          | 149 |  1.42G | 10314376 |
| extended      | 189 |  1.83G | 10314376 |
| merged.raw    | 339 |  1.72G |  5089559 |
| unmerged.raw  | 175 | 19.82M |   135258 |
| unmerged.trim | 175 | 19.81M |   135198 |
| M1            | 339 |  1.71G |  5061974 |
| U1            | 181 | 10.42M |    67599 |
| U2            | 168 |  9.39M |    67599 |
| Us            |   0 |      0 |        0 |
| M.cor         | 338 |  1.73G | 10259146 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 271.6 |    277 |  23.7 |         10.86% |
| M.ihist.merge.txt  | 337.7 |    338 |  19.3 |         98.69% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% | Kmer | RealG |  EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|-----:|------:|------:|---------:|----------:|
| Q0L0.R   | 307.3 |  285.6 |    7.05% | "95" | 4.64M | 4.66M |     1.00 | 0:02'18'' |
| Q20L60.R | 302.9 |  283.7 |    6.35% | "95" | 4.64M | 4.63M |     1.00 | 0:02'16'' |
| Q25L60.R | 284.0 |  273.1 |    3.84% | "89" | 4.64M | 4.57M |     0.98 | 0:02'11'' |
| Q30L60.R | 238.3 |  233.5 |    2.03% | "75" | 4.64M | 4.56M |     0.98 | 0:01'53'' |


Table: statKunitigsAnchors.md

| Name          | CovCor | Mapped% | N50Anchor |   Sum |    # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:--------------|-------:|--------:|----------:|------:|-----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000   |   40.0 |  95.96% |      9531 | 4.45M |  699 |        69 |  87.85K | 1652 |   39.0 | 3.0 |  10.0 |  72.0 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'53'' |
| Q0L0X40P001   |   40.0 |  96.19% |      9614 | 4.42M |  718 |       429 | 136.01K | 1669 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'54'' |
| Q0L0X40P002   |   40.0 |  96.02% |      9335 | 4.45M |  697 |        74 |  96.94K | 1711 |   39.0 | 3.0 |  10.0 |  72.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'51'' |
| Q0L0X40P003   |   40.0 |  96.03% |      9622 | 4.41M |  715 |       447 | 136.38K | 1708 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'52'' |
| Q0L0X40P004   |   40.0 |  96.20% |      9031 | 4.41M |  715 |       653 |  143.1K | 1653 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'52'' |
| Q0L0X40P005   |   40.0 |  96.20% |      8938 | 4.47M |  720 |        65 |  86.13K | 1719 |   39.0 | 3.0 |  10.0 |  72.0 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'53'' |
| Q0L0X80P000   |   80.0 |  92.26% |      4736 | 4.29M | 1185 |        63 | 129.49K | 2465 |   79.0 | 6.0 |  20.0 | 145.5 | "31,41,51,61,71,81" | 0:01'19'' | 0:00'51'' |
| Q0L0X80P001   |   80.0 |  91.94% |      5060 | 4.28M | 1142 |        60 | 120.11K | 2399 |   79.0 | 6.0 |  20.0 | 145.5 | "31,41,51,61,71,81" | 0:01'19'' | 0:00'52'' |
| Q0L0X80P002   |   80.0 |  92.17% |      4750 |  4.3M | 1166 |        56 | 116.96K | 2413 |   79.0 | 6.0 |  20.0 | 145.5 | "31,41,51,61,71,81" | 0:01'19'' | 0:00'51'' |
| Q20L60X40P000 |   40.0 |  96.52% |     10283 | 4.41M |  667 |       487 | 146.04K | 1633 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'54'' |
| Q20L60X40P001 |   40.0 |  96.70% |     10018 | 4.43M |  682 |       319 | 129.98K | 1620 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'54'' |
| Q20L60X40P002 |   40.0 |  96.36% |      9855 | 4.41M |  703 |       645 | 153.21K | 1714 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'52'' |
| Q20L60X40P003 |   40.0 |  96.50% |     10276 | 4.47M |  645 |        62 |  79.92K | 1603 |   39.0 | 3.0 |  10.0 |  72.0 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'53'' |
| Q20L60X40P004 |   40.0 |  96.51% |      9928 | 4.44M |  687 |       391 | 132.87K | 1667 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'53'' |
| Q20L60X40P005 |   40.0 |  96.41% |      9864 |  4.4M |  702 |       664 | 160.15K | 1688 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'52'' |
| Q20L60X80P000 |   80.0 |  93.29% |      5477 | 4.34M | 1068 |        62 | 111.42K | 2214 |   79.0 | 6.0 |  20.0 | 145.5 | "31,41,51,61,71,81" | 0:01'19'' | 0:00'53'' |
| Q20L60X80P001 |   80.0 |  93.23% |      5411 | 4.33M | 1084 |        67 |  121.9K | 2300 |   79.0 | 6.0 |  20.0 | 145.5 | "31,41,51,61,71,81" | 0:01'19'' | 0:00'53'' |
| Q20L60X80P002 |   80.0 |  93.23% |      5484 | 4.34M | 1061 |        64 | 113.65K | 2218 |   79.0 | 6.0 |  20.0 | 145.5 | "31,41,51,61,71,81" | 0:01'20'' | 0:00'51'' |
| Q25L60X40P000 |   40.0 |  97.82% |     14981 | 4.45M |  501 |       638 | 162.89K | 1481 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'57'' |
| Q25L60X40P001 |   40.0 |  97.91% |     15337 | 4.46M |  481 |       614 | 145.85K | 1453 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'59'' |
| Q25L60X40P002 |   40.0 |  97.94% |     16645 | 4.45M |  474 |       698 | 158.93K | 1475 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'48'' | 0:00'59'' |
| Q25L60X40P003 |   40.0 |  97.84% |     15126 | 4.46M |  511 |       527 | 147.07K | 1482 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'50'' | 0:00'56'' |
| Q25L60X40P004 |   40.0 |  97.78% |     14442 | 4.44M |  516 |       678 | 163.63K | 1460 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'48'' | 0:00'58'' |
| Q25L60X40P005 |   40.0 |  97.62% |     16136 | 4.44M |  489 |       652 |  145.8K | 1426 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'49'' | 0:00'56'' |
| Q25L60X80P000 |   80.0 |  96.69% |     10118 | 4.47M |  647 |        76 |  82.48K | 1523 |   79.0 | 5.0 |  20.0 | 141.0 | "31,41,51,61,71,81" | 0:01'18'' | 0:00'55'' |
| Q25L60X80P001 |   80.0 |  96.56% |     11160 | 4.47M |  635 |        66 |   75.8K | 1479 |   79.0 | 5.0 |  20.0 | 141.0 | "31,41,51,61,71,81" | 0:01'18'' | 0:00'56'' |
| Q25L60X80P002 |   80.0 |  96.37% |      9860 | 4.46M |  656 |        58 |  67.29K | 1513 |   79.0 | 5.0 |  20.0 | 141.0 | "31,41,51,61,71,81" | 0:01'18'' | 0:00'55'' |
| Q30L60X40P000 |   40.0 |  98.60% |     32897 |  4.5M |  257 |       569 | 114.71K | 1379 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'47'' | 0:01'07'' |
| Q30L60X40P001 |   40.0 |  98.54% |     30543 | 4.48M |  256 |       772 | 122.71K | 1374 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'47'' | 0:01'06'' |
| Q30L60X40P002 |   40.0 |  98.55% |     30821 | 4.49M |  277 |       746 | 136.68K | 1392 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'47'' | 0:01'04'' |
| Q30L60X40P003 |   40.0 |  98.56% |     30972 | 4.48M |  290 |      1007 | 136.84K | 1356 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'48'' | 0:01'04'' |
| Q30L60X40P004 |   40.0 |  98.57% |     29621 |  4.5M |  289 |       409 | 115.43K | 1447 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'48'' | 0:01'06'' |
| Q30L60X80P000 |   80.0 |  98.56% |     30012 | 4.48M |  287 |       686 | 118.98K | 1248 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:01'14'' | 0:01'10'' |
| Q30L60X80P001 |   80.0 |  98.47% |     30562 | 4.48M |  294 |      1038 | 144.48K | 1217 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:01'15'' | 0:01'07'' |


Table: statTadpoleAnchors.md

| Name          | CovCor | Mapped% | N50Anchor |   Sum |   # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:--------------|-------:|--------:|----------:|------:|----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000   |   40.0 |  98.28% |     30988 |  4.5M | 267 |       108 | 100.96K | 1254 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:01'04'' |
| Q0L0X40P001   |   40.0 |  98.20% |     28586 |  4.5M | 294 |       113 |  99.93K | 1256 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'04'' |
| Q0L0X40P002   |   40.0 |  98.27% |     27844 | 4.49M | 304 |       184 | 111.89K | 1356 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'38'' | 0:01'05'' |
| Q0L0X40P003   |   40.0 |  98.28% |     27213 |  4.5M | 301 |       198 | 106.25K | 1321 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'03'' |
| Q0L0X40P004   |   40.0 |  98.18% |     30512 |  4.5M | 268 |       100 |   97.5K | 1226 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:01'02'' |
| Q0L0X40P005   |   40.0 |  98.28% |     29298 | 4.48M | 290 |       698 | 133.31K | 1287 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'05'' |
| Q0L0X80P000   |   80.0 |  97.04% |     17314 | 4.49M | 422 |        61 |  64.52K | 1144 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'57'' |
| Q0L0X80P001   |   80.0 |  97.17% |     16043 | 4.49M | 443 |        55 |  62.99K | 1231 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'58'' |
| Q0L0X80P002   |   80.0 |  97.28% |     16254 | 4.49M | 442 |        65 |  72.19K | 1233 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'57'' |
| Q20L60X40P000 |   40.0 |  98.31% |     31084 | 4.49M | 278 |       192 | 110.12K | 1268 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'03'' |
| Q20L60X40P001 |   40.0 |  98.30% |     31997 | 4.49M | 279 |       411 | 113.83K | 1231 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'39'' | 0:01'04'' |
| Q20L60X40P002 |   40.0 |  98.09% |     29746 | 4.49M | 280 |       176 | 106.25K | 1224 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'01'' |
| Q20L60X40P003 |   40.0 |  98.32% |     29343 | 4.49M | 281 |       425 | 115.64K | 1291 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:00'38'' | 0:01'05'' |
| Q20L60X40P004 |   40.0 |  98.34% |     30923 |  4.5M | 274 |       117 | 103.22K | 1269 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'03'' |
| Q20L60X40P005 |   40.0 |  98.31% |     26892 | 4.49M | 286 |       172 | 113.41K | 1303 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:01'05'' |
| Q20L60X80P000 |   80.0 |  97.47% |     19540 | 4.49M | 378 |        73 |  70.37K | 1103 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'57'' |
| Q20L60X80P001 |   80.0 |  97.39% |     16521 | 4.49M | 426 |        85 |  81.81K | 1217 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'58'' |
| Q20L60X80P002 |   80.0 |  97.40% |     17315 | 4.49M | 423 |        60 |  65.84K | 1188 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'46'' | 0:00'58'' |
| Q25L60X40P000 |   40.0 |  98.47% |     28807 | 4.47M | 295 |       501 | 145.04K | 1370 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'05'' |
| Q25L60X40P001 |   40.0 |  98.52% |     30972 | 4.49M | 278 |       266 | 114.95K | 1339 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'36'' | 0:01'06'' |
| Q25L60X40P002 |   40.0 |  98.51% |     31202 | 4.49M | 280 |       283 | 113.75K | 1330 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'38'' | 0:01'04'' |
| Q25L60X40P003 |   40.0 |  98.47% |     30895 | 4.49M | 280 |       466 | 130.03K | 1349 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'36'' | 0:01'06'' |
| Q25L60X40P004 |   40.0 |  98.47% |     34253 | 4.49M | 253 |       428 | 120.26K | 1311 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'07'' |
| Q25L60X40P005 |   40.0 |  98.53% |     30923 | 4.48M | 284 |       539 | 142.25K | 1399 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'05'' |
| Q25L60X80P000 |   80.0 |  98.13% |     22972 |  4.5M | 322 |       103 |  74.91K | 1132 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'43'' | 0:01'03'' |
| Q25L60X80P001 |   80.0 |  98.11% |     22728 |  4.5M | 329 |        85 |  76.12K | 1168 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'46'' | 0:01'02'' |
| Q25L60X80P002 |   80.0 |  97.91% |     21452 | 4.49M | 344 |        92 |  78.81K | 1163 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:00'43'' | 0:01'03'' |
| Q30L60X40P000 |   40.0 |  98.58% |     29351 |  4.5M | 288 |       569 |  133.1K | 1630 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'36'' | 0:01'06'' |
| Q30L60X40P001 |   40.0 |  98.53% |     29297 | 4.48M | 289 |       750 | 144.59K | 1615 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'04'' |
| Q30L60X40P002 |   40.0 |  98.57% |     29319 | 4.49M | 299 |       858 | 146.47K | 1579 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'05'' |
| Q30L60X40P003 |   40.0 |  98.51% |     25819 | 4.48M | 321 |       897 | 153.22K | 1615 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'37'' | 0:01'05'' |
| Q30L60X40P004 |   40.0 |  98.54% |     27568 |  4.5M | 309 |       605 | 150.82K | 1657 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:00'35'' | 0:01'04'' |
| Q30L60X80P000 |   80.0 |  98.62% |     33193 | 4.51M | 228 |       244 |  78.64K | 1222 |   80.0 | 5.0 |  20.0 | 142.5 | "31,41,51,61,71,81" | 0:00'44'' | 0:01'10'' |
| Q30L60X80P001 |   80.0 |  98.54% |     36290 |  4.5M | 241 |       584 |  84.22K | 1210 |   80.0 | 5.0 |  20.0 | 142.5 | "31,41,51,61,71,81" | 0:00'42'' | 0:01'10'' |


Table: statMRKunitigsAnchors.md

| Name      | CovCor | Mapped% | N50Anchor |   Sum |   # | N50Others |    Sum |   # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:----------|-------:|--------:|----------:|------:|----:|----------:|-------:|----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000 |   40.0 |  97.02% |     38032 | 4.49M | 204 |       131 | 56.71K | 469 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:01'02'' | 0:00'55'' |
| MRX40P001 |   40.0 |  96.99% |     33415 | 4.47M | 262 |       173 | 86.14K | 536 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:01'01'' | 0:00'53'' |
| MRX40P002 |   40.0 |  96.97% |     32960 | 4.46M | 272 |       218 | 88.65K | 532 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:01'03'' | 0:00'51'' |
| MRX40P003 |   40.0 |  97.03% |     32065 | 4.47M | 236 |       159 | 78.92K | 505 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:01'01'' | 0:00'52'' |
| MRX40P004 |   40.0 |  96.95% |     32442 | 4.46M | 246 |       171 |  83.6K | 524 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:01'02'' | 0:00'53'' |
| MRX40P005 |   40.0 |  96.91% |     35088 | 4.47M | 249 |       157 | 75.16K | 510 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:01'02'' | 0:00'50'' |
| MRX80P000 |   80.0 |  96.11% |     26084 | 4.49M | 282 |       113 | 61.53K | 603 |   79.0 | 3.0 |  20.0 | 132.0 | "31,41,51,61,71,81" | 0:01'42'' | 0:00'50'' |
| MRX80P001 |   80.0 |  96.28% |     27466 | 4.48M | 277 |       120 | 65.81K | 609 |   79.0 | 3.0 |  20.0 | 132.0 | "31,41,51,61,71,81" | 0:01'43'' | 0:00'51'' |
| MRX80P002 |   80.0 |  96.21% |     27710 | 4.48M | 283 |       116 | 63.75K | 611 |   79.0 | 3.0 |  20.0 | 132.0 | "31,41,51,61,71,81" | 0:01'43'' | 0:00'51'' |
| MRX80P003 |   80.0 |  96.27% |     28782 | 4.48M | 266 |       114 | 61.59K | 588 |   79.0 | 4.0 |  20.0 | 136.5 | "31,41,51,61,71,81" | 0:01'42'' | 0:00'52'' |


Table: statMRTadpoleAnchors.md

| Name      | CovCor | Mapped% | N50Anchor |   Sum |   # | N50Others |    Sum |   # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:----------|-------:|--------:|----------:|------:|----:|----------:|-------:|----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000 |   40.0 |  96.76% |     49717 | 4.49M | 181 |       172 | 49.66K | 323 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:00'45'' | 0:00'51'' |
| MRX40P001 |   40.0 |  96.79% |     45981 | 4.48M | 186 |       199 | 53.77K | 330 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:00'42'' | 0:00'49'' |
| MRX40P002 |   40.0 |  96.81% |     46248 | 4.48M | 204 |       250 | 61.47K | 359 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:00'40'' | 0:00'47'' |
| MRX40P003 |   40.0 |  96.78% |     49542 | 4.49M | 168 |       190 | 51.04K | 314 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:00'41'' | 0:00'48'' |
| MRX40P004 |   40.0 |  96.76% |     47525 | 4.49M | 170 |       200 | 51.68K | 312 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:00'41'' | 0:00'47'' |
| MRX40P005 |   40.0 |  96.78% |     49409 | 4.49M | 170 |       182 | 50.61K | 308 |   39.0 | 1.0 |  12.0 |  63.0 | "31,41,51,61,71,81" | 0:00'44'' | 0:00'48'' |
| MRX80P000 |   80.0 |  96.54% |     42055 |  4.5M | 172 |       111 |  36.5K | 342 |   79.0 | 2.0 |  20.0 | 127.5 | "31,41,51,61,71,81" | 0:00'54'' | 0:00'49'' |
| MRX80P001 |   80.0 |  96.59% |     47834 |  4.5M | 159 |       118 | 38.27K | 326 |   79.0 | 3.0 |  20.0 | 132.0 | "31,41,51,61,71,81" | 0:00'52'' | 0:00'52'' |
| MRX80P002 |   80.0 |  96.52% |     50580 |  4.5M | 170 |       111 | 38.46K | 345 |   79.0 | 3.0 |  20.0 | 132.0 | "31,41,51,61,71,81" | 0:00'53'' | 0:00'49'' |
| MRX80P003 |   80.0 |  96.57% |     51829 |  4.5M | 159 |       112 | 36.84K | 321 |   79.0 | 3.0 |  20.0 | 132.0 | "31,41,51,61,71,81" | 0:00'51'' | 0:00'48'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |   Sum |   # | N50Others |     Sum |   # | median |  MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|------:|----:|----------:|--------:|----:|-------:|-----:|------:|------:|----------:|
| 7_mergeAnchors           |  97.75% |     63631 | 4.53M | 120 |      1563 | 198.69K | 135 |  285.0 |  9.0 |  20.0 | 468.0 | 0:01'17'' |
| 7_mergeKunitigsAnchors   |  98.89% |     63411 | 4.53M | 125 |      1550 | 174.22K | 124 |  284.0 | 14.0 |  20.0 | 489.0 | 0:02'36'' |
| 7_mergeMRKunitigsAnchors |  98.87% |     63053 | 4.51M | 122 |      1197 |  64.92K |  57 |  285.0 | 11.0 |  20.0 | 477.0 | 0:02'07'' |
| 7_mergeMRTadpoleAnchors  |  98.75% |     63540 | 4.51M | 115 |      1197 |  60.35K |  54 |  285.0 | 10.0 |  20.0 | 472.5 | 0:01'54'' |
| 7_mergeTadpoleAnchors    |  99.05% |     63411 | 4.53M | 127 |      1514 | 168.84K | 118 |  285.0 | 11.0 |  20.0 | 477.0 | 0:02'15'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |   Sum |   # | N50Others |    Sum |   # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|------:|----:|----------:|-------:|----:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  98.54% |    117621 | 4.53M |  76 |      1255 | 21.06K | 149 |  285.0 | 10.0 |  20.0 | 472.5 | 0:01'04'' |
| 8_spades_MR  |  98.40% |    132669 | 4.55M |  73 |      1246 | 15.89K | 145 |  371.0 |  9.5 |  20.0 | 599.2 | 0:01'02'' |
| 8_megahit    |  98.14% |     63050 | 4.52M | 119 |      1255 | 24.01K | 242 |  285.0 | 10.0 |  20.0 | 472.5 | 0:01'05'' |
| 8_megahit_MR |  98.37% |    102863 | 4.56M |  84 |      1218 | 15.85K | 169 |  371.0 |  8.5 |  20.0 | 594.8 | 0:01'01'' |
| 8_platanus   |  97.87% |    117593 | 4.54M |  79 |      1065 | 16.24K | 143 |  285.0 |  8.5 |  20.0 | 465.8 | 0:01'03'' |


Table: statCanu

| Name                |     N50 |     Sum |     # |
|:--------------------|--------:|--------:|------:|
| Genome              | 4641652 | 4641652 |     1 |
| Paralogs            |    1934 |  195673 |   106 |
| X80.trim.corrected  |   16820 | 175.59M | 10873 |
| Xall.trim.corrected |   20143 | 173.96M |  8468 |
| X80.trim.contig     | 4657933 | 4657933 |     1 |
| Xall.trim.contig    | 4670240 | 4670240 |     1 |


Table: statFinal

| Name                     |     N50 |     Sum |    # |
|:-------------------------|--------:|--------:|-----:|
| Genome                   | 4641652 | 4641652 |    1 |
| Paralogs                 |    1934 |  195673 |  106 |
| 7_mergeAnchors.anchors   |   63631 | 4525486 |  120 |
| 7_mergeAnchors.others    |    1563 |  198686 |  135 |
| anchorLong               |   63631 | 4525421 |  118 |
| anchorFill               |  651952 | 4577084 |   18 |
| canu_X80-trim            | 4657933 | 4657933 |    1 |
| canu_Xall-trim           | 4670240 | 4670240 |    1 |
| spades.contig            |  132608 | 4574638 |  138 |
| spades.scaffold          |  133063 | 4574668 |  135 |
| spades.non-contained     |  132608 | 4555782 |   74 |
| spades_MR.contig         |  148607 | 4587655 |  148 |
| spades_MR.scaffold       |  148607 | 4587755 |  147 |
| spades_MR.non-contained  |  148607 | 4569042 |   74 |
| megahit.contig           |   65422 | 4572359 |  200 |
| megahit.non-contained    |   65422 | 4548194 |  123 |
| megahit_MR.contig        |  110552 | 4630720 |  223 |
| megahit_MR.non-contained |  110552 | 4577919 |   86 |
| platanus.contig          |   14854 | 4712644 | 1174 |
| platanus.scaffold        |  148483 | 4577644 |  142 |
| platanus.non-contained   |  176491 | 4559860 |   64 |


# *Saccharomyces cerevisiae* S288c

* Genome: [Ensembl 82](http://sep2015.archive.ensembl.org/Saccharomyces_cerevisiae/Info/Index)
* Proportion of paralogs (> 1000 bp): 0.058

## s288c: download

* Reference genome

```bash
mkdir -p ${HOME}/data/anchr/s288c/1_genome
cd ${HOME}/data/anchr/s288c/1_genome

wget -N ftp://ftp.ensembl.org/pub/release-82/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa.gz
faops order Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa.gz \
    <(for chr in {I,II,III,IV,V,VI,VII,VIII,IX,X,XI,XII,XIII,XIV,XV,XVI,Mito}; do echo $chr; done) \
    genome.fa

cp ~/data/anchr/paralogs/model/Results/s288c/s288c.multi.fas 1_genome/paralogs.fas

```

* Illumina

    * [ERX1999216](https://www.ncbi.nlm.nih.gov/sra/ERX1999216)

        MiSeq (PE150) ERR1938683 PRJEB19900

    * [SRX2058864](https://www.ncbi.nlm.nih.gov/sra/SRX2058864)

        HiSeq 2500 (PE150, nextera) SRR4074255 PRJNA340312

```bash
mkdir -p ${HOME}/data/anchr/s288c/2_illumina
cd ${HOME}/data/anchr/s288c/2_illumina

cat << EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR193/003/ERR1938683/ERR1938683_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR193/003/ERR1938683/ERR1938683_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR407/005/SRR4074255/SRR4074255_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR407/005/SRR4074255/SRR4074255_2.fastq.gz
EOF

aria2c -x 9 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
9a635e035371a81c8538698a54a24bfc ERR1938683_1.fastq.gz
48f362c1d7a95b996bc7931669b1d74b ERR1938683_2.fastq.gz
7ba93499d73cdaeaf50dd506e2c8572d SRR4074255_1.fastq.gz
aee9ec3f855796b6d30a3d191fc22345 SRR4074255_2.fastq.gz
EOF

md5sum --check sra_md5.txt

```

* PacBio

    PacBio provides a dataset of *S. cerevisiae* strain
    [W303](https://github.com/PacificBiosciences/DevNet/wiki/Saccharomyces-cerevisiae-W303-Assembly-Contigs),
    while the reference strain S288c is not provided. So we use the dataset from
    [project PRJEB7245](https://www.ncbi.nlm.nih.gov/bioproject/PRJEB7245),
    [study ERP006949](https://trace.ncbi.nlm.nih.gov/Traces/sra/?study=ERP006949), and
    [sample SAMEA4461732](https://www.ncbi.nlm.nih.gov/biosample/SAMEA4461732). They're gathered
    with RS II and P6C4.

```bash
mkdir -p ${HOME}/data/anchr/s288c/3_pacbio
cd ${HOME}/data/anchr/s288c/3_pacbio

# download from sra
cat <<EOF > hdf5.txt
http://sra-download.ncbi.nlm.nih.gov/srapub_files/ERR1655118_ERR1655118_hdf5.tgz
EOF

aria2c -x 9 -s 3 -c -i hdf5.txt

# untar
mkdir -p ~/data/anchr/s288c/3_pacbio/untar
cd ~/data/anchr/s288c/3_pacbio
tar xvfz ERR1655118_ERR1655118_hdf5.tgz --directory untar

# convert .bax.h5 to .subreads.bam
mkdir -p ~/data/anchr/s288c/3_pacbio/bam
cd ~/data/anchr/s288c/3_pacbio/bam

source ~/share/pitchfork/deployment/setup-env.sh
for movie in m150412;
do 
    bax2bam ~/data/anchr/s288c/3_pacbio/untar/${movie}*.bax.h5
done

# convert .subreads.bam to fasta
mkdir -p ~/data/anchr/s288c/3_pacbio/fasta

for movie in m150412;
do
    if [ ! -e ~/data/anchr/s288c/3_pacbio/bam/${movie}*.subreads.bam ]; then
        continue
    fi

    samtools fasta \
        ~/data/anchr/s288c/3_pacbio/bam/${movie}*.subreads.bam \
        > ~/data/anchr/s288c/3_pacbio/fasta/${movie}.fasta
done

cd ~/data/anchr/s288c
cat 3_pacbio/fasta/*.fasta |
    faops dazz -l 0 -p long stdin stdout |
    pigz > 3_pacbio/pacbio.fasta.gz

```

* 在酿酒酵母中, 有下列几组完全相同的序列, 它们都是新近发生的片段重复:

    * I:216563-218385, VIII:537165-538987
    * I:223713-224783, VIII:550350-551420
    * IV:528442-530427, IV:532327-534312, IV:536212-538197
    * IV:530324-531519, IV:534209-535404
    * IV:5645-7725, X:738076-740156
    * IV:7810-9432, X:736368-737990
    * IX:9683-11043, X:9666-11026
    * IV:1244112-1245373, XV:575980-577241
    * VIII:212266-214124, VIII:214264-216122
    * IX:11366-14953, X:11349-14936
    * XII:468935-470576, XII:472587-474228, XII:482167-483808, XII:485819-487460,
    * XII:483798-485798, XII:487450-489450

* Rsync to hpcc

```bash
rsync -avP \
    --exclude="*_hdf5.tgz" \
    ~/data/anchr/s288c/ \
    wangq@202.119.37.251:data/anchr/s288c

# rsync -avP wangq@202.119.37.251:data/anchr/s288c/ ~/data/anchr/s288c
# rsync -avP wangq@202.119.37.251:data/anchr/s288c_MiSeq/ ~/data/anchr/s288c_MiSeq
# rsync -avP wangq@202.119.37.251:data/anchr/s288c_HiSeq/ ~/data/anchr/s288c_HiSeq

```

## s288c_MiSeq: symlink

```bash
mkdir -p ~/data/anchr/s288c_MiSeq/1_genome
cd ~/data/anchr/s288c_MiSeq/1_genome

ln -fs ../../s288c/1_genome/genome.fa genome.fa
ln -fs ../../s288c/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/s288c_MiSeq/2_illumina
cd ~/data/anchr/s288c_MiSeq/2_illumina

ln -fs ../../s288c/2_illumina/ERR1938683_1.fastq.gz R1.fq.gz
ln -fs ../../s288c/2_illumina/ERR1938683_2.fastq.gz R2.fq.gz

```

## s288c_MiSeq: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=s288c_MiSeq

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 12157105 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --sgastats \
    --trim2 "--dedupe" \
    --qual2 "20 25 30" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 60 80 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g

```

## s288c_MiSeq: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=s288c_MiSeq

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|------:|-------------------------------:|
| R.genome.bbtools  | 407.5 |    367 | 464.6 |                         48.81% |
| R.tadpole.bbtools | 394.8 |    360 | 139.2 |                         42.83% |
| R.genome.picard   | 402.1 |    367 | 142.1 |                             FR |
| R.tadpole.picard  | 394.4 |    360 | 139.4 |                             FR |


Table: statSgaStats

| Library | incorrectBases | perfectReads | overlapDepth |
|:--------|---------------:|-------------:|-------------:|
| R       |          0.14% |       89.85% |       111.58 |


Table: statReads

| Name       |    N50 |      Sum |       # |
|:-----------|-------:|---------:|--------:|
| Genome     | 924431 | 12157105 |      17 |
| Paralogs   |   3851 |  1059148 |     366 |
| Illumina.R |    150 |  995.54M | 6636934 |
| trim.R     |    150 |   990.9M | 6615308 |
| Q20L60     |    150 |  979.32M | 6566749 |
| Q25L60     |    150 |  947.87M | 6402446 |
| Q30L60     |    150 |  892.85M | 6090219 |


Table: statTrimReads

| Name     | N50 |     Sum |       # |
|:---------|----:|--------:|--------:|
| clumpify | 150 | 992.93M | 6619558 |
| trim     | 150 |  990.9M | 6615308 |
| filter   | 150 |  990.9M | 6615308 |
| R1       | 150 | 495.67M | 3307654 |
| R2       | 150 | 495.23M | 3307654 |
| Rs       |   0 |       0 |       0 |


```text
#R.trim
#Matched    6050    0.09140%
#Name   Reads   ReadsPct
```

```text
#R.filter
#Matched    0   0.00000%
#Name   Reads   ReadsPct
```

```text
#R.peaks
#k  31
#unique_kmers   38213108
#main_peak  53
#genome_size    14057090
#haploid_genome_size    14057090
#fold_coverage  53
#haploid_fold_coverage  53
#ploidy 1
#percent_repeat 19.456
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |     Sum |       # |
|:--------------|----:|--------:|--------:|
| clumped       | 150 | 990.89M | 6615240 |
| ecco          | 150 | 990.89M | 6615240 |
| eccc          | 150 | 990.89M | 6615240 |
| ecct          | 150 | 947.56M | 6322176 |
| extended      | 190 |    1.2G | 6322176 |
| merged.raw    | 387 | 902.24M | 2398220 |
| unmerged.raw  | 190 | 287.35M | 1525736 |
| unmerged.trim | 190 | 287.35M | 1525732 |
| M1            | 387 | 900.07M | 2392217 |
| U1            | 190 | 144.09M |  762866 |
| U2            | 190 | 143.25M |  762866 |
| Us            |   0 |       0 |       0 |
| M.cor         | 354 |   1.19G | 6310166 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 249.2 |    255 |  27.7 |         19.23% |
| M.ihist.merge.txt  | 376.2 |    371 |  72.7 |         75.87% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% |  Kmer |  RealG |   EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|------:|-------:|-------:|---------:|----------:|
| Q0L0.R   |  81.5 |   73.5 |    9.82% | "105" | 12.16M | 11.92M |     0.98 | 0:01'39'' |
| Q20L60.R |  80.6 |   73.6 |    8.64% | "105" | 12.16M | 11.86M |     0.98 | 0:01'38'' |
| Q25L60.R |  78.0 |   73.2 |    6.10% | "105" | 12.16M | 11.66M |     0.96 | 0:01'38'' |
| Q30L60.R |  73.5 |   70.7 |    3.76% | "105" | 12.16M |  11.6M |     0.95 | 0:01'34'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|-----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  79.60% |     11006 |    11M | 1566 |       107 | 326.14K | 3391 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'21'' |
| Q0L0X60P000    |   60.0 |  78.61% |      8467 | 10.88M | 1887 |        89 | 361.06K | 4013 |   50.0 | 2.0 |  14.7 |  84.0 | "31,41,51,61,71,81" | 0:02'56'' | 0:01'25'' |
| Q0L0XallP000   |   73.5 |  78.27% |      7662 | 10.84M | 2007 |        84 |    371K | 4249 |   62.0 | 3.0 |  17.7 | 106.5 | "31,41,51,61,71,81" | 0:03'27'' | 0:01'26'' |
| Q20L60X40P000  |   40.0 |  80.06% |     11397 | 11.04M | 1487 |        99 | 295.25K | 3237 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'21'' |
| Q20L60X60P000  |   60.0 |  78.91% |      8870 | 10.95M | 1814 |        85 | 314.12K | 3845 |   51.0 | 3.0 |  14.0 |  90.0 | "31,41,51,61,71,81" | 0:02'55'' | 0:01'25'' |
| Q20L60XallP000 |   73.6 |  78.50% |      8377 | 10.89M | 1932 |        82 | 340.25K | 4068 |   62.0 | 3.0 |  17.7 | 106.5 | "31,41,51,61,71,81" | 0:03'27'' | 0:01'27'' |
| Q25L60X40P000  |   40.0 |  82.20% |     18715 | 11.14M | 1019 |      1071 | 251.21K | 2359 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'28'' |
| Q25L60X60P000  |   60.0 |  81.07% |     15722 | 11.11M | 1189 |      1039 | 246.91K | 2605 |   51.0 | 2.0 |  15.0 |  85.5 | "31,41,51,61,71,81" | 0:02'55'' | 0:01'25'' |
| Q25L60XallP000 |   73.2 |  80.76% |     14598 |  11.1M | 1242 |      1019 | 240.74K | 2689 |   62.0 | 3.0 |  17.7 | 106.5 | "31,41,51,61,71,81" | 0:03'24'' | 0:01'30'' |
| Q30L60X40P000  |   40.0 |  84.54% |     21333 | 11.15M |  891 |      1052 |  250.7K | 2237 |   34.0 | 1.0 |  10.3 |  55.5 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'28'' |
| Q30L60X60P000  |   60.0 |  83.22% |     18603 | 11.15M |  983 |      1056 | 226.81K | 2280 |   51.0 | 2.0 |  15.0 |  85.5 | "31,41,51,61,71,81" | 0:02'55'' | 0:01'31'' |
| Q30L60XallP000 |   70.7 |  82.93% |     18093 | 11.13M | 1030 |      1056 | 230.26K | 2347 |   60.0 | 2.0 |  18.0 |  99.0 | "31,41,51,61,71,81" | 0:03'18'' | 0:01'29'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|-----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  91.09% |     23999 | 11.17M |  760 |      1157 | 290.37K | 2270 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:01'10'' | 0:01'36'' |
| Q0L0X60P000    |   60.0 |  89.56% |     19164 | 11.13M |  960 |      1077 | 283.96K | 2311 |   50.0 | 2.0 |  14.7 |  84.0 | "31,41,51,61,71,81" | 0:01'20'' | 0:01'31'' |
| Q0L0XallP000   |   73.5 |  88.93% |     15375 | 11.11M | 1148 |      1071 | 297.03K | 2552 |   62.0 | 3.0 |  17.7 | 106.5 | "31,41,51,61,71,81" | 0:01'32'' | 0:01'31'' |
| Q20L60X40P000  |   40.0 |  91.36% |     25531 | 11.18M |  723 |      1260 |  254.9K | 2178 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:01'08'' | 0:01'37'' |
| Q20L60X60P000  |   60.0 |  89.60% |     19765 | 11.16M |  917 |      1148 | 254.14K | 2194 |   51.0 | 2.0 |  15.0 |  85.5 | "31,41,51,61,71,81" | 0:01'21'' | 0:01'27'' |
| Q20L60XallP000 |   73.6 |  88.99% |     15699 | 11.11M | 1120 |      1081 | 289.21K | 2501 |   62.0 | 2.0 |  18.7 | 102.0 | "31,41,51,61,71,81" | 0:01'26'' | 0:01'29'' |
| Q25L60X40P000  |   40.0 |  92.11% |     28664 | 11.18M |  646 |      1260 | 280.38K | 2017 |   34.0 | 1.0 |  10.3 |  55.5 | "31,41,51,61,71,81" | 0:01'08'' | 0:01'43'' |
| Q25L60X60P000  |   60.0 |  90.73% |     26218 | 11.18M |  725 |      2215 |  260.6K | 1837 |   51.0 | 2.0 |  15.0 |  85.5 | "31,41,51,61,71,81" | 0:01'20'' | 0:01'29'' |
| Q25L60XallP000 |   73.2 |  89.99% |     22471 | 11.17M |  831 |      1683 | 249.06K | 1941 |   62.0 | 2.0 |  18.7 | 102.0 | "31,41,51,61,71,81" | 0:01'26'' | 0:01'29'' |
| Q30L60X40P000  |   40.0 |  92.68% |     29460 | 11.19M |  651 |      1273 | 269.58K | 2189 |   34.0 | 1.0 |  10.3 |  55.5 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'49'' |
| Q30L60X60P000  |   60.0 |  91.58% |     27292 | 11.19M |  680 |      1976 |  237.3K | 1945 |   51.0 | 2.0 |  15.0 |  85.5 | "31,41,51,61,71,81" | 0:01'20'' | 0:01'40'' |
| Q30L60XallP000 |   70.7 |  91.14% |     25656 | 11.18M |  712 |      1671 | 234.19K | 1924 |   60.0 | 2.0 |  18.0 |  99.0 | "31,41,51,61,71,81" | 0:01'25'' | 0:01'34'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|-----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  86.21% |     16878 | 11.06M | 1088 |       152 | 306.97K | 2309 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:02'38'' | 0:01'21'' |
| MRX40P001  |   40.0 |  84.20% |     16857 | 11.03M | 1069 |       158 | 314.89K | 2281 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:02'36'' | 0:01'19'' |
| MRX60P000  |   60.0 |  82.82% |     13426 |    11M | 1312 |       116 |  318.7K | 2766 |   51.0 | 3.0 |  14.0 |  90.0 | "31,41,51,61,71,81" | 0:03'33'' | 0:01'21'' |
| MRX80P000  |   80.0 |  81.01% |     12126 | 10.93M | 1461 |       113 | 359.88K | 3062 |   68.0 | 4.0 |  18.7 | 120.0 | "31,41,51,61,71,81" | 0:04'30'' | 0:01'24'' |
| MRXallP000 |   97.9 |  80.42% |     11042 | 10.94M | 1548 |       102 | 336.96K | 3235 |   83.0 | 5.0 |  20.0 | 147.0 | "31,41,51,61,71,81" | 0:05'21'' | 0:01'27'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|-----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  89.38% |     35974 | 11.16M |  553 |      1152 | 227.33K | 1236 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:01'17'' | 0:01'21'' |
| MRX40P001  |   40.0 |  89.04% |     34185 | 11.13M |  581 |      1138 | 245.86K | 1240 |   34.0 | 1.0 |  10.3 |  55.5 | "31,41,51,61,71,81" | 0:01'17'' | 0:01'21'' |
| MRX60P000  |   60.0 |  88.89% |     26720 | 11.14M |  715 |      1122 | 253.28K | 1517 |   51.0 | 2.0 |  15.0 |  85.5 | "31,41,51,61,71,81" | 0:01'29'' | 0:01'24'' |
| MRX80P000  |   80.0 |  88.38% |     20744 |  11.1M |  884 |      1038 | 269.63K | 1851 |   68.0 | 3.0 |  19.7 | 115.5 | "31,41,51,61,71,81" | 0:01'40'' | 0:01'23'' |
| MRXallP000 |   97.9 |  88.15% |     18021 | 11.11M | 1025 |      1039 | 252.49K | 2139 |   83.0 | 4.0 |  20.0 | 142.5 | "31,41,51,61,71,81" | 0:01'55'' | 0:01'23'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |    Sum |   # | N50Others |     Sum |   # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|-------:|----:|----------:|--------:|----:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  83.04% |     45312 | 11.17M | 437 |      4408 |  357.7K | 148 |   62.0 | 2.0 |  18.7 | 102.0 | 0:01'45'' |
| 7_mergeKunitigsAnchors   |  87.99% |     25473 | 11.16M | 723 |      2249 | 269.67K | 149 |   62.0 | 2.0 |  18.7 | 102.0 | 0:02'24'' |
| 7_mergeMRKunitigsAnchors |  86.36% |     22825 | 11.08M | 804 |      1810 | 210.88K | 123 |   62.0 | 2.0 |  18.7 | 102.0 | 0:02'10'' |
| 7_mergeMRTadpoleAnchors  |  86.46% |     42887 | 11.14M | 465 |      3723 | 222.27K | 102 |   62.0 | 2.0 |  18.7 | 102.0 | 0:02'07'' |
| 7_mergeTadpoleAnchors    |  88.78% |     37694 | 11.19M | 499 |      6149 | 307.29K | 115 |   62.0 | 2.0 |  18.7 | 102.0 | 0:02'34'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |    Sum |   # | N50Others |     Sum |   # | median | MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|-------:|----:|----------:|--------:|----:|-------:|----:|------:|------:|----------:|
| 8_spades     |  92.23% |     86250 | 11.29M | 234 |      5078 | 238.75K | 438 |   62.0 | 2.0 |  18.7 | 102.0 | 0:01'23'' |
| 8_spades_MR  |  94.36% |    117469 |  11.4M | 201 |      5239 |  201.4K | 397 |   84.0 | 3.0 |  20.0 | 139.5 | 0:01'24'' |
| 8_megahit    |  92.51% |     48143 | 11.21M | 423 |      2897 | 251.66K | 895 |   62.0 | 2.0 |  18.7 | 102.0 | 0:01'25'' |
| 8_megahit_MR |  93.52% |     86242 | 11.44M | 279 |      4348 | 203.63K | 584 |   84.0 | 3.0 |  20.0 | 139.5 | 0:01'22'' |
| 8_platanus   |  83.47% |     77257 | 11.33M | 256 |      2889 | 185.92K | 428 |   62.0 | 2.0 |  18.7 | 102.0 | 0:01'23'' |


Table: statFinal

| Name                     |    N50 |      Sum |    # |
|:-------------------------|-------:|---------:|-----:|
| Genome                   | 924431 | 12157105 |   17 |
| Paralogs                 |   3851 |  1059148 |  366 |
| 7_mergeAnchors.anchors   |  45312 | 11165036 |  437 |
| 7_mergeAnchors.others    |   4408 |   357697 |  148 |
| spades.contig            | 120316 | 11706235 | 1101 |
| spades.scaffold          | 132560 | 11706875 | 1082 |
| spades.non-contained     | 122873 | 11528443 |  204 |
| spades_MR.contig         | 125460 | 11732806 |  665 |
| spades_MR.scaffold       | 132728 | 11733422 |  655 |
| spades_MR.non-contained  | 126627 | 11605087 |  196 |
| megahit.contig           |  49142 | 11641716 |  955 |
| megahit.non-contained    |  49287 | 11462033 |  472 |
| megahit_MR.contig        |  84455 | 12007715 | 1274 |
| megahit_MR.non-contained |  86307 | 11640863 |  305 |
| platanus.contig          |  39177 | 12113080 | 4268 |
| platanus.scaffold        | 153178 | 11959734 | 3270 |
| platanus.non-contained   | 155016 | 11514764 |  172 |


## s288c_HiSeq: symlink

```bash
mkdir -p ~/data/anchr/s288c_HiSeq/1_genome
cd ~/data/anchr/s288c_HiSeq/1_genome

ln -fs ../../s288c/1_genome/genome.fa genome.fa
ln -fs ../../s288c/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/s288c_HiSeq/2_illumina
cd ~/data/anchr/s288c_HiSeq/2_illumina

ln -fs ../../s288c/2_illumina/SRR4074255_1.fastq.gz R1.fq.gz
ln -fs ../../s288c/2_illumina/SRR4074255_2.fastq.gz R2.fq.gz

```

## s288c_HiSeq: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=s288c_HiSeq

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 12157105 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --sgastats \
    --trim2 "--dedupe" \
    --qual2 "20 25 30" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 80" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g

```

## s288c_HiSeq: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=s288c_HiSeq

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median | STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|------:|-------------------------------:|
| R.genome.bbtools  | 356.5 |    320 | 484.3 |                         45.78% |
| R.tadpole.bbtools | 339.2 |    309 | 144.5 |                         43.32% |
| R.genome.picard   | 352.1 |    322 | 142.5 |                             FR |
| R.tadpole.picard  | 342.8 |    313 | 141.4 |                             FR |


Table: statSgaStats

| Library | incorrectBases | perfectReads | overlapDepth |
|:--------|---------------:|-------------:|-------------:|
| R       |          0.23% |       88.56% |      2188.74 |


Table: statReads

| Name       |    N50 |      Sum |        # |
|:-----------|-------:|---------:|---------:|
| Genome     | 924431 | 12157105 |       17 |
| Paralogs   |   3851 |  1059148 |      366 |
| Illumina.R |    151 |    2.94G | 19464114 |
| trim.R     |    150 |    2.68G | 18163836 |
| Q20L60     |    150 |    2.63G | 17869582 |
| Q25L60     |    150 |    2.52G | 17275353 |
| Q30L60     |    150 |    2.37G | 16421056 |


Table: statTrimReads

| Name     | N50 |   Sum |        # |
|:---------|----:|------:|---------:|
| clumpify | 151 | 2.78G | 18397208 |
| trim     | 150 | 2.68G | 18163836 |
| filter   | 150 | 2.68G | 18163836 |
| R1       | 150 | 1.34G |  9081918 |
| R2       | 150 | 1.34G |  9081918 |
| Rs       |   0 |     0 |        0 |


```text
#R.trim
#Matched    976734  5.30914%
#Name   Reads   ReadsPct
I5_Nextera_Transposase_1    571978  3.10905%
I7_Nextera_Transposase_1    393836  2.14074%
```

```text
#R.filter
#Matched    0   0.00000%
#Name   Reads   ReadsPct
```

```text
#R.peaks
#k  31
#unique_kmers   89032436
#main_peak  165
#genome_size    11714528
#haploid_genome_size    11714528
#fold_coverage  165
#haploid_fold_coverage  165
#ploidy 1
#percent_repeat 10.541
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 150 |   2.68G | 18136794 |
| ecco          | 150 |   2.68G | 18136794 |
| eccc          | 150 |   2.68G | 18136794 |
| ecct          | 150 |   2.57G | 17415786 |
| extended      | 190 |   3.25G | 17415786 |
| merged.raw    | 356 |    2.4G |  7289590 |
| unmerged.raw  | 190 | 527.76M |  2836606 |
| unmerged.trim | 190 | 527.76M |  2836598 |
| M1            | 356 |   2.35G |  7138027 |
| U1            | 190 |  267.2M |  1418299 |
| U2            | 190 | 260.56M |  1418299 |
| Us            |   0 |       0 |        0 |
| M.cor         | 327 |   2.88G | 17112652 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 211.2 |    221 |  53.0 |         39.55% |
| M.ihist.merge.txt  | 328.9 |    326 |  95.0 |         83.71% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% |  Kmer |  RealG |   EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|------:|-------:|-------:|---------:|----------:|
| Q0L0.R   | 220.4 |  197.9 |   10.20% | "105" | 12.16M | 12.44M |     1.02 | 0:04'16'' |
| Q20L60.R | 216.0 |  197.7 |    8.46% | "105" | 12.16M | 12.14M |     1.00 | 0:04'10'' |
| Q25L60.R | 207.2 |  195.1 |    5.84% | "105" | 12.16M | 11.84M |     0.97 | 0:04'00'' |
| Q30L60.R | 195.2 |  186.0 |    4.71% | "105" | 12.16M | 11.72M |     0.96 | 0:03'47'' |


Table: statKunitigsAnchors.md

| Name          | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |   Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:--------------|-------:|--------:|----------:|-------:|-----:|----------:|------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000   |   40.0 |  87.86% |      4916 | 10.08M | 2700 |       912 | 1.56M | 6179 |   37.0 | 4.0 |   8.3 |  73.5 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'38'' |
| Q0L0X40P001   |   40.0 |  87.94% |      3737 |  9.61M | 3145 |      1008 | 2.22M | 6855 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'38'' |
| Q0L0X40P002   |   40.0 |  87.94% |      3685 |  9.58M | 3187 |      1014 | 2.25M | 6863 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'35'' |
| Q0L0X40P003   |   40.0 |  87.99% |      3785 |  9.63M | 3104 |      1022 |  2.2M | 6746 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'38'' |
| Q0L0X80P000   |   80.0 |  86.02% |      4780 | 10.13M | 2757 |       902 | 1.36M | 5542 |   74.0 | 7.0 |  17.7 | 142.5 | "31,41,51,61,71,81" | 0:03'37'' | 0:01'36'' |
| Q0L0X80P001   |   80.0 |  85.89% |      4106 |  9.87M | 2993 |       979 | 1.64M | 5762 |   73.0 | 6.0 |  18.3 | 136.5 | "31,41,51,61,71,81" | 0:03'37'' | 0:01'36'' |
| Q20L60X40P000 |   40.0 |  88.36% |      3847 |  9.63M | 3110 |      1039 | 2.28M | 6668 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'37'' |
| Q20L60X40P001 |   40.0 |  88.03% |      3779 |  9.61M | 3094 |      1046 | 2.23M | 6549 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'12'' | 0:01'38'' |
| Q20L60X40P002 |   40.0 |  88.07% |      3754 |  9.64M | 3132 |      1002 | 2.21M | 6671 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'35'' |
| Q20L60X40P003 |   40.0 |  87.94% |      3894 |  9.68M | 3090 |      1024 | 2.17M | 6563 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'37'' |
| Q20L60X80P000 |   80.0 |  86.55% |      4937 | 10.19M | 2698 |       909 | 1.33M | 5308 |   74.0 | 7.0 |  17.7 | 142.5 | "31,41,51,61,71,81" | 0:03'36'' | 0:01'35'' |
| Q20L60X80P001 |   80.0 |  86.55% |      4961 | 10.19M | 2694 |       868 | 1.31M | 5345 |   74.0 | 7.0 |  17.7 | 142.5 | "31,41,51,61,71,81" | 0:03'36'' | 0:01'40'' |
| Q25L60X40P000 |   40.0 |  88.74% |      3769 |  9.69M | 3152 |      1028 | 2.24M | 6884 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'10'' | 0:01'40'' |
| Q25L60X40P001 |   40.0 |  88.74% |      3884 |  9.69M | 3066 |      1030 | 2.22M | 6723 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'37'' |
| Q25L60X40P002 |   40.0 |  88.70% |      3887 |  9.68M | 3086 |      1036 | 2.18M | 6644 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'10'' | 0:01'40'' |
| Q25L60X40P003 |   40.0 |  88.87% |      3915 |  9.67M | 3082 |      1037 | 2.21M | 6733 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'37'' |
| Q25L60X80P000 |   80.0 |  86.94% |      4525 | 10.05M | 2793 |       970 | 1.47M | 5390 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:03'36'' | 0:01'39'' |
| Q25L60X80P001 |   80.0 |  87.48% |      5185 |  10.2M | 2603 |       924 | 1.35M | 5373 |   74.0 | 7.0 |  17.7 | 142.5 | "31,41,51,61,71,81" | 0:03'35'' | 0:01'41'' |
| Q30L60X40P000 |   40.0 |  89.37% |      3913 |   9.7M | 3086 |      1039 | 2.22M | 6707 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'40'' |
| Q30L60X40P001 |   40.0 |  89.25% |      3940 |  9.65M | 3040 |      1064 | 2.27M | 6739 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'10'' | 0:01'40'' |
| Q30L60X40P002 |   40.0 |  89.18% |      4069 |  9.76M | 2989 |      1042 | 2.13M | 6580 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'41'' |
| Q30L60X40P003 |   40.0 |  89.39% |      3979 |  9.72M | 3019 |      1021 | 2.19M | 6703 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'11'' | 0:01'38'' |
| Q30L60X80P000 |   80.0 |  88.03% |      4692 | 10.06M | 2772 |       935 | 1.57M | 5655 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:03'34'' | 0:01'42'' |
| Q30L60X80P001 |   80.0 |  88.01% |      4765 | 10.09M | 2762 |       962 | 1.54M | 5620 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:03'34'' | 0:01'45'' |


Table: statTadpoleAnchors.md

| Name          | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |   Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:--------------|-------:|--------:|----------:|-------:|-----:|----------:|------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000   |   40.0 |  91.70% |      4038 |  9.75M | 3024 |      1010 |  2.1M | 6881 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'39'' |
| Q0L0X40P001   |   40.0 |  91.65% |      5564 | 10.23M | 2508 |       890 | 1.41M | 6238 |   37.0 | 4.0 |   8.3 |  73.5 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'40'' |
| Q0L0X40P002   |   40.0 |  91.73% |      3961 |  9.74M | 3037 |      1016 | 2.13M | 6932 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'40'' |
| Q0L0X40P003   |   40.0 |  91.88% |      4135 |  9.78M | 2945 |      1014 | 2.14M | 6839 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'40'' |
| Q0L0X80P000   |   80.0 |  92.37% |      5222 | 10.18M | 2598 |       932 | 1.71M | 6094 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'30'' | 0:01'55'' |
| Q0L0X80P001   |   80.0 |  92.23% |      5154 | 10.16M | 2585 |       911 | 1.65M | 6002 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'33'' | 0:01'51'' |
| Q20L60X40P000 |   40.0 |  92.06% |      4105 |   9.8M | 2971 |      1021 | 2.17M | 6911 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'42'' |
| Q20L60X40P001 |   40.0 |  91.87% |      4060 |  9.74M | 2957 |      1011 |  2.1M | 6731 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'07'' | 0:01'36'' |
| Q20L60X40P002 |   40.0 |  92.02% |      3999 |  9.78M | 3004 |       997 | 2.12M | 6949 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'10'' | 0:01'39'' |
| Q20L60X40P003 |   40.0 |  91.74% |      5468 | 10.28M | 2482 |       873 | 1.38M | 6164 |   37.0 | 4.0 |   8.3 |  73.5 | "31,41,51,61,71,81" | 0:01'10'' | 0:01'41'' |
| Q20L60X80P000 |   80.0 |  92.58% |      5164 | 10.21M | 2615 |       892 | 1.69M | 6112 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'32'' | 0:01'54'' |
| Q20L60X80P001 |   80.0 |  92.47% |      5194 |  10.2M | 2584 |       924 | 1.68M | 6063 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'30'' | 0:01'49'' |
| Q25L60X40P000 |   40.0 |  92.19% |      4076 |   9.8M | 3010 |      1007 | 2.08M | 7006 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'41'' |
| Q25L60X40P001 |   40.0 |  92.22% |      4085 |  9.81M | 2974 |      1004 | 2.09M | 7003 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'39'' |
| Q25L60X40P002 |   40.0 |  92.20% |      4160 |  9.82M | 2968 |      1031 | 2.07M | 6797 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'13'' | 0:01'37'' |
| Q25L60X40P003 |   40.0 |  92.04% |      5686 | 10.28M | 2473 |       871 | 1.36M | 6129 |   37.0 | 4.0 |   8.3 |  73.5 | "31,41,51,61,71,81" | 0:01'08'' | 0:01'39'' |
| Q25L60X80P000 |   80.0 |  92.94% |      5213 | 10.25M | 2551 |       932 | 1.64M | 6127 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'33'' | 0:01'53'' |
| Q25L60X80P001 |   80.0 |  92.97% |      5278 | 10.19M | 2552 |       982 | 1.72M | 6128 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'32'' | 0:01'55'' |
| Q30L60X40P000 |   40.0 |  92.38% |      4131 |  9.77M | 2963 |      1035 | 2.14M | 6882 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'09'' | 0:01'41'' |
| Q30L60X40P001 |   40.0 |  92.35% |      4169 |  9.75M | 2968 |      1034 | 2.16M | 6954 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'08'' | 0:01'39'' |
| Q30L60X40P002 |   40.0 |  92.17% |      4245 |  9.85M | 2926 |      1018 | 1.98M | 6715 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'10'' | 0:01'40'' |
| Q30L60X40P003 |   40.0 |  92.32% |      4245 |  9.82M | 2920 |       992 |    2M | 6779 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'10'' | 0:01'38'' |
| Q30L60X80P000 |   80.0 |  93.24% |      5405 | 10.24M | 2546 |       890 | 1.68M | 6245 |   75.0 | 6.0 |  19.0 | 139.5 | "31,41,51,61,71,81" | 0:01'36'' | 0:01'58'' |
| Q30L60X80P001 |   80.0 |  93.15% |      5723 |  10.3M | 2454 |       883 | 1.56M | 6030 |   75.0 | 6.0 |  19.0 | 139.5 | "31,41,51,61,71,81" | 0:01'31'' | 0:01'56'' |


Table: statMRKunitigsAnchors.md

| Name      | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |     Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:----------|-------:|--------:|----------:|-------:|-----:|----------:|--------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000 |   40.0 |  85.72% |      4749 |  9.98M | 2728 |       995 |   1.45M | 4420 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'37'' | 0:01'23'' |
| MRX40P001 |   40.0 |  85.51% |      4723 |  9.97M | 2758 |      1009 |   1.49M | 4483 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'38'' | 0:01'25'' |
| MRX40P002 |   40.0 |  85.41% |      4630 |  9.95M | 2743 |       988 |    1.5M | 4498 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'38'' | 0:01'24'' |
| MRX40P003 |   40.0 |  85.13% |      4698 |  9.95M | 2728 |       984 |   1.49M | 4365 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'37'' | 0:01'23'' |
| MRX40P004 |   40.0 |  85.39% |      4759 |  9.96M | 2719 |      1024 |   1.52M | 4411 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:02'38'' | 0:01'25'' |
| MRX80P000 |   80.0 |  83.77% |      6213 | 10.33M | 2299 |       842 | 975.19K | 3860 |   74.0 | 7.0 |  17.7 | 142.5 | "31,41,51,61,71,81" | 0:04'31'' | 0:01'24'' |
| MRX80P001 |   80.0 |  83.45% |      6162 | 10.31M | 2338 |       880 |  988.1K | 3887 |   74.0 | 7.0 |  17.7 | 142.5 | "31,41,51,61,71,81" | 0:04'30'' | 0:01'23'' |


Table: statMRTadpoleAnchors.md

| Name      | CovCor | Mapped% | N50Anchor |    Sum |    # | N50Others |   Sum |    # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:----------|-------:|--------:|----------:|-------:|-----:|----------:|------:|-----:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000 |   40.0 |  90.57% |      5153 | 10.12M | 2600 |       953 | 1.57M | 4922 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'16'' | 0:01'35'' |
| MRX40P001 |   40.0 |  90.79% |      4996 | 10.07M | 2649 |       986 | 1.68M | 5048 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'17'' | 0:01'34'' |
| MRX40P002 |   40.0 |  90.64% |      5108 | 10.08M | 2579 |       973 | 1.61M | 4918 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'17'' | 0:01'33'' |
| MRX40P003 |   40.0 |  90.84% |      5160 | 10.08M | 2592 |       923 | 1.63M | 5006 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'20'' | 0:01'37'' |
| MRX40P004 |   40.0 |  90.28% |      5113 | 10.07M | 2595 |       992 | 1.58M | 4773 |   37.0 | 3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:01'25'' | 0:01'33'' |
| MRX80P000 |   80.0 |  89.25% |      6198 | 10.34M | 2285 |       878 | 1.11M | 3779 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'44'' | 0:01'30'' |
| MRX80P001 |   80.0 |  89.16% |      6246 | 10.38M | 2271 |       890 | 1.11M | 3767 |   74.0 | 6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:01'44'' | 0:01'30'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |    Sum |    # | N50Others |   Sum |    # | median |  MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|-------:|-----:|----------:|------:|-----:|-------:|-----:|------:|------:|----------:|
| 7_mergeAnchors           |  87.98% |     15838 | 11.04M | 1214 |      1865 | 4.58M | 2838 |  185.0 | 15.0 |  20.0 | 345.0 | 0:02'11'' |
| 7_mergeKunitigsAnchors   |  93.15% |     11881 | 10.99M | 1532 |      1732 | 4.64M | 3068 |  186.0 | 18.0 |  20.0 | 360.0 | 0:03'46'' |
| 7_mergeMRKunitigsAnchors |  90.74% |     11000 | 10.86M | 1551 |      1472 | 2.22M | 1666 |  185.0 | 16.0 |  20.0 | 349.5 | 0:02'58'' |
| 7_mergeMRTadpoleAnchors  |  90.92% |     11600 | 10.96M | 1508 |      1449 |  2.2M | 1672 |  185.0 | 16.0 |  20.0 | 349.5 | 0:02'55'' |
| 7_mergeTadpoleAnchors    |  93.06% |     13491 | 11.01M | 1411 |      1666 | 4.38M | 2984 |  185.0 | 17.0 |  20.0 | 354.0 | 0:03'41'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |    Sum |   # | N50Others |     Sum |    # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|-------:|----:|----------:|--------:|-----:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  92.44% |     38385 | 11.18M | 597 |      1374 | 321.66K |  874 |  185.0 | 13.0 |  20.0 | 336.0 | 0:01'42'' |
| 8_spades_MR  |  92.77% |     54113 | 11.28M | 504 |      1423 |  285.8K |  778 |  223.0 | 15.0 |  20.0 | 402.0 | 0:01'39'' |
| 8_megahit    |  90.24% |     27923 |  11.1M | 789 |      1247 | 326.17K | 1327 |  184.0 | 13.0 |  20.0 | 334.5 | 0:01'41'' |
| 8_megahit_MR |  92.42% |     41053 | 11.35M | 554 |      1356 | 259.74K |  998 |  223.0 | 17.0 |  20.0 | 411.0 | 0:01'39'' |
| 8_platanus   |  89.43% |     24429 | 11.06M | 895 |      1045 | 278.25K | 1420 |  186.0 | 12.0 |  20.0 | 333.0 | 0:01'40'' |


Table: statFinal

| Name                     |    N50 |      Sum |    # |
|:-------------------------|-------:|---------:|-----:|
| Genome                   | 924431 | 12157105 |   17 |
| Paralogs                 |   3851 |  1059148 |  366 |
| 7_mergeAnchors.anchors   |  15838 | 11040979 | 1214 |
| 7_mergeAnchors.others    |   1865 |  4578703 | 2838 |
| spades.contig            | 100082 | 11686050 | 1204 |
| spades.scaffold          | 107598 | 11686780 | 1176 |
| spades.non-contained     | 102809 | 11499948 |  278 |
| spades_MR.contig         |  98750 | 11754736 | 1017 |
| spades_MR.scaffold       | 117682 | 11758642 |  979 |
| spades_MR.non-contained  |  99683 | 11565634 |  275 |
| megahit.contig           |  37720 | 11623866 | 1050 |
| megahit.non-contained    |  39093 | 11421408 |  539 |
| megahit_MR.contig        |  48765 | 12102411 | 1816 |
| megahit_MR.non-contained |  50037 | 11606236 |  448 |
| platanus.contig          |   4797 | 12324154 | 6839 |
| platanus.scaffold        |  38569 | 11887603 | 3658 |
| platanus.non-contained   |  40566 | 11339030 |  527 |


# *Drosophila melanogaster* iso-1

* Genome: [Ensembl 82](http://sep2015.archive.ensembl.org/Drosophila_melanogaster/Info/Index)
* Proportion of paralogs (> 1000 bp): 0.0661

## iso_1: download

* Reference genome

```bash
mkdir -p ~/data/anchr/iso_1/1_genome
cd ~/data/anchr/iso_1/1_genome

wget -N ftp://ftp.ensembl.org/pub/release-82/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa.gz
faops order Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa.gz \
    <(for chr in {2L,2R,3L,3R,4,X,Y,dmel_mitochondrion_genome}; do echo $chr; done) \
    genome.fa

cp ~/data/anchr/paralogs/model/Results/iso_1/iso_1.multi.fas 1_genome/paralogs.fas
```

* Illumina

    * [ERX645969](https://www.ncbi.nlm.nih.gov/sra/?term=ERX645969)

        ERR701706-ERR701711 HiSeq 2000

    * [ERX645975](https://www.ncbi.nlm.nih.gov/sra/?term=ERX645975)

        ERR701712 ERR701713 HiSeq 2500 laboratory strain nos-GAL4; UAS-DCR2

    * SRX081846 labels ycnbwsp instead of iso-1.

```bash
mkdir -p ~/data/anchr/iso_1/2_illumina
cd ~/data/anchr/iso_1/2_illumina

cat << EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701706/ERR701706_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701706/ERR701706_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701707/ERR701707_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701707/ERR701707_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701708/ERR701708_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701708/ERR701708_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701709/ERR701709_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701709/ERR701709_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701710/ERR701710_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701710/ERR701710_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701711/ERR701711_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701711/ERR701711_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701712/ERR701712_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701712/ERR701712_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701713/ERR701713_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR701/ERR701713/ERR701713_2.fastq.gz
EOF

aria2c -x 9 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
a8a6c25c6c5c0fd0614cf922c2d362ce ERR701706_1.fastq.gz
7505f2615e64b9a23aa7b94d3fa0424b ERR701706_2.fastq.gz
f936e6a30cadb5ce23ab6fd3c37bbaed ERR701707_1.fastq.gz
bfd0a93a6a8381502a538a8154ee3837 ERR701707_2.fastq.gz
d731ac125513744c6d3225e97c3d03f5 ERR701708_1.fastq.gz
880638916636194987184d46db86b88e ERR701708_2.fastq.gz
d92e991965b291d1f642a8cb021f816a ERR701709_1.fastq.gz
fbd57f2c1b06f4b8e2f06f8f9df51758 ERR701709_2.fastq.gz
62abb11673775412afdceabf49360abc ERR701710_1.fastq.gz
dc4022980881e459b565997574311299 ERR701710_2.fastq.gz
3fca504995f8fac6083a916a2af2d702 ERR701711_1.fastq.gz
30b14bd452a5386efa2da48c262815b9 ERR701711_2.fastq.gz
a6066532b411192be13e9ff5231092f8 ERR701712_1.fastq.gz
d6ca4111786d6d554a615ea3a9a76137 ERR701712_2.fastq.gz
df6285d1c8f8f1a62396064e68eaba65 ERR701713_1.fastq.gz
668c7a8e70b1186584367609112f7909 ERR701713_2.fastq.gz
EOF

md5sum --check sra_md5.txt

pigz -d -c ERR7017{06..11}_1.fastq.gz | pigz > HiSeq_2000_1.fq.gz
pigz -d -c ERR7017{06..11}_2.fastq.gz | pigz > HiSeq_2000_2.fq.gz

pigz -d -c ERR7017{12,13}_1.fastq.gz | pigz > HiSeq_2500_1.fq.gz
pigz -d -c ERR7017{12,13}_2.fastq.gz | pigz > HiSeq_2500_2.fq.gz

```

* PacBio

    PacBio provides a dataset of *D. melanogaster* strain
    [ISO1](https://github.com/PacificBiosciences/DevNet/wiki/Drosophila-sequence-and-assembly), the
    same stock used in the official BDGP reference assemblies. This is gathered with RS II and P5C3.

```bash
mkdir -p ~/data/anchr/iso_1/3_pacbio
cd ~/data/anchr/iso_1/3_pacbio

cat <<EOF > tgz.txt
https://s3.amazonaws.com/datasets.pacb.com/2014/Drosophila/raw/Dro1_24NOV2013_398.tgz
https://s3.amazonaws.com/datasets.pacb.com/2014/Drosophila/raw/Dro2_25NOV2013_399.tgz
https://s3.amazonaws.com/datasets.pacb.com/2014/Drosophila/raw/Dro3_26NOV2013_400.tgz
https://s3.amazonaws.com/datasets.pacb.com/2014/Drosophila/raw/Dro4_28NOV2013_401.tgz
https://s3.amazonaws.com/datasets.pacb.com/2014/Drosophila/raw/Dro5_29NOV2013_402.tgz
https://s3.amazonaws.com/datasets.pacb.com/2014/Drosophila/raw/Dro6_1DEC2013_403.tgz
EOF
aria2c -x 9 -s 3 -c -i tgz.txt

# untar
mkdir -p ~/data/anchr/iso_1/3_pacbio/untar
cd ~/data/anchr/iso_1/3_pacbio
tar xvfz Dro1_24NOV2013_398.tgz --directory untar
#tar xvfz Dro2_25NOV2013_399.tgz --directory untar
#tar xvfz Dro3_26NOV2013_400.tgz --directory untar
#tar xvfz Dro4_28NOV2013_401.tgz --directory untar
tar xvfz Dro5_29NOV2013_402.tgz --directory untar
tar xvfz Dro6_1DEC2013_403.tgz --directory untar

find . -type f -name "*.ba?.h5" | parallel -j 1 "mv {} untar" 

# convert .bax.h5 to .subreads.bam
mkdir -p ~/data/anchr/iso_1/3_pacbio/bam
cd ~/data/anchr/iso_1/3_pacbio/bam

source ~/share/pitchfork/deployment/setup-env.sh
for movie in m131124_190051 m131124_221952 m131125_013854 m131125_045830 m131130_054035 m131130_091217 m131130_124231 m131130_161213 m131130_194336 m131130_231441 m131201_024805 m131201_061903 m131201_223357 m131202_020424 m131202_053545 m131202_090545 m131202_123546 m131202_160616 m131202_193958 m131202_231109;
do 
    if [ -e ~/data/anchr/iso_1/3_pacbio/bam/${movie}*.subreads.bam ]; then
        continue
    fi
    bax2bam ~/data/anchr/iso_1/3_pacbio/untar/${movie}*.bax.h5
done

# convert .subreads.bam to fasta
mkdir -p ~/data/anchr/iso_1/3_pacbio/fasta
for movie in m131124_190051 m131124_221952 m131125_013854 m131125_045830 m131130_054035 m131130_091217 m131130_124231 m131130_161213 m131130_194336 m131130_231441 m131201_024805 m131201_061903 m131201_223357 m131202_020424 m131202_053545 m131202_090545 m131202_123546 m131202_160616 m131202_193958 m131202_231109;
do
    if [ ! -e ~/data/anchr/iso_1/3_pacbio/bam/${movie}*.subreads.bam ]; then
        continue
    fi

    samtools fasta \
        ~/data/anchr/iso_1/3_pacbio/bam/${movie}*.subreads.bam \
        > ~/data/anchr/iso_1/3_pacbio/fasta/${movie}.fasta
done

cd ~/data/anchr/iso_1
cat 3_pacbio/fasta/*.fasta > 3_pacbio/pacbio.fasta

```

* Rsync to hpcc

```bash
rsync -avP \
    --exclude="ERR70*" \
    --exclude="*.tgz" \
    ~/data/anchr/iso_1/ \
    wangq@202.119.37.251:data/anchr/iso_1

# rsync -avP wangq@202.119.37.251:data/anchr/iso_1/ ~/data/anchr/iso_1
# rsync -avP wangq@202.119.37.251:data/anchr/iso_1_HiSeq_2000/ ~/data/anchr/iso_1_HiSeq_2000
# rsync -avP wangq@202.119.37.251:data/anchr/iso_1_HiSeq_2500/ ~/data/anchr/iso_1_HiSeq_2500

```

## iso_1_HiSeq_2000: symlink

```bash
mkdir -p ~/data/anchr/iso_1_HiSeq_2000/1_genome
cd ~/data/anchr/iso_1_HiSeq_2000/1_genome

ln -fs ../../iso_1/1_genome/genome.fa genome.fa
ln -fs ../../iso_1/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/iso_1_HiSeq_2000/2_illumina
cd ~/data/anchr/iso_1_HiSeq_2000/2_illumina

ln -fs ../../iso_1/2_illumina/HiSeq_2000_1.fq.gz R1.fq.gz
ln -fs ../../iso_1/2_illumina/HiSeq_2000_2.fq.gz R2.fq.gz

```

## iso_1_HiSeq_2000: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=iso_1_HiSeq_2000

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 137567477 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 80 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g

```

## iso_1_HiSeq_2000: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=iso_1_HiSeq_2000

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

The `meryl` step of `canu` failed in hpcc, run it locally.

Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 586.3 |    244 | 3419.1 |                         43.08% |
| R.tadpole.bbtools | 257.1 |    234 |  108.0 |                         34.78% |
| R.genome.picard   | 265.6 |    244 |  109.9 |                             FR |
| R.tadpole.picard  | 257.1 |    235 |  107.5 |                             FR |


Table: statReads

| Name       |      N50 |       Sum |         # |
|:-----------|---------:|----------:|----------:|
| Genome     | 25286936 | 137567477 |         8 |
| Paralogs   |     4031 |  13665900 |      4492 |
| Illumina.R |      101 |    18.12G | 179363706 |
| trim.R     |      100 |    15.08G | 152676468 |
| Q25L60     |      100 |    14.26G | 144969179 |


Table: statTrimReads

| Name     | N50 |    Sum |         # |
|:---------|----:|-------:|----------:|
| clumpify | 101 | 17.58G | 174107624 |
| trim     | 100 |  15.1G | 152848736 |
| filter   | 100 | 15.08G | 152676468 |
| R1       | 100 |  7.54G |  76338234 |
| R2       | 100 |  7.54G |  76338234 |
| Rs       |   0 |      0 |         0 |


```text
#R.trim
#Matched    1603022 0.92071%
#Name   Reads   ReadsPct
Reverse_adapter 1142676 0.65630%
TruSeq_Adapter_Index_1_6    178923  0.10277%
```

```text
#R.filter
#Matched    172076  0.11258%
#Name   Reads   ReadsPct
gi|9626372|ref|NC_001422.1| Coliphage phiX174, complete genome  172030  0.11255%
```

```text
#R.peaks
#k  31
#unique_kmers   421736860
#main_peak  71
#genome_size    249578696
#haploid_genome_size    124789348
#fold_coverage  35
#haploid_fold_coverage  71
#ploidy 2
#het_rate   0.00634
#percent_repeat 13.041
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |    Sum |         # |
|:--------------|----:|-------:|----------:|
| clumped       | 100 | 15.06G | 152458682 |
| ecco          | 100 | 15.06G | 152458682 |
| eccc          | 100 | 15.06G | 152458682 |
| ecct          | 100 | 14.43G | 146051868 |
| extended      | 140 | 20.03G | 146051868 |
| merged.raw    | 280 | 15.61G |  59072574 |
| unmerged.raw  | 140 |  3.73G |  27906720 |
| unmerged.trim | 140 |  3.73G |  27902494 |
| M1            | 281 | 15.44G |  58313449 |
| U1            | 140 |  1.87G |  13951247 |
| U2            | 140 |  1.86G |  13951247 |
| Us            |   0 |      0 |         0 |
| M.cor         | 254 | 19.22G | 144529392 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 149.9 |    152 |  23.5 |         25.80% |
| M.ihist.merge.txt  | 264.2 |    256 |  71.7 |         80.89% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% | Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|-----:|--------:|--------:|---------:|----------:|
| Q0L0.R   | 109.6 |  101.0 |    7.84% | "71" | 137.57M | 128.81M |     0.94 | 0:27'43'' |
| Q25L60.R | 103.7 |   97.1 |    6.35% | "71" | 137.57M |  126.8M |     0.92 | 0:26'01'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  80.25% |     11766 | 111.42M | 18037 |      1071 | 8.87M | 60263 |   36.0 | 2.0 |  10.0 |  63.0 | "31,41,51,61,71,81" | 0:27'10'' | 0:17'22'' |
| Q0L0X40P001    |   40.0 |  80.33% |     11874 | 111.47M | 17950 |      1063 | 8.76M | 60428 |   36.0 | 2.0 |  10.0 |  63.0 | "31,41,51,61,71,81" | 0:27'05'' | 0:17'59'' |
| Q0L0X80P000    |   80.0 |  76.75% |      9259 | 112.77M | 19590 |      1034 |  5.5M | 51915 |   72.0 | 5.0 |  19.0 | 130.5 | "31,41,51,61,71,81" | 0:43'05'' | 0:16'14'' |
| Q0L0XallP000   |  101.0 |  75.42% |      8175 | 113.08M | 21268 |      1026 | 4.08M | 52708 |   91.0 | 6.0 |  20.0 | 163.5 | "31,41,51,61,71,81" | 0:51'35'' | 0:15'48'' |
| Q25L60X40P000  |   40.0 |  80.65% |     14465 | 112.89M | 15599 |      1051 | 6.28M | 52659 |   36.0 | 3.0 |   9.0 |  67.5 | "31,41,51,61,71,81" | 0:27'15'' | 0:17'39'' |
| Q25L60X40P001  |   40.0 |  80.63% |     14515 | 112.92M | 15680 |      1049 | 6.18M | 52926 |   36.0 | 3.0 |   9.0 |  67.5 | "31,41,51,61,71,81" | 0:27'11'' | 0:18'12'' |
| Q25L60X80P000  |   80.0 |  78.56% |     11863 | 113.09M | 16837 |      1048 | 5.43M | 47128 |   72.0 | 5.0 |  19.0 | 130.5 | "31,41,51,61,71,81" | 0:43'17'' | 0:16'59'' |
| Q25L60XallP000 |   97.1 |  77.68% |     10856 | 113.85M | 17586 |      1037 | 4.08M | 46839 |   88.0 | 6.0 |  20.0 | 159.0 | "31,41,51,61,71,81" | 0:49'49'' | 0:17'22'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  82.31% |     19423 | 112.81M | 13102 |      1054 | 5.44M | 44271 |   36.0 | 3.0 |   9.0 |  67.5 | "31,41,51,61,71,81" | 0:13'43'' | 0:17'29'' |
| Q0L0X40P001    |   40.0 |  82.16% |     19418 | 112.73M | 13127 |      1050 | 5.42M | 44097 |   36.0 | 3.0 |   9.0 |  67.5 | "31,41,51,61,71,81" | 0:14'03'' | 0:17'32'' |
| Q0L0X80P000    |   80.0 |  82.46% |     18710 | 113.99M | 12618 |      1064 | 5.23M | 41964 |   73.0 | 5.0 |  19.3 | 132.0 | "31,41,51,61,71,81" | 0:19'08'' | 0:20'11'' |
| Q0L0XallP000   |  101.0 |  81.48% |     17234 | 115.28M | 12681 |      1062 | 3.54M | 40512 |   92.0 | 6.0 |  20.0 | 165.0 | "31,41,51,61,71,81" | 0:20'57'' | 0:19'19'' |
| Q25L60X40P000  |   40.0 |  81.82% |     18779 | 112.26M | 13557 |      1059 | 5.57M | 43565 |   36.0 | 3.0 |   9.0 |  67.5 | "31,41,51,61,71,81" | 0:13'53'' | 0:16'56'' |
| Q25L60X40P001  |   40.0 |  81.87% |     19102 | 112.31M | 13559 |      1053 | 5.44M | 43408 |   36.0 | 3.0 |   9.0 |  67.5 | "31,41,51,61,71,81" | 0:13'50'' | 0:16'28'' |
| Q25L60X80P000  |   80.0 |  82.85% |     19122 | 113.57M | 12844 |      1076 |  5.5M | 41985 |   73.0 | 5.0 |  19.3 | 132.0 | "31,41,51,61,71,81" | 0:19'16'' | 0:19'42'' |
| Q25L60XallP000 |   97.1 |  82.49% |     18471 | 114.98M | 12439 |      1067 |  3.7M | 40782 |   89.0 | 6.0 |  20.0 | 160.5 | "31,41,51,61,71,81" | 0:20'44'' | 0:20'39'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  74.29% |     14810 | 112.41M | 14192 |      1065 | 4.58M | 29058 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:38'23'' | 0:11'32'' |
| MRX40P001  |   40.0 |  74.34% |     14948 | 112.37M | 14140 |      1081 | 4.57M | 28905 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:38'24'' | 0:11'06'' |
| MRX40P002  |   40.0 |  74.21% |     14570 |  112.4M | 14283 |      1069 |  4.6M | 29182 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:38'26'' | 0:11'04'' |
| MRX80P000  |   80.0 |  72.84% |     10040 | 111.33M | 17932 |      1018 | 4.72M | 37334 |   77.0 |  6.0 |  19.7 | 142.5 | "31,41,51,61,71,81" | 1:04'27'' | 0:12'28'' |
| MRXallP000 |  139.7 |  71.59% |      8196 | 111.68M | 20819 |      1039 | 3.27M | 43062 |  136.0 | 11.0 |  20.0 | 253.5 | "31,41,51,61,71,81" | 1:43'58'' | 0:13'19'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  77.27% |     29760 | 114.08M |  8969 |      1294 | 3.27M | 19534 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:18'35'' | 0:12'06'' |
| MRX40P001  |   40.0 |  77.09% |     30137 | 114.06M |  8975 |      1394 | 3.22M | 19332 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:18'16'' | 0:11'34'' |
| MRX40P002  |   40.0 |  77.29% |     29541 | 114.08M |  9034 |      1339 |  3.2M | 19516 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:18'14'' | 0:11'38'' |
| MRX80P000  |   80.0 |  76.34% |     19753 | 113.68M | 11184 |      1140 | 3.53M | 23668 |   78.0 |  6.0 |  20.0 | 144.0 | "31,41,51,61,71,81" | 0:23'13'' | 0:12'36'' |
| MRXallP000 |  139.7 |  76.48% |     13855 | 114.24M | 14261 |      1990 | 2.62M | 31368 |  137.0 | 10.0 |  20.0 | 250.5 | "31,41,51,61,71,81" | 0:30'38'' | 0:14'09'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |     Sum |    # | N50Others |    Sum |    # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|--------:|-----:|----------:|-------:|-----:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  78.85% |     40398 | 115.49M | 7420 |      1417 | 10.15M | 6991 |   92.0 | 7.0 |  20.0 | 169.5 | 0:18'03'' |
| 7_mergeKunitigsAnchors   |  84.32% |     27312 | 115.73M | 9892 |      1423 |  9.67M | 6760 |   92.0 | 6.0 |  20.0 | 165.0 | 0:34'39'' |
| 7_mergeMRKunitigsAnchors |  82.94% |     26389 | 114.52M | 9485 |      1444 |  4.74M | 3096 |   92.0 | 5.0 |  20.0 | 160.5 | 0:24'38'' |
| 7_mergeMRTadpoleAnchors  |  82.59% |     36142 | 114.58M | 7745 |      1668 |  3.42M | 2002 |   92.0 | 6.0 |  20.0 | 165.0 | 0:22'48'' |
| 7_mergeTadpoleAnchors    |  84.59% |     30855 | 115.35M | 8918 |      1339 |   7.4M | 5228 |   93.0 | 6.0 |  20.0 | 166.5 | 0:27'48'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |     Sum |    # | N50Others |   Sum |     # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|--------:|-----:|----------:|------:|------:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  80.38% |    132432 | 118.48M | 3323 |      4570 | 2.79M |  6963 |   92.0 | 19.0 |  11.7 | 184.0 | 0:13'18'' |
| 8_spades_MR  |  84.56% |    106548 | 119.18M | 3847 |      4807 |  2.9M |  7558 |  137.0 | 34.0 |  11.7 | 274.0 | 0:13'15'' |
| 8_megahit    |  79.80% |     60645 | 116.53M | 5823 |      4169 |  2.5M | 11991 |   92.0 | 14.0 |  16.7 | 184.0 | 0:16'03'' |
| 8_megahit_MR |  84.65% |     49041 | 119.25M | 6818 |      1970 | 3.33M | 13336 |  137.0 | 36.0 |   9.7 | 274.0 | 0:13'21'' |
| 8_platanus   |  76.53% |    104961 | 117.56M | 4381 |      3127 | 2.53M |  7629 |   92.0 | 15.0 |  15.7 | 184.0 | 0:13'08'' |


Table: statFinal

| Name                     |      N50 |       Sum |      # |
|:-------------------------|---------:|----------:|-------:|
| Genome                   | 25286936 | 137567477 |      8 |
| Paralogs                 |     4031 |  13665900 |   4492 |
| 7_mergeAnchors.anchors   |    40398 | 115487731 |   7420 |
| 7_mergeAnchors.others    |     1417 |  10153838 |   6991 |
| spades.contig            |   124735 | 134956643 | 114733 |
| spades.scaffold          |   134657 | 134962523 | 114496 |
| spades.non-contained     |   140082 | 121269758 |   3659 |
| spades_MR.contig         |   106650 | 124703318 |  13352 |
| spades_MR.scaffold       |   163431 | 124786350 |  12544 |
| spades_MR.non-contained  |   108701 | 122077155 |   4197 |
| megahit.contig           |    55366 | 124511536 |  20692 |
| megahit.non-contained    |    59716 | 119033376 |   6175 |
| megahit_MR.contig        |    41583 | 133179347 |  32569 |
| megahit_MR.non-contained |    47868 | 122581483 |   7687 |
| platanus.contig          |    13667 | 157026071 | 348548 |
| platanus.scaffold        |   143062 | 129879353 |  76805 |
| platanus.non-contained   |   160951 | 120083492 |   3248 |


## iso_1_HiSeq_2500: symlink

```bash
mkdir -p ~/data/anchr/iso_1_HiSeq_2500/1_genome
cd ~/data/anchr/iso_1_HiSeq_2500/1_genome

ln -fs ../../iso_1/1_genome/genome.fa genome.fa
ln -fs ../../iso_1/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/iso_1_HiSeq_2500/2_illumina
cd ~/data/anchr/iso_1_HiSeq_2500/2_illumina

ln -fs ../../iso_1/2_illumina/HiSeq_2500_1.fq.gz R1.fq.gz
ln -fs ../../iso_1/2_illumina/HiSeq_2500_2.fq.gz R2.fq.gz

```

## iso_1_HiSeq_2500: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=iso_1_HiSeq_2500

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 137567477 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,2,3" \
    --cov2 "40 80 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g

```

## iso_1_HiSeq_2500: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=iso_1_HiSeq_2500

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 418.0 |    194 | 2722.9 |                         35.46% |
| R.tadpole.bbtools | 201.6 |    179 |   82.1 |                         36.97% |
| R.genome.picard   | 219.0 |    197 |   81.0 |                             FR |
| R.tadpole.picard  | 206.0 |    185 |   77.1 |                             FR |
| R.tadpole.picard  | 137.9 |    135 |   18.3 |                             RF |


Table: statReads

| Name       |      N50 |       Sum |        # |
|:-----------|---------:|----------:|---------:|
| Genome     | 25286936 | 137567477 |        8 |
| Paralogs   |     4031 |  13665900 |     4492 |
| Illumina.R |      126 |    11.55G | 91646278 |
| trim.R     |      125 |     9.66G | 80509352 |
| Q25L60     |      125 |     8.86G | 75233684 |


Table: statTrimReads

| Name     | N50 |    Sum |        # |
|:---------|----:|-------:|---------:|
| clumpify | 126 | 11.51G | 91329042 |
| trim     | 125 |  9.68G | 80681522 |
| filter   | 125 |  9.66G | 80509352 |
| R1       | 125 |  4.84G | 40254676 |
| R2       | 125 |  4.81G | 40254676 |
| Rs       |   0 |      0 |        0 |


```text
#R.trim
#Matched    9144616 10.01282%
#Name   Reads   ReadsPct
Reverse_adapter 2778840 3.04267%
TruSeq_Adapter_Index_1_6    2597713 2.84434%
pcr_dimer   1619479 1.77324%
Nextera_LMP_Read2_External_Adapter  1039224 1.13789%
PCR_Primers 962123  1.05347%
```

```text
#R.filter
#Matched    172005  0.21319%
#Name   Reads   ReadsPct
gi|9626372|ref|NC_001422.1| Coliphage phiX174, complete genome  171951  0.21312%
```

```text
#R.peaks
#k  31
#unique_kmers   409163089
#main_peak  46
#genome_size    138372254
#haploid_genome_size    138372254
#fold_coverage  46
#haploid_fold_coverage  46
#ploidy 1
#percent_repeat 13.670
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 125 |   9.65G | 80465536 |
| ecco          | 125 |   9.65G | 80465536 |
| eccc          | 125 |   9.65G | 80465536 |
| ecct          | 125 |    9.3G | 77554938 |
| extended      | 165 |  12.28G | 77554938 |
| merged.raw    | 240 |   8.53G | 36904460 |
| unmerged.raw  | 165 | 568.59M |  3746018 |
| unmerged.trim | 165 | 568.22M |  3743164 |
| M1            | 241 |   8.49G | 36691065 |
| U1            | 165 | 290.15M |  1871582 |
| U2            | 165 | 278.06M |  1871582 |
| Us            |   0 |       0 |        0 |
| M.cor         | 234 |    9.1G | 77125294 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 159.2 |    158 |  38.8 |         68.50% |
| M.ihist.merge.txt  | 231.1 |    217 |  71.3 |         95.17% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% | Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|-----:|--------:|--------:|---------:|----------:|
| Q0L0.R   |  70.2 |   62.0 |   11.61% | "87" | 137.57M | 134.14M |     0.98 | 0:17'12'' |
| Q25L60.R |  64.5 |   59.2 |    8.17% | "87" | 137.57M | 132.75M |     0.97 | 0:15'26'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  63.05% |      6600 | 80.84M | 20560 |      1021 | 5.63M | 52466 |   35.0 | 3.0 |   8.7 |  66.0 | "31,41,51,61,71,81" | 0:26'34'' | 0:10'26'' |
| Q0L0XallP000   |   62.0 |  57.23% |      5576 | 77.41M | 21281 |      1017 | 4.79M | 50060 |   55.0 | 5.0 |  13.3 | 105.0 | "31,41,51,61,71,81" | 0:36'02'' | 0:10'13'' |
| Q25L60X40P000  |   40.0 |  65.70% |      7283 | 81.71M | 19894 |      1027 | 5.74M | 51813 |   35.0 | 3.0 |   8.7 |  66.0 | "31,41,51,61,71,81" | 0:26'35'' | 0:11'00'' |
| Q25L60XallP000 |   59.2 |  61.77% |      6548 | 79.18M | 20109 |      1026 | 4.94M | 48983 |   53.0 | 5.0 |  12.7 | 102.0 | "31,41,51,61,71,81" | 0:34'29'' | 0:10'37'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  73.85% |      9701 | 89.58M | 18831 |      1029 | 5.83M | 55032 |   35.0 | 3.0 |   8.7 |  66.0 | "31,41,51,61,71,81" | 0:13'45'' | 0:13'18'' |
| Q0L0XallP000   |   62.0 |  70.18% |      9380 | 86.23M | 18437 |      1027 | 5.13M | 48642 |   55.0 | 5.0 |  13.3 | 105.0 | "31,41,51,61,71,81" | 0:15'25'' | 0:12'48'' |
| Q25L60X40P000  |   40.0 |  74.11% |      9286 | 90.26M | 19149 |      1028 | 5.05M | 56059 |   36.0 | 4.0 |   8.0 |  72.0 | "31,41,51,61,71,81" | 0:13'43'' | 0:13'35'' |
| Q25L60XallP000 |   59.2 |  71.55% |      9439 | 87.13M | 18555 |      1028 | 5.01M | 50017 |   53.0 | 5.0 |  12.7 | 102.0 | "31,41,51,61,71,81" | 0:15'03'' | 0:12'40'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  60.71% |      7930 | 81.29M | 18548 |      1038 | 4.17M | 39471 |   36.0 | 4.0 |   8.0 |  72.0 | "31,41,51,61,71,81" | 0:35'52'' | 0:10'23'' |
| MRXallP000 |   66.1 |  58.63% |      6425 | 78.23M | 19653 |      1031 | 4.63M | 41903 |   61.0 | 7.0 |  13.3 | 122.0 | "31,41,51,61,71,81" | 0:53'02'' | 0:10'44'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  67.05% |     13184 | 88.32M | 15789 |      1050 |  3.7M | 33917 |   36.0 | 4.0 |   8.0 |  72.0 | "31,41,51,61,71,81" | 0:15'38'' | 0:09'09'' |
| MRXallP000 |   66.1 |  63.74% |     10266 | 83.47M | 16802 |      1041 | 3.99M | 35901 |   61.0 | 7.0 |  13.3 | 122.0 | "31,41,51,61,71,81" | 0:18'45'' | 0:09'30'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |    Sum |     # | N50Others |    Sum |    # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|-------:|------:|----------:|-------:|-----:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  67.48% |     16635 | 91.76M | 14947 |      1053 | 10.88M | 9016 |   55.0 | 5.0 |  13.3 | 105.0 | 0:13'13'' |
| 7_mergeKunitigsAnchors   |  65.45% |      8817 |    83M | 18228 |      1057 |  7.73M | 6458 |   55.0 | 5.0 |  13.3 | 105.0 | 0:14'47'' |
| 7_mergeMRKunitigsAnchors |  57.64% |      8145 | 79.35M | 17755 |      1060 |  4.94M | 3725 |   55.0 | 5.0 |  13.3 | 105.0 | 0:09'48'' |
| 7_mergeMRTadpoleAnchors  |  61.63% |     13759 | 86.68M | 15092 |      1065 |  4.46M | 3188 |   55.0 | 5.0 |  13.3 | 105.0 | 0:10'49'' |
| 7_mergeTadpoleAnchors    |  70.73% |     12695 | 91.69M | 16780 |      1052 |  7.09M | 5591 |   55.0 | 5.0 |  13.3 | 105.0 | 0:16'10'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  83.96% |     94559 | 117.18M |  3857 |      2659 | 3.33M |  8324 |   54.0 |  9.0 |   9.0 | 108.0 | 0:11'17'' |
| 8_spades_MR  |  86.55% |     68707 | 117.55M |  5216 |      3534 | 3.15M | 10776 |   59.0 | 10.0 |   9.7 | 118.0 | 0:10'56'' |
| 8_megahit    |  81.25% |     23056 | 111.14M | 12487 |      1384 | 4.26M | 25537 |   54.0 |  8.0 |  10.0 | 108.0 | 0:10'59'' |
| 8_megahit_MR |  83.15% |     15377 | 115.37M | 19672 |      1178 | 4.51M | 40505 |   58.0 | 13.0 |   6.3 | 116.0 | 0:11'01'' |
| 8_platanus   |  79.13% |     33955 | 114.65M |  8886 |      1714 | 2.85M | 16327 |   54.0 |  9.0 |   9.0 | 108.0 | 0:11'12'' |


Table: statFinal

| Name                     |      N50 |       Sum |      # |
|:-------------------------|---------:|----------:|-------:|
| Genome                   | 25286936 | 137567477 |      8 |
| Paralogs                 |     4031 |  13665900 |   4492 |
| 7_mergeAnchors.anchors   |    16635 |  91757040 |  14947 |
| 7_mergeAnchors.others    |     1053 |  10880551 |   9016 |
| spades.contig            |    91456 | 127858287 |  47655 |
| spades.scaffold          |   108910 | 127876905 |  47314 |
| spades.non-contained     |    99752 | 120511297 |   4470 |
| spades_MR.contig         |    68015 | 123898783 |  17027 |
| spades_MR.scaffold       |    78225 | 123939215 |  16629 |
| spades_MR.non-contained  |    71579 | 120698684 |   5588 |
| megahit.contig           |    18346 | 125961264 |  40603 |
| megahit.non-contained    |    21748 | 115404464 |  13052 |
| megahit_MR.contig        |     7897 | 149100468 |  79604 |
| megahit_MR.non-contained |    14607 | 119894571 |  21256 |
| platanus.contig          |     7231 | 151661483 | 312260 |
| platanus.scaffold        |    40467 | 123714953 |  40319 |
| platanus.non-contained   |    44318 | 117507720 |   7441 |


# *Caenorhabditis elegans* N2

* Genome: [Ensembl 82](http://sep2015.archive.ensembl.org/Caenorhabditis_elegans/Info/Index)
* Proportion of paralogs (> 1000 bp): 0.0472

## n2: download

* Reference genome

```bash
mkdir -p ~/data/anchr/n2/1_genome
cd ~/data/anchr/n2/1_genome

wget -N ftp://ftp.ensembl.org/pub/release-82/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna_sm.toplevel.fa.gz
faops order Caenorhabditis_elegans.WBcel235.dna_sm.toplevel.fa.gz \
    <(for chr in {I,II,III,IV,V,X,MtDNA}; do echo $chr; done) \
    genome.fa

cp ~/data/anchr/paralogs/model/Results/n2/n2.multi.fas 1_genome/paralogs.fas
```

* Illumina

    * [SRX1321528](https://www.ncbi.nlm.nih.gov/sra/SRX1321528) SRR2598966

        HiSeq 2500 pe120, insert size 200(138)

    * [SRX697546](https://www.ncbi.nlm.nih.gov/sra/SRX697546) SRR1571299 7.5G
    * [SRX697551](https://www.ncbi.nlm.nih.gov/sra/SRX697551) SRR1571322 4G

        HiSeq 2000 pe100, insert size 200(68)

    * Other SRA
        * [SRX770040](https://www.ncbi.nlm.nih.gov/sra/SRX770040) - GEO
        * ERX1118232 - ERR1039478, 9.8G
        * DRX007633 - DRR008443 - GA II
        * SRX026594 - SRR065390 - GA II

```bash
# Downloading from ena with aria2
mkdir -p ~/data/anchr/n2/2_illumina
cd ~/data/anchr/n2/2_illumina

cat << EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR259/006/SRR2598966/SRR2598966_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR259/006/SRR2598966/SRR2598966_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR157/009/SRR1571299/SRR1571299_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR157/009/SRR1571299/SRR1571299_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR157/002/SRR1571322/SRR1571322_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR157/002/SRR1571322/SRR1571322_2.fastq.gz
EOF

aria2c -x 9 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
1f3f5dba991ad565263281c0770a12fa SRR2598966_1.fastq.gz
7fb98259f2f3feb7b82ba862ae57996a SRR2598966_2.fastq.gz
60e8b2981855b0af44a2ade68c09915f SRR1571299_1.fastq.gz
3f0e9d29a27df4f424d59a9d38196a6f SRR1571299_2.fastq.gz
11778477088b22a520218e236cc34502 SRR1571322_1.fastq.gz
5ac12fa22126e4393fc18a33cc5e7233 SRR1571322_2.fastq.gz
EOF

md5sum --check sra_md5.txt

```

* PacBio

https://github.com/PacificBiosciences/DevNet/wiki/C.-elegans-data-set

```bash
mkdir -p ~/data/anchr/n2/3_pacbio/fasta
cd ~/data/anchr/n2/3_pacbio/fasta

perl -MMojo::UserAgent -e '
    my $url = q{http://datasets.pacb.com.s3.amazonaws.com/2014/c_elegans/wget.html};

    my $ua   = Mojo::UserAgent->new->max_redirects(10);
    my $tx   = $ua->get($url);
    my $base = $tx->req->url;

    $tx->res->dom->find(q{a})->map( sub { $base->new( $_->{href} )->to_abs($base) } )
        ->each( sub                     { print shift . "\n" } );
' \
    | grep subreads.fasta \
    > s3.url.txt

aria2c -x 9 -s 3 -c -i s3.url.txt
find . -type f -name "*.fasta" | parallel -j 2 pigz -p 8

cd ~/data/anchr/n2/3_pacbio
find fasta -type f -name "*.subreads.fasta.gz" \
    | sort \
    | xargs gzip -d -c \
    | faops filter -l 0 stdin pacbio.fasta

```

* Rsync to hpcc

```bash
rsync -avP \
    --exclude="*.tgz" \
    ~/data/anchr/n2/ \
    wangq@202.119.37.251:data/anchr/n2

# rsync -avP wangq@202.119.37.251:data/anchr/n2/ ~/data/anchr/n2
# rsync -avP wangq@202.119.37.251:data/anchr/n2_pe120/ ~/data/anchr/n2_pe120
# rsync -avP wangq@202.119.37.251:data/anchr/n2_pe100/ ~/data/anchr/n2_pe100

```

## n2_pe120: symlink

```bash
mkdir -p ~/data/anchr/n2_pe120/1_genome
cd ~/data/anchr/n2_pe120/1_genome

ln -fs ../../n2/1_genome/genome.fa genome.fa
ln -fs ../../n2/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/n2_pe120/2_illumina
cd ~/data/anchr/n2_pe120/2_illumina

ln -fs ../../n2/2_illumina/SRR2598966_1.fastq.gz R1.fq.gz
ln -fs ../../n2/2_illumina/SRR2598966_2.fastq.gz R2.fq.gz

```

## n2_pe120: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=n2_pe120

cd ${WORKING_DIR}/${BASE_NAME}

rm -f *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 100286401 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 60 80 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g

```

## n2_pe120: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=n2_pe120

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 350.8 |    215 | 1739.5 |                         43.21% |
| R.tadpole.bbtools | 233.5 |    190 |  129.7 |                         39.00% |
| R.genome.picard   | 262.6 |    219 |  138.0 |                             FR |
| R.tadpole.picard  | 239.1 |    198 |  123.6 |                             FR |
| R.tadpole.picard  | 135.0 |    131 |   18.7 |                             RF |


Table: statReads

| Name       |      N50 |       Sum |         # |
|:-----------|---------:|----------:|----------:|
| Genome     | 17493829 | 100286401 |         7 |
| Paralogs   |     2013 |   5313653 |      2637 |
| Illumina.R |      120 |    24.03G | 200235436 |
| trim.R     |      120 |    21.27G | 183188022 |
| Q25L60     |      120 |    18.92G | 166329944 |


Table: statTrimReads

| Name     | N50 |    Sum |         # |
|:---------|----:|-------:|----------:|
| clumpify | 120 | 22.37G | 186437022 |
| trim     | 120 | 21.28G | 183241882 |
| filter   | 120 | 21.27G | 183188022 |
| R1       | 120 | 10.64G |  91594011 |
| R2       | 120 | 10.63G |  91594011 |
| Rs       |   0 |      0 |         0 |


```text
#R.trim
#Matched    22231715    11.92452%
#Name   Reads   ReadsPct
Reverse_adapter 7771044 4.16819%
pcr_dimer   5399536 2.89617%
TruSeq_Adapter_Index_1_6    4708097 2.52530%
PCR_Primers 2173369 1.16574%
Nextera_LMP_Read2_External_Adapter  1893775 1.01577%
```

```text
#R.filter
#Matched    53193   0.02903%
#Name   Reads   ReadsPct
gi|9626372|ref|NC_001422.1| Coliphage phiX174, complete genome  53190   0.02903%
```

```text
#R.peaks
#k  31
#unique_kmers   949673692
#main_peak  140
#genome_size    97464341
#haploid_genome_size    97464341
#fold_coverage  140
#haploid_fold_coverage  140
#ploidy 1
#percent_repeat 6.068
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |    Sum |         # |
|:--------------|----:|-------:|----------:|
| clumped       | 120 | 21.25G | 182987284 |
| ecco          | 120 | 21.25G | 182987284 |
| ecct          | 120 | 19.63G | 169139438 |
| extended      | 160 | 26.14G | 169139438 |
| merged.raw    | 256 | 16.87G |  70903903 |
| unmerged.raw  | 160 |  4.17G |  27331632 |
| unmerged.trim | 160 |  4.17G |  27330130 |
| M1            | 256 |  16.3G |  68526012 |
| U1            | 160 |  2.09G |  13665065 |
| U2            | 160 |  2.08G |  13665065 |
| Us            |   0 |      0 |         0 |
| M.cor         | 224 | 20.54G | 164382154 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 148.8 |    149 |  41.1 |         51.54% |
| M.ihist.merge.txt  | 237.9 |    221 |  85.4 |         83.84% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% | Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|-----:|--------:|--------:|---------:|----------:|
| Q0L0.R   | 212.1 |  180.7 |   14.80% | "85" | 100.29M | 106.83M |     1.07 | 0:39'40'' |
| Q25L60.R | 188.7 |  172.7 |    8.52% | "83" | 100.29M | 101.82M |     1.02 | 0:32'35'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  85.30% |      7524 | 87.42M | 17849 |       495 | 3.29M | 45275 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:25'31'' | 0:13'41'' |
| Q0L0X40P001    |   40.0 |  85.36% |      7481 | 87.52M | 17972 |       419 | 3.26M | 45263 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:25'34'' | 0:14'08'' |
| Q0L0X40P002    |   40.0 |  85.29% |      7733 | 87.44M | 17750 |       315 | 3.17M | 44777 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:25'29'' | 0:14'02'' |
| Q0L0X40P003    |   40.0 |  85.31% |      7547 | 87.42M | 17873 |       384 | 3.24M | 45155 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:25'21'' | 0:13'45'' |
| Q0L0X60P000    |   60.0 |  82.77% |      5927 | 85.87M | 20572 |      1031 | 4.11M | 47402 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:31'01'' | 0:13'12'' |
| Q0L0X60P001    |   60.0 |  82.78% |      6073 | 85.82M | 20354 |      1036 | 4.15M | 47023 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:30'57'' | 0:12'57'' |
| Q0L0X60P002    |   60.0 |  82.74% |      5976 | 85.74M | 20458 |      1035 | 4.14M | 47205 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:30'57'' | 0:13'15'' |
| Q0L0X80P000    |   80.0 |  81.07% |      5000 | 83.91M | 22776 |      1151 | 6.06M | 51977 |   74.0 |  6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:36'31'' | 0:12'59'' |
| Q0L0X80P001    |   80.0 |  81.02% |      5065 | 83.77M | 22597 |      1150 | 6.12M | 51785 |   74.0 |  6.0 |  18.7 | 138.0 | "31,41,51,61,71,81" | 0:36'40'' | 0:13'23'' |
| Q0L0XallP000   |  180.7 |  73.68% |      3184 | 77.04M | 28884 |      8662 | 9.48M | 63433 |  168.0 | 12.0 |  20.0 | 306.0 | "31,41,51,61,71,81" | 1:05'02'' | 0:15'04'' |
| Q25L60X40P000  |   40.0 |  88.24% |     10408 | 89.32M | 14629 |       448 | 2.78M | 42338 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:26'14'' | 0:17'30'' |
| Q25L60X40P001  |   40.0 |  88.25% |     10451 | 89.14M | 14440 |       582 | 2.82M | 42028 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:26'15'' | 0:17'15'' |
| Q25L60X40P002  |   40.0 |  88.29% |     10352 | 89.23M | 14550 |       366 | 2.76M | 42298 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:26'09'' | 0:17'48'' |
| Q25L60X40P003  |   40.0 |  88.22% |     10391 | 89.28M | 14471 |       400 | 2.76M | 42167 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:26'12'' | 0:17'04'' |
| Q25L60X60P000  |   60.0 |  86.32% |      9094 | 88.63M | 15818 |      1044 | 3.37M | 39809 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:31'54'' | 0:15'12'' |
| Q25L60X60P001  |   60.0 |  86.41% |      9070 | 88.69M | 15809 |      1053 | 3.49M | 40029 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:31'46'' | 0:15'31'' |
| Q25L60X80P000  |   80.0 |  85.32% |      7880 | 87.92M | 17210 |      1332 | 5.08M | 41922 |   75.0 |  7.0 |  18.0 | 144.0 | "31,41,51,61,71,81" | 0:37'35'' | 0:14'36'' |
| Q25L60X80P001  |   80.0 |  85.31% |      7844 | 87.85M | 17272 |      1333 | 5.26M | 42031 |   75.0 |  6.0 |  19.0 | 139.5 | "31,41,51,61,71,81" | 0:37'39'' | 0:15'00'' |
| Q25L60XallP000 |  172.7 |  82.00% |      5466 | 85.65M | 21888 |      8841 | 8.45M | 48545 |  162.0 | 13.0 |  20.0 | 301.5 | "31,41,51,61,71,81" | 1:04'08'' | 0:16'16'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  90.64% |     12822 |  90.1M | 12908 |        76 | 3.16M | 48048 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:18'48'' | 0:21'24'' |
| Q0L0X40P001    |   40.0 |  90.70% |     12890 |    90M | 12913 |        71 |  3.1M | 48042 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:18'56'' | 0:20'52'' |
| Q0L0X40P002    |   40.0 |  90.63% |     13150 | 90.07M | 12864 |        76 | 3.15M | 47933 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:18'45'' | 0:20'59'' |
| Q0L0X40P003    |   40.0 |  90.68% |     13101 | 90.02M | 12820 |        71 | 3.12M | 48154 |   37.0 |  3.0 |   9.3 |  69.0 | "31,41,51,61,71,81" | 0:18'57'' | 0:21'22'' |
| Q0L0X60P000    |   60.0 |  88.92% |     12881 | 89.99M | 12503 |       840 | 2.59M | 36031 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:20'34'' | 0:18'52'' |
| Q0L0X60P001    |   60.0 |  88.97% |     13021 | 89.97M | 12508 |       648 | 2.57M | 36135 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:20'25'' | 0:18'25'' |
| Q0L0X60P002    |   60.0 |  88.95% |     12999 | 90.01M | 12476 |       500 |  2.5M | 35690 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:20'22'' | 0:18'23'' |
| Q0L0X80P000    |   80.0 |  87.86% |     11897 | 89.75M | 13137 |      1055 | 3.36M | 34720 |   75.0 |  7.0 |  18.0 | 144.0 | "31,41,51,61,71,81" | 0:21'39'' | 0:17'24'' |
| Q0L0X80P001    |   80.0 |  87.85% |     12016 | 89.78M | 13142 |      1055 |  3.3M | 34674 |   75.0 |  7.0 |  18.0 | 144.0 | "31,41,51,61,71,81" | 0:21'21'' | 0:17'39'' |
| Q0L0XallP000   |  180.7 |  87.59% |      8134 | 89.06M | 17321 |      5234 | 7.61M | 47950 |  170.0 | 13.0 |  20.0 | 313.5 | "31,41,51,61,71,81" | 0:27'29'' | 0:22'14'' |
| Q25L60X40P000  |   40.0 |  91.44% |     13419 | 90.33M | 12752 |        62 | 2.95M | 50832 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:19'05'' | 0:23'11'' |
| Q25L60X40P001  |   40.0 |  91.39% |     13530 | 90.34M | 12684 |        65 | 2.99M | 50664 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:19'19'' | 0:22'54'' |
| Q25L60X40P002  |   40.0 |  91.35% |     13300 | 90.39M | 12760 |        62 | 2.95M | 50403 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:19'07'' | 0:22'10'' |
| Q25L60X40P003  |   40.0 |  91.38% |     13510 | 90.38M | 12746 |        61 | 2.93M | 50605 |   38.0 |  3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:19'02'' | 0:22'56'' |
| Q25L60X60P000  |   60.0 |  90.23% |     13879 | 90.42M | 12043 |       106 | 2.32M | 38055 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:21'21'' | 0:20'25'' |
| Q25L60X60P001  |   60.0 |  90.18% |     13838 | 90.41M | 12077 |       324 | 2.36M | 38263 |   56.0 |  5.0 |  13.7 | 106.5 | "31,41,51,61,71,81" | 0:21'06'' | 0:20'23'' |
| Q25L60X80P000  |   80.0 |  89.42% |     13468 | 90.36M | 12223 |      1048 | 2.97M | 35460 |   75.0 |  7.0 |  18.0 | 144.0 | "31,41,51,61,71,81" | 0:22'34'' | 0:19'58'' |
| Q25L60X80P001  |   80.0 |  89.40% |     13357 | 90.36M | 12257 |      1049 | 3.04M | 35509 |   75.0 |  7.0 |  18.0 | 144.0 | "31,41,51,61,71,81" | 0:22'21'' | 0:19'31'' |
| Q25L60XallP000 |  172.7 |  87.88% |     10194 | 90.06M | 14787 |      4696 | 6.92M | 37947 |  162.0 | 14.0 |  20.0 | 306.0 | "31,41,51,61,71,81" | 0:27'48'' | 0:19'55'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  83.87% |     10094 | 87.98M | 14557 |      1062 | 4.03M | 32439 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:33'09'' | 0:11'54'' |
| MRX40P001  |   40.0 |  84.01% |     10048 | 87.98M | 14698 |      1067 | 4.03M | 32872 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:33'06'' | 0:12'19'' |
| MRX40P002  |   40.0 |  84.09% |     10081 | 88.08M | 14667 |      1057 | 3.95M | 32672 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:33'02'' | 0:12'09'' |
| MRX40P003  |   40.0 |  83.91% |     10102 | 88.03M | 14613 |      1063 | 4.02M | 32598 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:33'07'' | 0:11'46'' |
| MRX40P004  |   40.0 |  84.06% |     10067 | 88.02M | 14542 |      1065 | 3.97M | 32568 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:33'04'' | 0:12'08'' |
| MRX60P000  |   60.0 |  82.87% |      8467 | 87.09M | 16459 |      1410 | 6.01M | 36898 |   57.0 |  6.0 |  13.0 | 112.5 | "31,41,51,61,71,81" | 0:41'59'' | 0:12'29'' |
| MRX60P001  |   60.0 |  83.13% |      8429 | 87.19M | 16477 |      1387 |    6M | 36967 |   57.0 |  6.0 |  13.0 | 112.5 | "31,41,51,61,71,81" | 0:42'05'' | 0:12'20'' |
| MRX60P002  |   60.0 |  82.96% |      8446 | 87.12M | 16504 |      1389 | 6.01M | 37022 |   57.0 |  6.0 |  13.0 | 112.5 | "31,41,51,61,71,81" | 0:42'04'' | 0:12'23'' |
| MRX80P000  |   80.0 |  81.94% |      7406 | 85.97M | 17945 |      2076 |  7.4M | 39833 |   76.0 |  8.0 |  17.3 | 150.0 | "31,41,51,61,71,81" | 0:50'58'' | 0:12'36'' |
| MRX80P001  |   80.0 |  82.12% |      7423 | 86.09M | 17929 |      2002 | 7.39M | 39907 |   76.0 |  8.0 |  17.3 | 150.0 | "31,41,51,61,71,81" | 0:51'01'' | 0:12'52'' |
| MRXallP000 |  204.8 |  76.95% |      4712 | 83.03M | 23738 |      5740 | 6.59M | 50720 |  196.0 | 21.0 |  20.0 | 388.5 | "31,41,51,61,71,81" | 1:47'36'' | 0:14'37'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  85.19% |     14029 | 89.18M | 11825 |      1039 |    3M | 26666 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:20'26'' | 0:12'18'' |
| MRX40P001  |   40.0 |  85.27% |     14003 | 89.27M | 11837 |      1038 | 2.97M | 26696 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:20'27'' | 0:12'39'' |
| MRX40P002  |   40.0 |  85.25% |     14025 | 89.16M | 11805 |      1034 | 2.92M | 26576 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:20'26'' | 0:12'38'' |
| MRX40P003  |   40.0 |  85.23% |     14096 | 89.17M | 11789 |      1036 | 2.93M | 26534 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:20'31'' | 0:12'12'' |
| MRX40P004  |   40.0 |  85.22% |     13971 | 89.18M | 11828 |      1034 | 2.93M | 26674 |   38.0 |  4.0 |   8.7 |  75.0 | "31,41,51,61,71,81" | 0:20'28'' | 0:12'40'' |
| MRX60P000  |   60.0 |  85.04% |     13333 | 89.32M | 12199 |      1361 |  4.5M | 27698 |   57.0 |  7.0 |  12.0 | 114.0 | "31,41,51,61,71,81" | 0:22'00'' | 0:12'30'' |
| MRX60P001  |   60.0 |  85.01% |     13325 | 89.35M | 12173 |      1333 | 4.47M | 27682 |   57.0 |  7.0 |  12.0 | 114.0 | "31,41,51,61,71,81" | 0:22'02'' | 0:12'51'' |
| MRX60P002  |   60.0 |  85.00% |     13350 | 89.31M | 12175 |      1325 |  4.4M | 27649 |   57.0 |  7.0 |  12.0 | 114.0 | "31,41,51,61,71,81" | 0:22'18'' | 0:12'57'' |
| MRX80P000  |   80.0 |  84.78% |     12473 |    89M | 12786 |      1925 | 5.94M | 28828 |   76.0 |  9.0 |  16.3 | 152.0 | "31,41,51,61,71,81" | 0:24'05'' | 0:13'12'' |
| MRX80P001  |   80.0 |  84.80% |     12288 | 88.97M | 12816 |      1905 | 5.98M | 29005 |   76.0 |  9.0 |  16.3 | 152.0 | "31,41,51,61,71,81" | 0:23'41'' | 0:13'38'' |
| MRXallP000 |  204.8 |  84.76% |      9421 | 88.95M | 15795 |      5374 |  6.2M | 36861 |  197.0 | 22.0 |  20.0 | 394.0 | "31,41,51,61,71,81" | 0:35'16'' | 0:16'57'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |    Sum |     # | N50Others |    Sum |    # | median |  MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|-------:|------:|----------:|-------:|-----:|-------:|-----:|------:|------:|----------:|
| 7_mergeAnchors           |  88.66% |     17652 | 92.46M | 10157 |      7650 | 16.64M | 6015 |  170.0 | 13.0 |  20.0 | 313.5 | 0:25'00'' |
| 7_mergeKunitigsAnchors   |  93.76% |     16059 | 91.47M | 11012 |      7027 |  13.2M | 4852 |  170.0 | 13.0 |  20.0 | 313.5 | 0:44'58'' |
| 7_mergeMRKunitigsAnchors |  92.79% |     14983 | 90.21M | 11479 |      4892 |  8.33M | 3257 |  170.0 | 13.0 |  20.0 | 313.5 | 0:36'58'' |
| 7_mergeMRTadpoleAnchors  |  92.27% |     15537 |  90.4M | 11196 |      5200 |  7.38M | 2543 |  170.0 | 14.0 |  20.0 | 318.0 | 0:31'41'' |
| 7_mergeTadpoleAnchors    |  93.31% |     16355 | 91.57M | 10729 |      4221 | 10.97M | 4709 |  170.0 | 14.0 |  20.0 | 318.0 | 0:46'24'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |    Sum |    # | N50Others |   Sum |     # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|-------:|-----:|----------:|------:|------:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  90.29% |     34958 | 93.71M | 5446 |     43902 | 5.82M | 10643 |  169.0 | 14.0 |  20.0 | 316.5 | 0:15'14'' |
| 8_spades_MR  |  91.46% |     43321 | 95.04M | 4491 |     12022 | 5.72M |  9220 |  197.0 | 21.0 |  20.0 | 390.0 | 0:15'14'' |
| 8_megahit    |  86.81% |     18196 | 91.19M | 9888 |     29617 | 5.73M | 20304 |  169.0 | 14.0 |  20.0 | 316.5 | 0:14'23'' |
| 8_megahit_MR |  91.31% |     28845 | 95.82M | 6865 |      8339 | 5.73M | 14303 |  197.0 | 22.0 |  20.0 | 394.0 | 0:14'38'' |
| 8_platanus   |  90.55% |     36761 | 94.47M | 5321 |      1062 | 1.52M |  9408 |  171.0 | 13.0 |  20.0 | 315.0 | 0:15'18'' |


Table: statFinal

| Name                     |      N50 |       Sum |      # |
|:-------------------------|---------:|----------:|-------:|
| Genome                   | 17493829 | 100286401 |      7 |
| Paralogs                 |     2013 |   5313653 |   2637 |
| 7_mergeAnchors.anchors   |    17652 |  92458087 |  10157 |
| 7_mergeAnchors.others    |     7650 |  16643836 |   6015 |
| spades.contig            |    37485 | 105976689 |  56433 |
| spades.scaffold          |    45097 | 105994826 |  55374 |
| spades.non-contained     |    40599 |  99540804 |   5214 |
| spades_MR.contig         |    43476 | 102909840 |  12277 |
| spades_MR.scaffold       |    50824 | 102966931 |  11699 |
| spades_MR.non-contained  |    44924 | 100772324 |   4799 |
| megahit.contig           |    17613 | 101368532 |  21457 |
| megahit.non-contained    |    18770 |  96922121 |  10425 |
| megahit_MR.contig        |    26268 | 106034997 |  18448 |
| megahit_MR.non-contained |    27961 | 101548918 |   7598 |
| platanus.contig          |    12870 | 108779033 | 108326 |
| platanus.scaffold        |    49959 |  97543421 |  11611 |
| platanus.non-contained   |    50967 |  95994536 |   4086 |


## n2_pe100: symlink

```bash
mkdir -p ~/data/anchr/n2_pe100/1_genome
cd ~/data/anchr/n2_pe100/1_genome

ln -fs ../../n2/1_genome/genome.fa genome.fa
ln -fs ../../n2/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/n2_pe100/2_illumina
cd ~/data/anchr/n2_pe100/2_illumina

ln -fs ../../n2/2_illumina/SRR1571299_1.fastq.gz R1.fq.gz
ln -fs ../../n2/2_illumina/SRR1571299_2.fastq.gz R2.fq.gz

ln -fs ../../n2/2_illumina/SRR1571322_1.fastq.gz S1.fq.gz
ln -fs ../../n2/2_illumina/SRR1571322_2.fastq.gz S2.fq.gz

```

## n2_pe100: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=n2_pe100

cd ${WORKING_DIR}/${BASE_NAME}

rm -f *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 100286401 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 60 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --parallel 24 \
    --xmx 110g

```

## n2_pe100: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=n2_pe100

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```


Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 253.7 |    207 | 1041.8 |                         41.49% |
| R.tadpole.bbtools | 209.9 |    202 |   69.6 |                         41.78% |
| S.genome.bbtools  | 265.0 |    210 | 1147.9 |                         34.15% |
| S.tadpole.bbtools | 218.4 |    210 |   68.2 |                         42.09% |
| R.genome.picard   | 214.1 |    207 |   68.3 |                             FR |
| R.tadpole.picard  | 211.1 |    203 |   68.7 |                             FR |
| S.genome.picard   | 217.9 |    210 |   65.5 |                             FR |
| S.tadpole.picard  | 219.0 |    211 |   67.8 |                             FR |


Table: statReads

| Name       |      N50 |       Sum |        # |
|:-----------|---------:|----------:|---------:|
| Genome     | 17493829 | 100286401 |        7 |
| Paralogs   |     2013 |   5313653 |     2637 |
| Illumina.R |      100 |     7.54G | 75384334 |
| trim.R     |      100 |     2.41G | 25843048 |
| Q25L60     |      100 |      2.3G | 24729544 |
| Illumina.S |      100 |     4.02G | 40224592 |
| trim.S     |      100 |     1.29G | 13865668 |
| Q25L60     |      100 |     1.23G | 13221034 |


Table: statTrimReads

| Name     | N50 |     Sum |        # |
|:---------|----:|--------:|---------:|
| clumpify | 100 |   7.28G | 72804426 |
| trim     | 100 |   2.41G | 25843048 |
| filter   | 100 |   2.41G | 25843048 |
| R1       | 100 |   1.28G | 12921524 |
| R2       | 100 |   1.13G | 12921524 |
| Rs       |   0 |       0 |        0 |
| clumpify | 100 |   3.96G | 39627568 |
| trim     | 100 |   1.29G | 13865668 |
| filter   | 100 |   1.29G | 13865668 |
| S1       | 100 | 686.22M |  6932834 |
| S2       | 100 | 605.43M |  6932834 |
| Ss       |   0 |       0 |        0 |


```text
#R.trim
#Matched    758194  1.04141%
#Name   Reads   ReadsPct
TruSeq_Adapter_Index_1_6    310535  0.42653%
Reverse_adapter 184463  0.25337%
Nextera_LMP_Read2_External_Adapter  111769  0.15352%
```

```text
#R.filter
#Matched    0   0.00000%
#Name   Reads   ReadsPct
```

```text
#R.peaks
#k  31
#unique_kmers   123434456
#main_peak  12
#genome_size    113154381
#haploid_genome_size    113154381
#fold_coverage  12
#haploid_fold_coverage  12
#ploidy 1
#percent_repeat 22.111
#start  center  stop    max volume
```


```text
#S.trim
#Matched    193156  0.48743%
#Name   Reads   ReadsPct
TruSeq_Adapter_Index_1_6    80521   0.20319%
```

```text
#S.filter
#Matched    0   0.00000%
#Name   Reads   ReadsPct
```

```text
#S.peaks
#k  31
#unique_kmers   111430061
#main_peak  5
#genome_size    141057416
#haploid_genome_size    141057416
#fold_coverage  5
#haploid_fold_coverage  5
#ploidy 1
#percent_repeat 38.894
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 100 |   2.41G | 25833480 |
| ecco          | 100 |   2.41G | 25833480 |
| ecct          | 100 |   2.33G | 25001866 |
| extended      | 140 |   3.13G | 25001866 |
| merged.raw    | 246 |   2.42G | 10411398 |
| unmerged.raw  | 133 | 442.46M |  4179070 |
| unmerged.trim | 133 | 442.42M |  4178516 |
| M1            | 246 |   2.41G | 10390539 |
| U1            | 140 | 272.57M |  2089258 |
| U2            |  87 | 169.85M |  2089258 |
| Us            |   0 |       0 |        0 |
| M.cor         | 230 |   2.87G | 24959594 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 139.4 |    141 |  28.7 |         31.66% |
| M.ihist.merge.txt  | 232.3 |    227 |  65.9 |         83.28% |

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 100 |   1.29G | 13862970 |
| ecco          | 100 |   1.29G | 13862970 |
| ecct          | 100 |    1.1G | 11863536 |
| extended      | 140 |   1.42G | 11863536 |
| merged.raw    | 241 | 939.12M |  4101691 |
| unmerged.raw  | 120 | 387.44M |  3660154 |
| unmerged.trim | 120 | 387.41M |  3659816 |
| N1            | 241 |    938M |  4096621 |
| V1            | 127 | 227.05M |  1829908 |
| V2            | 110 | 160.35M |  1829908 |
| Vs            |   0 |       0 |        0 |
| N.cor         | 207 |   1.33G | 11853058 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| N.ihist.merge1.txt | 145.9 |    149 |  27.0 |         26.19% |
| N.ihist.merge.txt  | 229.0 |    223 |  63.8 |         69.15% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% | Kmer |   RealG |   EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|-----:|--------:|-------:|---------:|----------:|
| Q0L0.R   |  24.0 |   22.9 |    4.60% | "71" | 100.29M | 96.97M |     0.97 | 0:04'38'' |
| Q25L60.R |  23.0 |   22.1 |    3.64% | "71" | 100.29M |  96.8M |     0.97 | 0:04'31'' |
| Q0L0.S   |  12.9 |   12.2 |    5.46% | "71" | 100.29M |  89.9M |     0.90 | 0:02'35'' |
| Q25L60.S |  12.3 |   11.7 |    4.66% | "71" | 100.29M | 89.09M |     0.89 | 0:02'29'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |    Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|------:|----------:|-------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0XallP000   |   35.1 |  89.91% |     11188 | 83.55M | 14794 |      1907 | 10.15M | 59917 |   28.0 | 3.0 |   6.3 |  55.5 | "31,41,51,61,71,81" | 0:20'13'' | 0:19'25'' |
| Q25L60XallP000 |   33.9 |  89.88% |     11019 | 83.83M | 14878 |      3481 |  9.15M | 59772 |   27.0 | 3.0 |   6.0 |  54.0 | "31,41,51,61,71,81" | 0:19'33'' | 0:18'43'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0XallP000   |   35.1 |  89.82% |     10106 | 82.11M | 15645 |      2750 | 9.35M | 64296 |   28.0 | 3.0 |   6.3 |  55.5 | "31,41,51,61,71,81" | 0:10'50'' | 0:18'56'' |
| Q25L60XallP000 |   33.9 |  89.61% |      9691 | 81.29M | 16085 |      1773 | 10.2M | 64728 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:10'45'' | 0:17'49'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  85.47% |      9632 | 80.47M | 15117 |      6986 | 8.01M | 40901 |   32.0 | 5.0 |   5.7 |  64.0 | "31,41,51,61,71,81" | 0:30'10'' | 0:13'01'' |
| MRXallP000 |   41.8 |  85.45% |      9643 | 79.94M | 15024 |      4330 | 8.71M | 40696 |   33.0 | 4.0 |   7.0 |  66.0 | "31,41,51,61,71,81" | 0:31'02'' | 0:13'12'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  86.63% |      9156 | 79.59M | 15490 |      5715 | 8.88M | 46555 |   32.0 | 4.0 |   6.7 |  64.0 | "31,41,51,61,71,81" | 0:16'22'' | 0:14'43'' |
| MRXallP000 |   41.8 |  86.58% |      9186 | 79.86M | 15480 |      7485 | 8.57M | 46160 |   33.0 | 4.0 |   7.0 |  66.0 | "31,41,51,61,71,81" | 0:16'32'' | 0:14'59'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |    Sum |     # | N50Others |    Sum |    # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|-------:|------:|----------:|-------:|-----:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  72.99% |     13677 | 81.97M | 12602 |      1555 | 14.59M | 8071 |   28.0 | 2.0 |   7.3 |  51.0 | 0:13'20'' |
| 7_mergeKunitigsAnchors   |  68.41% |     11811 |  82.7M | 13951 |      3433 |   9.1M | 4233 |   28.0 | 3.0 |   6.3 |  55.5 | 0:10'16'' |
| 7_mergeMRKunitigsAnchors |  64.46% |      9864 | 78.89M | 14514 |      7290 |  7.94M | 3369 |   28.0 | 2.0 |   7.3 |  51.0 | 0:08'40'' |
| 7_mergeMRTadpoleAnchors  |  62.89% |      9382 | 78.26M | 14860 |      9953 |  7.94M | 3229 |   28.0 | 2.0 |   7.3 |  51.0 | 0:08'11'' |
| 7_mergeTadpoleAnchors    |  64.40% |     10421 | 80.99M | 14888 |      4509 |   8.9M | 4063 |   28.0 | 3.0 |   6.3 |  55.5 | 0:08'37'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |    Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|-------:|------:|----------:|------:|------:|-------:|----:|------:|------:|----------:|
| 8_spades     |  90.82% |     23247 | 86.93M |  9057 |     29419 |  8.1M | 18216 |   28.0 | 4.0 |   5.3 |  56.0 | 0:10'21'' |
| 8_spades_MR  |  88.31% |     14148 | 84.47M | 12498 |     37925 |  7.8M | 25358 |   33.0 | 5.0 |   6.0 |  66.0 | 0:09'18'' |
| 8_megahit    |  89.02% |     15946 | 84.47M | 11570 |     17480 | 8.26M | 23746 |   28.0 | 3.0 |   6.3 |  55.5 | 0:09'30'' |
| 8_megahit_MR |  89.56% |     14361 | 85.15M | 12324 |     30458 | 8.07M | 25266 |   33.0 | 5.0 |   6.0 |  66.0 | 0:09'29'' |
| 8_platanus   |  79.70% |     11255 | 74.73M | 13115 |      7646 | 6.72M | 27153 |   28.0 | 3.0 |   6.3 |  55.5 | 0:07'25'' |


Table: statFinal

| Name                     |      N50 |       Sum |      # |
|:-------------------------|---------:|----------:|-------:|
| Genome                   | 17493829 | 100286401 |      7 |
| Paralogs                 |     2013 |   5313653 |   2637 |
| 7_mergeAnchors.anchors   |    13677 |  81965941 |  12602 |
| 7_mergeAnchors.others    |     1555 |  14590973 |   8071 |
| spades.contig            |    21708 | 104281921 |  69139 |
| spades.scaffold          |    22758 | 104289060 |  68811 |
| spades.non-contained     |    25124 |  95049532 |   9208 |
| spades_MR.contig         |    13329 |  99112753 |  35898 |
| spades_MR.scaffold       |    13628 |  99124516 |  35706 |
| spades_MR.non-contained  |    14790 |  92269166 |  13042 |
| megahit.contig           |    14867 |  98517269 |  24724 |
| megahit.non-contained    |    16370 |  92730446 |  12212 |
| megahit_MR.contig        |    13539 |  99670329 |  25181 |
| megahit_MR.non-contained |    14965 |  93211437 |  13099 |
| platanus.contig          |     2958 | 104308540 | 313135 |
| platanus.scaffold        |     9054 |  93429435 |  62957 |
| platanus.non-contained   |    11337 |  81447985 |  14042 |


# *Arabidopsis thaliana* Col-0

* Genome: [Ensembl Genomes](http://plants.ensembl.org/Arabidopsis_thaliana/Info/Index)
* Proportion of paralogs (> 1000 bp): 0.1158

## col_0: download

* Reference genome

```bash
mkdir -p ~/data/anchr/col_0/1_genome
cd ~/data/anchr/col_0/1_genome

wget -N ftp://ftp.ensemblgenomes.org/pub/release-29/plants/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.29.dna_sm.toplevel.fa.gz
faops order Arabidopsis_thaliana.TAIR10.29.dna_sm.toplevel.fa.gz \
    <(for chr in {1,2,3,4,5,Mt,Pt}; do echo $chr; done) \
    genome.fa
```

* Illumina

    * [SRX2527206](https://www.ncbi.nlm.nih.gov/sra/SRX2527206)

        MiSeq SRR5216995

    * [SRX202246](https://www.ncbi.nlm.nih.gov/sra/SRX202246)

        HiSeq (pe100)


```bash
mkdir -p ${HOME}/data/anchr/col_0/2_illumina
cd ${HOME}/data/anchr/col_0/2_illumina

cat << EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR521/005/SRR5216995/SRR5216995_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR521/005/SRR5216995/SRR5216995_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR611/SRR611086/SRR611086_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR611/SRR611086/SRR611086_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR616/SRR616966/SRR616966_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR616/SRR616966/SRR616966_2.fastq.gz
EOF

aria2c -x 9 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
ce4a92a9364a6773633223ff7a807810 SRR5216995_1.fastq.gz
5c6672124a628ea0020c88e74eff53a3 SRR5216995_2.fastq.gz
c921fe8752c08161b354a1e10e219c24 SRR611086_1.fastq.gz
8b727dbaa35a36800cd2b3803270e26e SRR611086_2.fastq.gz
3cdf439a7f6e095ce1790ad8af2557bd SRR616966_1.fastq.gz
7369b16069274992c6506b9e953412bc SRR616966_2.fastq.gz
EOF

md5sum --check sra_md5.txt

```

* PacBio

Chin, C.-S. *et al.* Phased diploid genome assembly with single-molecule real-time sequencing.
*Nature Methods* (2016). doi:10.1038/nmeth.4035

P4C2 is not supported in newer version of SMRTAnalysis.

https://www.ncbi.nlm.nih.gov/biosample/4539665

[SRX1715692](https://www.ncbi.nlm.nih.gov/sra/SRX1715692)

```bash
mkdir -p ~/data/anchr/col_0/3_pacbio
cd ~/data/anchr/col_0/3_pacbio

cat <<EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/002/SRR3405242
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/003/SRR3405243
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/004/SRR3405244
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/006/SRR3405246
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/008/SRR3405248
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/000/SRR3405250
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/002/SRR3405252
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/003/SRR3405253
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/004/SRR3405254
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/005/SRR3405255
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/006/SRR3405256
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/007/SRR3405257
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/008/SRR3405258
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/009/SRR3405259
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/005/SRR3405245
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/007/SRR3405247
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/009/SRR3405249
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/001/SRR3405251
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/000/SRR3405260
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/003/SRR3405263
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/005/SRR3405265
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/007/SRR3405267
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/009/SRR3405269
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/001/SRR3405271
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/004/SRR3405274
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/005/SRR3405275
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/006/SRR3405276
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/007/SRR3405277
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/008/SRR3405278
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/009/SRR3405279
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/000/SRR3405280
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/001/SRR3405281
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/002/SRR3405282
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/003/SRR3405283
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/004/SRR3405284
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/005/SRR3405285
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/006/SRR3405286
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/007/SRR3405287
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/008/SRR3405288
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/009/SRR3405289
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/000/SRR3405290
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/001/SRR3405261
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/002/SRR3405262
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/004/SRR3405264
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/006/SRR3405266
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/008/SRR3405268
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/000/SRR3405270
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/002/SRR3405272
ftp://ftp.sra.ebi.ac.uk/vol1/srr/SRR340/003/SRR3405273
EOF

aria2c -x 6 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
be9c803f847ff1c81d153110cc699390        SRR3405242
c68a2c3b62245a697722fd3f8fda7a2d        SRR3405243
7116e8a0de87b1acd016d9b284e4795c        SRR3405244
51f8e5ee4565aace4e5a5cba73e3e597        SRR3405246
f339f580e86aad3a5487b5cec8ae80d4        SRR3405248
1a8246ed1f7c38801cfc603e088abb70        SRR3405250
a0ce8435a7fa2e7ddbd6ac181902f751        SRR3405252
8754f69a1c8c1f00b58b48454c1c01ad        SRR3405253
367508500303325e855666133505a5af        SRR3405254
d250f69fcf2975c89ceab5a4f9425b36        SRR3405255
badd9b2d23f94d1c98263d2e786742ae        SRR3405256
6c5cbd3bce9459283a415d8a5c05c86e        SRR3405257
32da7a364c8cbda5cf76b87f7c51b475        SRR3405258
eb3819adf483451ac670f89d1ea6b76e        SRR3405259
5337862eeb0945f932de74e8f7b9ec4f        SRR3405245
4545ce4666878fcbcda1e7737be1896b        SRR3405247
71d61bc64e3ca9b91f08b1c6b1389f16        SRR3405249
b9a911b8eb4fbfe29dff8cf920429f18        SRR3405251
99bae070fa90d53c8f15b9cf42c634f6        SRR3405260
830e02f1f3cb66b9e085803a21ad8040        SRR3405263
86d28c63f00095ae0ff1151e7e0bf7b4        SRR3405265
3e048ad8dbb526d4a533ee1d5ec10a43        SRR3405267
1b73ed3a1124f5f025c511672c1e18d3        SRR3405269
fa07c85b9e6258abcef8bdb730ab812f        SRR3405271
aeb6ab7edfa42e5e27704b7625c659c1        SRR3405274
0eb24fcc9b40f6fe0f013fe79dd7edf7        SRR3405275
f051e0065602477e0a1d13a6d0a42d3d        SRR3405276
178540e33e9f4f76adc8509b147d7ff6        SRR3405277
6fdfa97e2eacf0ac186b5333e97c334b        SRR3405278
a6bb6b57db82eb6e4161847f9d35a608        SRR3405279
8399b8e8e4d48c7374a414a9585efa5b        SRR3405280
e725278a3837775e214b39093a900927        SRR3405281
fab9120bfa1130b300f7e82b74d23173        SRR3405282
33929263f09811d7f7360a9675e82cdd        SRR3405283
7f9e58c6fa43e8f2f3fa2496e149d2cb        SRR3405284
b9a469affbff1bdcb1b299c106c2c1b9        SRR3405285
688ab23dbfe7977f9de780486a8d5c6b        SRR3405286
fadc273d324413017e45570e3bf0ee6e        SRR3405287
6f4b0eb22cb523ddecb842042d500ceb        SRR3405288
03a4581c1b951dba3bb9e295e9113bf3        SRR3405289
51fa78f451a33bd44f985ac220e17efe        SRR3405290
fac8c4c2a862a4d572d77d0deb4b0abc        SRR3405261
3fd1a3d8140cfa96a0287e9e2b6055c4        SRR3405262
f908e6194fb3a0026b5263acadbd2600        SRR3405264
e04a7d96ba91ebb11772c019981ea9eb        SRR3405266
784e28febf413c6dfa842802aa106a55        SRR3405268
05b91a051fc52417858e93ce3b22fe2e        SRR3405270
07bca433005313a4a2c8050e32952f58        SRR3405272
a9bbee29c3d507760c4c33fbbe436fa6        SRR3405273
EOF

md5sum --check sra_md5.txt

for sra in SRR34052{42,43,44,46,48,50,52,53,54,55,56,57,58,59,45,47,49,51,60,63,65,67,69,71,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,61,62,64,66,68,70,72,73}; do
    echo ${sra}
    fastq-dump ./${sra}
done

cat SRR34052{42,43,44,46,48,50,52,53,54,55,56,57,58,59,45,47,49,51,60,63,65,67,69,71,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,61,62,64,66,68,70,72,73}.fastq \
    > pacbio.fq

find . -name "*.fq" | parallel -j 2 pigz -p 8
rm *.fastq

faops filter -l 0 pacbio.fq.gz pacbio.fasta

```

* Rsync to hpcc

```bash
rsync -avP \
    --exclude="SRR340*" \
    --exclude="*.tgz" \
    ~/data/anchr/col_0/ \
    wangq@202.119.37.251:data/anchr/col_0

# rsync -avP wangq@202.119.37.251:data/anchr/col_0/ ~/data/anchr/col_0
# rsync -avP wangq@202.119.37.251:data/anchr/col_0_MiSeq/ ~/data/anchr/col_0_MiSeq
# rsync -avP wangq@202.119.37.251:data/anchr/col_0_HiSeq/ ~/data/anchr/col_0_HiSeq

```


## col_0_MiSeq: symlink

```bash
mkdir -p ~/data/anchr/col_0_MiSeq/1_genome
cd ~/data/anchr/col_0_MiSeq/1_genome

ln -fs ../../col_0/1_genome/genome.fa genome.fa
ln -fs ../../col_0/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/col_0_MiSeq/2_illumina
cd ~/data/anchr/col_0_MiSeq/2_illumina

ln -fs ../../col_0/2_illumina/SRR5216995_1.fastq.gz R1.fq.gz
ln -fs ../../col_0/2_illumina/SRR5216995_2.fastq.gz R2.fq.gz

```

## col_0_MiSeq: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=col_0_MiSeq

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 119667750 \
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

```

## col_0_MiSeq: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=col_0_MiSeq

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 419.8 |    340 | 1245.2 |                         48.78% |
| R.tadpole.bbtools | 338.6 |    319 |  116.3 |                         42.37% |
| R.genome.picard   | 396.4 |    377 |  109.9 |                             FR |
| R.genome.picard   | 255.3 |    268 |   52.6 |                             RF |
| R.tadpole.picard  | 376.6 |    360 |  108.5 |                             FR |
| R.tadpole.picard  | 253.4 |    265 |   52.0 |                             RF |


Table: statReads

| Name       |      N50 |       Sum |        # |
|:-----------|---------:|----------:|---------:|
| Genome     | 23459830 | 119667750 |        7 |
| Paralogs   |     2007 |  16447809 |     8055 |
| Illumina.R |      301 |    15.53G | 53786130 |
| trim.R     |      276 |    13.42G | 52881044 |
| Q25L60     |      265 |    12.14G | 50605703 |
| Q30L60     |      241 |    10.28G | 47349846 |


Table: statTrimReads

| Name     | N50 |    Sum |        # |
|:---------|----:|-------:|---------:|
| clumpify | 301 | 15.53G | 53779068 |
| trim     | 276 | 13.42G | 52881050 |
| filter   | 276 | 13.42G | 52881044 |
| R1       | 292 |  7.17G | 26440522 |
| R2       | 254 |  6.24G | 26440522 |
| Rs       |   0 |      0 |        0 |


```text
#R.trim
#Matched    1037665 1.92950%
#Name   Reads   ReadsPct
Reverse_adapter 430782  0.80102%
TruSeq_Universal_Adapter    286644  0.53300%
pcr_dimer   92485   0.17197%
Nextera_LMP_Read2_External_Adapter  60004   0.11158%
```

```text
#R.filter
#Matched    3   0.00001%
#Name   Reads   ReadsPct
```

```text
#R.peaks
#k  31
#unique_kmers   1207079530
#main_peak  66
#genome_size    136648789
#haploid_genome_size    136648789
#fold_coverage  66
#haploid_fold_coverage  66
#ploidy 1
#percent_repeat 18.342
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 276 |  13.42G | 52879410 |
| ecco          | 276 |  13.42G | 52879410 |
| ecct          | 280 |  10.96G | 42180246 |
| extended      | 319 |   12.6G | 42180246 |
| merged.raw    | 412 |   8.03G | 20185179 |
| unmerged.raw  | 289 | 440.41M |  1809888 |
| unmerged.trim | 289 | 440.39M |  1809762 |
| M1            | 413 |   7.99G | 20074709 |
| U1            | 312 | 261.46M |   904881 |
| U2            | 235 | 178.94M |   904881 |
| Us            |   0 |       0 |        0 |
| M.cor         | 405 |   8.45G | 41959180 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 336.0 |    334 |  86.3 |         64.84% |
| M.ihist.merge.txt  | 397.7 |    387 | 104.7 |         95.71% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% |  Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|------:|--------:|--------:|---------:|----------:|
| Q0L0.R   | 112.1 |   68.8 |   38.63% | "127" | 119.67M | 131.66M |     1.10 | 0:20'07'' |
| Q25L60.R | 101.5 |   73.6 |   27.48% | "127" | 119.67M | 126.05M |     1.05 | 0:18'20'' |
| Q30L60.R |  85.9 |   73.6 |   14.39% | "127" | 119.67M |  118.9M |     0.99 | 0:16'35'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|-------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  67.84% |      8077 | 100.67M | 19794 |       810 | 10.08M | 53093 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:30'02'' | 0:13'38'' |
| Q0L0X50P000    |   50.0 |  68.77% |      8771 | 102.15M | 18664 |       518 |  8.37M | 59198 |   34.0 | 3.0 |   8.3 |  64.5 | "31,41,51,61,71,81" | 0:34'57'' | 0:15'05'' |
| Q0L0X60P000    |   60.0 |  69.45% |      7385 | 100.71M | 20760 |       671 | 11.19M | 70923 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:39'58'' | 0:16'42'' |
| Q0L0XallP000   |   68.8 |  69.86% |      7423 | 101.75M | 20780 |       304 |  9.98M | 79186 |   46.0 | 4.0 |  11.3 |  87.0 | "31,41,51,61,71,81" | 0:44'24'' | 0:18'28'' |
| Q25L60X40P000  |   40.0 |  68.27% |     12421 | 103.39M | 15253 |       706 |  6.16M | 38165 |   28.0 | 2.0 |   7.3 |  51.0 | "31,41,51,61,71,81" | 0:29'37'' | 0:12'53'' |
| Q25L60X50P000  |   50.0 |  68.42% |     11011 | 102.71M | 16485 |       739 |  7.07M | 41804 |   35.0 | 2.0 |   9.7 |  61.5 | "31,41,51,61,71,81" | 0:34'32'' | 0:13'18'' |
| Q25L60X60P000  |   60.0 |  68.72% |     11967 | 104.19M | 15289 |       419 |  5.15M | 42492 |   42.0 | 3.0 |  11.0 |  76.5 | "31,41,51,61,71,81" | 0:39'28'' | 0:14'05'' |
| Q25L60XallP000 |   73.6 |  69.13% |     11436 | 104.33M | 15427 |       114 |  4.98M | 46218 |   52.0 | 4.0 |  13.3 |  96.0 | "31,41,51,61,71,81" | 0:46'19'' | 0:15'18'' |
| Q30L60X40P000  |   40.0 |  72.36% |     17402 | 104.97M | 12154 |       764 |  4.36M | 31159 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 0:29'38'' | 0:13'02'' |
| Q30L60X50P000  |   50.0 |  71.95% |     15723 |  104.1M | 13188 |       821 |  5.44M | 32106 |   37.0 | 2.0 |  10.3 |  64.5 | "31,41,51,61,71,81" | 0:34'20'' | 0:13'08'' |
| Q30L60X60P000  |   60.0 |  71.69% |     17993 | 105.57M | 11476 |       625 |  3.52M | 29711 |   45.0 | 3.0 |  12.0 |  81.0 | "31,41,51,61,71,81" | 0:39'16'' | 0:13'26'' |
| Q30L60XallP000 |   73.6 |  71.44% |     17124 | 105.17M | 11950 |       701 |  4.01M | 30429 |   55.0 | 3.0 |  15.3 |  96.0 | "31,41,51,61,71,81" | 0:45'52'' | 0:13'44'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  76.31% |     11001 | 102.44M | 16448 |       885 | 7.76M | 37391 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:15'31'' | 0:12'26'' |
| Q0L0X50P000    |   50.0 |  75.95% |     14966 | 104.38M | 13201 |       750 | 5.14M | 31922 |   34.0 | 3.0 |   8.3 |  64.5 | "31,41,51,61,71,81" | 0:16'46'' | 0:12'03'' |
| Q0L0X60P000    |   60.0 |  75.31% |     14426 | 104.23M | 13406 |       790 |  5.2M | 31264 |   41.0 | 3.0 |  10.7 |  75.0 | "31,41,51,61,71,81" | 0:17'48'' | 0:12'19'' |
| Q0L0XallP000   |   68.8 |  74.78% |     14998 |  104.9M | 12841 |       694 | 4.32M | 30035 |   47.0 | 4.0 |  11.7 |  88.5 | "31,41,51,61,71,81" | 0:19'09'' | 0:11'52'' |
| Q25L60X40P000  |   40.0 |  79.37% |     15785 | 104.28M | 13067 |       813 | 5.69M | 33032 |   28.0 | 2.0 |   7.3 |  51.0 | "31,41,51,61,71,81" | 0:14'46'' | 0:13'05'' |
| Q25L60X50P000  |   50.0 |  78.82% |     15062 | 103.95M | 13545 |       848 | 5.92M | 31921 |   35.0 | 2.0 |   9.7 |  61.5 | "31,41,51,61,71,81" | 0:16'06'' | 0:12'22'' |
| Q25L60X60P000  |   60.0 |  78.30% |     19049 | 105.49M | 11113 |       648 | 3.82M | 27766 |   43.0 | 3.0 |  11.3 |  78.0 | "31,41,51,61,71,81" | 0:17'28'' | 0:13'15'' |
| Q25L60XallP000 |   73.6 |  77.37% |     18019 |  105.7M | 11289 |       611 | 3.49M | 27296 |   52.0 | 4.0 |  13.3 |  96.0 | "31,41,51,61,71,81" | 0:19'06'' | 0:12'27'' |
| Q30L60X40P000  |   40.0 |  84.03% |     17800 | 105.22M | 11881 |       796 | 4.61M | 33248 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 0:14'20'' | 0:13'59'' |
| Q30L60X50P000  |   50.0 |  83.55% |     16741 | 104.52M | 12555 |       844 | 5.52M | 32414 |   37.0 | 2.0 |  10.3 |  64.5 | "31,41,51,61,71,81" | 0:15'19'' | 0:13'11'' |
| Q30L60X60P000  |   60.0 |  83.30% |     21104 | 105.98M | 10431 |       740 | 3.48M | 28575 |   45.0 | 3.0 |  12.0 |  81.0 | "31,41,51,61,71,81" | 0:16'31'' | 0:14'03'' |
| Q30L60XallP000 |   73.6 |  82.85% |     20630 | 105.73M | 10611 |       847 | 3.87M | 27817 |   55.0 | 3.0 |  15.3 |  96.0 | "31,41,51,61,71,81" | 0:18'02'' | 0:13'27'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  75.08% |     23537 | 105.03M |  9101 |       182 | 2.99M | 20461 |   33.0 | 3.0 |   8.0 |  63.0 | "31,41,51,61,71,81" | 0:35'40'' | 0:10'40'' |
| MRX50P000  |   50.0 |  74.87% |     22041 | 104.68M |  9449 |       173 | 3.34M | 21179 |   41.0 | 3.0 |  10.7 |  75.0 | "31,41,51,61,71,81" | 0:43'02'' | 0:10'40'' |
| MRX60P000  |   60.0 |  74.72% |     20739 | 104.61M |  9799 |       162 | 3.38M | 21937 |   50.0 | 4.0 |  12.7 |  93.0 | "31,41,51,61,71,81" | 0:48'31'' | 0:11'27'' |
| MRXallP000 |   70.6 |  74.55% |     19565 | 104.56M | 10168 |       151 | 3.37M | 22697 |   59.0 | 5.0 |  14.7 | 111.0 | "31,41,51,61,71,81" | 0:55'32'' | 0:11'07'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |    # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|-----:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  87.60% |     28024 | 105.36M | 8160 |      1006 | 2.93M | 17811 |   33.0 | 3.0 |   8.0 |  63.0 | "31,41,51,61,71,81" | 0:15'27'' | 0:10'08'' |
| MRX50P000  |   50.0 |  87.56% |     27770 | 105.47M | 8213 |      1006 | 2.94M | 17900 |   42.0 | 4.0 |  10.0 |  81.0 | "31,41,51,61,71,81" | 0:16'27'' | 0:10'33'' |
| MRX60P000  |   60.0 |  87.53% |     27145 | 105.11M | 8268 |       297 |  3.1M | 18007 |   50.0 | 4.0 |  12.7 |  93.0 | "31,41,51,61,71,81" | 0:17'44'' | 0:10'55'' |
| MRXallP000 |   70.6 |  87.52% |     26607 | 105.22M | 8362 |       335 | 3.07M | 18156 |   59.0 | 5.0 |  14.7 | 111.0 | "31,41,51,61,71,81" | 0:19'07'' | 0:10'48'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |    # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|--------:|------:|----------:|-------:|-----:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  63.17% |     23019 | 102.84M |  9831 |      1203 | 12.26M | 9461 |   47.0 | 3.0 |  12.7 |  84.0 | 0:11'19'' |
| 7_mergeKunitigsAnchors   |  75.87% |     18590 | 103.87M | 11477 |      1160 | 10.61M | 8881 |   47.0 | 3.0 |  12.7 |  84.0 | 0:20'27'' |
| 7_mergeMRKunitigsAnchors |  68.28% |     18365 | 102.21M | 11273 |      1133 |  3.58M | 3026 |   47.0 | 3.0 |  12.7 |  84.0 | 0:12'55'' |
| 7_mergeMRTadpoleAnchors  |  69.01% |     21257 | 102.69M | 10351 |      1164 |  3.58M | 2743 |   47.0 | 3.0 |  12.7 |  84.0 | 0:13'17'' |
| 7_mergeTadpoleAnchors    |  77.28% |     20096 | 104.08M | 10898 |      1193 |  8.45M | 6700 |   47.0 | 3.0 |  12.7 |  84.0 | 0:21'25'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |     Sum |    # | N50Others |   Sum |     # | median | MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|--------:|-----:|----------:|------:|------:|-------:|----:|------:|------:|----------:|
| 8_spades     |  74.36% |     43471 | 109.44M | 5923 |      1357 | 3.84M | 10164 |   47.0 | 4.0 |  11.7 |  88.5 | 0:10'16'' |
| 8_spades_MR  |  92.27% |     58605 |  110.9M | 5255 |      1149 | 2.52M | 10902 |   59.0 | 8.0 |  11.7 | 118.0 | 0:10'18'' |
| 8_megahit    |  67.63% |     27474 |  104.6M | 9041 |      1076 | 3.97M | 17560 |   47.0 | 4.0 |  11.7 |  88.5 | 0:09'26'' |
| 8_megahit_MR |  91.89% |     47133 | 110.07M | 6013 |      1090 | 2.65M | 12591 |   59.0 | 7.0 |  12.7 | 118.0 | 0:10'01'' |
| 8_platanus   |  66.12% |     24447 | 112.43M | 8968 |       724 | 3.18M | 13703 |   47.0 | 3.0 |  12.7 |  84.0 | 0:10'53'' |


Table: statFinal

| Name                     |      N50 |       Sum |      # |
|:-------------------------|---------:|----------:|-------:|
| Genome                   | 23459830 | 119667750 |      7 |
| Paralogs                 |     2007 |  16447809 |   8055 |
| 7_mergeAnchors.anchors   |    23019 | 102835961 |   9831 |
| 7_mergeAnchors.others    |     1203 |  12258565 |   9461 |
| spades.contig            |    65550 | 129317383 | 106015 |
| spades.scaffold          |    68478 | 129320894 | 105919 |
| spades.non-contained     |    82157 | 113275768 |   4242 |
| spades_MR.contig         |    58377 | 116503363 |  16526 |
| spades_MR.scaffold       |    65625 | 116564063 |  16241 |
| spades_MR.non-contained  |    60075 | 113415107 |   5648 |
| megahit.contig           |    28974 | 117054661 |  29067 |
| megahit.non-contained    |    32252 | 108569539 |   8520 |
| megahit_MR.contig        |    44348 | 117822209 |  17591 |
| megahit_MR.non-contained |    47093 | 112721626 |   6580 |
| platanus.contig          |    15025 | 141853472 | 121527 |
| platanus.scaffold        |    46223 | 130179099 |  85625 |
| platanus.non-contained   |    52218 | 115618578 |   4731 |


## col_0_HiSeq: symlink

```bash
mkdir -p ~/data/anchr/col_0_HiSeq/1_genome
cd ~/data/anchr/col_0_HiSeq/1_genome

ln -fs ../../col_0/1_genome/genome.fa genome.fa
ln -fs ../../col_0/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/col_0_HiSeq/2_illumina
cd ~/data/anchr/col_0_HiSeq/2_illumina

ln -fs ../../col_0/2_illumina/SRR611086_1.fastq.gz R1.fq.gz
ln -fs ../../col_0/2_illumina/SRR611086_2.fastq.gz R2.fq.gz

ln -fs ../../col_0/2_illumina/SRR616966_1.fastq.gz S1.fq.gz
ln -fs ../../col_0/2_illumina/SRR616966_2.fastq.gz S2.fq.gz

```

## col_0_HiSeq: template

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=col_0_HiSeq

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 119667750 \
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

```

## col_0_HiSeq: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=col_0_HiSeq

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 643.9 |    472 | 2203.1 |                         38.55% |
| R.tadpole.bbtools | 449.6 |    470 |   83.8 |                         27.27% |
| S.genome.bbtools  | 651.9 |    487 | 2132.2 |                         38.77% |
| S.tadpole.bbtools | 467.5 |    486 |   79.8 |                         26.59% |
| R.genome.picard   | 467.2 |    472 |   36.9 |                             FR |
| R.tadpole.picard  | 450.4 |    470 |   82.0 |                             FR |
| S.genome.picard   | 483.3 |    487 |   34.0 |                             FR |
| S.tadpole.picard  | 467.5 |    486 |   79.4 |                             FR |


Table: statReads

| Name       |      N50 |       Sum |        # |
|:-----------|---------:|----------:|---------:|
| Genome     | 23459830 | 119667750 |        7 |
| Paralogs   |     2007 |  16447809 |     8055 |
| Illumina.R |      100 |     9.98G | 99782698 |
| trim.R     |      100 |     9.04G | 92151778 |
| Q25L60     |      100 |      8.4G | 85947212 |
| Q30L60     |      100 |     7.48G | 77966430 |
| Illumina.S |      100 |     4.97G | 49703592 |
| trim.S     |      100 |     4.52G | 46093536 |
| Q25L60     |      100 |     4.17G | 42753132 |
| Q30L60     |      100 |     3.69G | 38554536 |


Table: statTrimReads

| Name     | N50 |   Sum |        # |
|:---------|----:|------:|---------:|
| clumpify | 100 | 9.68G | 96806966 |
| trim     | 100 | 9.04G | 92151778 |
| filter   | 100 | 9.04G | 92151778 |
| R1       | 100 | 4.55G | 46075889 |
| R2       | 100 | 4.49G | 46075889 |
| Rs       |   0 |     0 |        0 |
| clumpify | 100 | 4.87G | 48668478 |
| trim     | 100 | 4.52G | 46093538 |
| filter   | 100 | 4.52G | 46093536 |
| S1       | 100 | 2.28G | 23046768 |
| S2       | 100 | 2.24G | 23046768 |
| Ss       |   0 |     0 |        0 |


```text
#R.trim
#Matched    47911   0.04949%
#Name   Reads   ReadsPct
```

```text
#R.filter
#Matched    0   0.00000%
#Name   Reads   ReadsPct
```

```text
#R.peaks
#k  31
#unique_kmers   1044780442
#main_peak  29
#genome_size    141608567
#haploid_genome_size    141608567
#fold_coverage  29
#haploid_fold_coverage  29
#ploidy 1
#percent_repeat 21.982
#start  center  stop    max volume
```


```text
#S.trim
#Matched    24408   0.05015%
#Name   Reads   ReadsPct
```

```text
#S.filter
#Matched    1   0.00000%
#Name   Reads   ReadsPct
```

```text
#S.peaks
#k  31
#unique_kmers   645724743
#main_peak  14
#genome_size    145286689
#haploid_genome_size    145286689
#fold_coverage  14
#haploid_fold_coverage  14
#ploidy 1
#percent_repeat 23.006
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 100 |   9.04G | 92126146 |
| ecco          | 100 |   9.04G | 92126146 |
| ecct          | 100 |   7.05G | 71697232 |
| extended      | 140 |   9.73G | 71697232 |
| merged.raw    | 186 | 146.38M |   798991 |
| unmerged.raw  | 140 |   9.53G | 70099250 |
| unmerged.trim | 140 |   9.53G | 70095626 |
| M1            | 255 | 104.61M |   491775 |
| U1            | 140 |   4.79G | 35047813 |
| U2            | 140 |   4.74G | 35047813 |
| Us            |   0 |       0 |        0 |
| M.cor         | 140 |   9.64G | 71079176 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 125.4 |    122 |  23.8 |          1.20% |
| M.ihist.merge.txt  | 183.2 |    145 |  89.1 |          2.23% |

| Name          | N50 |    Sum |        # |
|:--------------|----:|-------:|---------:|
| clumped       | 100 |  4.52G | 46085656 |
| ecco          | 100 |  4.52G | 46085656 |
| ecct          | 100 |  3.47G | 35284504 |
| extended      | 140 |  4.79G | 35284504 |
| merged.raw    | 165 | 64.03M |   370990 |
| unmerged.raw  | 140 |   4.7G | 34542524 |
| unmerged.trim | 140 |   4.7G | 34539910 |
| N1            | 173 | 42.83M |   235305 |
| V1            | 140 |  2.36G | 17269955 |
| V2            | 140 |  2.34G | 17269955 |
| Vs            |   0 |      0 |        0 |
| N.cor         | 140 |  4.74G | 35010520 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| N.ihist.merge1.txt | 139.6 |    139 |  16.6 |          1.45% |
| N.ihist.merge.txt  | 172.6 |    159 |  61.6 |          2.10% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% | Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|-----:|--------:|--------:|---------:|----------:|
| Q0L0.R   |  75.5 |   61.2 |   19.01% | "71" | 119.67M | 228.39M |     1.91 | 0:17'04'' |
| Q25L60.R |  70.2 |   57.8 |   17.73% | "71" | 119.67M | 213.61M |     1.79 | 0:15'53'' |
| Q30L60.R |  62.6 |   52.1 |   16.78% | "71" | 119.67M | 191.16M |     1.60 | 0:15'02'' |
| Q0L0.S   |  37.7 |   28.9 |   23.36% | "71" | 119.67M | 148.12M |     1.24 | 0:08'19'' |
| Q25L60.S |  34.9 |   27.3 |   21.89% | "71" | 119.67M | 141.47M |     1.18 | 0:07'47'' |
| Q30L60.S |  30.9 |   24.5 |   20.50% | "71" | 119.67M | 132.41M |     1.11 | 0:07'05'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |      # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|------:|-------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  70.12% |      6898 | 109.37M | 24696 |      1002 |  7.5M | 119238 |   26.0 | 2.0 |   6.7 |  48.0 | "31,41,51,61,71,81" | 0:22'32'' | 0:26'01'' |
| Q0L0X40P001    |   40.0 |  70.13% |      6916 | 109.31M | 24703 |      1002 | 7.58M | 118966 |   26.0 | 2.0 |   6.7 |  48.0 | "31,41,51,61,71,81" | 0:22'37'' | 0:25'28'' |
| Q0L0X50P000    |   50.0 |  69.37% |      5115 | 113.05M | 31583 |      1000 | 7.88M | 130284 |   33.0 | 2.0 |   9.0 |  58.5 | "31,41,51,61,71,81" | 0:25'31'' | 0:26'19'' |
| Q0L0X60P000    |   60.0 |  67.09% |      4257 | 112.88M | 35550 |       971 | 7.57M | 122251 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:28'28'' | 0:22'11'' |
| Q0L0XallP000   |   90.1 |  53.19% |      2449 |  95.66M | 43817 |      1008 | 6.22M |  96979 |   59.0 | 4.0 |  15.7 | 106.5 | "31,41,51,61,71,81" | 0:38'21'' | 0:11'30'' |
| Q25L60X40P000  |   40.0 |  71.46% |      8788 | 106.77M | 20415 |      1006 | 6.99M | 102814 |   26.0 | 2.0 |   6.7 |  48.0 | "31,41,51,61,71,81" | 0:22'57'' | 0:24'03'' |
| Q25L60X40P001  |   40.0 |  71.45% |      8850 | 106.54M | 20262 |      1005 | 7.07M | 103662 |   26.0 | 2.0 |   6.7 |  48.0 | "31,41,51,61,71,81" | 0:22'55'' | 0:23'44'' |
| Q25L60X50P000  |   50.0 |  71.24% |      7131 | 109.81M | 24455 |      1007 | 8.06M | 116840 |   33.0 | 2.0 |   9.0 |  58.5 | "31,41,51,61,71,81" | 0:25'57'' | 0:26'03'' |
| Q25L60X60P000  |   60.0 |  70.24% |      5897 | 111.78M | 28230 |      1002 | 7.22M | 117819 |   40.0 | 3.0 |  10.3 |  73.5 | "31,41,51,61,71,81" | 0:28'50'' | 0:25'35'' |
| Q25L60XallP000 |   85.0 |  63.29% |      3740 | 109.65M | 37554 |      1006 | 6.57M | 101288 |   56.0 | 3.0 |  15.7 |  97.5 | "31,41,51,61,71,81" | 0:36'29'' | 0:15'39'' |
| Q30L60X40P000  |   40.0 |  71.81% |      9401 | 104.54M | 18912 |      1001 | 5.93M |  86922 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:22'35'' | 0:21'02'' |
| Q30L60X50P000  |   50.0 |  72.43% |      8800 | 105.64M | 19953 |      1005 | 8.14M |  98329 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:26'11'' | 0:23'32'' |
| Q30L60X60P000  |   60.0 |  72.50% |      8024 | 107.94M | 21649 |      1012 | 7.59M | 107391 |   41.0 | 3.0 |  10.7 |  75.0 | "31,41,51,61,71,81" | 0:29'31'' | 0:24'40'' |
| Q30L60XallP000 |   76.6 |  71.05% |      6543 | 109.73M | 25575 |      1011 | 8.05M | 107933 |   52.0 | 3.0 |  14.3 |  91.5 | "31,41,51,61,71,81" | 0:33'57'' | 0:24'08'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|-------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  77.13% |     11307 | 101.19M | 17052 |      1007 |  7.46M | 64962 |   26.0 | 1.0 |   7.7 |  43.5 | "31,41,51,61,71,81" | 0:11'41'' | 0:16'46'' |
| Q0L0X40P001    |   40.0 |  77.06% |     11190 | 101.04M | 17017 |      1010 |  7.58M | 64585 |   26.0 | 1.0 |   7.7 |  43.5 | "31,41,51,61,71,81" | 0:11'51'' | 0:16'09'' |
| Q0L0X50P000    |   50.0 |  77.57% |     12631 | 103.79M | 15089 |      1043 |  5.31M | 57993 |   33.0 | 2.0 |   9.0 |  58.5 | "31,41,51,61,71,81" | 0:13'53'' | 0:17'10'' |
| Q0L0X60P000    |   60.0 |  77.96% |     13223 | 104.77M | 14852 |      1105 |  6.71M | 57078 |   39.0 | 2.0 |  11.0 |  67.5 | "31,41,51,61,71,81" | 0:15'48'' | 0:17'58'' |
| Q0L0XallP000   |   90.1 |  78.89% |     14290 | 106.27M | 13784 |      1423 | 11.77M | 56936 |   59.0 | 4.0 |  15.7 | 106.5 | "31,41,51,61,71,81" | 0:20'07'' | 0:19'46'' |
| Q25L60X40P000  |   40.0 |  78.26% |     10665 | 102.59M | 16959 |      1007 |  4.11M | 64096 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:11'46'' | 0:16'58'' |
| Q25L60X40P001  |   40.0 |  78.25% |     10737 | 102.48M | 16821 |      1010 |  4.19M | 64374 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:11'40'' | 0:17'00'' |
| Q25L60X50P000  |   50.0 |  78.79% |     11781 | 103.58M | 15937 |      1029 |  4.96M | 59572 |   33.0 | 2.0 |   9.0 |  58.5 | "31,41,51,61,71,81" | 0:13'29'' | 0:17'05'' |
| Q25L60X60P000  |   60.0 |  79.15% |     12403 | 104.32M | 15479 |      1053 |  6.41M | 58324 |   40.0 | 2.0 |  11.3 |  69.0 | "31,41,51,61,71,81" | 0:15'33'' | 0:17'59'' |
| Q25L60XallP000 |   85.0 |  80.06% |     13374 | 105.77M | 14452 |      1284 |   9.4M | 57702 |   56.0 | 3.0 |  15.7 |  97.5 | "31,41,51,61,71,81" | 0:18'13'' | 0:19'12'' |
| Q30L60X40P000  |   40.0 |  78.88% |      9060 | 101.52M | 18831 |      1003 |  4.31M | 68040 |   27.0 | 2.0 |   7.0 |  49.5 | "31,41,51,61,71,81" | 0:11'19'' | 0:16'20'' |
| Q30L60X50P000  |   50.0 |  79.53% |     10069 | 102.32M | 17521 |      1008 |  5.11M | 63471 |   34.0 | 2.0 |   9.3 |  60.0 | "31,41,51,61,71,81" | 0:12'50'' | 0:16'32'' |
| Q30L60X60P000  |   60.0 |  79.78% |     10637 | 103.45M | 17101 |      1020 |  5.54M | 61927 |   41.0 | 2.0 |  11.7 |  70.5 | "31,41,51,61,71,81" | 0:14'26'' | 0:16'57'' |
| Q30L60XallP000 |   76.6 |  80.24% |     11436 | 104.69M | 16199 |      1056 |  6.35M | 61059 |   52.0 | 3.0 |  14.3 |  91.5 | "31,41,51,61,71,81" | 0:16'41'' | 0:18'41'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  79.89% |     14613 | 104.67M | 13128 |      1055 | 3.82M | 36264 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 0:28'20'' | 0:12'54'' |
| MRX40P001  |   40.0 |  79.48% |     14427 | 104.63M | 13177 |      1050 | 3.81M | 36080 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 0:28'20'' | 0:12'24'' |
| MRX40P002  |   40.0 |  79.39% |     14522 | 104.63M | 13127 |      1052 | 3.85M | 36181 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 0:28'21'' | 0:12'28'' |
| MRX50P000  |   50.0 |  78.93% |     14371 | 104.69M | 13219 |      1090 | 4.12M | 35899 |   38.0 | 3.0 |   9.7 |  70.5 | "31,41,51,61,71,81" | 0:33'01'' | 0:12'53'' |
| MRX50P001  |   50.0 |  78.95% |     14264 | 104.35M | 13226 |      1077 |  4.5M | 35855 |   38.0 | 2.0 |  10.7 |  66.0 | "31,41,51,61,71,81" | 0:33'13'' | 0:13'04'' |
| MRX60P000  |   60.0 |  78.80% |     14080 | 104.39M | 13373 |      1095 | 4.66M | 36156 |   46.0 | 3.0 |  12.3 |  82.5 | "31,41,51,61,71,81" | 0:37'37'' | 0:12'50'' |
| MRX60P001  |   60.0 |  78.49% |     14057 | 104.36M | 13302 |      1100 | 4.68M | 36068 |   46.0 | 3.0 |  12.3 |  82.5 | "31,41,51,61,71,81" | 0:37'32'' | 0:13'20'' |
| MRXallP000 |  120.2 |  77.12% |     12525 | 104.73M | 14429 |      1187 | 4.61M | 39321 |   92.0 | 6.0 |  20.0 | 165.0 | "31,41,51,61,71,81" | 1:05'01'' | 0:14'58'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |   Sum |     # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|------:|------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  86.13% |     14565 | 104.69M | 13250 |      1024 | 3.58M | 40492 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 2:22'47'' | 0:13'39'' |
| MRX40P001  |   40.0 |  86.05% |     14413 |  104.6M | 13307 |      1021 | 3.55M | 40361 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 2:30'25'' | 0:13'57'' |
| MRX40P002  |   40.0 |  86.28% |     14575 | 104.61M | 13228 |      1024 | 3.61M | 40494 |   30.0 | 2.0 |   8.0 |  54.0 | "31,41,51,61,71,81" | 2:17'06'' | 0:14'00'' |
| MRX50P000  |   50.0 |  85.62% |     14895 | 104.57M | 12952 |      1045 | 4.08M | 37053 |   38.0 | 2.0 |  10.7 |  66.0 | "31,41,51,61,71,81" | 3:13'24'' | 0:13'05'' |
| MRX50P001  |   50.0 |  85.64% |     14850 | 104.58M | 12993 |      1041 | 4.04M | 37003 |   38.0 | 2.0 |  10.7 |  66.0 | "31,41,51,61,71,81" | 2:40'30'' | 0:13'21'' |
| MRX60P000  |   60.0 |  85.39% |     15050 | 104.73M | 12802 |      1075 | 4.24M | 35510 |   46.0 | 3.0 |  12.3 |  82.5 | "31,41,51,61,71,81" | 2:11'16'' | 0:13'06'' |
| MRX60P001  |   60.0 |  85.45% |     15080 | 104.72M | 12801 |      1077 | 4.24M | 35442 |   46.0 | 3.0 |  12.3 |  82.5 | "31,41,51,61,71,81" | 3:09'00'' | 0:13'30'' |
| MRXallP000 |  120.2 |  85.01% |     14746 | 105.34M | 13010 |      1226 | 4.17M | 34715 |   92.0 | 6.0 |  20.0 | 165.0 | "31,41,51,61,71,81" | 5:14'35'' | 0:14'30'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |     # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|--------:|------:|----------:|-------:|------:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  66.22% |     17631 | 105.79M | 11511 |      1232 |  25.8M | 18764 |   59.0 | 3.0 |  16.7 | 102.0 | 0:14'57'' |
| 7_mergeKunitigsAnchors   |  77.69% |     14912 | 106.44M | 13328 |      1114 | 17.93M | 14757 |   59.0 | 3.0 |  16.7 | 102.0 | 0:32'30'' |
| 7_mergeMRKunitigsAnchors |  73.14% |     16525 | 104.95M | 11887 |      1334 |  5.95M |  4218 |   59.0 | 3.0 |  16.7 | 102.0 | 0:21'26'' |
| 7_mergeMRTadpoleAnchors  |  72.35% |     16245 |    105M | 12004 |      1303 |  5.83M |  4115 |   59.0 | 3.0 |  16.7 | 102.0 | 0:20'49'' |
| 7_mergeTadpoleAnchors    |  75.06% |     15628 | 105.64M | 12724 |      1342 | 17.88M | 12445 |   59.0 | 3.0 |  16.7 | 102.0 | 0:25'10'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |     # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|--------:|------:|----------:|-------:|------:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  79.47% |     47777 | 131.92M | 14331 |      1390 | 29.77M | 40821 |   53.0 | 48.0 |   3.0 | 106.0 | 0:14'40'' |
| 8_spades_MR  |  90.79% |     55027 | 113.96M |  5803 |      1750 |  7.05M | 13687 |   91.0 | 22.0 |   8.3 | 182.0 | 0:12'23'' |
| 8_megahit    |  75.33% |     19492 | 126.49M | 19060 |      1225 | 15.31M | 44974 |   55.0 | 47.0 |   3.0 | 110.0 | 0:13'10'' |
| 8_megahit_MR |  90.27% |     26683 | 110.67M |  8402 |      1735 |  8.76M | 20295 |   91.0 | 12.0 |  18.3 | 182.0 | 0:12'31'' |
| 8_platanus   |  64.72% |     48072 | 111.29M |  5919 |      1666 |  4.59M | 10717 |   59.0 |  4.0 |  15.7 | 106.5 | 0:11'47'' |


Table: statFinal

| Name                     |      N50 |       Sum |      # |
|:-------------------------|---------:|----------:|-------:|
| Genome                   | 23459830 | 119667750 |      7 |
| Paralogs                 |     2007 |  16447809 |   8055 |
| 7_mergeAnchors.anchors   |    17631 | 105785426 |  11511 |
| 7_mergeAnchors.others    |     1232 |  25801572 |  18764 |
| spades.contig            |     8038 | 228607128 | 262911 |
| spades.scaffold          |    11278 | 234018870 | 193144 |
| spades.non-contained     |    33548 | 161697325 |  26722 |
| spades_MR.contig         |    50269 | 124909417 |  18560 |
| spades_MR.scaffold       |    60056 | 124995829 |  17348 |
| spades_MR.non-contained  |    52796 | 121010682 |   8140 |
| megahit.contig           |     6290 | 195044031 | 159428 |
| megahit.non-contained    |    15779 | 141799029 |  26913 |
| megahit_MR.contig        |    22540 | 128931826 |  32755 |
| megahit_MR.non-contained |    24998 | 119430586 |  11923 |
| platanus.contig          |     7357 | 141505136 | 339360 |
| platanus.scaffold        |    62712 | 118432583 |  11460 |
| platanus.non-contained   |    64938 | 115881092 |   4796 |


# *Oryza sativa* Japonica Group Nipponbare

* Genome: [Ensembl Genomes](http://plants.ensembl.org/Oryza_sativa/Info/Index)
* Proportion of paralogs (> 1000 bp): 0.16

## nip: download

* Reference genome

```bash
mkdir -p ~/data/anchr/nip/1_genome
cd ~/data/anchr/nip/1_genome

aria2c -x 9 -s 3 -c ftp://ftp.ensemblgenomes.org/pub/release-29/plants/fasta/oryza_sativa/dna/Oryza_sativa.IRGSP-1.0.29.dna_sm.toplevel.fa.gz
faops order Oryza_sativa.IRGSP-1.0.29.dna_sm.toplevel.fa.gz \
    <(for chr in $(seq 1 1 12); do echo $chr; done) \
    genome.fa

cp ~/data/anchr/paralogs/model/Results/nip/nip.multi.fas paralogs.fas

```

* Illumina

    * HiSeq 180 bp [SRX734432](https://www.ncbi.nlm.nih.gov/sra/SRX2527206) SRR1614244
    * HiSeq 300 bp [SRX179254](https://www.ncbi.nlm.nih.gov/sra/SRX179254) SRR545231
    * MiSeq 450 bp [SRX179262](https://www.ncbi.nlm.nih.gov/sra/SRX179262:)

```bash
mkdir -p ~/data/anchr/nip/2_illumina
cd ~/data/anchr/nip/2_illumina

cat << EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR161/004/SRR1614244/SRR1614244_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR161/004/SRR1614244/SRR1614244_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR545/SRR545231/SRR545231_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR545/SRR545231/SRR545231_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547959/SRR547959_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547959/SRR547959_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547960/SRR547960_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547960/SRR547960_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547961/SRR547961_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547961/SRR547961_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547962/SRR547962_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547962/SRR547962_2.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547963/SRR547963_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR547/SRR547963/SRR547963_2.fastq.gz
EOF

aria2c -x 9 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
8ca85062cf7ef7fb21af1c22d16a5309 SRR1614244_1.fastq.gz
931f7c2d1e4d6518a19a9da71c57d966 SRR1614244_2.fastq.gz
40de697ca36bf716eaec81b33da981a0 SRR545231_1.fastq.gz
31c8db680b80c46c29ed676f92673d88 SRR545231_2.fastq.gz
f9d28190a3afe4de548093ca89c6fc1a SRR547959_1.fastq.gz
c0066dbb3324e9682c3aa261e0a68611 SRR547959_2.fastq.gz
8952369dfc210ec7a3576c1ed400a412 SRR547960_1.fastq.gz
350636b59d1f0ceec218eed53cb7a348 SRR547960_2.fastq.gz
b1e44beae52463be1208c2d8919507d1 SRR547961_1.fastq.gz
d99b2ba121242baa29eb6d328d6faa51 SRR547961_2.fastq.gz
e72f545e4867d8139330882d8831ec97 SRR547962_1.fastq.gz
a6c409d39676e7a04439dfe2db8cb3ac SRR547962_2.fastq.gz
3ae7f6a6776fe4380382e26d33f62166 SRR547963_1.fastq.gz
0e1ed356f77ee45e893cd143c42f3b23 SRR547963_2.fastq.gz
EOF

md5sum --check sra_md5.txt

pigz -d -c SRR5479{59..63}_1.fastq.gz | pigz > MiSeq_1.fq.gz
pigz -d -c SRR5479{59..63}_2.fastq.gz | pigz > MiSeq_2.fq.gz

```

* PacBio

    [SRX1897300](https://www.ncbi.nlm.nih.gov/sra/SRX1897300) SRR3743363

```bash
mkdir -p ~/data/anchr/nip/3_pacbio
cd ~/data/anchr/nip/3_pacbio

cat <<EOF > sra_ftp.txt
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR374/003/SRR3743363/SRR3743363_subreads.fastq.gz
EOF

aria2c -x 6 -s 3 -c -i sra_ftp.txt

cat << EOF > sra_md5.txt
a77a415cc45f4077d88f81976a59e078 SRR3743363_subreads.fastq.gz
EOF

md5sum --check sra_md5.txt

faops filter -l 0 SRR3743363_subreads.fastq.gz pacbio.fasta

```

* Rsync to hpcc

```bash
rsync -avP \
    --exclude="*_subreads.fastq.gz" \
    --exclude="SRR5479*" \
    ~/data/anchr/nip/ \
    wangq@202.119.37.251:data/anchr/nip

# rsync -avP wangq@202.119.37.251:data/anchr/nip/ ~/data/anchr/nip
# rsync -avP wangq@202.119.37.251:data/anchr/nip_pe300/ ~/data/anchr/nip_pe300
# rsync -avP wangq@202.119.37.251:data/anchr/nip_pe180/ ~/data/anchr/nip_pe180

```

## nip_pe300: symlink

```bash
mkdir -p ~/data/anchr/nip_pe300/1_genome
cd ~/data/anchr/nip_pe300/1_genome

ln -fs ../../nip/1_genome/genome.fa genome.fa
ln -fs ../../nip/1_genome/paralogs.fas paralogs.fas

mkdir -p ~/data/anchr/nip_pe300/2_illumina
cd ~/data/anchr/nip_pe300/2_illumina

ln -fs ../../nip/2_illumina/SRR545231_1.fastq.gz R1.fq.gz
ln -fs ../../nip/2_illumina/SRR545231_2.fastq.gz R2.fq.gz

ln -fs ../../nip/2_illumina/MiSeq_1.fq.gz S1.fq.gz
ln -fs ../../nip/2_illumina/MiSeq_2.fq.gz S2.fq.gz

```

## nip_pe300: template

* `fastqc` failed on MiSeq

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=nip_pe300

cd ${WORKING_DIR}/${BASE_NAME}

rm -f *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue largemem \
    --genome 373245519 \
    --is_euk \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe" \
    --qual2 "25" \
    --len2 "60" \
    --filter "adapter,phix,artifact" \
    --mergereads \
    --ecphase "1,3" \
    --cov2 "40 60 80 all" \
    --tadpole \
    --statp 5 \
    --redoanchors \
    --fillanchor \
    --parallel 24 \
    --xmx 240g

```

## nip_pe300: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=nip_pe300

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```

Table: statInsertSize

| Group             |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:------------------|------:|-------:|-------:|-------------------------------:|
| R.genome.bbtools  | 355.0 |    270 | 1720.0 |                         47.15% |
| R.tadpole.bbtools | 265.0 |    269 |   36.6 |                         25.80% |
| S.genome.bbtools  | 562.6 |    478 | 1800.0 |                         39.06% |
| S.tadpole.bbtools | 437.6 |    470 |   83.3 |                         22.23% |
| R.genome.picard   | 267.8 |    270 |   23.4 |                             FR |
| R.tadpole.picard  | 264.1 |    268 |   33.7 |                             FR |
| S.genome.picard   | 466.8 |    478 |   52.5 |                             FR |
| S.tadpole.picard  | 444.0 |    471 |   75.6 |                             FR |


Table: statReads

| Name       |      N50 |       Sum |         # |
|:-----------|---------:|----------:|----------:|
| Genome     | 29958434 | 373245519 |        12 |
| Paralogs   |     2842 |  88451827 |     36289 |
| Illumina.R |      101 |    17.22G | 170502194 |
| trim.R     |      100 |    14.56G | 150128474 |
| Q25L60     |      100 |    13.72G | 142307299 |
| Illumina.S |      251 |    14.66G |  58388638 |
| trim.S     |      204 |     9.91G |  53703334 |
| Q25L60     |      196 |     8.82G |  50216252 |


Table: statTrimReads

| Name     | N50 |    Sum |         # |
|:---------|----:|-------:|----------:|
| clumpify | 101 | 16.98G | 168069864 |
| trim     | 100 |  14.7G | 151582888 |
| filter   | 100 | 14.56G | 150128474 |
| R1       | 100 |   7.3G |  75064237 |
| R2       | 100 |  7.25G |  75064237 |
| Rs       |   0 |      0 |         0 |
| clumpify | 251 | 14.65G |  58378514 |
| trim     | 204 |  9.91G |  53703334 |
| filter   | 204 |  9.91G |  53703334 |
| S1       | 221 |  5.33G |  26851667 |
| S2       | 190 |  4.59G |  26851667 |
| Ss       |   0 |      0 |         0 |


```text
#R.trim
#Matched    554500  0.32992%
#Name   Reads   ReadsPct
pcr_dimer   275777  0.16408%
```

```text
#R.filter
#Matched    1454335 0.95943%
#Name   Reads   ReadsPct
gi|9626372|ref|NC_001422.1| Coliphage phiX174, complete genome  1454335 0.95943%
```

```text
#R.peaks
#k  31
#unique_kmers   401621605
#main_peak  29
#genome_size    285342375
#haploid_genome_size    285342375
#fold_coverage  29
#haploid_fold_coverage  29
#ploidy 1
#percent_repeat 9.059
#start  center  stop    max volume
```


```text
#S.trim
#Matched    5198001 8.90396%
#Name   Reads   ReadsPct
pcr_dimer   4034972 6.91174%
PCR_Primers 676732  1.15921%
TruSeq_Universal_Adapter    227739  0.39011%
PhiX_read1_adapter  70932   0.12150%
Nextera_LMP_Read2_External_Adapter  65027   0.11139%
TruSeq_Adapter_Index_1_6    59489   0.10190%
```

```text
#S.filter
#Matched    0   0.00000%
#Name   Reads   ReadsPct
```

```text
#S.peaks
#k  31
#unique_kmers   538719816
#main_peak  23
#genome_size    287276457
#haploid_genome_size    287276457
#fold_coverage  23
#haploid_fold_coverage  23
#ploidy 1
#percent_repeat 8.177
#start  center  stop    max volume
```


Table: statMergeReads

| Name          | N50 |    Sum |         # |
|:--------------|----:|-------:|----------:|
| clumped       | 100 | 14.55G | 150071482 |
| ecco          | 100 | 14.55G | 150071482 |
| ecct          | 100 | 13.74G | 141572878 |
| extended      | 140 | 18.91G | 141572878 |
| merged.raw    | 309 | 18.29G |  60084049 |
| unmerged.raw  | 124 |  2.54G |  21404780 |
| unmerged.trim | 124 |  2.54G |  21404420 |
| M1            | 309 | 18.11G |  59475937 |
| U1            | 124 |  1.27G |  10702210 |
| U2            | 123 |  1.26G |  10702210 |
| Us            |   0 |      0 |         0 |
| M.cor         | 306 | 20.71G | 140356294 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| M.ihist.merge1.txt | 133.6 |    136 |  33.1 |          1.86% |
| M.ihist.merge.txt  | 304.4 |    308 |  28.6 |         84.88% |

| Name          | N50 |     Sum |        # |
|:--------------|----:|--------:|---------:|
| clumped       | 204 |   9.91G | 53673054 |
| ecco          | 204 |   9.91G | 53673054 |
| ecct          | 205 |   8.56G | 46143636 |
| extended      | 241 |  10.27G | 46143636 |
| merged.raw    | 515 |    8.3G | 18237512 |
| unmerged.raw  | 193 |   1.72G |  9668612 |
| unmerged.trim | 193 |   1.72G |  9664308 |
| N1            | 515 |   8.24G | 18092828 |
| V1            | 209 | 941.28M |  4832154 |
| V2            | 173 |  780.2M |  4832154 |
| Vs            |   0 |       0 |        0 |
| N.cor         | 507 |   9.98G | 45849964 |

| Group              |  Mean | Median | STDev | PercentOfPairs |
|:-------------------|------:|-------:|------:|---------------:|
| N.ihist.merge1.txt | 249.9 |    228 | 117.3 |         19.41% |
| N.ihist.merge.txt  | 455.3 |    509 | 121.9 |         79.05% |


Table: statQuorum

| Name     | CovIn | CovOut | Discard% |  Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:---------|------:|-------:|---------:|------:|--------:|--------:|---------:|----------:|
| Q0L0.R   |  39.0 |   37.6 |    3.69% |  "71" | 373.25M | 292.04M |     0.78 | 0:26'46'' |
| Q25L60.R |  36.8 |   35.8 |    2.59% |  "71" | 373.25M | 289.61M |     0.78 | 0:26'02'' |
| Q0L0.S   |  26.6 |   22.0 |   17.00% | "115" | 373.25M | 291.65M |     0.78 | 0:17'18'' |
| Q25L60.S |  23.6 |   21.5 |    9.23% | "107" | 373.25M | 287.91M |     0.77 | 0:16'21'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  77.31% |      4717 | 246.98M | 70720 |       876 | 24.49M | 241335 |   42.0 | 5.0 |   9.0 |  84.0 | "31,41,51,61,71,81" | 1:57'10'' | 1:43'35'' |
| Q0L0XallP000   |   59.6 |  76.31% |      4637 | 245.53M | 70627 |       880 | 26.87M | 223179 |   62.0 | 7.0 |  13.7 | 124.0 | "31,41,51,61,71,81" | 2:23'53'' | 1:30'45'' |
| Q25L60X40P000  |   40.0 |  77.84% |      4402 | 239.29M | 72025 |       963 | 30.84M | 253362 |   42.0 | 4.0 |  10.0 |  81.0 | "31,41,51,61,71,81" | 1:55'17'' | 1:42'48'' |
| Q25L60XallP000 |   57.3 |  77.44% |      4449 | 240.56M | 71404 |       945 |  31.3M | 238899 |   61.0 | 7.0 |  13.3 | 122.0 | "31,41,51,61,71,81" | 2:18'33'' | 1:37'21'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median | MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  79.99% |      4619 | 244.39M | 71620 |       836 | 26.34M | 278831 |   42.0 | 4.0 |  10.0 |  81.0 | "31,41,51,61,71,81" | 1:22'09'' | 2:05'29'' |
| Q0L0XallP000   |   59.6 |  79.80% |      4931 | 248.07M | 68845 |       835 | 26.21M | 254343 |   63.0 | 7.0 |  14.0 | 126.0 | "31,41,51,61,71,81" | 1:31'42'' | 1:55'14'' |
| Q25L60X40P000  |   40.0 |  79.85% |      4229 | 235.83M | 73527 |       987 | 31.58M | 287042 |   43.0 | 4.0 |  10.3 |  82.5 | "31,41,51,61,71,81" | 1:19'08'' | 2:02'21'' |
| Q25L60XallP000 |   57.3 |  80.12% |      4480 | 239.51M | 71200 |       952 | 32.76M | 270420 |   61.0 | 6.0 |  14.3 | 118.5 | "31,41,51,61,71,81" | 1:27'32'' | 1:56'01'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  68.14% |      4454 | 231.91M | 68387 |       722 | 19.93M | 166687 |   45.0 |  6.0 |   9.0 |  90.0 | "31,41,51,61,71,81" | 2:17'46'' | 0:48'25'' |
| MRX40P001  |   40.0 |  68.20% |      4460 | 231.89M | 68431 |       725 | 20.08M | 167087 |   45.0 |  6.0 |   9.0 |  90.0 | "31,41,51,61,71,81" | 2:18'12'' | 0:48'06'' |
| MRX60P000  |   60.0 |  67.82% |      4304 | 229.54M | 69407 |       742 | 22.17M | 170154 |   68.0 |  9.0 |  13.7 | 136.0 | "31,41,51,61,71,81" | 2:55'52'' | 0:49'44'' |
| MRX80P000  |   80.0 |  67.62% |      4248 |  230.4M | 70386 |       674 | 20.36M | 173143 |   92.0 | 14.0 |  16.7 | 184.0 | "31,41,51,61,71,81" | 3:34'06'' | 0:53'01'' |
| MRXallP000 |   82.2 |  67.61% |      4226 | 229.64M | 70425 |       697 | 21.24M | 173346 |   94.0 | 14.0 |  17.3 | 188.0 | "31,41,51,61,71,81" | 3:38'29'' | 0:50'53'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  70.84% |      4756 | 235.24M | 66402 |       614 | 18.64M | 169445 |   45.0 |  6.0 |   9.0 |  90.0 | "31,41,51,61,71,81" | 1:11'56'' | 1:03'20'' |
| MRX40P001  |   40.0 |  70.66% |      4762 | 235.02M | 66270 |       651 | 18.73M | 169233 |   45.0 |  6.0 |   9.0 |  90.0 | "31,41,51,61,71,81" | 1:12'15'' | 1:03'03'' |
| MRX60P000  |   60.0 |  70.70% |      4692 |  235.3M | 66945 |       637 | 19.13M | 171669 |   69.0 | 10.0 |  13.0 | 138.0 | "31,41,51,61,71,81" | 1:19'54'' | 1:05'46'' |
| MRX80P000  |   80.0 |  70.70% |      4610 | 234.73M | 67517 |       640 | 19.68M | 174718 |   92.0 | 14.0 |  16.7 | 184.0 | "31,41,51,61,71,81" | 1:27'58'' | 1:08'29'' |
| MRXallP000 |   82.2 |  70.73% |      4590 | 234.06M | 67524 |       653 | 20.54M | 175033 |   95.0 | 14.0 |  17.7 | 190.0 | "31,41,51,61,71,81" | 1:27'14'' | 1:08'00'' |


Table: statMergeAnchors.md

| Name                     | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |     # | median | MAD | lower | upper | RunTimeAN |
|:-------------------------|--------:|----------:|--------:|------:|----------:|-------:|------:|-------:|----:|------:|------:|----------:|
| 7_mergeAnchors           |  73.51% |      5533 |    239M | 60328 |      1092 | 53.05M | 47518 |   64.0 | 6.0 |  15.3 | 123.0 | 0:58'47'' |
| 7_mergeKunitigsAnchors   |  76.55% |      5105 | 242.38M | 64759 |      1086 | 33.58M | 30406 |   63.0 | 6.0 |  15.0 | 121.5 | 1:23'53'' |
| 7_mergeMRKunitigsAnchors |  75.69% |      4755 | 230.07M | 64739 |      1075 | 21.91M | 20177 |   63.0 | 6.0 |  15.0 | 121.5 | 1:11'45'' |
| 7_mergeMRTadpoleAnchors  |  76.42% |      4962 |  232.5M | 63411 |      1075 | 20.38M | 18670 |   63.0 | 6.0 |  15.0 | 121.5 | 1:11'42'' |
| 7_mergeTadpoleAnchors    |  74.83% |      5132 | 242.12M | 64577 |      1075 | 34.09M | 30837 |   63.0 | 6.0 |  15.0 | 121.5 | 1:10'18'' |


Table: statOtherAnchors.md

| Name         | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper | RunTimeAN |
|:-------------|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|----------:|
| 8_spades     |  79.73% |      8027 |  270.2M | 50915 |       972 | 20.91M |  90513 |   63.0 |  6.0 |  15.0 | 121.5 | 0:50'31'' |
| 8_spades_MR  |  82.21% |      7279 | 270.85M | 54707 |       794 | 20.68M |  99468 |   94.0 | 12.0 |  19.3 | 188.0 | 0:48'36'' |
| 8_megahit    |  73.40% |      5611 | 247.41M | 62064 |      1001 | 22.27M | 119703 |   62.0 |  6.0 |  14.7 | 120.0 | 0:39'21'' |
| 8_megahit_MR |  80.26% |      6254 | 265.25M | 61265 |       878 | 23.68M | 121153 |   94.0 | 14.0 |  17.3 | 188.0 | 0:44'02'' |
| 8_platanus   |  79.88% |      8604 | 276.56M | 49946 |       921 |  18.6M |  90093 |   63.0 |  6.0 |  15.0 | 121.5 | 0:53'54'' |


Table: statFinal

| Name                     |      N50 |       Sum |       # |
|:-------------------------|---------:|----------:|--------:|
| Genome                   | 29958434 | 373245519 |      12 |
| Paralogs                 |     2842 |  88451827 |   36289 |
| 7_mergeAnchors.anchors   |     5533 | 239004468 |   60328 |
| 7_mergeAnchors.others    |     1092 |  53048773 |   47518 |
| anchorLong               |    11694 |   6109247 |     730 |
| anchorFill               |    11836 |   6101555 |     718 |
| spades.contig            |    10498 | 333178098 |  317779 |
| spades.scaffold          |    10600 | 333194034 |  317377 |
| spades.non-contained     |    12389 | 291112407 |   39619 |
| spades_MR.contig         |     9570 | 300510916 |   72822 |
| spades_MR.scaffold       |    10680 | 300919712 |   69023 |
| spades_MR.non-contained  |     9875 | 291558054 |   45025 |
| megahit.contig           |     6031 | 306910815 |  145228 |
| megahit.non-contained    |     7100 | 269708904 |   57652 |
| megahit_MR.contig        |     6264 | 327073836 |  140532 |
| megahit_MR.non-contained |     7260 | 288945148 |   60053 |
| platanus.contig          |     2164 | 408036693 | 1141507 |
| platanus.scaffold        |    11221 | 315724276 |  135931 |
| platanus.non-contained   |    12104 | 295160826 |   40146 |


## nip_pe180: run

```bash
WORKING_DIR=${HOME}/data/anchr
BASE_NAME=nip_pe180

cd ${WORKING_DIR}/${BASE_NAME}
#rm -fr 4_*/ 6_*/ 7_*/ 8_*/ && rm -fr 2_illumina/trim 2_illumina/mergereads statReads.md 

bash 0_bsub.sh
#bkill -J "${BASE_NAME}-*"

#bash 0_master.sh
#bash 0_cleanup.sh

```


Table: statInsertSize

| Group           |  Mean | Median |  STDev | PercentOfPairs/PairOrientation |
|:----------------|------:|-------:|-------:|-------------------------------:|
| genome.bbtools  | 213.3 |    175 | 1209.1 |                         43.41% |
| tadpole.bbtools | 161.6 |    162 |   44.7 |                         32.19% |
| genome.picard   | 173.0 |    177 |   36.6 |                             FR |
| tadpole.picard  | 164.1 |    165 |   41.6 |                             FR |
| tadpole.picard  | 113.4 |    110 |   17.1 |                             RF |


Table: statReads

| Name      |      N50 |       Sum |         # |
|:----------|---------:|----------:|----------:|
| Genome    | 29958434 | 373245519 |        12 |
| Paralogs  |     2842 |  88451827 |     36289 |
| Illumina  |      101 |     49.5G | 490080436 |
| trim      |      100 |    42.18G | 436041412 |
| Q25L60    |      100 |    39.23G | 407293560 |
| Q30L60    |      100 |    34.71G | 365583577 |
| PacBio    |     3843 |    12.75G |   4569941 |
| Xall.raw  |     3843 |    12.75G |   4569941 |
| Xall.trim |     3731 |     9.13G |   2880183 |


Table: statTrimReads

| Name     | N50 |    Sum |         # |
|:---------|----:|-------:|----------:|
| clumpify | 101 |  48.7G | 482148792 |
| trim     | 100 | 42.31G | 437362526 |
| filter   | 100 | 42.18G | 436041412 |
| R1       | 100 | 21.11G | 218020706 |
| R2       | 100 | 21.08G | 218020706 |
| Rs       |   0 |      0 |         0 |


```text
#trim
#Matched    49418746    10.24969%
#Name   Reads   ReadsPct
pcr_dimer   28297190    5.86897%
PCR_Primers 5344003 1.10837%
Nextera_LMP_Read2_External_Adapter  5003882 1.03783%
TruSeq_Adapter_Index_1_6    4635975 0.96152%
PhiX_read1_adapter  3831069 0.79458%
Reverse_adapter 1625329 0.33710%
TruSeq_Universal_Adapter    479753  0.09950%
PhiX_read2_adapter  52478   0.01088%
I5_Nextera_Transposase_1    22467   0.00466%
I5_Nextera_Transposase_2    19363   0.00402%
RNA_Adapter_(RA5)_part_#_15013205   13570   0.00281%
Bisulfite_R2    12962   0.00269%
I5_Primer_Nextera_XT_and_Nextera_Enrichment_[N/S/E]501  10072   0.00209%
I7_Nextera_Transposase_2    7825    0.00162%
RNA_PCR_Primer_Index_1_(RPI1)_2,9   7132    0.00148%
I7_Primer_Nextera_XT_and_Nextera_Enrichment_N701    7046    0.00146%
I7_Nextera_Transposase_1    6647    0.00138%
Nextera_LMP_Read1_External_Adapter  5313    0.00110%
I5_Adapter_Nextera  4801    0.00100%
Bisulfite_R1    3632    0.00075%
I7_Adapter_Nextera_No_Barcode   3071    0.00064%
RNA_PCR_Primer_(RP1)_part_#_15013198    2784    0.00058%
```

```text
#filter
#Matched    1320251 0.30187%
#Name   Reads   ReadsPct
gi|9626372|ref|NC_001422.1| Coliphage phiX174, complete genome  1319530 0.30170%
contam_129  152 0.00003%
contam_32   136 0.00003%
```


Table: statMergeReads

| Name          | N50 |     Sum |         # |
|:--------------|----:|--------:|----------:|
| clumped       | 100 |  42.17G | 435882618 |
| ecco          | 100 |  42.17G | 435882618 |
| ecct          | 100 |  38.88G | 402035290 |
| extended      | 140 |  53.91G | 402035290 |
| merged        | 217 |  39.13G | 195895582 |
| unmerged.raw  | 129 |   1.27G |  10244126 |
| unmerged.trim | 129 |   1.27G |  10240950 |
| U1            | 129 | 636.35M |   5120475 |
| U2            | 129 | 630.75M |   5120475 |
| Us            |   0 |       0 |         0 |
| pe.cor        | 215 |   40.6G | 402032114 |

| Group            |  Mean | Median | STDev | PercentOfPairs |
|:-----------------|------:|-------:|------:|---------------:|
| ihist.merge1.txt | 136.5 |    142 |  34.3 |         60.38% |
| ihist.merge.txt  | 199.8 |    207 |  45.7 |         97.45% |


Table: statQuorum

| Name   | CovIn | CovOut | Discard% | AvgRead | Kmer |   RealG |    EstG | Est/Real |   RunTime |
|:-------|------:|-------:|---------:|--------:|-----:|--------:|--------:|---------:|----------:|
| Q0L0   | 352.5 |  324.4 |    7.97% |      97 | "71" | 119.67M | 304.93M |     2.55 | 1:14'37'' |
| Q25L60 | 328.0 |  307.7 |    6.18% |      97 | "71" | 119.67M | 300.76M |     2.51 | 1:09'08'' |
| Q30L60 | 290.3 |  275.2 |    5.18% |      96 | "71" | 119.67M | 298.28M |     2.49 | 1:03'45'' |


Table: statKunitigsAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  79.10% |      3703 | 204.02M | 71500 |      2741 | 79.63M | 241259 |   33.0 | 10.0 |   3.0 |  66.0 | "31,41,51,61,71,81" | 1:42'35'' | 1:15'51'' |
| Q0L0X40P001    |   40.0 |  79.12% |      3692 | 204.01M | 71443 |      2767 | 79.57M | 241312 |   33.0 | 10.0 |   3.0 |  66.0 | "31,41,51,61,71,81" | 1:42'42'' | 1:16'11'' |
| Q0L0X80P000    |   80.0 |  77.38% |      4170 | 211.09M | 67550 |      2552 | 62.12M | 200386 |   64.0 | 22.0 |   3.0 | 128.0 | "31,41,51,61,71,81" | 2:37'23'' | 1:17'36'' |
| Q0L0XallP000   |  104.0 |  75.93% |      4133 | 214.82M | 68783 |      2315 | 52.06M | 185684 |   85.0 | 30.0 |   3.0 | 170.0 | "31,41,51,61,71,81" | 3:04'23'' | 1:14'53'' |
| Q25L60X40P000  |   40.0 |  79.83% |      3675 | 205.89M | 72306 |      2811 | 80.64M | 248142 |   34.0 | 11.0 |   3.0 |  68.0 | "31,41,51,61,71,81" | 1:43'07'' | 1:20'53'' |
| Q25L60X40P001  |   40.0 |  79.80% |      3674 |  205.9M | 72439 |      2809 | 80.73M | 247963 |   34.0 | 11.0 |   3.0 |  68.0 | "31,41,51,61,71,81" | 1:43'10'' | 1:19'44'' |
| Q25L60X80P000  |   80.0 |  78.83% |      4184 | 209.19M | 67114 |      2745 | 70.76M | 209876 |   64.0 | 22.0 |   3.0 | 128.0 | "31,41,51,61,71,81" | 2:39'06'' | 1:23'04'' |
| Q25L60XallP000 |   98.7 |  78.00% |      4212 | 212.66M | 67383 |      2607 | 62.55M | 196872 |   80.0 | 28.0 |   3.0 | 160.0 | "31,41,51,61,71,81" | 3:01'07'' | 1:21'31'' |
| Q30L60X40P000  |   40.0 |  80.00% |      3347 | 200.13M | 75053 |      2750 | 87.57M | 260831 |   35.0 | 11.0 |   3.0 |  70.0 | "31,41,51,61,71,81" | 1:39'18'' | 1:20'11'' |
| Q30L60X40P001  |   40.0 |  80.05% |      3336 | 200.34M | 75178 |      2727 | 87.96M | 260846 |   35.0 | 11.0 |   3.0 |  70.0 | "31,41,51,61,71,81" | 1:39'28'' | 1:20'17'' |
| Q30L60X80P000  |   80.0 |  80.05% |      3860 | 207.19M | 70147 |      2801 | 79.77M | 232998 |   66.0 | 22.0 |   3.0 | 132.0 | "31,41,51,61,71,81" | 2:36'18'' | 1:32'56'' |
| Q30L60XallP000 |   88.2 |  79.83% |      3889 | 206.37M | 69533 |      2797 | 79.73M | 226673 |   72.0 | 24.0 |   3.0 | 144.0 | "31,41,51,61,71,81" | 2:46'15'' | 1:30'44'' |


Table: statTadpoleAnchors.md

| Name           | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:---------------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| Q0L0X40P000    |   40.0 |  80.59% |      3532 | 199.29M | 72054 |      3099 | 87.21M | 247928 |   34.0 | 11.0 |   3.0 |  68.0 | "31,41,51,61,71,81" | 0:53'48'' | 1:11'46'' |
| Q0L0X40P001    |   40.0 |  80.58% |      3534 | 198.96M | 71857 |      3129 | 87.42M | 247922 |   34.0 | 11.0 |   3.0 |  68.0 | "31,41,51,61,71,81" | 0:53'43'' | 1:11'54'' |
| Q0L0X80P000    |   80.0 |  82.09% |      4548 | 213.61M | 65097 |      3533 | 77.94M | 215458 |   64.0 | 21.0 |   3.0 | 128.0 | "31,41,51,61,71,81" | 1:25'16'' | 1:32'42'' |
| Q0L0XallP000   |  104.0 |  81.92% |      4787 | 215.11M | 63041 |      3517 | 75.11M | 196172 |   82.0 | 27.0 |   3.0 | 164.0 | "31,41,51,61,71,81" | 1:34'33'' | 1:32'11'' |
| Q25L60X40P000  |   40.0 |  80.77% |      3414 |  199.1M | 73476 |      3024 | 85.92M | 254282 |   35.0 | 11.0 |   3.0 |  70.0 | "31,41,51,61,71,81" | 0:52'44'' | 1:13'14'' |
| Q25L60X40P001  |   40.0 |  80.74% |      3424 | 199.16M | 73498 |      3057 | 85.99M | 254224 |   35.0 | 11.0 |   3.0 |  70.0 | "31,41,51,61,71,81" | 0:53'01'' | 1:13'04'' |
| Q25L60X80P000  |   80.0 |  82.62% |      4354 |  212.6M | 66810 |      3560 | 83.22M | 226608 |   65.0 | 21.0 |   3.0 | 130.0 | "31,41,51,61,71,81" | 1:24'30'' | 1:36'09'' |
| Q25L60XallP000 |   98.7 |  82.58% |      4566 | 213.65M | 64824 |      3569 |  81.3M | 211451 |   79.0 | 26.0 |   3.0 | 158.0 | "31,41,51,61,71,81" | 1:32'21'' | 1:37'37'' |
| Q30L60X40P000  |   40.0 |  80.25% |      3067 | 190.64M | 75626 |      2798 | 88.72M | 263413 |   36.0 | 11.0 |   3.0 |  72.0 | "31,41,51,61,71,81" | 0:49'29'' | 1:11'24'' |
| Q30L60X40P001  |   40.0 |  80.33% |      3071 | 190.63M | 75687 |      2753 | 89.32M | 263245 |   36.0 | 11.0 |   3.0 |  72.0 | "31,41,51,61,71,81" | 0:49'15'' | 1:10'58'' |
| Q30L60X80P000  |   80.0 |  82.91% |      3809 | 207.75M | 71298 |      3298 | 92.54M | 252017 |   67.0 | 21.0 |   3.0 | 134.0 | "31,41,51,61,71,81" | 1:19'28'' | 1:42'27'' |
| Q30L60XallP000 |   88.2 |  83.04% |      3938 | 210.37M | 70585 |      3345 | 89.48M | 246662 |   74.0 | 24.0 |   3.0 | 148.0 | "31,41,51,61,71,81" | 1:23'40'' | 1:46'02'' |


Table: statMRKunitigsAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  75.44% |      4491 | 206.43M | 62218 |      3144 | 54.38M | 127639 |   34.0 | 12.0 |   3.0 |  68.0 | "31,41,51,61,71,81" | 2:32'09'' | 0:40'25'' |
| MRX40P001  |   40.0 |  75.46% |      4499 | 206.41M | 62203 |      3125 | 54.47M | 127560 |   34.0 | 12.0 |   3.0 |  68.0 | "31,41,51,61,71,81" | 2:31'58'' | 0:40'30'' |
| MRX80P000  |   80.0 |  74.00% |      4266 | 211.48M | 65589 |      2893 | 45.93M | 122213 |   69.0 | 24.0 |   3.0 | 138.0 | "31,41,51,61,71,81" | 3:50'22'' | 0:44'43'' |
| MRXallP000 |  108.8 |  73.14% |      4118 |  212.9M | 67420 |      2744 |  42.3M | 119965 |   95.0 | 32.0 |   3.0 | 190.0 | "31,41,51,61,71,81" | 4:46'01'' | 0:46'53'' |


Table: statMRTadpoleAnchors.md

| Name       | CovCor | Mapped% | N50Anchor |     Sum |     # | N50Others |    Sum |      # | median |  MAD | lower | upper |                Kmer | RunTimeKU | RunTimeAN |
|:-----------|-------:|--------:|----------:|--------:|------:|----------:|-------:|-------:|-------:|-----:|------:|------:|--------------------:|----------:|----------:|
| MRX40P000  |   40.0 |  77.96% |      4505 | 197.43M | 59851 |      3747 |    67M | 127069 |   32.0 | 11.0 |   3.0 |  64.0 | "31,41,51,61,71,81" | 1:22'12'' | 0:40'39'' |
| MRX40P001  |   40.0 |  77.94% |      4517 | 197.31M | 59662 |      3759 | 67.29M | 126649 |   32.0 | 11.0 |   3.0 |  64.0 | "31,41,51,61,71,81" | 1:21'49'' | 0:40'47'' |
| MRX80P000  |   80.0 |  77.44% |      4787 | 213.44M | 61445 |      3510 | 50.07M | 110922 |   68.0 | 24.0 |   3.0 | 136.0 | "31,41,51,61,71,81" | 1:41'43'' | 0:46'55'' |
| MRXallP000 |  108.8 |  77.27% |      4727 | 215.22M | 62351 |      3478 |  48.5M | 105636 |   93.0 | 32.0 |   3.0 | 186.0 | "31,41,51,61,71,81" | 1:55'47'' | 0:49'51'' |


Table: statFinal

| Name                             |      N50 |       Sum |       # |
|:---------------------------------|---------:|----------:|--------:|
| Genome                           | 29958434 | 373245519 |      12 |
| Paralogs                         |     2842 |  88451827 |   36289 |
| 7_mergeKunitigsAnchors.anchors   |     5363 | 240787806 |   66809 |
| 7_mergeKunitigsAnchors.others    |     3427 | 152146559 |   62088 |
| 7_mergeTadpoleAnchors.anchors    |     5174 | 242678225 |   68994 |
| 7_mergeTadpoleAnchors.others     |     3620 | 146909552 |   58710 |
| 7_mergeMRKunitigsAnchors.anchors |     4993 | 223941334 |   62953 |
| 7_mergeMRKunitigsAnchors.others  |     3462 |  69282117 |   27735 |
| 7_mergeMRTadpoleAnchors.anchors  |     5141 | 221096838 |   60828 |
| 7_mergeMRTadpoleAnchors.others   |     4042 |  82103467 |   29718 |
| 7_mergeAnchors.anchors           |     6003 | 248451868 |   63541 |
| 7_mergeAnchors.others            |     3506 | 180159633 |   75109 |
| spades.contig                    |    12514 | 351318316 |  381553 |
| spades.scaffold                  |    12831 | 351338323 |  380642 |
| spades.non-contained             |    15457 | 299243861 |   35762 |
| spades.anchor                    |     9660 | 240430520 |   43321 |
| megahit.contig                   |     6632 | 307254168 |  135080 |
| megahit.non-contained            |     7787 | 272070666 |   54912 |
| megahit.anchor                   |     5780 | 217367537 |   55256 |
| platanus.contig                  |     2364 | 410328234 | 1140381 |
| platanus.scaffold                |     9646 | 311671367 |  150025 |
| platanus.non-contained           |    10787 | 284255639 |   43921 |
| platanus.anchor                  |     6662 | 217741681 |   50714 |
