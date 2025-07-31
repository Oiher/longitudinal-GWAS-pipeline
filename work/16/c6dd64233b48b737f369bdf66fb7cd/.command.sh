#!/bin/bash -ue
echo "Processing - chr3.1.vcf.gz"
echo "Assigned cpus: 4"
echo "Assigned memory: 12 GB"

set +x
if [[ 1 == 1 ]]; then
  cp chr3.1.vcf.gz tmp_input.gz
else
  bcftools view -h chr3.vcf | gzip > tmp_input.gz
  cat chr3.1.vcf.gz >> tmp_input.gz
fi

process1.sh     4     tmp_input.gz     -9     hg19     3     chr3.1

plink2 --pfile chr3.1_p1out         --make-bed         --out chr3.1_p1out
