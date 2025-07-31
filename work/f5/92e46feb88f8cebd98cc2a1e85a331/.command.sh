#!/bin/bash -ue
plink2           --indep-pairwise 50 .2           --maf 0.05           --pfile "allchr_SURV_CPH_p2in"           --out EUR_affected.ld

plink2           --keep EUR_affected_filtered.tsv           --out EUR_affected.pca           --extract EUR_affected.ld.prune.in           --pca 10           --threads 4           --memory 12288           --pfile "allchr_SURV_CPH_p2in"
