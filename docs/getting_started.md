# Getting Started

This page will walk you through the process of building the docker image and setting up Nextflow to run the 
GWAS pipeline. If running this pipeline from ADWB, skip the installation section and go to the basic usage
section.

## Installation

### Requirements

The pipeline requires the following software prerequisites and has been tested on a Linux Ubuntu 18.04 environment

#### Linux Ubuntu

If you are running the analysis on your local machine with a non-Linux operating system (i.e. Windows or macOS), you can use Linux Ubuntu in the following ways:
- Create a Linux Ubuntu Virtual Machine (Windows & macOS) [VirtualBox 7](https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview)
- Install Windows Subsystem for Linux (Windows only) [WSL2](https://canonical-ubuntu-wsl.readthedocs-hosted.com/en/latest/guides/install-ubuntu-wsl2/)
  
Alternatively, you may connect to your institution's HPC with Linux Ubuntu installed.

If you already have Linux Ubuntu, make sure it is version 18.04 or higher. You can update to the latest version by running:

```bash
sudo apt update
sudo apt upgrade
```

#### Java JRE

To use Nextflow, you will require a Java Runtime Environment (JRE) version 11 or higher. You can learn how to install Java from the [Nextflow website](https://www.nextflow.io/docs/latest/install.html#install-nextflow:~:text=%EF%83%81-,Requirements,-%EF%83%81) or download the latest Java JDK directly from the [Oracle website](https://www.oracle.com/java/technologies/downloads/).

Once installed, check the version using:

```bash
java -version
```

#### Nextflow 

You can learn how to install Nextflow from the [Nextflow website](https://www.nextflow.io/docs/latest/install.html)

Once installed, check that it is installed properly by running:

```bash
nextflow run hello
```

#### Docker

You can install Docker Desktop for Windows, macOS, or Linux from the [Docker website](https://www.docker.com/products/docker-desktop/)

To install Docker Desktop for Linux Ubuntu, follow these instructions from the [Docker documentation](https://docs.docker.com/desktop/install/ubuntu/)

Once installed, check that it is installed properly by running:

```bash
docker version
```

#### Git

Install [Git](https://github.com/git-guides/install-git) using:

```bash
sudo apt-get install git-all
```

## Basic Usage

For a quick example of how to run Nextflow, we will download some example data from our `testdata` repository:

```bash
git clone https://github.com/AMCalejandro/testdata![image](https://github.com/Oiher/longitudinal-GWAS-pipeline/assets/49872153/f2df8f48-0f02-4a2c-96f9-b8aac456437b)
```

Then, we can run the Nextflow analysis with the default parameters using this command:

```bash
nextflow run michael-ta/longitudinal-GWAS-pipeline -profile standard -r main![image](https://github.com/Oiher/longitudinal-GWAS-pipeline/assets/49872153/dc0ea189-4d14-45ba-9674-c51cd1ef6e3e)
```

