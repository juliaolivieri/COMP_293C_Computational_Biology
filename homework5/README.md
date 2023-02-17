# HW 5 Problem 4 Instructions

In this assignment, you are going to practice creating an `.sbatch` file yourself, and learning how to navigate the cluster and job submission more fluently.

## Catalog of cluster commands

------
| **Command** | **Usage**| **Example usage** | **Description**|
|--|--|--|--|
|`cd` | `cd <directory name>`| `cd job_output` | Command to enter a directory|
| `cd ~` | `cd ~` | `cd ~` | Command to navigate to your home directory | 
| `cd ..` | `cd ..` | `cd ..` | Command to navigate one directory up from the current directory|
| `ls` | `ls` | `ls` | Command to show the contents of the current directory |
| `nano` | `nano <file to edit>` | `nano run_setup.sbatch` | Command to open the nano file editor to edit a specific file |
| `history` | `history` | `history` | Command to show the history of the commands you've typed into the command line |
| `less` | `less <file name>` | `less e_coli.fasta` | Command to view the contents of a file without editing it (type `q` to quit) |
| `cat` | `cat <file name>` | `cat count_kmers.111860.out` | Command to print the output of a file to the screen |
| `sbatch` | `sbatch <submission script file>` | `sbatch run_setup.sbatch` | Command to submit a job |
| `wc -l` | `wc -l <file name>` | `wc -l seedlen_18_err_0.01.txt` | Command to print the number of lines of a file |
| `squeue` | `squeue -u <username>` | `squeue -u jolivieri` | Command to show the jobs you've submitted that are currently in the queue |
| `cp` | `cp <file to copy> <new file name>`| `cp run_template.sbatch run_kmer_counts.sbatch` | Command to copy the contents of a file to a new file |
| `mkdir` | `mkdir <new directory name>` | `mkdir job_output` | Command to create a new directory inside the current directory |

## Setup

You can start by logging onto the cluster and running `git pull` to copy the new files into your directory. 

The script that we'll be running in this assignment is `count_kmers.py`. We talked in class about how finding regulatory motifs in the genome is essentially the process of finding kmers that are over-represented in the genome compared to a random sequence. 

The `count_kmers.py` script takes as input a FASTA file and a kmer length, and counts the number of times each kmer appears in that genome. It also creates a "randomized" version of the genome by randomly reordering the bases of the actual genome, and finds the number of times each kmer appears in that "randomized genome" as a point of comparison. Its output is a file that contains the kmers and their counts for both the genome and the "randomized" genome, sorted by how common they are.

For example, here's the output for when `kmer_len = 2`:

```
kmer    count   rand_kmer       count
GC      383931  CC      299618
CG      346670  GG      298956
TT      339482  GC      298720
AA      337870  CG      298678
CA      325149  CA      290716
TG      322239  TC      290690
AT      309819  CT      290542
CC      271673  AC      290525
GG      270137  GA      290007
TC      267288  TG      289709
GA      267247  AG      289580
AC      256662  GT      289240
GT      255608  AA      281473
AG      237877  AT      280649
CT      236061  TT      280539
TA      211961  TA      280032
```

The first two columns correspond to the genome, and the second two columns corresponds to the randomized version.

The command to run this script is `python count_kmers.py --fasta <fasta_path> --kmer_len <kmer length>`.

For example, if our fasta file was `e_coli.fasta` and we wanted to count kmers of length 2, the command would be:

`python count_kmers.py --fasta e_coli.fasta --kmer_len 2`

This would create a file called `kmer_comp_e_coli_2.tsv` in our `outputs` directory.

**Part a: What difference do you notice between the genome count column and the randomized count column?**

## Creating an sbatch script

There is a template sbatch file called `run_template.sbatch` in your directory. This is what we'll modify to run our script.

You can copy this file by running `cp run_template.sbatch <name for your new sbatch file>`. For example, you can run `cp run_template.sbatch run_kmer_count.sbatch`. This will copy the contents of the sbatch file to a new file with a different name.

After you copy the template, use `nano` to edit it. You should edit the occurrences of `JOB_NAME`, `JOB_TIME`, and `PUT COMMAND HERE`.
* `JOB_NAME`: This is what your job will appear as when you check the queue with `squeue`, and the name the `.out` and `.err` files will be saved with.
* `JOB_TIME`: This is the amount of time requested for the job. We've requested 10 minutes before by setting this equal to `10:00`.
* `PUT COMMAND HERE`: This is the command that will be run by the job. Put in the command you want to run, exactly as you would type it into the command line.

Running this job will create output in the `job_output` and `outputs` directories of our current directory. But those directories don't exist yet! We'll have to create them with the `mkdir` command. If you run `mkdir <name of new directory>` it will create a new directory in your current directory. For example, `mkdir job_output` will make a directory called `job_output` in your current directory. Make a directory called `outputs` as well.

## Submitting your job

When you first write an sbatch file, it's often helpful to check whether your commands are right before submitting the job. You can do this by running `bash <your script file>`, for example `bash run_count_kmers.sbatch`. This will run the commands in your file as though you submitted them on the command line, and send all the output and errors to your terminal. Try running your sbatch script using this command, and check that you don't have any errors and that the correct output is created in the `outputs` directory.

When you've checked that your command runs correctly, try submitting the job using `sbatch <your job name>`, for example `sbatch run_count_kmers.sbatch`. This will submit the job to the cluster. 

Try submitting jobs with at least 3 different values for `kmer_len`. Check that the corresponding output files are created in the `outputs` directory.

**Part b: For which kmer length is the discrepancy between the most common kmer in the genome and randomized genome largest? Include the value of k, the highest frequency kmer in the genome (with its count), and the highest frequency kmer in the "randomized" genome (with its count).**

## Running on a different genome

So far, most of the jobs we've run have completed in a few seconds. This brings up the question: why submit jobs at all, rather than just running them on the command line? We're now going to try running some jobs that require a bit more time.

First, download the `Drosophila` (fruit fly) genome using the following command:

`wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/215/GCF_000001215.4_Release_6_plus_ISO1_MT/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz`

It should take about a minute to download.

Now, to de-compress the file run `gunzip GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz`.

You should now have a file called `GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna` in your directory.

Modify your sbatch file to use this fasta file instead of `e_coli.fasta`. Submit jobs to count kmers in this genome, using the same three values you used for the e coli genome. The output files should be called something like `kmer_comp_GCF_000001215_<kmer length>.tsv`.

**Part c: For which kmer length is the discrepancy between the most common kmer in the genome and randomized genome largest? Include the value of k, the highest frequency kmer in the genome (with its count), and the highest frequency kmer in the "randomized" genome (with its count).**

