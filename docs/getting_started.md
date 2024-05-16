# Getting Started

This page will walk you through the process of building the docker image and setting up Nextflow to run the 
GWAS pipeline. If running this pipeline from ADWB, skip the installation section and go to the basic usage
section.

## Installation

### Requirements

The pipeline requires the following software prerequisites and has been tested on a Linux Ubuntu 18.04 environment

**1. Linux Ubuntu 18.04**

If you already have Linux Ubuntu, please ensure it is version 18.04 or higher. You can check your Ubuntu version by typing `lsb_release -a` in the command line. To update to the latest version, use `sudo apt update` and `sudo apt upgrade`.

If you are running the analysis on your local machine with a non-Linux operating system (i.e. Windows or macOS), you can use Linux Ubuntu in the following ways:
- Create a Linux Ubuntu Virtual Machine (Windows & macOS) - [VirtualBox 7](https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview)
- Install Windows Subsystem for Linux (Windows only) - [WSL2](https://canonical-ubuntu-wsl.readthedocs-hosted.com/en/latest/guides/install-ubuntu-wsl2/)
- Alternatively, you may connect to your institution's HPC with Linux Ubuntu installed.

**2. Java JRE 11**

To use Nextflow, you will require a Java Runtime Environment (JRE) version 11 or higher. You can learn how to install Java from the [Nextflow website](https://www.nextflow.io/docs/latest/install.html#install-nextflow:~:text=%EF%83%81-,Requirements,-%EF%83%81) or download the latest Java JDK directly from the [Oracle website](https://www.oracle.com/java/technologies/downloads/). Once installed, check the version using `java -version`.

**3. Nextflow**

You can install Nextflow following the instructions on the [Nextflow website](https://www.nextflow.io/docs/latest/install.html). Once installed, check that it is installed properly by running `nextflow run hello`.

**4. Docker Desktop**

You can install Docker Desktop for Windows, macOS, or Linux from the [Docker website](https://www.docker.com/products/docker-desktop/). To activate Docker Desktop for WSL2, follow these instructions from the [Docker documentation](https://docs.docker.com/desktop/wsl/). Once installed, check that it is installed properly by running `docker run hello-world`.

**5. Git**

To clone the `testdata` repository, you will need to install [Git](https://github.com/git-guides/install-git) using `sudo apt-get install git-all`.


## Basic Usage

For a quick example of how to run Nextflow, we will download some example data from our `testdata` repository:

```bash
git clone https://github.com/AMCalejandro/testdata
```

Then, we can run the Nextflow analysis with the default parameters using this command:

```bash
nextflow run michael-ta/longitudinal-GWAS-pipeline -profile standard -r main
```

