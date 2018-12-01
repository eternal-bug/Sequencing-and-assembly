#!usr/bin/bash

usage () {
cat <<EOF
NAME
    download_EBI_sequence_data.sh

DESCRIPTION
    This program is used to download EBI sequnece data.
    you just provide the PRJ or SRP or SRS or SRR number as main link.
    and set the SRR file you want.If you want to download the all of PRJ
    sequence data.you just set the second parameter as "ALL".

SYNOPSIS
    download_EBI_sequence_data.sh <PRJ number> <thread_num> <SRR list>

    <PRJ number>  is ambiguous statement.It can be PRJ,also can be SRP 
                  or SRX or SRR.

    <SRR list>    is the SRR file you want to download.If you want to 
                  download the all sequence data in the PRJ.you can set
                  it as "ALL".

    <thread_num>  This is unnecessary parameter.[default] is 5 thread.

DEPEND
    * md5sum      used to check download sequnce data file completeness.
    * aria2c      used to download sequnce data file.

EXAMPLE
    __________________________________________________________________
    $ SRR_list=(SRR5282968 SRR5283017 SRR5283074 SRR5283111)
    $ PRJ=PRJNA375953
    $ download_EBI_sequence_data.sh \$PRJ thread_num \${SRR_list[@]} 
    __________________________________________________________________

AUTHOR
    Written by eternal-bug.
EOF
exit 1
}

function estimate_md5 {
  file=$1
  export md5=$2
  $md5check=$(md5sum ${file});
  if [ $(echo $md5check | perl -n -e 'if(m/$ENV{md5}/){print 1}')x == 1x ];
  then
    return 1;
  else
    return 0;
  fi
}

function download_ebi_link {
  SRP=$1
  path=.
  if [ -z $2 ];
  then
    echo -n
  else
    path=$2
  fi
  wget -O ${path}/${SRP}.tsv -c "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=${SRP}&result=read_run&fields=run_accession,scientific_name,instrument_model,fastq_md5,fastq_ftp,sra_ftp&download=txt"
}

function aria2c_download {
  file=$1
  thread=5
  if [ -z $2 ];
  then
    echo -n
  else
    thread=$2
  fi
  debug "====> aria2c -c -j ${thread} -x 9 -s 6 -i ${file}" w
  aria2c -c -j ${thread} -x 9 -s 6 -i ${file}
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
  r=$(md5sum ${file} | perl -ne 'print 1 if m/$ENV{md5v}/')
  return ${r}
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

# 测试参数
if [ -z $1 ]; then
  usage
fi

if [ -z $2 ]; then
  usage
fi

# 得到PRJ或者SRP项目文件
SRP=$1
download_ebi_link ${SRP}

# 设置下载的列表
agr_num=0
download_list=()
for SRR in $@
do
  let agr_num+=1
  # 排除第一个参数
  if [ $agr_num -eq 1 ];
  then
    echo -n
  elif [ $agr_num -eq 2 ];
  then
    echo -n
  else
    let num=${agr_num}-1
    download_list[${num}]=${SRR}
  # 将参数输出到文件中
    echo $SRR >> download_list.txt
  fi
done

# https://stackoverflow.com/questions/9736202/read-tab-separated-file-line-into-array
echo >aria2c.download.md5
cat ${SRP}.tsv | tail -n+2 | while IFS=$'\t' read -r -a row ;
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
        if [ -f ./${SRR_full_name} ];
        then
          md5_c_v=$(md5sum_check ${SRR_full_name} ${md5v})
          if [ ${md5_c_v} ];
          then
            debug "===> ${SRR_full_name} exists..." t
            continue
          fi
        fi
        # md5sum check file
        echo -e "${LinkList[$i]}\t${Md5List[$i]}" >aria2c.download.md5
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
        if [ -f ./${SRR_full_name} ];
        then
          md5_c_v=$(md5sum_check ${SRR_full_name} ${md5v})
          if [ ${md5_c_v}x ];
          then
            debug "===> ${SRR_full_name} exists..." t
            continue
          fi
        fi
        # md5sum check file
        echo -e "${LinkList[$i]}\t${Md5List[$i]}" >aria2c.download.md5
        echo $(echo ${LinkList[$i]} | perl -pe '$_ = "ftp://". $_ unless $_ =~ m{^ftp://};')
      done
    else
      continue
    fi
  done
done > aria2c.download.txt

aria2c_download aria2c.download.txt $2 
