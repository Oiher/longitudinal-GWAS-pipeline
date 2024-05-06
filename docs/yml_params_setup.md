# Set YAML file parameters

The cloned repository will contain a `params.yml` file where the parameters for the analysis can be set. Detailed descriptions of each parameter are present in the `Commandline parameters` section. There are five main sections to modify: 

## 1. Input files 

Specify the path for the `input`, `covarfile`, and `phenofile` files required for the analysis. For example:

```sh
# Input files
input: ./longitudinal-GWAS-pipeline/example/genotype/chr[1-3].vcf
covarfile: ./longitudinal-GWAS-pipeline/example/covariates.tsv
phenofile: ./example/phenotype.surv.tsv
```
See `Input file formats` for more details on which variables need to be present in the `phenofile` and `covarfile`.

## 2. Variable names

Specify the variable names to be used in the analysis as they appear in the Input files.

- `pheno_name`: the name of the independent variable, i.e. the outcome of interest
- `covariates`: the covariates to be used, written in double quotes (`""`) and separated by spaces
- `study_col`: the column in the `covarfile` where the study arm is specified (e.g. affected/unaffected/intermediate)
For survival analyses, you must also specify the time-to-event column
- `time_col`: the column in the `phenofile` where the time-to-event is defined

For example, for a survival analysis using "Sex" and "Age at baseline" as covariates, we would specify the following:

```sh
#Variables names
pheno_name: surv_y
covariates: "SEX age_at_baseline"
study_col: study_arm
time_col: study_days
```

## 3. Model variables

These boolean variables will be used to determine which type of model will be run. Currently, there are three options to choose from: `glm`, `lmm_gallop`, and `cph`. Thus, we can select which model to use by setting the corresponding `params.yml` parameter to `true` or `false`. For example, for a survival analysis we would set the `survival_flag` to `true` and the rest to `false`:

```sh
# Model variables
longitudinal_flag: false
survival_flag: true
linear_flag: false
```

The `chunk_flag` can be set to `true` if we wish to divide the genetic files into smaller chunks which can be run in parallel for increased speed of analysis. The chunk size can be specified using the `chunk_size` and `plink_chunk_size` parameters:

```sh
# Chunk size
chunk_flag: true
chunk_size:
plink_chunk_size:
```

## 4. Parameters for genetic QC

Here we specify the parameters for genetic QC, such as maf, ancestry, and assembly. For example:

```sh
# Parameters for genetic QC
r2thres: -9
minor_allele_freq: "0.05"
minor_allele_ct: "20"
kinship: "0.177"
ancestry: "EUR"
assembly: "hg19"
```
Detailed descriptions of each parameter can be found in the `Commandline parameters` section.

## 5. Dataset name 

Finally, an identifier name can be given to the analysis, which will be used to name the cache and results folders. Additionally, the `mh_plot` flag can be set to `true` if we desire to produce Manhattan Plots to visualise the results.

```sh
#Identifier for the input genotype files - useful to cache results
dataset: "V2_SURV"
# Generate manhattan with result files
mh_plot: true
```
