#!/bin/bash -ue
set -x
from=$(cat allchr_LONG_LMM_p2in.1.txt | cut -f 1)
to=$(cat allchr_LONG_LMM_p2in.1.txt | cut -f 2)
echo ${from}
echo ${to}
nameout="EUR_affected_chr2_${from}_${to}"


plink2 --pfile chr2            --keep EUR_affected_filtered.pca.tsv            --export A            --from ${from}            --to ${to}            --mac 20            --update-sex EUR_affected_filtered.pca.tsv            --pheno EUR_affected_filtered.pca.tsv            --pheno-col-nums 4            --hwe 1e-6            --out "${nameout}"             --threads 2            --memory 6144
