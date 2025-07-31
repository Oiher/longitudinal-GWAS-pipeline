#!/bin/bash -ue
plink2           --indep-pairwise 50 .2           --maf 0.05           --pfile "allchr_SURV_CPH_p2in"           --out EUR_control.ld

plink2           --keep EUR_control_filtered.tsv           --out EUR_control.pca           --extract EUR_control.ld.prune.in           --pca 10           --threads 4           --memory 12288           --pfile "allchr_SURV_CPH_p2in"
