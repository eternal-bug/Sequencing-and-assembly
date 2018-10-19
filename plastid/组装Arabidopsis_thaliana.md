# *Arabidopsis thaliana*[拟南芥]

## 缩写说明
+ Ler is Landsbergerecta 
+ Col is Columbia
+ Ws  is Wassilewskija
为拟南芥常见的生态型

## 基本信息
+ Genome: GCF_000001735.3, TAIR10,  119.668 Mb
+ Chloroplast: [NC_000932](https://www.ncbi.nlm.nih.gov/nuccore/NC_000932), **Columbia**, 154478 bp , [文章](https://watermark.silverchair.com/dnares_6_5_283.pdf?token=AQECAHi208BE49Ooan9kkhW_Ercy7Dm3ZL_9Cf3qfKAc485ysgAAAj4wggI6BgkqhkiG9w0BBwagggIrMIICJwIBADCCAiAGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMd-POKnyXwGAWhHWtAgEQgIIB8WoNwMNhBQ1od7x9NaALzl6cSMYfg4xVmK_xbRh3ETRPw9pvfC13CR0v5mMquc0q5zqxJ_ReGAOUV919FPGAtlj82CxuUcwUJmEcNZknOWpPIKDkrP-2dEsg1Rn5z3O5kSmgP8JieTaLGMP8WvX-N1_NDKyyzz9chGmXgUI4y43EeY-iRz5djjlE2S4glv027DDD-MNYDdpojxiaOm4rw5ZT8EsOodOXbo0-BTqB_qP5sFRhDIz8-2og0P_Zbt2ssb0MEvmsvvu9sv0TC0HGiyuwJpuqgDPm0QEgUPbQyzy3_rIDfdvz2d4wODnBKnt-sVvuyip6-wOKrOu0-eVTUc2j5VkPPV7hW8WmBZtJrCn5vEhaA78VdCrBrhTtkzDNfBqPRMsiRk3wYaT3nwWf-t1Ovf1sp52Yi2SW2I8l7pAxF3kYVMrRQyrcIWSR5SOiLfPIAYz8gq5YCluH6JZ1RlM3908VnIuH-LxggE0k0OvFquCKF7hd_tzB96kTMBmqHj_EVmcFurwhwGusI1jiGG7veEShdB1HRB75oibs6OTd0p9wXdjw8zXobGTg0Du2f0327yEWXF2prVI6Qva5ACib-ksQrWe_dW25yIlWjKPL-le09RsCPLpKZBa2uZSKJg7h-s9mMLTww18eBc8cJXnN)
+ Chloroplast: [KX551970.1](https://www.ncbi.nlm.nih.gov/nuccore/KX551970.1), **Landsberg erecta**, 154515 bp
+ Mitochondrion: Y08501, 366924 bp

## 数据来源1
+ 测序数据：Illumina Hiseq
+ [《Great majority of recombination events in Arabidopsis are gene conversionevents》](http://www.pnas.org/content/109/51/20992)
+ PRJNA178613
+ [补充](http://www.pnas.org/highwire/filestream/611045/field_highwire_adjunct_files/0/sapp.pdf)
> The Arabidopsis thaliana accession “Columbia-0” (Col) and “Landsbergerecta” (Ler)
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
PRJNA178613 | Ler | SRR611087 | 5,079,145,000 * 2 | ~83 | ～490 | 100 | Illumina HiSeq
PRJNA178613 | Ler | SRR616965 | 2,543,625,500 * 2 | ~41 | ～480 | 100 | Illumina HiSeq
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
