```bash
for i in $(ls -d SRR*);
do
  cd ${i}
  if [ -e result.tar.gz ];
  then
    echo -e "${i} result.tar.gz exists."
  else
    echo -e "${i} begin to package..."
    tar -vczf result.tar.gz \
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
    ./8_spades_MR/spades.non-contained.fasta\
    ./9_quast \
    ./*.md
    echo -e "${i} package complete."
  fi
  cd ../
done
```
