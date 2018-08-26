
rm total.md

# 定义需要合并的项目的列表
# 按照生成的顺序
mdlist=(statInsertSize.md statReads.md statTrimReads.md statMergeReads.md statQuorum.md statKunitigsAnchors.md statTadpoleAnchors.md statMRKunitigsAnchors.md statMRTadpoleAnchors.md statMergeAnchors.md statOtherAnchors.md statFinal.md statBUSCO.md)

for md in ${mdlist[@]}
do
  if [ -f $md ]
  then
    cat $md | perl -p -e '
      if(m/^Table/){
        # 作为二级标题
        s/^/## /;
      }
    ' >> total.md
    echo >> total.md
  fi
done
