# Differential RNA sequencing data access

## Dataset options

Dataset name | Species | Dataset description | Dataset link | Google Drive link
--|--|--|--|--
`balding` | Human | Data from balding and non-balding human skin cells  | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE184866 | https://drive.google.com/uc?id=1YEzez3UML4UITdkzeZibZJ950mq61oNG 
`covid_kidney` | Human | Data from kidneys of covid-positive patients and covid-negative patients | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE202182 | https://drive.google.com/uc?id=1x31euzPC7dT24DG2eJ5NaIQaUXi1Usj7 
`eczema` | Human | Data from skin samples of people with either eczema or psoriasis | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE223799 | https://drive.google.com/uc?id=1lE-Pv6VwePMzwKG3zfCdRD2rLj1fLbyw 
`multiple_sclerosis` | Human | Data from immune cells of people who do and do not have multiple sclerosis| https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE159225 | https://drive.google.com/uc?id=1uzUa5EvpMsCCbOsv5uNsqfH5pva5I9q1 
`diabetes` | Rat | Data from rats with mechanical allodynia (P1, P2, P3), rats with diabetes but without mechanical allodynia (NP1, NP2, NP3), and controls (con1, con2, con3)| https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE226315 | https://drive.google.com/uc?id=1mbQNKM91E1UHDQD3tCcHtP7yCEyaC-kI 
`mosquito` | Mosquito | Data from mosquito cells infected with the Eilat virus or not infected | https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE220562 | https://drive.google.com/uc?id=1_LAGQ2Rf8FqKvNVY9Tvtqgq2oajxc8Ln 

## Genome downloads

Genome name | Index Gdrive link | gtf link | index prefix
--|--|--|--
Human | *to be added*| https://github.com/juliaolivieri/COMP_293C_Computational_Biology/blob/main/project/differential_rnaseq/hg38.ensGene.gtf.gz | `hg38/hg38`
Rat | *to be added*| https://github.com/juliaolivieri/COMP_293C_Computational_Biology/blob/main/project/differential_rnaseq/rn6.ensGene.gtf.gz| `rn6/rn6`
Mosquito |*to be added* | *to be added*| *to be added*

## Steps for differential gene expression analysis

1. Run `pip install gdown` to install the package required for downloading files from Google Drive.
1. Find the Google Drive link for your data from the table above. Then run `gdown <google drive link>`. For example, if you were using the balding dataset, the command would be:
   ```
   gdown https://drive.google.com/uc?id=1YEzez3UML4UITdkzeZibZJ950mq61oNG
   ```
   This will download the RNA sequencing reads onto the cluster.
1. Extract the reads from this file by running `tar -xvf <name of downloaded file>` on the cluster after the download has completed. For example,
   ```
   tar -xvf balding_reads.tar.gz
   ```
1. Find the Index Gdrive link for your data from the table above. Then run `gdown <index gdrive link>`. For example, if you were using Human data, the command would be:
   ```
   gdown *to be added*
   ```
   This will download the required bowtie2 index onto the cluster.
1. Extract the index from this file by running `tar -xvf <name of downloaded file>`. For example, if you were using human, the command would be:
   ```
   tar -xvf hg38_index.tar.gz
   ```
1. Download the annotation file for your genome using the url in the table above, using `wget`. For example, if you are using human data, run:
   ```
   wget https://github.com/juliaolivieri/COMP_293C_Computational_Biology/blob/main/project/differential_rnaseq/hg38.ensGene.gtf.gz
   ```
   Run `gunzip *` to unzip the file.
1. Next, we can download the scripts we'll need to perform differential expression analysis on our data:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/run_alignment.sbatch
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/run_gene_exp_mat.sbatch
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/run_ttest.sbatch
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/t_test.py
   ```
1. Now that we have the data downloaded, we are ready to start our analysis. Create a folder called `job_output` and a folder called `output`. We can begin by aligning the reads to the genome. Edit the `run_alignment.sbatch` file so that `INDEX` is equal to the index "prefix" (available in the table above). Set `NAME` equal to the name of one of the files in the `reads` folder that you downloaded, not including the suffix `.fq`. For example, if `positive3.fq` is in  `reads`, then you can let `NAME=positive3` to align these reads. Submit the job with `sbatch run_alignment.sbatch`.
1. Submit alignment jobs for all read files in the `reads` folder.
1. Check for your jobs to complete using the `squeue` command. Once they have completed, you can edit the `run_gene_exp_mat.sbatch` file to let `GTF` equal the name of the gtf file you downloaded. For example, `hg38.ensGene.gtf`. Submit this job.
1. Once this job completes, check that `output/ge.mat` is not empty. This is where the gene counts should be.
1. Submit `run_ttest.sbatch` to calculate the table of p values from your output. This should result in a file called `diffexp.csv` in `output`.
1. You can analyze the resulting table. What fraction of genes had p values < 0.05? Which genes have the lowest p values? Etc.

<!--
## Create conda environment
We'll start by downloading the software necessary to download the data into a new conda environment. Run each of the following commands (each one will take a bit of time, and you may need to type `y` to verify that you want to install the packages). 

```
conda create --name sratools
conda activate sratools
conda install -c bioconda sra-tools=3.0.3
```

## Submit downloading jobs

1. Find the "Dataset name" of the dataset you want to use from the table above.
1. Download the `AccList` file for your specific dataset onto the cluster:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/<dataset name>_AccList.txt
   ```
   For example, to download the `balding` file you would run:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/balding_AccList.txt
   ```
1. Download the script that will submit download jobs:
   ```
   wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/differential_rnaseq/sraWrapper.sh
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

NOTE: If this doesn't work, you can try downloading the files using `wget`. Try running the following command for each SRR number in the `AccList` file:

```
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/<SRR number>/<SRR number>
```

For example, to download the file corresponding to `SRR16089879` the command would be:

```
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR16089879/SRR16089879
```

Then you can use `fastq-dump` to unpack the file:

```
fastq-dump --split-files --gzip <SRR number>
```

For example, if the SRR number was `SRR16089879` the command would be:
```
fastq-dump --split-files --gzip SRR16089879
```

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

-->
