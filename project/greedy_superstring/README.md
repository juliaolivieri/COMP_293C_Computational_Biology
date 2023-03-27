# Guidance for greedy superstring project

For this project, I would recommend randomly generating reads to use for the algorithm from real genome(s). 

You can download the genome(s) you're interested in using the instructions here: https://github.com/juliaolivieri/COMP_293C_Computational_Biology/tree/main/project/download_genomes.

You can download the scripts necessary for generating random reads using the following commands:

```
wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/greedy_superstring/gen_reads.py
wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/project/greedy_superstring/run_rand_reads.sbatch
```

You can modify the input parameters in `run_rand_reads.sbatch` and submit it to generate the random reads.
