process GWASQC {
  //scratch true
  storeDir "${params.STORE_DIR}/${params.dataset}/p2_qc_pipeline_cache"
  publishDir "${params.OUTPUT_DIR}/${params.dataset}/PLOTS/GWASQC_PLOTS_${params.datetime}/", mode: 'copy', overwrite: true, pattern: "*.{html,png}"
  label 'large_mem'
  
  input:
    path "*" 
  output:
    path "${params.ancestry}_samplelist_p2out.h5", emit: gwasqc_h5_file 
    path "*.{html,png}", emit: gwasqc_figures
  
  script:
    """
    set +x

    echo "Running ADDI_QC_PIPELINE for ${params.dataset} and ${params.ancestry} ancestry"
    addi_qc_pipeline.py \
      --geno "allchr_${params.dataset}_p2in" \
      --ref "/srv/GWAS-Pipeline/References/ref_panel/1kg_ashkj_ref_panel_gp2_pruned_hg38_newids" \
      --ref_labels "/srv/GWAS-Pipeline/References/ref_panel/ancestry_ref_labels.txt" \
      --pop "${params.ancestry}" \
      --out "${params.ancestry}_samplelist_p2out"    
    """
}