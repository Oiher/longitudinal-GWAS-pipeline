#!/bin/bash

## Run locally (no problems)

    # CROSS-SECTIONAL GLM
    nextflow run main_testing.nf -c nextflow_testing.config -params-file params_cs.yml -profile standard -ansi-log false

    # SURVIVAL CPH
    nextflow run main.nf -params-file params_surv.yml -profile standard -ansi-log false

    # LONGITUDINAL LMM
    nextflow run main.nf -params-file params_lt.yml -profile standard -ansi-log false

#--- 

## Run from GitHub

    # CROSS-SECTIONAL GLM
    nextflow run Oiher/longitudinal-GWAS-pipeline -params-file params_cs.yml -profile standard -r main -ansi-log false

    # LONGTIUDINAL LMM
    nextflow run Oiher/longitudinal-GWAS-pipeline -params-file params_lt.yml -profile standard -r main

    # SURVIVAL CPH
    nextflow run Oiher/longitudinal-GWAS-pipeline -params-file params_surv.yml -profile standard -r main

#---


