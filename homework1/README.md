# Homework 1 Problem 4 Instructions

Note: in all coding instructions that follow, do not include the `$` when executing. Only include the text after the `$`.

## Log into the cluster and create a folder for the assignment

1. First, log in to the cluster using the command:

`$ ssh <your username>@ecs-cluster.serv.pacific.edu`

For example, I would use the command:

`$ ssh jolivieri@ecs-cluster.serv.pacific.edu`

2. Next, from the cluster, create a folder for this homework assignment:

`$ mkdir COMP293C_HW1`

If you use the `ls` command, it should now show the folder.

We will enter the folder we just created using the `cd` command:

`$ cd COMP293C_HW1`

## Download the necessary files

3. Now it's time to download the files we'll need for this question. 

Run the following two commands to download the two files:

`$ wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/homework1/test_fasta.fa`

`$ wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/homework1/greedy_superstring.py`

You can use the `ls` command to show the files present in the current folder. You should see `test_fasta.fa` and `greedy_superstring.py` present.

## Explore the files that you downloaded

4. The file `test_fasta.fa` is a text file that follows the FASTA format. This means that the first line starts with `>`, and the rest of the text on that line is a label. The second line represents the DNA sequence corresponding to that label. This pattern repeats throughout the file.

We can observe this file by opening it with the text editor you practiced with in Problem 3. Check that the file follows this format.

5. The file `greedy_superstring.py` contains code that takes in a FASTA file as an input variable, performs the greedy superstring algorithm on the sequences in that FASTA file, and prints the result. You can use the text editor you practiced with in Problem 3 to open this file and look at it.

## Run the Python program on the test file

6. Now we'll try running the python program on `test_fasta.py`. This program has one command-line argument, which we'll use to input our FASTA file. Try running the following command:

`$ python greedy_superstring.py --fasta test_fasta.fa`

Check that the result matches up with your solution to Problem 2a.


## Create your own FASTA file to run on

7. Now, let's try creating your own FASTA file with your own sequences. Open a new file with the text editor you practiced with in Problem 3. Create a file following the FASTA format entitled `my_fasta.fa`. Make sure that there isn't a blank line at the end. Your file should have at least 5 sequences (you can decide the length and composition of the sequences).

8. Run the greedy algorithm on your new sequences:

`$ python greedy_superstring.py --fasta my_fasta.fa`

9. Edit the sequences in `my_fasta.fa` such that the superstring returned by the algorithm has at most half the number of bases in it as the sum of the lengths of all of your sequences. For example, if your sequences were ATG, GTCC, and GTGAT, the sum of the lengths of all the sequences would be 3 + 4 + 5 = 12. The superstring that the program creates based on these sequences is GTGATGTCC, which has length 9. In order for the superstring to have half the number of bases of the sum of all the sequences in this case, it would need to have length at most 6. Essentially, you want your superstring to "condense" your input sequences by at least a factor of 2.

## Download your FASTA file to submit

10. Submit `my_fasta.fa` and the superstring that `greedy_superstring.py` returns when run on the file. You can copy `my_fasta.fa` from the cluster to your local system by running the following command from your local system:

`$ scp <your username>@ecs-cluster.serv.pacific.edu:/exports/home/<your username>/COMP293C_HW1/my_fasta.fa .`

For example, my version of the command would be:

`$ scp jolivieri@ecs-cluster.serv.pacific.edu:/exports/home/jolivieri/COMP293C_HW1/my_fasta.fa .`
