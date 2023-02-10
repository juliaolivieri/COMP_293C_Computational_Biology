# Homework 4 Problem 2 Instructions

In this problem we will try running BLAST on the cluster, and check how the number of results change when we change the seed length or the sequencing error of the reads.

## Setup

Start by logging into the cluster and navigating into the `COMP_293C_Computational_Biology` folder.

`$ cd COMP_293C_Computational_Biology`

Run `git pull` to download the files for today's assignment.

A folder called `homework4` should appear. Enter this folder.

`$ cd homework4`

You can use `ls` to check that this folder contains two `.sbatch` files, a python script called `gen_reads.py`, empty folders `job_output` and `outputs`, and a folder called `dbs` that contains the file `c_elegans_chr1.fa`.

`c_elegans_chr1.fa` is a FASTA file containing the sequence from chromosome 1 of _C elegans_, a small (about 1mm-long) worm whose genome has been heavily studied.

We'll be aligning sequences to this chromosome with BLAST for this problem. To start, we need to run the command to create a BLAST database from the FASTA file. This is performed in `run_setup.sbatch`. Your conda environment `alignment_env` will be loaded in this file. If you called your environment something different, you can edit the file. You can submit this file now:

`$ sbatch run_setup.sbatch`

It should only take a few seconds to run. There should now be output in the `job_output` directory, as well as additional files in the `dbs` directory. The `dbs` directory now contains processed files based on `c_elegans_chr1.fa` that makes it easy to search.

We are now ready to proceed with the assignment.

## Generating reads

We've created a BLAST database so we can search chromosome 1 of _C elegans_ easily. But what will we search for? The python script `gen_reads.py` generates 10 fake DNA sequencing reads of length 100 from this chromosome by randomly sampling different sections of the fasta file `c_elegans_chr1.fa`.

You can try running the following command:

`$ python gen_reads.py --error_rate 0` 

A file called `rand_reads.fa` should have appeared in your directory. You can use `less` to look at it (remember, `q` quits out of `less`).

You make have noticed the `error_rate` argument that we used in that command. This is a value in [0,1] that determines the fraction of bases that have been artificially changed. For example, if `error_rate = 0.1` then 10% of the bases will be switched to another base (and won't perfectly match the genome anymore). This is a parameter we'll change over the course of the assignment.

## Submitting a BLAST query

Now it's time to actually run BLAST on some reads. The command to run BLAST is in `run_blast.sbatch`. Your conda environment `alignment_env` will be loaded in this file. If you called your environment something different, you can edit the file. 

Let's start by submitting the job:

`$ sbatch run_blast.sbatch`

Let's use `less` to look at this sbatch file. We can see that our output will be saved as `job_output/blast.*.out` and the error messages will be saved as `job_output/blast.*.err`. This job has a 10 minute limit, and uses 50 megabytes of memory.

Then we can see a variable called `SEED_LEN` and a variable called `SEQ_ERR`. These are the variables we will be manipulating in this assignment.

Next, the conda environment is loaded, reads are generated with error rate equal to `SEQ_ERR`, and BLAST is run on those reads using seeds of length `SEED_LEN`. Finally, the output is processed and the script completes.

## Understanding the BLAST output

Let's check the `outputs` folder for the output of our job.

`$ cd outputs`

There should be one file called `seedlen_18_err_0.01.txt`. The parameters used for the job are specified in the file name (`SEED_LEN` was equal to 18 and `SEQ_ERR` was equal to 0.01).

You can use `less` to look at this file. Each row corresponds to an alignment of a read to a different choromosome location. The columns represent the following:
1. The read number
2. The length of the alignment
3. The number of mismatches
4. The starting location of the alignment
5. The ending location of the alignment

Remember, these reads were generated from the genome itself, so we'd "expect" one alignment for each that is of length 100, maybe with a few mismatches due to the error that we introduced. 

**Part a: Does this match up with what you see in your output?**

## Modifying the `.sbatch`  file and submitting more jobs

**Part b: How do you expect the number of alignments to change as `SEED_LEN` changes? Explain why.**

**Part c: How do you expect the number of alignments to change as `SEQ_ERR` changes? Explain why.**

We'll now test out these predictions by modifying the values in our sbatch file and submitting more jobs. Make sure you're in the `homework4` directory (you might have to move up one directory with `cd ..`). Now edit the `run_blast.sbatch` file:

`$ nano run_blast.sbatch`

Change the value of `SEED_LEN`, save the file, and submit it using `sbatch run_blast.sbatch`. After the script is done running, your new output should appear in `outputs`.

How can we compare these outputs? One easy way to figure out how many alignments BLAST found in each file is by counting the number of lines of each file. Enter the `outputs` directory using `cd outputs`, and run the following command to count the number of lines in each file of the directory and sort by the number of lines:

`$ wc -l * | sort -h`

You should see output that looks something like this:

```
(base) [jolivieri@node1 outputs]$ wc -l * | sort -h
   36 seedlen_18_err_0.01.txt
  383 seedlen_15_err_0.01.txt
  419 total
```

This means that there are 36 lines in `seedlen_18_err_0.01.txt` and 383 lines in `seedlen_15_err_0.01.txt`. This means that with `SEED_LEN == 18` and `SEQ_ERR == 0.01`, BLAST found 35 alignments (note the first line is a header row), and with `SEED_LEN == 15` and `SEQ_ERR == 0.01`,  BLAST found 382 alignments.

**Part d: Choose three different values for `SEED_LEN` and three different values for `SEQ_ERR`. Run jobs for each combination of these two values (so 9 jobs in total). Submit a screenshot of the result of the `wc -l * | sort -h` command in the `outputs` directory with all 9 files. How do your observations compare to what you predicted in parts b and c?**

Turn in your answers to parts a, b, c, and d of this problem.
