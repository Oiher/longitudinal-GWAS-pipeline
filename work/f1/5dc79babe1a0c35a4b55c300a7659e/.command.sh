#!/bin/bash -ue
echo "Processing - chr6.1.vcf.gz"
echo "Assigned cpus: 4"
echo "Assigned memory: 12 GB"

set +x
if [[ 1 == 1 ]]; then
  cp chr6.1.vcf.gz tmp_input.gz
else
  bcftools view -h chr6.vcf | gzip > tmp_input.gz
  cat chr6.1.vcf.gz >> tmp_input.gz
fi

process1.sh     4     tmp_input.gz     -9     hg19     6     chr6.1
plink2 --pfile chr6.1_p1out         --make-bed         --out chr6.1_p1out
