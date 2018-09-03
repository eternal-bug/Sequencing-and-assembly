# 导入环境变量
export PATH="~/stq/Applications/augustus-3.3.1/bin:$PATH"
export AUGUSTUS_CONFIG_PATH="/share/home/wangq/stq/Applications/augustus-3.3.1/config"
export PATH="~/stq/Applications/hmmer-3.2.1/src:$PATH"
export PATH="~/stq/Applications/blast+-2.7.1-linux/bin:$PATH"

ROOTTMP=$(pwd)

GREEN=
RED=
NC=
if tty -s < /dev/fd/1 2> /dev/null; then
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color
fi

log_warn () {
    echo >&2 -e "${RED}==> $@ <==${NC}"
}

log_info () {
    echo >&2 -e "${GREEN}==> $@${NC}"
}

log_debug () {
    echo >&2 -e "==> $@"
}

list=('7_mergeKunitigsAnchors/anchor.merge.fasta' '7_mergeTadpoleAnchors/anchor.merge.fasta' '7_mergeMRKunitigsAnchors/anchor.merge.fasta' '7_mergeMRTadpoleAnchors/anchor.merge.fasta' '7_mergeMRMegahitAnchors/anchor.merge.fasta' '7_mergeMRSpadesAnchors/anchor.merge.fasta' '7_mergeAnchors/anchor.merge.fasta' '7_anchorLong/contig.fasta' '7_anchorFill/contig.fasta' '8_spades/spades.non-contained.fasta' '8_spades_MR/spades.non-contained.fasta' '8_megahit/megahit.non-contained.fasta' '8_megahit_MR/megahit.non-contained.fasta' '8_platanus/platanus.non-contained.fasta')

# 文件名单来自于 `9_quast.sh`
for path in ${list[@]};
do
  cd $ROOTTMP
  if [ -f $path ];
  then
    log_info $path
    BASH_DIR=$( cd "$( dirname "$path" )" && pwd )
    cd ${BASH_DIR}
    
    # 新建文件夹
    if [ -d busco ];
    then
      # do nothing
      echo -n
    else
      mkdir busco
    fi
    cd busco
    
    # 去除特殊字符,busco不允许标签名出线斜线(/),所以将其除去
    if [ -f tmp.fasta ];
    then
      # do nothing
      echo -n
    else
      cat ../$(basename $path) | sed "s/\///g" > tmp.fasta
    fi
    
    # 这里的-o选项似乎不起效，这个工具的输出路径就是当前目录
    ~/stq/Applications/busco/scripts/run_BUSCO.py \
        -i tmp.fasta \
        -l ~/stq/database/BUSCO/embryophyta_odb9 \
        -o  .\
        -m genome \
        --cpu 8
  fi
  cd $ROOTTMP
done


# ============================= sample ================================
    
# # BUSCO version is: 3.0.2 
# # The lineage dataset is: embryophyta_odb9 (Creation date: 2016-02-13, number of species: 30, number of BUSCOs: 1440)
# # To reproduce this run: python /share/home/wangq/stq/Applications/busco/scripts/run_BUSCO.py -i tmp.fasta -o . -l /share/home/wangq/stq/database/BUSCO/embryophyta_odb9/ -m genome -c 8 -sp arabidopsis
# #
# # Summarized benchmarking in BUSCO notation for file tmp.fasta
# # BUSCO was run in mode: genome
# 
# 	C:0.0%[S:0.0%,D:0.0%],F:0.0%,M:100.0%,n:1440
# 
# 	0	Complete BUSCOs (C)
# 	0	Complete and single-copy BUSCOs (S)
# 	0	Complete and duplicated BUSCOs (D)
# 	0	Fragmented BUSCOs (F)
# 	1440	Missing BUSCOs (M)
# 	1440	Total BUSCO groups searched

# ============================= sample ================================

cd $ROOTTMP
rm statBUSCO.md

echo 'Table: statBUSCO.md' > statBUSCO.md
echo  >> statBUSCO.md
echo '| File | C | S | D | F | M | Total |' >> statBUSCO.md
echo '|:--:|:--:|:--:|:--:|:--:|:--:|:--:|' >> statBUSCO.md
  
for path in ${list[@]};
do
  cd $ROOTTMP
  export this_dirname=$(dirname $path)
  if [ -d ${this_dirname}/busco/run_./ ];
  then
    BASH_DIR=$( cd "$( dirname "$path" )" && pwd )
    cd ${BASH_DIR}/busco/run_./
    
    if [ -f short_summary_*.txt ];
    then
      cat short_summary_..txt | perl -n -e '
        if (m/(\d+)\s*Complete BUSCOs/){
          $C = $1;
        }
        if (m/(\d+)\s*Complete and single-copy BUSCOs/){
          $S = $1;
        }
        if (m/(\d+)\s*Complete and duplicated BUSCOs/){
          $D = $1;
        }
        if (m/(\d+)\s*Fragmented BUSCOs/){
          $F = $1;
        }
        if (m/(\d+)\s*Missing BUSCOs/){
          $M = $1;
        }
        if (m/(\d+)\s*Total BUSCO groups searched/){
          $T = $1;
        }
        END{
          printf "| %s | %d | %d | %d | %d | %d | %d |\n",$ENV{this_dirname},
                                                         $C || 0,
                                                         $S || 0,
                                                         $D || 0,
                                                         $F || 0,
                                                         $M || 0,
                                                         $T || 0;
        }
      ' >> ../../../statBUSCO.md
    fi
    cd $ROOTTMP
  fi
done
