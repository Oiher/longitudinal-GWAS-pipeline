# Getting Started

## Introduction

longGWAS is a computational pipeline, developed using [Nextflow](https://www.nextflow.io/docs/latest/index.html), that allows us to perform custom GWAS analyses with ease.

This page will walk you through how to set up Nextflow and run the longGWAS pipeline.

## Requirements

### Hardware

The pipeline is meant to be run on a server with considerable resources, and it is not meant to be run on a local machine. 

The minimum hardware specifications are:

```text
4 CPUs
12GB RAM
```

### Software

The pipeline requires the following software prerequisites and has been tested on a Linux Ubuntu 18.04 environment:

**1. Java JRE 11**

To use Nextflow, you will require a Java Runtime Environment (JRE) version 11 or higher. You can learn how to install Java from the [Nextflow website](https://www.nextflow.io/docs/latest/install.html#install-nextflow:~:text=%EF%83%81-,Requirements,-%EF%83%81) or download the latest Java JDK directly from the [Oracle website](https://www.oracle.com/java/technologies/downloads/). Once installed, check the version using `java -version`.

**2. Nextflow**

You can install Nextflow following the instructions on the [Nextflow website](https://www.nextflow.io/docs/latest/install.html). Once installed, check that it is installed properly by running `nextflow run hello`.

**3. Docker**

You can install Docker Engine from the [Docker documentation](https://docs.docker.com/engine/install/). Once installed, check that it is installed properly by running `docker run hello-world`.

**4. Git**

We run the longGWAS pipeline hosted on GitHub at [michael-ta/longitudinal-GWAS-pipeline](https://github.com/michael-ta/longitudinal-GWAS-pipeline). Therefore, we will require [Git](https://github.com/git-guides/install-git) to be installed for Nextflow to pull the software from GitHub. Additionally, we have made available some [test data](https://github.com/AMCalejandro/testdata) on a separate GitHub repository, which can be cloned into your system using Git. To install Git, run `sudo apt-get install git-all`.


## Basic Usage

For a quick example of how to run Nextflow, we will download some example data from our `testdata` repository:

```bash
git clone https://github.com/AMCalejandro/testdata
```

Then, we can run the longGWAS analysis with the default parameters using these Nextflow commands:

```bash
nextflow run michael-ta/longitudinal-GWAS-pipeline -profile standard -r main
```

_Note_: To learn more about the Nextflow command line interface (CLI), please refer to the [Nextflow documentation](https://www.nextflow.io/docs/latest/cli.html).
