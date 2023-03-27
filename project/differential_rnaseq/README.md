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
1. The files will have cryptic names beginning with `SRR`. You can see the label of each file in the `<dataset name>_labels.csv` file in this GitHub folder.

download files from accession list

rename files? paired-end

download genome to create index
