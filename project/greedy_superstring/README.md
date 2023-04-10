# Guidance for greedy superstring project

For this project, I would recommend randomly generating reads to use for the algorithm from real genome(s). 

You can download the genome(s) you're interested in using the instructions here: https://github.com/juliaolivieri/COMP_293C_Computational_Biology/tree/main/project/download_genomes.

You can download the scripts necessary for generating random reads using the following commands:

```
wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/greedy_superstring/gen_reads.py
wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/greedy_superstring/run_rand_reads.sbatch
wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/greedy_superstring/greedy_superstring.py
wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/greedy_superstring/run_superstring.sbatch
```

The steps I would suggest for the project are the following:

1. Download the genome you are interested in using the instructions here: https://github.com/juliaolivieri/COMP_293C_Computational_Biology/tree/main/project/download_genomes.
1. Modify the input parameters in `run_rand_reads.sbatch` so that FASTA contains the path to your downloaded genome file, and `SEQ_ERR` and `READ_LEN` are whatever you would like. Then submit this script. This script using the `gen_reads.py` file to create a file called `rand_reads.fa`.
1. Submit the `run_superstring.sbatch` file. It will use the greedy superstring algorithm to assemble the reads in `rand_reads.fa` into a single "genome" saved in `output.txt`. You can modify either of these names in the sbatch file.
1. Analyze your "output genome" in `output.txt`.
