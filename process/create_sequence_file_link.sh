ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/[._]R\d+\.f(ast)*q\.gz//;print $new')
do
  if [ ! -d ${name} ];
  then
    # 新建文件夹
    mkdir -p ${name}/1_genome
    mkdir -p ${name}/2_illumina
  else
    # 建立链接
    if [ -f ../../genome/genome.fa ];
    then
      cd ${name}/1_genome
      ln -fs ../../genome/genome.fa genome.fa
    fi
    cd ${ROOTTMP}
    if [ -f ../../sequence_data/${name}* ];
    then 
      cd ${name}/2_illumina
      ln -fs ../../sequence_data/${name}*R1.f*.gz R1.fq.gz
      ln -fs ../../sequence_data/${name}*R2.f*.gz R2.fq.gz
    fi
    cd ${ROOTTMP}
  fi
done
