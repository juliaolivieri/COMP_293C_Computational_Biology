# Homework 2, Problem 2 Instructions

Note: If you run into any technical difficulties with this assignment at all, let me know! I'll probably be able to save you a lot of time and frustration.

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

## Understanding the SBATCH file

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
TO_RUN="python3 gene_prediction.py --fasta ${FASTA} --thresh ${THRESH} --gff ${GFF}"

echo 
echo "SCRIPT BEGINS"
date
echo $TO_RUN
eval $TO_RUN
date
echo "SCRIPT ENDS"
echo 
```

Let's understand what's going on in this file. The first line, `#!/bin/bash`, tells the cluster that this is a bash script. The lines that start with `#SBATCH` are parameters that we submit to the job scheduling system (this workload manager is called Slurm). We're telling it the name we want to give our job, where we want to save the output, where we want to save any error messages, how much time we want to give it (that's 10 minutes), how many nodes we want to give it, and how much memory we want to give it (that's 50 megabytes). 

In the rest of the script we can write whatever we want the cluster to do, as though we're executing each line in succession. I start with a few variables, to organize the script and make it easy to see what we're changing. `THRESH` will be the threshold that we use for the program, `FASTA` is the location of the FASTA file, `GFF`  is the location of the GFF file, and `TO_RUN` puts these variables together into the command we actually want to run.

Next there are some `echo` commands to print to the screen marking the beginning of the script. The `date` command prints the current date and time. `echo $TO_RUN` prints the command we're going to run to the screen, and `eval $TO_RUN` actually runs that command.

## Submiting your first job

Now that we understand what's going on in this script, we're ready to submit it to the cluster! You can do this using the following command:

`$ sbatch run_gene_pred.sbatch`

The terminal should print something like `Submitted batch job 111306` (but with a different number). So what happened? Our job was submitted to the cluster, and it should complete pretty instantaneously. Let's see what the output is by entering the `job_output` folder.

`$ cd job_output`

Using `ls` should show you two files, `gene_pred.111306.err` and `gene_pred.111306.out` (except with your job number). `gene_pred.111306.err` should contain any error messages that came up when executing the code. You can use the `less` command to check it out. It should be empty.

The file `gene_pred.111306.out` should contain the output of the job. You can use `less` to look at it. It should show something like this:

```
SCRIPT BEGINS
Fri Jan 27 10:10:31 PST 2023
python3 gene_prediction.py --fasta e_coli/sequence.fasta --thresh 1600 --gff e_coli/sequence.gff3
genome length: 4639675
beginning of genome: AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGCTTCTGAACTGGTTACCTGCCGTGAGTAAAT
fraction A: 0.2462
fraction T: 0.2459
fraction G: 0.2537
fraction C: 0.2542

3 genes are annotated out of 3 predicted: 100.00%
Fri Jan 27 10:10:34 PST 2023
SCRIPT ENDS
```

We can see that this is the output we got from running on the command line, with additional lines showing the date and time that the script started and ended, and text markers indicating when the script began and ended.

## Editing the SBATCH script

Now, we know what the result of the script is when `thresh = 1600`. But what happens when we change that number? We can edit this value in the script, and then re-submit to see our new results. 

You can use the following command to open the file with a simple screen-based text editor:

`$ nano run_gene_pred.sbatch` 

Use the arrow keys to move to where we set `THRESH=1600`. Then you can change this value to something else (for example, 1000). Press the CONTROL and X keys at the same time to exit. It will ask whether you want to save at the bottom of the screen: press Y for yes, and then press enter. You have now edited the file. Here is a "beginner's guide to nano" if it's helpful: https://www.howtogeek.com/42980/the-beginners-guide-to-nano-the-linux-command-line-text-editor/.

Note: There are other more sophisticated screen-based text editors as well, but they have much steeper learning curves. If you're interested in trying one out, I suggest the "vim" editor. To run through a tutorial of vim, just type `vimtutor` and then press enter on the command line. Follow the instructions on the screen to complete the tutorial.

Now let's try submitting our edited job script:

`$ sbatch run_gene_pred.sbatch`

Depending on what threshold value you chose, this might complete immediately, or it might take a few minutes. You can always check the status of your current jobs using the following command:

`$ squeue -u <username>`

So for example I would use

`$ squeue -u jolivieri`

When a job is running, you'll see output that looks like this:

```
[jolivieri@node1 homework2]$ squeue -u jolivieri
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            111307   compute gene_pre jolivier  R       0:26      1 node002

```

When no job is running, you should just see this:

```
[jolivieri@node1 homework2]$ squeue -u jolivieri
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)

```

Once your job completes, you can check its output. Navigate to the `job_output` folder. Once you run with several thresholds, it can be easier to just print all of the "output" file contents to the screen at once. You can do this using the following command:

`$ cat gene_pred.*.out`

The asterisk is a "wildcard" character that matches any pattern.

## Running multiple jobs

Now try changing the threshold to a few other values, and running the script each time. You don't have to wait until your previous job completes to start a new job - after you submit, feel free to edit the sbatch file and submit again.

Note that when you press the up arrowkey on the command line, it will show the most recent command you used. You can keep pressing "up" to cycle through your most recent commands. This can be helpful when you're running the same script multiple times.

If you ever want to revert your `run_gene_pred.sbatch` script to what it contained when you first downloaded it (before you made any changes), you can run the following command:

`$ git checkout run_gene_pred.sbatch`

## What to submit

Try out at least 5 different thresholds. List each threshold value, along with the fraction of predicted genes that were annotated at that threshold. What threshold had the lowest fraction? Does this make sense to you?
