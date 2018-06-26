# Anchr的参数说明

basename ：the basename of this genome, default is the working directory
         ：基因组文件的基名，默认是工作目录
 
genome   ：your best guess of the haploid genome size
         ：最好知道单倍体基因组的大小

is_euk   ：eukaryotes or not
         ：是否为真核生物

tmp=s    ：user defined tempdir
         ：用户定义的临时文件夹

se       ：single end mode for Illumina
         ：Illumina的单端测序模式

trim2=s  ：steps for trimming Illumina reads
         ：修剪reads的步骤（默认是--uniq）

sample2=i：total sampling coverage of Illumina reads
         ：Illumina reads的所有样品的覆盖度

cov2=s   ：down sampling coverage of Illumina reads
         ：将覆盖度低于某个值的reads剔除【二代】（默认是40 80）

qual2=s  ：quality threshold
         ：read质量控制的阈值【二代】（默认是25 30）

len2=s   ：quality threshold
         ：read质量控制的阈值（默认是60）

reads=s  ：how many reads to estimate insert size
         ：使用多少条reads来对插入片段进行估计（默认是2000000条）

tadpole  ：also use tadpole to create k-unitigs（不太理解）
         ：使用tadpole来创建k-unitigs

cov3=s   ：down sampling coverage of PacBio reads
         ：将覆盖度低于某个值的reads剔除【三代】

qual3=s  ：raw and/or trim
         ：是使用原始数据还是对数据进行修剪【三代】（默认是“修剪”）

parallel ：number of threads
         ：运行的的线程数
___________________________________________________________________________


#数据下载与检验
# 首先登陆服务器

# Medicago A17的组装
# 样例在https://github.com/wang-q/sra/blob/master/cpDNA.md
##从服务器上传数据到超算
###用法
```bash
rsync -avP \
    服务器的文件位置 \
    超算的位置
```
   
