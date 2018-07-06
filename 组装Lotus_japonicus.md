# 数据来源
《High-resolution genetic maps of Lotus japonicus and L. burttii based on re-sequencing of recombinant inbred lines》
# DRA004729, DRA004730, DRA004731(文章中提供的DRA号DRA002730应该为DRA004730)
# 从三个项目文件中分别下载两个测序文件，共六个文件

================= DRA004729 ===============
# DRR060472
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060472/DRR060472_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060472/DRR060472_2.fastq.gz
# DRR060474
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060474/DRR060474_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060474/DRR060474_2.fastq.gz
# DRR060563
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060563/DRR060563_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060563/DRR060563_2.fastq.gz

# 下载DRR060488
4e269a0230023390624efde245794743
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060488/DRR060488_1.fastq.gz
cee881f303f3ae5d5c9d00675ca91da7
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060488/DRR060488_2.fastq.gz
# 下载DRR060545
2488a3bd67ff75a5601eff436a25ebda
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060545/DRR060545_1.fastq.gz
437c6d7cf74099cb68b001aff67e0c89
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060545/DRR060545_2.fastq.gz

================= DRA002730 ===============
# 下载DRR060585
6476141a0b1dc503368dc960bb0dc5c5
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060585/DRR060585_1.fastq.gz
d75707128e4f3939a08b4fcfc2464af2
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060585/DRR060585_2.fastq.gz
# 下载DRR060617
9269026c7a92672dd5c4d1f8e5eaf46a
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060617/DRR060617_1.fastq.gz
0d0a9c2775ed23b1ee808e69a6c56241
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060617/DRR060617_2.fastq.gz

================= DRA004731 ===============
# 下载DRR060674
34e634fa692e6e31dfb8f21e4750d11
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060674/DRR060674_1.fastq.gz
90e9e5b76738630b63d194f637793768
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060674/DRR060674_2.fastq.gz

# 下载DRR060746
822aee77c0418546f9e2cca6321118d2
ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060746/DRR060746_1.fastq.gz
7f7933961d3665036b6e5edff3e1f9b1
ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060746/DRR060746_2.fastq.gz


# 服务器...
cd ~/Documents/data/anchr/Lotus_corniculatus/
for n in 488 545 585 617 674 746
do
  for m in 1 2
  do
    aria2c -x 9 -s 3 -c ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR060/DRR060${n}/DRR060${n}_${m}.fastq.gz
    done
done
