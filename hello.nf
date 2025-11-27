#!/usr/bin/env nextflow 

/*
 * Enables modules
 */
nextflow.enable.dsl = 2


/* 
 * Import modules
 */
include { sayHello }              from './test_dir/dummy.nf'

workflow HELLO {
    sayHello(params.greeting)
}

workflow {
    HELLO()
}