rsync -avP
         ~/../wangq/data/na-seq/cpDNA/Medicago/* \
         ~/stq/data/dna-seq/cpDNA/Medicago

#进入到超算中

#创建文件软链接
# -p参数表示递归新建不存在的文件夹
mkdir -p ~/stq/data/dna-seq/A17/SRR1542423/1_genome
cd ~/stq/data/dna-seq/A17/SRR1542423/1_genome
ln ../../../cpDNA/Medicago/genome.fa genome.fa
    
mkdir -p ~/stq/data/dna-seq/A17/SRR1542423/2_illumina
cd ~/stq/data/dna-seq/A17/SRR1542423/2_illumina
ln ../../../cpDNA/Medicago/SRR1542423_1.fastq.gz R1.fastq.gz
ln ../../../cpDNA/Medicago/SRR1542423_2.fastq.gz R2.fastq.gz

#创建组装的bash模版文件
#设定工作区域
WORKING_DIR=${HOME}/stq/data/dna-seq/A17
BASE_NAME=SRR1542423

cd ${WORKING_DIR}/${BASE_NAME}

rm *.sh
anchr template \
    . \
    --basename ${BASE_NAME} \
    --queue mpi \
    --genome 1_000_000 \
    --fastqc \
    --kmergenie \
    --insertsize \
    --sgapreqc \
    --trim2 "--dedupe --cutoff 92 --cutk 31" \
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

#提交超算任务
    #用法
    bsub -q mpi -n 24 -J "任务名" "
       任务（可以是bash文件也可以是bash代码）
    "
#使用bjobs来查看当前任务的运行情况
#使用bkill来杀掉进程

bsub -q mpi -n 24 -J "stq" "
bash 0_bsub.sh
"









##文章《Great majority of recombination events in Arabidopsis are gene conversion events》中拟南芥的测序数据下载

for n in 072 073 074 075 076 077 078 079 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118;
do
for m in 1 2
do
aria2c -x 9 -s 3 -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR611/SRR611${n}/SRR611${n}_${m}.fastq.gz;
done
done

for n in 963 965 966 982
do
for m in 1 2
aria2c -x 9 -s 3 -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR616/SRR616${n}/SRR616${n}_${m}.fastq.gz
done
done

# 生成检查MD5值的文件
cat << EOF > sra_md5.txt
8680e02ec66012cddd342a1e62fcfdb7 SRR611072_1.fastq.gz
254c8fbd9a1b14e777976fc94809ebd4 SRR611072_2.fastq.gz
3d95e8d5532779aa8dd0e2375ba1fb32 SRR611073_1.fastq.gz
e83e6c8bb64382a742123bc08481a5ef SRR611073_2.fastq.gz
26c74064babac0edacbb2841e0a80b50 SRR611074_1.fastq.gz
c6f3f29fd46ae9ca0fdaa525c90ecc69 SRR611074_2.fastq.gz
3727e55058cc568c393a9079126c7ab8 SRR611075_1.fastq.gz
5b3f429cd8c816293b4e89f4b8cdb78b SRR611075_2.fastq.gz
0fb9ee4e9332ff96245a345204b2ddab SRR611076_1.fastq.gz
7070bd206b3e219dce8a11b1bf795702 SRR611076_2.fastq.gz
178914707d96f55a5d8c54e463390978 SRR611077_1.fastq.gz
8c29277a4efe95937d1b2184ac10303a SRR611077_2.fastq.gz
5e499f5cd40716390785b85595695445 SRR611078_1.fastq.gz
ef99c460b42406208987cfe2a77edde0 SRR611078_2.fastq.gz
21a540df63c73715e9fca13fdbc6ba1f SRR611079_1.fastq.gz
2f8b9180c9cf820bc9897f478ee35f83 SRR611079_2.fastq.gz
b8abd1785df4e0752026fa28595a8b10 SRR611080_1.fastq.gz
4596884d6bd5946b81d899010ac07898 SRR611080_2.fastq.gz
4ada2f9aada87d2bf2a61d5c48a87543 SRR611081_1.fastq.gz
184e453c07f4b53b8198a29bc8d0f76f SRR611081_2.fastq.gz
f76dbb97f469ac9872fb429da28f17a1 SRR611082_1.fastq.gz
baf904f0d5c84c15f8ab1a7ceb374aa8 SRR611082_2.fastq.gz
202a447113601fbc4dc814182f6586a8 SRR611083_1.fastq.gz
390df2bd29d64376037f982a3cf966e6 SRR611083_2.fastq.gz
caebaa31767daa64b8d58e0a0e4dd105 SRR611084_1.fastq.gz
6432379cd39f22c09484ffe9ba7f8e64 SRR611084_2.fastq.gz
3a04bc31b2820137c2cad6ea9ad0e123 SRR611085_1.fastq.gz
3ed5ef77832e9cb02dd8095700b1f0f2 SRR611085_2.fastq.gz
c921fe8752c08161b354a1e10e219c24 SRR611086_1.fastq.gz
8b727dbaa35a36800cd2b3803270e26e SRR611086_2.fastq.gz
42b7ff99152b1a597d9bb50d3ab4e486 SRR611087_1.fastq.gz
532604fedbd610d2bc26379d48ba2e36 SRR611087_2.fastq.gz
3e89787d4379e43d64692bb0677bf57c SRR611088_1.fastq.gz
ba40fbabb181b01c8130cab2394ada9a SRR611088_2.fastq.gz
96de9e359d644ad3093ee70efe3b4974 SRR611089_1.fastq.gz
c68d6988d03eedeb58f069829dd4f685 SRR611089_2.fastq.gz
2f5709c7670a50d5c34c4cd96f9c1b3b SRR611090_1.fastq.gz
91d24848e32ab815cb2c9ddf8602735e SRR611090_2.fastq.gz
3653d8e340f43cc539735f4f17598418 SRR611091_1.fastq.gz
a7c9745fa160f69cd8b9a80a76de4e68 SRR611091_2.fastq.gz
b4dcb116c3a509176b557d237a8fefda SRR611092_1.fastq.gz
210800d22fb2d102e8d22ba4a5134b15 SRR611092_2.fastq.gz
97d44d8c27e0c88e9d719456ced8cdc3 SRR611093_1.fastq.gz
bc496b873c41077454956eeb28e32d42 SRR611093_2.fastq.gz
e15392cdddb66101d7f41cff6ac2e5bf SRR611094_1.fastq.gz
c059d4630d0b2b3cc11bc549c6b187d5 SRR611094_2.fastq.gz
b28432132c0bd80bcb69dfec8d6d8d03 SRR611095_1.fastq.gz
6923e2a7816cc8e8abc5e856c6375edc SRR611095_2.fastq.gz
319bb660d177363d4cb48a5f9fae3339 SRR611096_1.fastq.gz
72aa8a5bf6122d8438307001e072e09c SRR611096_2.fastq.gz
0dd672c035a870248c09baf7aac12878 SRR611097_1.fastq.gz
713d42799561fbadb2d7e2441953e964 SRR611097_2.fastq.gz
8010bf48d44c17a8efc724625525b92e SRR611098_1.fastq.gz
d18e48151d7ff6259b1a099f66025675 SRR611098_2.fastq.gz
e0f534637e3b95381b2d0f92545480f7 SRR611099_1.fastq.gz
bbacc35b8eee758bb451bbf172018041 SRR611099_2.fastq.gz
5a7c1d8ab0fd2bcd75c20277aa17963d SRR611100_1.fastq.gz
226408a9aec6e43f05dc6892fc303ae4 SRR611100_2.fastq.gz
66586798ed092f46a03f6a8890602849 SRR611101_1.fastq.gz
ee973899a64468b286f92b1a97824235 SRR611101_2.fastq.gz
5ee27cab01b3eea267e86a30cfd29305 SRR611102_1.fastq.gz
086b31be5247f1049cf59075b2dda83a SRR611102_2.fastq.gz
72c626fb4cda7d1aa8e06235cecb5019 SRR611103_1.fastq.gz
27f2b5550fb589fb01353406e1b3d95e SRR611103_2.fastq.gz
bd5e1ef6c1ee510d84bf512c97dd406c SRR611104_1.fastq.gz
c3c0877bea46ce0c70a4c1b8affbf8dc SRR611104_2.fastq.gz
29b2d71ae8536087dc511c5d986a7509 SRR611105_1.fastq.gz
5023f8eb24754322698b6d545013723a SRR611105_2.fastq.gz
0b119487a6a0a2adb946ba45c8fbb183 SRR611106_1.fastq.gz
b0cd8d613ecdeabfa7740af0177b5b18 SRR611106_2.fastq.gz
58d944e534ae92832ded6f0d67982b3f SRR611107_1.fastq.gz
0285ca673f689d395c8408f0dff83196 SRR611107_2.fastq.gz
0e7f1dbe38ce2a4791bf81ddbf32759e SRR611108_1.fastq.gz
298201b1e17ab883491114c90282fdaa SRR611108_2.fastq.gz
5d8acceb568414f0efd0807ded03f8f1 SRR611109_1.fastq.gz
7058cf7db7a717bdcbe8297a7d87b5f5 SRR611109_2.fastq.gz
1136d83bfe87ab38f5a8391eb395f3c3 SRR611110_1.fastq.gz
149cf034dc87536b8c3a5290c3743791 SRR611110_2.fastq.gz
7c210319be9c0e7741d5444eef113d7a SRR611111_1.fastq.gz
e840f020a00d47f11503157ec5a6d8bb SRR611111_2.fastq.gz
28cea60950ae5345bc27b0dc54072eb6 SRR611112_1.fastq.gz
373b40e4ad83a63cedce9be4eee2077b SRR611112_2.fastq.gz
f6ab7747a2d06ed315b6c234992d76f7 SRR611113_1.fastq.gz
164000e4f2a0c88df7e67a5370da7b69 SRR611113_2.fastq.gz
58794aeae433837a23f71271ad7e81ef SRR611114_1.fastq.gz
3f038da98769b4bdd9d65ac8bbd43eec SRR611114_2.fastq.gz
405172388c7b0f125bb09103c3c7fccf SRR611115_1.fastq.gz
a419914c37bbeaf645be4b71dad12a58 SRR611115_2.fastq.gz
c628e0abb2e80e3484e0d61e10a3a1ae SRR611116_1.fastq.gz
7b1eb0ebb1c79a94b4fc3544a072f177 SRR611116_2.fastq.gz
a099bdd1ba95d9fa95b1b2ec053375c7 SRR611117_1.fastq.gz
9759d4c887e039d8b2a2682e26701d92 SRR611117_2.fastq.gz
4efbc97cc5be551734a77dddd2b98608 SRR611118_1.fastq.gz
086d9e94fccbe2da26e2476882470b8e SRR611118_2.fastq.gz
9352596624ef13b57bd10f9a4c885123 SRR616963_1.fastq.gz
143d70161bd5533b6366f971479db73e SRR616963_2.fastq.gz
5a02d031d25be08500b69d94f845c10a SRR616965_1.fastq.gz
c8a758f9fa2a7f8bc23e42f23fcaa784 SRR616965_2.fastq.gz
3cdf439a7f6e095ce1790ad8af2557bd SRR616966_1.fastq.gz
7369b16069274992c6506b9e953412bc SRR616966_2.fastq.gz
8b1e5a0c3158627d662e08f75e1caade SRR616982_1.fastq.gz
d7e23bdd68fc0954ec57f617ccdcf2ed SRR616982_2.fastq.gz
EOF

# 进行md5值的检查
# md5sum会对文件进行校检
# 如果md5值对应，就会在文件名后面显示ok，否则会显示FAILED
md5sum —-check sra_md5.txt

