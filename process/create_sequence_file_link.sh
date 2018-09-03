ROOTTMP=$(pwd)
cd ${ROOTTMP}
for name in $(ls ./sequence_data/*.gz')
do
  fq_basename=$(cat ${file} | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/[._]R\d+\.f(ast)*q\.gz//;print $new)
  paired_end_num=$(cat ${file} | perl -MFile::Basename -n -e '$new = basename($_);$new =~ s/[._]R(\d+)\.f(ast)*q\.gz//;print $1)
  if [ ! -d ${name} ];
  then
    # 新建文件夹
    mkdir -p ${name}/1_genome
    mkdir -p ${name}/2_illumina
  else
    # 建立链接
    if [ -f ../../genome/genome.fa ];
    then
      if [ -e ./${name}/genome.fa ];
      then
        echo -n
      else
        cd ${name}/1_genome
        ln -fs ../../genome/genome.fa genome.fa
      fi
    fi
    cd ${ROOTTMP}
    if [ -f ../../sequence_data/${name} ];
    then 
      cd ${name}/2_illumina
      ln -fs ../../sequence_data/${name} R${paired_end_num}.fq.gz
    fi
    cd ${ROOTTMP}
  fi
done
