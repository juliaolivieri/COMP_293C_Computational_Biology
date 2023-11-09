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

You don't need to activate it: it'll be activated for you in the `.sbatch` scripts that we'll be running.

## Alignment

We want to see whether there are gene expression differences between the tumor and non-tumor data. Our first step will be to align each sequence to the genome. We'll use the aligner `bowtie2` to do this.

Bowtie2 requires an index, just like BLAST. The index has been created for you, and is found in the `index` folder. Because alignment can take a while, we'll only be aligning to chromosome 22.

Make a directory called `job_output` and a directory called `output`.

Now take a look at the `run_alignment.sbatch` file using `less` or `nano`. We can see that the script activates the conda environment and then runs a command starting with `bowtie2` and the FASTQ file called `tumor1`. 

Submit this script using the `sbatch` command. You can use the `squeue` command to check whether it's running. It should take several minutes to complete.

No need to wait for that job to complete before we submit more. We want to align each one of our six FASTQ files, so submit jobs with `NAME=` each of the following:

```
tumor1
tumor2
tumor3
nontumor1
nontumor2
nontumor3
```

Each time, you'll be submitting a job to align the give file. If you use `squeue` to check on your jobs, you should see several jobs running at once.

The output from these jobs should appear in the `output` folder. They'll take a few minutes to complete. You'll know the jobs are done when `squeue -u <username>` doesn't show any jobs running.

## Creating the gene expression matrix

We now have aligned files (they should have the suffix `.sam`), so we know where each read aligns in the chromosome, but we want to get a gene expression matrix to summarize all of the counts for all of our data. 

We'll do this using a software called `featureCounts`. The command is located in `run_gene_exp_mat.sbatch`. This command takes in the annotation file in our `data`  directory and all of our `.sam` files, and outputs a gene expression matrix.

You can run this script using `sbatch`. It should take a few seconds to complete. Look at the file `ge.mat` in the `output` directory. There is one row per gene name, and one column for each of our `sam` files.

## Performing a t-test for each gene

Now that we have our gene expression matrix, we want to check for differential gene expression using a t-test for each gene.

We'll do this using the python script `t_test.py`. It takes in our gene expression matrix, normalizes each column, performs a t test for each column, performs multiple hypothesis correction, and then outputs a file with our p values and an image visualizing the differential expression.

We can submit this script using `sbatch run_ttest.sbatch`. It should take a few seconds to complete.

## Understanding the output

There should be several new files in the `output` directory. If there are not: you may get an error for not having all of the libraries installed. Run the following commands to install the necessary libraries: 

```
conda activate diffexp_env
conda install pandas
conda install statsmodels
conda install scipy
```

If it still isn't working, you can try running this command directly from the command line in your `homework6` directory: `python t_test.py --exp_matrix output/ge.mat --outpath output/diffexp`

`diffexp.csv` includes one line per gene, ordered from lowest p value (most significant) to highest p value (least significant). The first column shows the gene id, the second shows the p value, and the third shows the p value corrected for multiple hypothesis testing.

**Part a: What is the gene identifier with the lowest p value (indicating most significant difference between tumor and non-tumor samples in our dataset)? Search for it on the Gene Cards website to find its "common" name: https://www.genecards.org/**

**Part b: Look under "Additional Disease Information" for the gene. Is it found in any cancer databases? Check this for two other genes with small p values in the table as well.**

Check the `.out` file from your `t_test` job. It should tell you the number of genes tested, the number of genes with p values < 0.05, and the number of genes with corrected p values < 0.05. 

**Part c: Based on the number of genes tested, how many genes would you expect to have p values < 0.05 by random chance, even if there was no true difference in the populations?**

**Part d: How does the number of genes with p values < 0.05 compare to the number of genes with corrected p values < 0.05?**
