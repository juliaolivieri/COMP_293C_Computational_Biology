# Homework 6

In this homework, we're going to perform the a differential gene expression analysis, starting from the raw data through multiple hypothesis correction.

## Dataset

We'll be using data from a study of esophageal squamous cell carcinoma (https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE29968). 

We have access to RNA-Seq data from three different patients. For each one, we have data from the patient's normal tissue, as well as the patient's tumor.

You can find these files in the `data` folder. They are currently compressed, which is why they have the suffix `.gz`. These are FASTQ rather than FASTA files: if you use `less` to view one of the files, you'll see that they follow a slightly different format.

## Creating the conda environment

We're going to create a conda environment that has all of the packages necessary for this week's homework. Often, when we have a lot of packages to download, it's easiest to put all of their names into a `.yml`  file and load them all at once. You can view the file `environment.yml` to see which packages we're loading.

Run the following command to create this conda environment:

`$ conda env create --file environment.yml` 



## Alignment

We want to see whether there are gene expression differences between the tumor and non-tumor data. Our first step will be to align each sequence to the genome. We'll use the aligner `bowtie2` to do this.

Bowtie2 requires an index, just like BLAST. The index has been created for you, and is found in the `index` folder. Because alignment can take a while, we'll only be aligning to chromosome 22.

Make a directory called `job_output` and a directory called `output`.

