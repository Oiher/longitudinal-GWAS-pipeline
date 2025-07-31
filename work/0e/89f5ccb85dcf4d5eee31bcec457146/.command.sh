#!/bin/bash -ue
set -x
cat allchr.mergelist.txt | uniq > tmp_mergefile.txt
plink2 --memory 12288       --pmerge-list "tmp_mergefile.txt"       --make-bed       --out "allchr_SURV_CPH_p2in"
