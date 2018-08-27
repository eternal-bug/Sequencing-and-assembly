ROOTTMP=~/stq/data/anchr/Ampelopsis_grossedentata/Agr_PE400_R
cd $ROOTTMP

echo 'Table: statBUSCO.md' > statBUSCO.md
echo  >> statBUSCO.md
echo '| File | C | S | D | F | M | Total |' >> statBUSCO.md
echo '|:--:|:--:|:--:|:--:|:--:|:--:|:--:|' >> statBUSCO.md
  
for path in '7_mergeKunitigsAnchors/anchor.merge.fasta' '7_mergeTadpoleAnchors/anchor.merge.fasta' '7_mergeMRKunitigsAnchors/anchor.merge.fasta' '7_mergeMRTadpoleAnchors/anchor.merge.fasta' '7_mergeMRMegahitAnchors/anchor.merge.fasta' '7_mergeMRSpadesAnchors/anchor.merge.fasta' '7_mergeAnchors/anchor.merge.fasta' '7_anchorLong/contig.fasta' '7_anchorFill/contig.fasta' '8_spades/spades.non-contained.fasta' '8_spades_MR/spades.non-contained.fasta' '8_megahit/megahit.non-contained.fasta' '8_megahit_MR/megahit.non-contained.fasta' '8_platanus/platanus.non-contained.fasta';
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
