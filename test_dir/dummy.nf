#!/usr/bin/env nextflow

/*
 * Use echo to print 'Hello World!' to a file
 */

// define process sayHello
// This process takes a greeting as input and writes it to a file named output.txt
// equivalent to a function def sayHello(greeting)
// basic process with input, output, and script sections
process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val greeting // val qualifier tells Nextflow to expect a value of some kind (can be a string, a number, whatever)

    output:
        path 'output.txt' // path qualifier tells Nextflow this should be handled as a path (includes both directory paths and files).

    script:
    """
    echo '$greeting' > output.txt
    """
}

// Simple workflow definition
// Workflow typically contains multiple calls to processes connected by channels
workflow {

    // emit the greeting
    sayHello(params.greeting)
}