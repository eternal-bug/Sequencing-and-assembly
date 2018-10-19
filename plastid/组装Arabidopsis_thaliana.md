# Arabidopsis thaliana[拟南芥]

## 基本信息
+ Genome: GCF_000001735.3, TAIR10, 119.668 Mb
+ Chloroplast: NC_000932, 154478 bp
+ Mitochondrion: Y08501, 366924 bp

## 数据来源1
+ 测序数据：Illumina Hiseq
+ [《Great majority of recombination events in Arabidopsis are gene conversionevents》](http://www.pnas.org/content/109/51/20992)
+ PRJNA178613
+ [补充](http://www.pnas.org/highwire/filestream/611045/field_highwire_adjunct_files/0/sapp.pdf)
> The Arabidopsis thaliana accession “Columbia-0” (Col) and “Landsberg erecta” (Ler)
> were obtained from Joy Bergelson (University of Chicago). In total, there are 75
> sequenced F2 genomes with 1649×coverage. In addition, one of Ler (Ler4) and Col
> (Col3) were independently sequenced thrice with ~29.8×coverage in each sequencing.
> The other 3 Ler (Ler1, Ler2 and Ler3) and 2 Col plants (Col1 and Col2) were sequenced
> with ~21.2× coverage. 

```
Columbia-0(Col)       ==> Sample_Col_G    ==> SRR611086 SRR616966
Landsberg erecta(Ler) ==> Sample_Ler_XL_4 ==> SRR611087 SRR616965
```

## 数据来源2
+ 测序数据：Illumina MiSeq
+ PRJNA369183
+ SRR5216995

## 文件信息
project| type | NO | size.bp | coverage	| insert | read.len | seq type| com | other |
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
PRJNA178613 | Col | SRR611086 | | | | | Illumina HiSeq
PRJNA178613 | Col | SRR616966 | | | | | Illumina HiSeq
PRJNA178613 | Ler | SRR611087 | 5,079,145,000 * 2 | ~83 | | | Illumina HiSeq
PRJNA178613 | Ler | SRR616965 | 2,543,625,500 * 2 | ~41 | | | Illumina HiSeq
PRJNA369183 | Col | SRR5216995 | | | | | Illumina MiSeq

## 组装col

### Hiseq

#### SRR611086
```

```


#### SRR616966
```

```

### Miseq

#### SRR5216995

## 组装Ler

### SRR611087

+ ~83

```bash
WORKING_DIR=~/stq/data/anchr/Arabidopsis_thaliana
BASE_NAME=SRR611087
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 332 --cutk 31" \
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
```

### SRR616965

+ ~41

```bash
WORKING_DIR=~/stq/data/anchr/Arabidopsis_thaliana
BASE_NAME=SRR616965
cd ${WORKING_DIR}/${BASE_NAME}
bash 0_realClean.sh

anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 164 --cutk 31" \
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
```
