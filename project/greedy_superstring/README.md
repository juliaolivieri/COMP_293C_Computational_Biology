# Guidance for greedy superstring project

Updated guidance for the greedy superstring project:

1. If you have already cloned the COMP_293C_Computational_Biology repo, you can enter that repo and run `git pull`. Otherwise, you can clone the repo: `git clone https://github.com/juliaolivieri/COMP_293C_Computational_Biology.git`
1. Navigate into `COMP_293C_Computational_Biology` with `cd`, then navigate into `project`, then `greedy_superstring`.
1. The file `fastas` includes the fasta sequences for the gene Myl6 for several organisms. These are the fastas you can sample and try to "reassemble" using the greedy algorithm.
1. The `run_greedy_superstring.sbatch` is the file you will mostly be working with. Open this file. There are several arguments you can change: you can change the number of reads generated, the lengths of the reads, the sequencing error rates of the reads, and the species that you are sampling from. Make a job output directory with `mkdir job_output`. Try running this script with `sbatch run_greedy_superstring.sbatch`.
1. This should create an output file starting with `output` and ending with `txt`. The title of the output file keeps track of the input parameters that created this file.
1. The output file includes information such as the length of the greedily assembled sequence, the length of the original sequence that reads were sampled from, the length of time in seconds it took the algorithm to complete, and the assembled sequence. You can compare these values across multiple runs, changing the parameters.
