#!usr/bin/bash
# This program is used to download EBI sequence data.
# 2019/01/10

function usage {
cat <<EOF
NAME
    download_EBI_sequence_data.sh

DESCRIPTION
    This program is used to download EBI sequnece data.
    you just provide the PRJ or SRP or SRS or SRR number as main link.
    and set the SRR file you want.If you want to download the all of PRJ
    sequence data.

SYNOPSIS
    download_EBI_sequence_data.sh -p <PRJ number> -t <thread_num> 
                                  -s <SRR list> -d <output dir>
 *  -p  is ambiguous statement.It can be PRJ,also can be SRP 
        or SRX or SRR or ERA, etc.
 *  -s  is the SRR file you want to download.If you assign 
        many files to download. You should Put them in quotation
        marks, such as "SRRXXXXX SRRXXXXX SRRXXXXX". You can set
        it as "ALL" when you want to download the all sequence
        data in the PRJ.
    -t  Set the download thread num.This is unnecessary parameter.
        [default] is 5 thread.
    -d  output directory

DEPEND
    md5sum      used to check download sequnce data file completeness.
 *  aria2c      used to download sequnce data file.

  Notice: * mark mean this argument or tools is necessary.

EXAMPLE
    $ PRJ=PRJNA375953
    $ download_EBI_sequence_data.sh -p \$PRJ -t 10 -s "SRR5282968 SRR5283017 SRR5283074 SRR5283111"

AUTHOR
    Written by eternal-bug.

VERSION
    v 1.3


EOF
exit 1
}


function check_md5 {
  local file=$1
  export md5=$2
  $md5check=$(md5sum ${file});
  if [ $(echo $md5check | perl -n -e 'if(m/$ENV{md5}/){print 1}')x == 1x ];
  then
    echo 1;
  else
    echo 0;
  fi
}

function estimate_md5 {
  local md5_check_return
  local info
  md5_check_return=$1
  info=$2
  ${info:=file}
  if ( ${md5_check_return} );
  then
    debug "===> ${info} is available..." t
  else
    debug "===> ${info} is unavailable, please check it..." w
  fi
}

function download_ebi_link {
  SRP=$1
  path=$2
  wget -O ${path}/${SRP}.tsv -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${SRP}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"
}

function aria2c_download {
  local file=$1
  local thread=$2
  local dir=$3
  debug "====> aria2c -c -j ${thread} -x 9 -s 6 -d ${dir} -i ${file}" w
  aria2c -c -j ${thread} -x 9 -s 6 -d ${dir} -i ${file}
  # return=$( aria2c -c -j ${thread} -x 9 -s 6 -i ${file} >&2)
  # if [ ${return}x == 0x ];
  # then
  #   debug "download success" "t"
  # else
  #   debug "download fail" "w"
  # fi
}

function md5sum_check {
  file=$1
  export md5sum=$2
  debug "begin to check ${file} md5 value..."
  r=$(md5sum ${file} | perl -ne 'if(m/$ENV{md5v}/){print "true"}else{print "false"}')
  echo ${r}
}

function debug {
  info=$1
  type=$2  # w is warn, t is tip
  if [ ${type}x == wx ];
  then
    echo -e "\033[0;31m$info\033[0m" >&2
  elif [ ${type}x == tx ];
  then
    echo -e "\033[0;32m$info\033[0m" >&2
  else
    echo -e "$info" >&2
  fi
}

# ================== 开始 ====================

# 获得参数
SRP=
declare -i THREAD=5
OUT=.
SRR=
arg_available_num=0
declare -a list=()
while getopts p:t:s:o: opt;
do
  case $opt in
    p)
      SRP=$OPTARG
      ((arg_available_num++))
    ;;
    t)
      THREAD=$OPTARG
    ;;
    s)
      SRR=$OPTARG
      ((arg_available_num++))
    ;;
    o)
      OUT=$OPTARG
    ;;
    ?)
      debug "Agrument $OPTION is meaningless." w
    ;;
  esac
done

if [ -z ${SRP} ];
then
  debug "===> arguments -p is necessary.Please assign it." w
