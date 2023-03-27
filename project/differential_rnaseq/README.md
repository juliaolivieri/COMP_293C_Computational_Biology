# Differential RNA sequencing data access

## Dataset options

Dataset name | Species | Dataset description | Dataset link 
--|--|--|--
`balding` | Human | Data from balding and non-balding human skin cells  | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE184866  
`covid_kidney` | Human | Data from kidneys of covid-positive patients and covid-negative patients | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE202182 
`eczema` | Human | Data from skin samples of people with either eczema or psoriasis | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE223799 
`multiple_sclerosis` | Human | Data from immune cells of people who do and do not have multiple sclerosis| https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE159225 

## Create conda environment
We'll start by downloading the software necessary to download the data into a new conda environment. Run each of the following commands (each one will take a bit of time, and you may need to type `y` to verify that you want to install the packages). 

```
create --name sratools
conda activate sratools
conda install -c bioconda sra-tools
```

## Submit downloading jobs

1. Find the "Dataset name" of the dataset you want to use from the table above.
1. Download the `AccList` file for your specific dataset onto the cluster:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/<dataset name>_AccList.txt
   ```
   For example, to download the `balding` file you would run:
   ```
   https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/balding_AccList.txt
   ```
1. Download the script that will submit download jobs:
   ```
   wget https://github.com/juliaolivieri/COMP_293C_Computational_Biology/edit/main/project/differential_rnaseq/sraWrapper.sh
   ```
1. Run this script using your `AccList` file:
   ```
   bash sraWrapper.sh <dataset name>_AccList.txt
   ```
   For example, to download the `balding` file you would run:
   ```
   bash sraWrapper.sh balding_AccList.txt
   ```
1. The files should be starting to download. If you run `squeue`, you should see a bunch of jobs submitted under your username. Wait until all the jobs have finished running (this can take several hours).

## Renaming files

The files will have cryptic names beginning with `SRR`. There should be a file with the suffix `_1.fastq.gz` and one with the suffix `_2.fastq.gz` for each SRR number. It can be useful to give these files more informative names.

1.  Check the label of each file in the `<dataset name>_labels.csv` file in this GitHub folder.
1. To rename a file from `old_name.fastq.gz` to `new_name.fastq.gz`, we can use this command `mv old_name.fastq.gz new_name.fastq.gz`. For example, to rename `SRR16089879_1.fastq.gz` as `non_balding_C_1.fastq.gz`, you can run:
   ```
   mv SRR16089879_1.fastq.gz non_balding_C_1.fastq.gz
   ```
1. Rename each of your files according to their label.

## Creating the index

In the differential expression assignment from homework 6, we used an "index" to align the reads to the genome. We only aligned reads to one chromosome to save time. For the the project, you will create your own index file to align with. 

1. We'll start by downloading the fasta file for the human genome. Run the following command to download an sbatch file that includes the command to download the human genome:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/download_genomes/run_get_genome.sbatch
   ```
1. Next, run `sbatch run_get_genome.sbatch`. This will submit a job to download the fasta file from the human genome in a file called `hg38`. Wait until this job completes (you can check its progress with `squeue`). It may take a few hours.
1. Once the genome is downloaded, we're ready to create our Bowtie2 index. Download the script to create the index by running:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/run_index.sbatch
   ```
1. Submit the script to create the index and wait for it to complete: `sbatch run_index.sbatch`.
