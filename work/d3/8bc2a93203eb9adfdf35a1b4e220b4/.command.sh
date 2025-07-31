#!/bin/bash -ue
# run merge command on tmp list
set +x

plink --merge-list chr5.mergelist.txt         --out chr5

plink2 --bfile chr5         --make-pgen         --sort-vars         --out chr5

#plink2 --pmerge-list chr5.mergelist.txt       #--make-pgen       #--sort-vars       #--out chr5
#plink2 --make-bed       #  --pfile chr5       #  --out chr5
