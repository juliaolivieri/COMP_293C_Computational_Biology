# Differential RNA sequencing data access

## Dataset options



## Create conda environment
We'll start by downloading the software necessary to download the data into a new conda environment. Run each of the following commands (each one will take a bit of time, and you may need to type `y` to verify that you want to install the packages). 

```
create --name sratools
conda activate sratools
conda install -c bioconda sra-tools
```

## Submit downloading jobs

First, decide on which data you want to use. 

download files from accession list

rename files? paired-end

download genome to create index
