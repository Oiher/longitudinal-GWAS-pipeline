# Example usage 

Here, we will demonstrate how to run longGWAS analyses using the example dataset provided in the `testdata` GitHub repository. This data allows us to perform either a cross-sectional, longitudinal, or survival analysis.

To access the data, clone the repository like so:

```sh
git clone https://github.com/AMCalejandro/testdata
```

## Cross-sectional analysis

The default longGWAS parameters are set to run a cross-sectional analysis. We can perform this analysis by simply running the following [Nextflow command line arguments](https://www.nextflow.io/docs/latest/cli.html):

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline -profile standard -r main
```

The default parameters are specified in the `nextflow.config` file (shown in the [Nextflow Configuration](config.md)) section. To pass your custom parameters, you can modify the above command using command line parameters from the [Command line Parameters](parameters.md) section. For example:

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline \
--chunk_size 60000 --minor_allele_freq '0.01' --dataset 'TEST_2' \
-profile standard -r main
```

If you intend to customise multiple parameters, we recommend you modify the `params.yml` file and pass it using the [`-params-file <params.yml>` argument](https://www.nextflow.io/docs/latest/cli.html#:~:text=inspecting%20the%20pipeline.-,%2Dparams%2Dfile,-Load%20script%20parameters). The YAML file contains all the parameters from the [Command line Parameters](parameters.md) section which allows us to modify them in a more convenient fashion. For example, we can achieve the same result as the command above by changing the `chunk_size`, `minor_allele_freq`, and `dataset` parameters, as indicated by the `->` symbol:

```bash
# Input files
input                 = "$PWD/example/genotype/chr[1-3].vcf"
covarfile             = "$PWD/example/covariates.tsv"
phenofile             = "$PWD/example/phenotype.cs.tsv"

# Variables names
pheno_name            = 'y'
covariates            = 'SEX age_at_baseline'
study_col             = 'study_arm'
time_col              = 'study_days'

# Model variables
longitudinal_flag     = false
survival_flag         = false
linear_flag           = true
chunk_flag            = true
-> chunk_size            = 60000
plink_chunk_size      = 10000

# Parameters for genetic QC
r2thres               = -9
-> minor_allele_freq     = '0.01'
minor_allele_ct       = '20'
kinship               = '0.177'
ancestry              = 'EUR'
assembly              = 'hg19'

# Identifier for the input genotype files - useful to cache results
-> dataset               = 'TEST_2'

# Generate manhattan plot with result files
mh_plot               = true
}
```

The analyses can therefore be run like so:

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline \
-params-file params.yml \
-profile standard -r main
```

## Longitudinal analysis

To run a longitudinal analysis, we will need to change the input `phenofile`, as well as activate the `longitudinal_flag`. We can do this by specifying these parameters in the Nextflow command:

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline \
--phenofile "$PWD/example/phenotype.lt.tsv" --longitudinal_flag true --dataset 'LONG' \
-profile standard -r main
```

Alternatively, we can pass the `params.yml` file using the `-params-file` option:

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline \
-params-file params.yml \
-profile standard -r main
```

With the following modified parameters:

```sh
# Input files
input                 = "$PWD/example/genotype/chr[1-3].vcf"
covarfile             = "$PWD/example/covariates.tsv"
-> phenofile             = "$PWD/example/phenotype.lt.tsv"

# Variables names
pheno_name            = 'y'
covariates            = 'SEX age_at_baseline'
study_col             = 'study_arm'
time_col              = 'study_days'

# Model variables
-> longitudinal_flag     = true
survival_flag         = false
-> linear_flag           = false
chunk_flag            = true
chunk_size            = 30000
plink_chunk_size      = 10000

# Parameters for genetic QC
r2thres               = -9
minor_allele_freq     = '0.05'
minor_allele_ct       = '20'
kinship               = '0.177'
ancestry              = 'EUR'
assembly              = 'hg19'

# Identifier for the input genotype files - useful to cache results
-> dataset               = 'LONG'

# Generate manhattan plot with result files
mh_plot               = true
}
```

## Survival analysis

To run a survival analysis, we will need to change the input `phenofile`, as well as activating the `survival_flag`. We can do this by modifying these parameters in the Nextflow command:

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline \
--phenofile "$PWD/example/phenotype.surv.tsv" --survival_flag true --dataset 'SURV' \
-profile standard -r main
```

Alternatively, we can pass the `params.yml` file like so:

```sh
nextflow run michael-ta/longitudinal-GWAS-pipeline \
-params-file params.yml \
-profile standard -r main
```

With the following modified parameters:

```sh
# Input files
input                 = "$PWD/example/genotype/chr[1-3].vcf"
covarfile             = "$PWD/example/covariates.tsv"
-> phenofile             = "$PWD/example/phenotype.surv.tsv"

# Variables names
pheno_name            = 'y'
covariates            = 'SEX age_at_baseline'
study_col             = 'study_arm'
time_col              = 'study_days'

# Model variables
longitudinal_flag     = false
-> survival_flag         = true
-> linear_flag           = false
chunk_flag            = true
chunk_size            = 30000
plink_chunk_size      = 10000

# Parameters for genetic QC
r2thres               = -9
minor_allele_freq     = '0.05'
minor_allele_ct       = '20'
kinship               = '0.177'
ancestry              = 'EUR'
assembly              = 'hg19'

# Identifier for the input genotype files - useful to cache results
-> dataset               = 'SURV'

# Generate manhattan plot with result files
mh_plot               = true
}
```


