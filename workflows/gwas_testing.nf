#!/usr/bin/env nextflow 

/*
 * Enables modules
 */
nextflow.enable.dsl = 2


/* 
 * Import modules
 */
include { DOQC }              from '../subworkflows/fullqc.nf'
include { GWASDATA_PREP }     from '../subworkflows/gwasinputs.nf'
include { GWAS_RUN }          from '../subworkflows/rungwas.nf'
include { SAVE_RESULTS }      from '../subworkflows/saveresults.nf'


/* 
 * main script flow
 */
workflow GWAS {
  // Define model and show log info
  if ( params.longitudinal_flag ) {
        MODEL = "lmm_gallop"
    } 
    else if ( params.survival_flag ) {
        MODEL = "cph"
    }
    else {
        MODEL = "glm"
    }
  
  // Define working directory
  
  log.info """\
  LONG-GWAS - GWAS P I P E L I N E
  ======================================
  Chunk size for genetic processing        : ${params.chunk_size}
  Kinship matrix threshold                 : ${params.kinship}
  R2 threshold                             : ${params.r2thres}
  MAF threshold                            : ${params.minor_allele_freq}
  data ancestry                            : ${params.ancestry}
  genetic data assemble                    : ${params.assembly}
  phenotype name                           : ${params.pheno_name}
  covariates                               : ${params.covariates}
  analysis                                 : ${MODEL}
  outdir                                   : ${projectDir}/files/longGWAS_pipeline/results/cache/${params.dataset}
  """
  /*
  * Datetime
  */
  datetime = new java.util.Date()
  params.datetime = new java.text.SimpleDateFormat("YYYY-MM-dd'T'HHMMSS").format(datetime)   
  // Get the cache and the input check channels
  Channel
  .fromPath( "${params.STORE_DIR}/${params.dataset}/p1_run_cache/*" )
  .map{ f -> tuple(f.getSimpleName(), f) }
  .set{ cache }

  Channel
   .fromPath(params.input)
   .map{ f -> tuple(f.getSimpleName(), f) }
   .set{ input_check_ch }

  DOQC( input_check_ch, cache )

  GWASDATA_PREP(params.covarfile, DOQC)

  // Get phenotypes on a channel
  Channel
    .of( params.pheno_name )
    .splitCsv(header: false)
    .collect()
    .set{ phenonames }
  
  GWAS_RUN(params.phenofile,
           phenonames,
           GWASDATA_PREP.out.CHUNKS,
           GWASDATA_PREP.out.PLINK_SLIST)

  SAVE_RESULTS(GWAS_RUN.out, MODEL)
}

