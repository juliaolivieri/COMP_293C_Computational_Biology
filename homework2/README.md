# Homework 2, Problem 2 Instructions

## Download assignment files

In this assignment, we're going to learn how to submit jobs to the cluster.

To start, log in to the cluster. This GitHub repo contains the code for this week's assignment. You can download it onto the cluster by running the following command:

`$ git clone https://github.com/juliaolivieri/COMP_293C_Computational_Biology.git`

This will copy all the files in this GitHub repo to the cluster. If you run the command `ls`, you should now see a folder called `COMP_293C_Computational_Biology`. Enter that folder:

`$ cd COMP_293C_Computational_Biology`

Run `ls` again to see what folders we have access to. Now enter the folder for homework 2:

`$ cd homework2`

## Run `gene_prediction.py` script

Use `ls` to look around again. There are a few files in the folder, including a script called `gene_prediction.py`. This is a script that searches the _E coli_ genome for stop codons in each reading frame (only along one strand of the DNA), just like the example we saw in class. Given a threshold value `thresh`, it will find every stretch of _E coli_'s genome that's of length at least `thresh` that doesn't have any STOP codons. As we saw in class, we expect these areas to be more likely to contain gene sequence.

We're going to see if what we expect actually occurs. Try running the following command:

`$ python3 gene_prediction.py --fasta e_coli/sequence.fasta --gff e_coli/sequence.gff3 --thresh 1600`

You should see the following output:

```
genome length: 4639675
beginning of genome: AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGCTTCTGAACTGGTTACCTGCCGTGAGTAAAT
fraction A: 0.2462
fraction T: 0.2459
fraction G: 0.2537
fraction C: 0.2542

3 genes are annotated out of 3 predicted: 100.00%
````

## Understand `gene_prediction.py` input and output

Let's break this down, starting with the command we ran. We used `python3` to indicate that we're running a Python 3 script, and then we included the script name (`gene_prediction.py`). Next, we included three **command line arguments**. These are values you pass into the program from the function call.

What are these command line arguments? `--fasta` indicates that the next value will be the path to the FASTA file we want to analyze. In our case, the FASTA file is located at `e_coli/sequence.fasta`. This is the sequence of the entire bacterial genome. 

`--gff` indicates that the next value will be the path to the gff file, which in our case is `e_coli/sequence.gff3`. A "gff file" is a file that contains the locations of all known genes in the genome.

Finally, `--thresh` indicates that the next value will be the threshold the program should use. Because we put in 1600, it will only be keeping track of stretches of the genome of length at least 1600 that don't include STOP codons.

Now let's break down the output. It starts with some information about the genome: the length of the genome, and the fraction of each base present (you can see that Gs and Cs are slightly overrepresented compared to As and Ts).

Finally, it gives us the information we're really interested in: the program found three "predicted" genes based on our threshold, and all three are annotated. This means 100% of the stretches of the _E coli_ genome without STOP codons of length > 1600 are known to be genes! We've successfully predicted several genes! (Note: for simplicity, this program is not checking the reverse complement of the genome).

## Explore the directory

You're free to check out the `gene_prediction.py` script using the `less` command (remember, press `q` to quit that view). This is also a great chance to practice tab-completion. Type in `less g` and then hit tab - the rest of the script name should fill in, to give you `less gene_prediction.py`! Tab completion is super helpful so we don't have to spend too much time testing out commands.

You can also check out the FASTA and gff files: navigate to the `e_coli` directory using the `cd` command, and use the `less` command to check out these files (you can press the arrow keys to scroll). Remember, you can use the `cd ..` command to jump up a directory level (for example, to get from `e_coli` back to `homework2`). 

## Submit your first job

Now that we've tried running the `gene_prediction.py` script on the command line, let's try to run it by submitting a job instead. We'll basically write down the commands we want the cluster to run for us in a file ending in `.sbatch`, "submit" that file, and then we're free to leave the cluster or do something else - the code will be executed and all output will be saved.

The sbatch file we'll be using is `run_gene_pred.sbatch`. Here's the contents of that file:

```
#!/bin/bash
#
#SBATCH --job-name=gene_pred
#SBATCH --output=job_output/gene_pred.%j.out
#SBATCH --error=job_output/gene_pred.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=50M

THRESH=6
FASTA="e_coli/sequence.fasta"
GFF="e_coli/sequence.gff3"
to_run="python3 gene_prediction.py --fasta ${FASTA} --thresh ${THRESH} --gff ${GFF}"

echo 
echo "SCRIPT BEGINS"
date
echo $to_run
eval $to_run
date
echo "SCRIPT ENDS"
echo 
```
