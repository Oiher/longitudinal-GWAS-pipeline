# Nextflow Configuration

Nextflow pipelines look for a configuration file `nextflow.config` at runtime to determine resource allocation and
define any environment variables required for any process. The longitudinal GWAS pipeline 
provides a default configuration file for users to manage resource allocation and define environment
variables specifying the paths of the outputs and cache directory. In addition, this long-gwas default config file supports the use of cloud-based executors such as the Google Cloud batch (gcb) profile.
To read more about Nextflow profiles please refer to the [Nextflow documentation](https://www.nextflow.io/docs/latest/config.html#config-profiles). Users can use the -C <config-file> option to use a custom configuration file and override the default long-gwas configuration.


By default, each task is launched using the `gwas-pipeline` docker image and assigned 2 CPUs. The process labels
`small`, `medium`, and `large_mem` are used to manage resource allocation between 3 types of tasks within the pipeline. `small` tasks run in parallel, each with access to 2 CPUs and 6GB of working memory. This label is typically assigned to 
the model fitting jobs. `medium` tasks have access to 4 CPUs with 12GB of working memory each. These tasks benefit 
from access to multiple cores and are typically run consecutively to take advantage of the full capacity of the 
compute resources.

Below is the default `nextflow.config` file used by the longitudinal GWAS pipeline

```ini
params {
    input                 = "$PWD/example/genotype/chr[1-3].vcf"
    covarfile             = "$PWD/example/covariates.tsv"
    phenofile             = "$PWD/example/phenotype.cs.tsv"

    //Variables names
    pheno_name            = 'y'
    covariates            = 'SEX age_at_baseline'
    study_col             = 'study_arm'
    time_col              = 'study_days'

    // Model variables
    longitudinal_flag     = false
    survival_flag         = false
    linear_flag           = true
    chunk_flag            = true
    chunk_size            = 30000

    //# Parameters for genetic QC
    r2thres               = -9
    minor_allele_freq     = '0.05'
    minor_allele_ct       = '20'
    kinship               = '0.177'
    ancestry              = 'EUR'
    assembly              = 'hg19'
    
    //#Identifier for the input genotype files - useful to cache results
    dataset               = 'TEST'

    //# Generate manhattan with result files
    mh_plot               = true
}


// Create profiles
profiles {
  standard {
    env {
      RESOURCE_DIR = "$PWD/files"
      OUTPUT_DIR = "$PWD/files/longGWAS_pipeline/results"
      STORE_DIR = "$PWD/files/longGWAS_pipeline/results/cache"
      ADDI_QC_PIPELINE = '/usr/src/ADDI-GWAS-QC-pipeline/addi_qc_pipeline.py'
    }
    process {
      container = 'amcalejandro/longgwas:v2'
      cpus = 2
      withLabel: small {
        cpus = 2
        memory = '6 GB'
      }
      withLabel: medium {
        cpus = 4
        memory = '12 GB'
      }
      withLabel: large_mem {
        cpus = 4
        memory = '12 GB'
      }
    }
    docker {
      enabled = true
      temp = 'auto'
    }
  }

  adwb {
    env {
      RESOURCE_DIR = '/files'
      OUTPUT_DIR = '/files/longGWAS_pipeline/results'
      STORE_DIR = '/files/longGWAS_pipeline/cache'
      ADDI_QC_PIPELINE = '/usr/src/ADDI-GWAS-QC-pipeline/addi_qc_pipeline.py'
    }
    process {
      container = 'gwas-pipeline'
      cpus = 2

      withLabel: small {
        cpus = 2
        memory = '5 GB'
      }
      withLabel: medium {
        cpus = 2
        memory = '15 GB'
      }
      withLabel: large_mem {
        cpus = 10
        memory = '70 GB'
      }
    }
    executor {
      cpus = 20
      name = 'local'
      memory = '75 GB'
    }
    docker {
      enabled = true
      temp = 'auto'
    }
  }

  biowulf {
    env {
      RESOURCE_DIR = '/files'
      OUTPUT_DIR = "$LONG_GWAS_DIR/$PROJECT_NAME/results"
      STORE_DIR = "$LONG_GWAS_DIR/Data/Cache"
      ADDI_QC_PIPELINE = '/usr/src/ADDI-GWAS-QC-pipeline/addi_qc_pipeline.py'
    }
    process {
      container = "$LONG_GWAS_DIR/Docker/gwas-pipeline_survival.sif"
      cpus = 2

      withLabel: small {
        cpus = 2
        memory = '5 GB'
      }
      withLabel: medium {
        cpus = 2
        memory = '15 GB'
      }
      withLabel: large_mem {
        cpus = 10
        memory = '115 GB'
      }
    }
    executor {
      cpus = 20
      name = 'local'
      memory = '125 GB'
    }
    singularity {
      enabled = true
      temp = 'auto'
      runOptions = "--bind $PWD --env APPEND_PATH=$PWD/bin"
    }
  }

  gls {
    env {
      RESOURCE_DIR = 'gs://long-gwas/nextflow-test/files'
      OUTPUT_DIR = 'gs://long-gwas/nextflow-test/files/results'
      STORE_DIR = 'gs://long-gwas/nextflow-test/files/cache'
      ADDI_QC_PIPELINE = '/usr/src/ADDI-GWAS-QC-pipeline/addi_qc_pipeline.py'
    }
    process {
      cpus = 4
      withLabel: small {
        cpus = 4
        memory = '12 GB'
      }
      withLabel: medium {
        cpus = 4
        memory = '12 GB'
      }
      withLabel: large_mem {
        cpus = 4
        memory = '12 GB'
      }
    }
    workDir = 'gs://long-gwas/nextflow-test/workdir'
    process.executor = 'google-lifesciences'
    process.container = 'amcalejandro/longgwas:v2'
    
    google.location = 'us-central1'
    google.project = 'gp2-data-explorer'
    google.region  = 'us-central1'
    google.lifeSciences.bootDiskSize = '20GB'
    
    process.cpus = 8
    process.memory = '32 GB'
    process.disk = '30 GB'
    errorStrategy = { task.exitStatus==14 ? 'retry' : 'terminate' }
  }

  gcb {
    env {
      RESOURCE_DIR = 'gs://long-gwas/nextflow-test-batch/files'
      OUTPUT_DIR = 'gs://long-gwas/nextflow-test-batch/files/results'
      STORE_DIR = 'gs://long-gwas/nextflow-test-batch/files/cache'
      ADDI_QC_PIPELINE = '/usr/src/ADDI-GWAS-QC-pipeline/addi_qc_pipeline.py'
    }
    process {
      container = 'amcalejandro/longgwas:v2'
      cpus = 2
      withLabel: small {
        cpus = 2
        memory = '6 GB'
      }
      withLabel: medium {
        cpus = 2
        memory = '6 GB'
      }
      withLabel: large_mem {
        cpus = 2
        memory = '6 GB'
      }
    }

    workDir = 'gs://long-gwas/nextflow-test-batch/workdir'
    errorStrategy = { task.exitStatus==14 ? 'retry' : 'terminate' }
    maxRetries = 5
    
    process.executor = 'google-batch'
    process.container = 'amcalejandro/longgwas:v2'
    
    google.location = 'us-central1'
    google.project = 'gp2-data-explorer'
    google.region  = 'us-central1'
    google.batch.spot = true
    
    
  }

  'gs-data' {
    env {
      RESOURCE_DIR = "$PWD/files"
      OUTPUT_DIR = "$PWD/files/longGWAS_pipeline/results"
      STORE_DIR = "$PWD/files/longGWAS_pipeline/results/cache"
      ADDI_QC_PIPELINE = '/usr/src/ADDI-GWAS-QC-pipeline/addi_qc_pipeline.py'
    }

    process.container = 'amcalejandro/longgwas:v2'
    google.region = 'us-central1'
    process.executor = 'local'
  }
}
```
