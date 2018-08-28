log_info () {
    echo >&2 -e "\033[0;32m==> $@\033[0m"
}

ROOTTMP=$(pwd)

for path in '7_mergeKunitigsAnchors' '7_mergeTadpoleAnchors' '7_mergeMRKunitigsAnchors' '7_mergeMRTadpoleAnchors' '7_mergeMRMegahitAnchors' '7_mergeMRSpadesAnchors' '7_mergeAnchors' '7_anchorLong' '7_anchorFill' '8_spades' '8_spades_MR' '8_megahit' '8_megahit_MR' '8_platanus';
do
  cd $ROOTTMP
  if [ -d $path ];
  then
    log_info $path
    cd $path
    if [ -d busco ];
    then
      rm -rf busco
    fi
  fi
  cd $ROOTTMP
done
