#!/bin/bash -ue
set +x

addi_qc_pipeline.py       --geno "allchr_LONG_LMM_p2in"       --ref "/srv/GWAS-Pipeline/References/ref_panel/1kg_ashkj_ref_panel_gp2_pruned_hg38_newids"       --ref_labels "/srv/GWAS-Pipeline/References/ref_panel/ancestry_ref_labels.txt"       --pop "EUR"       --out "EUR_samplelist_p2out"
