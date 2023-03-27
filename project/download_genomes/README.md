# How to download genome and gtf files

1. Explore the genomes on this webpage, and decide which one you want to download.
1. Find the name of the genome. For human, you can use `hg38`. Otherwise, this will be the blue text in the gray box with the date. For example, for *C. elegans* the name is `ce11`. For cat, the name is `felCat9`.
   ![the identifier for C. elegans is cel1](c_elegans.png)
   ![the identifier for cat is felCat9](cat.png)
1.  Run `wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/download_genomes/run_get_genome.sbatch` to download the `run_get_genome.sbatch` script.
1. Edit the `run_get_genome.sbatch` script to set `GENOME` equal to the name of the genome you just found.
1. Submit the script with `sbatch run_get_genome.sbatch`. The FASTA and annotation file will be downloaded in a new folder. For large genomes this could take a while.   