fi

if [ -z ${SRR} ];
then
  debug "===> arguments -s is necessary.Please assign it." w
fi

if [[ "${arg_available_num}" -eq 2 ]];
then
  list=($SRP $THREAD $OUT "$SRR")
  echo ${list[@]}
else
  usage
fi

# new build dir
if [ -d ${OUT} ];
then
  echo -n 
else
  mkdir ${OUT}
fi

((max=${#list[@]}-1))
for i in $(seq 0 ${max});
do
  case ${i} in
    0)
      SRP=${list[${i}]}
    ;;
    1)
      THREAD=${list[${i}]}
    ;;
    2)
      OUT=${list[${i}]}
    ;;
    3)
      SRR=${list[${i}]}
    ;;
  esac
done

# 得到PRJ或者SRP项目文件
download_ebi_link ${SRP} ${OUT}

# 设置下载的列表
array=($SRR)
download_list=()
echo ${OUT}/download_list.txt
num=0
for i in "${array[@]}";
do
  download_list[${n}]=${i}
  let num+=1
  echo $i >> ${OUT}/download_list.txt
done

# https://stackoverflow.com/questions/9736202/read-tab-separated-file-line-into-array
echo >${OUT}/aria2c.download.md5
cat ${OUT}/${SRP}.tsv | tail -n+2 | while IFS=$'\t' read -r -a row ;
do
  linkall=${row[4]}
  md5all=${row[3]}

  LinkList=($(echo ${linkall} | perl -pe 's/;/ /;'))
  Md5List=($(echo ${md5all} | perl -pe 's/;/ /'))
  SRR=$(echo ${LinkList[0]} | perl -pe 's{^.+\/}{};s{[._]R?\d+\.f(ast)*q\.gz}{}')
  for d in ${download_list[@]};
  do
    if [ "${d}"x == "ALL"x ];
    then
      LinkListLen=${#LinkList[@]}
      for ((i=0;i<${LinkListLen};i++));
      do
        export md5v=${Md5List[$i]}
        SRR_full_name=$(echo ${LinkList[$i]} | perl -pe 's{^.+\/}{}')
        # check file live
        if [ -f ${OUT}/${SRR_full_name} ];
        then
          md5_c_v=$(md5sum_check ${SRR_full_name} ${md5v})
          if ( ${md5_c_v} );
          then
            debug "===> ${SRR_full_name} is available..." t
            continue
          else
            debug "===> ${SRR_full_name} is unavailable, please check it..." w
          fi
        fi
        # md5sum check file
        echo -e "${Md5List[$i]}\t${SRR_full_name}" >>${OUT}/aria2c.download.md5
        echo $(echo ${LinkList[$i]} | perl -pe '$_ = "ftp://". $_ unless $_ =~ m{^ftp://};')
      done
    elif [ "${d}"x == "${SRR}"x ];
    then
      LinkListLen=${#LinkList[@]}
      for ((i=0;i<${LinkListLen};i++));
      do
        md5v=${Md5List[$i]}
        SRR_full_name=$(echo ${LinkList[$i]} | perl -pe 's{^.+\/}{}')

        # check file live
        if [ -f ${OUT}/${SRR_full_name} ];
        then
          md5_c_v=$(md5sum_check ${SRR_full_name} ${md5v})
          if ( {md5_c_v} )
          then
            debug "===> ${SRR_full_name} exists..." t
            continue
          else
            debug "===> ${SRR_full_name} is unavailable, please check it..." w
          fi
        fi
        # md5sum check file
        echo -e "${Md5List[$i]}\t${SRR_full_name}" >>${OUT}/aria2c.download.md5
        echo $(echo ${LinkList[$i]} | perl -pe '$_ = "ftp://". $_ unless $_ =~ m{^ftp://};')
      done
    else
      continue
    fi
  done
done > ${OUT}/aria2c.download.txt

aria2c_download ${OUT}/aria2c.download.txt $THREAD ${OUT}
md5sum --check ${OUT}/aria2c.download.md5
