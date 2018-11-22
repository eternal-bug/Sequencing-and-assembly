```bash
mode=SRR
for n in $(ls -d ./${mode}*/);
do
  cd ./${n}/
  if [ -e result.tar.gz ];
  then
    echo -n
  else
    echo -e "\033[0;32m====> begin to package ${n}\033[0m"
    tar -czvf ./result.tar.gz \
    ./2_illumina/fastqc \
    ./2_illumina/insertSize \
    ./2_illumina/kmergenie \
    ./2_illumina/sgaPreQC \
    ./7_mergeAnchors/anchor.merge.fasta \
    ./7_mergeAnchors/others.non-contained.fasta \
    ./8_megahit/anchor/anchor.fasta \
    ./8_megahit/megahit.non-contained.fasta \
    ./8_megahit_MR/megahit.non-contained.fasta \
    ./8_megahit_MR/anchor/anchor.fasta \
    ./8_platanus/anchor/anchor.fasta \
    ./8_platanus/platanus.non-contained.fasta \
    ./8_spades/anchor/anchor.fasta \
    ./8_spades/spades.non-contained.fasta \
    ./8_spades_MR/anchor/anchor.fasta \
    ./8_spades_MR/spades.non-contained.fasta \
    ./8_megahit/anchor/contig.proper.yml \
    ./8_megahit_MR/anchor/contig.proper.yml \
    ./8_platanus/anchor/contig.proper.yml \
    ./8_spades/anchor/contig.proper.yml \
    ./8_spades_MR/anchor/contig.proper.yml \
    ./9_quast \
    ./*.md 
    echo -e "\033[0;32m====> ${n} package complete.\033[0m"

    echo -e "\033[0;31m====> remove ${n}\033[0m"
    for m in $(ls | grep -v ".tar.gz");
    do
      rm -rf ${m}
    done
  fi
  cd ../
done


for n in $(ls -d ./${mode}*/);
do
  cd ./${n}/
  if [ -e result.tar.gz ];
  then
    echo -e "\033[0;32m====> begin to unpackage ${n}\033[0m"
    tar -xzvf ./result.tar.gz
    rm ./result.tar.gz
  fi

  cd ../
done
```
