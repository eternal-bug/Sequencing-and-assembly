# Sequencing-and-assembly
+ 拟南芥 (*Arabidopsis*)
+ 蒺藜苜蓿 (*Medicago truncatula*)
+ 大豆 (*cicer arietinum*)
+ 兵豆 (*Glycine max*)
+ 红豆 (*Vigna angularis*)
+ 豌豆  (*Pisum sativum*)
+ 百脉根 (*Lotus corniculatus*)
+ 鹰嘴豆 (*cicer arietinum*)

```
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
         ：从测序文件中提取多少量的read进行组装（因为不同深度对于不同细胞器的组装的影响是不同的）（默认是40 80）

qual2=s  ：quality threshold
         ：read质量控制的阈值【二代】（默认是25 30）

len2=s   ：filter reads less or equal to this length
         ：将长度短于该值的read筛选掉（默认是60）

reads=s  ：how many reads to estimate insert size
         ：使用多少条reads来对插入片段进行估计（默认是2000000条）

tadpole  ：also use tadpole to create k-unitigs（不太理解）
         ：使用tadpole来创建k-unitigs

cov3=s   ：down sampling coverage of PacBio reads
         ：同cov2【三代】

qual3=s  ：raw and/or trim
         ：是使用原始数据还是对数据进行修剪【三代】（默认是“修剪”）

parallel ：number of threads
         ：运行的的线程数
```

