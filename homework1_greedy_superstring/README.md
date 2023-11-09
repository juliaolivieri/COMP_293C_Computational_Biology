# Homework 1, Problems 3 and 4

## Homework 1 Problem 3 Instructions

Note: in all coding instructions that follow, do not include the `$` when executing. Only include the text after the `$`.

### Log in to the cluster

1. First, log in to the cluster using the command:

`$ ssh <your username>@ecs-cluster.serv.pacific.edu`

For example, I would use the command:

`$ ssh jolivieri@ecs-cluster.serv.pacific.edu`

### The `whoami` command

2. In this problem, we'll learn how to "move around" the computational cluster and see what's there. Adapted from: https://www.hpc-carpentry.org/hpc-shell/02-navigation/index.html.

Right now, you should see something like this:

`[yourUsername@node1 ~]$`

The dollar sign is a prompt, which shows us that the shell is waiting for input. When typing commands, either from this lesson or from other sources, do not type the prompt, only the commands that follow it.

Type the command `whoami`, then press the Enter key to send the command to the shell. The command’s output is the ID of the current user, i.e., it shows us who the shell thinks we are:

Input:

`$ whoami`

Output:

`yourUsername`

### The `pwd` and `ls` commands

Next, let’s find out where we are by running a command called `pwd` (which stands for “print working directory”). (“Directory” is another word for “folder”). At any moment, our current working directory (where we are) is the directory that the computer assumes we want to run commands in unless we explicitly specify something else. Here, the computer’s response is `/exports/home/yourUsername`, which is `yourUsername` home directory.

Input:

`$ pwd`

Output:

`/exports/home/yourUsername`

So, we know where we are. How do we look and see what’s in our current directory?

Try the following:

`$ ls`

`ls` prints the names of the files and directories in the current directory in alphabetical order, arranged neatly into columns. If nothing shows up when you run `ls`, it means that nothing’s there. Let’s make a directory for us to play with.

### The `mkdir` and `cd` commands

`mkdir <new directory name>` makes a new directory with that name in your current location. Notice that this command required two pieces of input: the actual name of the command (`mkdir`) and an argument that specifies the name of the directory you wish to create.

Input:

`$ mkdir documents` 

Let’s `ls` again. You should now see the `documents` folder. What if we wanted to go inside it and do stuff there? We will use the `cd` (change directory) command to move around. Let’s `cd` into our new documents folder.

Input:

`$ cd documents`

`$ pwd`

Output:

`/exports/home/yourUsername/documents`

### Returning home and to the base directory

When using the shell, `~` is a shortcut that represents `/exports/home/yourUsername`.

Now that we know how to use `cd`, we can go anywhere. That’s a lot of responsibility. What happens if we get “lost” and want to get back to where we started?

To go back to your home directory, any of the following three commands will work:

`$ cd /exports/home/yourUsername`

`$ cd ~`

`$ cd`

A quick note on the structure of a UNIX (Linux/Mac/Android/Solaris/etc) filesystem. Directories and absolute paths (i.e. exact position in the system) are always prefixed with a `/`. `/` by itself is the “root” or base directory.

Let’s go there now, look around, and then return to our home directory.

Input:

`$ cd /`

`$ ls`

`$ cd ~`

Output:

`bin   copyright  etc      exports-backup  install                        lib    media  opt   root  sbin  sys       tmp  var
boot  dev        exports  home            kernel-3.10.0-327.el7.src.rpm  lib64  mnt    proc  run   srv   tftpboot  usr`

The “home” directory is the one where we generally want to keep all of our files. Other folders on a UNIX OS contain system files, and get modified and changed as you install new software or upgrade your OS.

### Other navigational shortcuts

There are several other useful shortcuts you should be aware of.

* `.` represents your current directory
* `..` represents the “parent” directory of your current location
* While typing nearly anything, you can have bash try to autocomplete what you are typing by pressing the `tab` key.

Let's try these out now:

Input:

`$ cd ./documents`

`$ pwd`

`$ cd ..`

`$ pwd`

Output:

`/exports/home/yourUsername/documents`

`/exports/home/yourUsername`

### The `history` command

Finally, try out the `history` command. This prints every command you have typed in the cluster during the given session. 

Input:

`$ history`

Output:

Something like:

```  
  291  cd /
  292  ls
  293  cd ~
  294  ls
  295  cd ./documents/
  296  pwd
  297  cd ..
  298  pwd
  299  ls -a
  300  ls -l
  301  ls -la
  302  man ls
  303  ls --help
  304  :q
  305  ls
  306  pwd
  307  ls
  308  cd documents/
  309  pwd
  310  cd /
  311  ls
  312  cd 
  313  cd ./documents
  314  pwd
  315  cd ..
  316  pwd
  317  cd ./documents
  318  pwd
  319  cd ..
  320  pwd
  321  history
  322  ls
  323  pwd
  324  history
  ```
  
Take a screenshot of your terminal with the output of the history command. This is what you will turn in as proof that you completed this question.

## Homework 1 Problem 4 Instructions

Note: in all coding instructions that follow, do not include the `$` when executing. Only include the text after the `$`.

### Log into the cluster and create a folder for the assignment

1. First, log in to the cluster using the command if you're not logged in already:

`$ ssh <your username>@ecs-cluster.serv.pacific.edu`

For example, I would use the command:

`$ ssh jolivieri@ecs-cluster.serv.pacific.edu`

2. Next, from the cluster, create a folder for this homework assignment:

`$ mkdir COMP293C_HW1`

If you use the `ls` command, it should now show the folder.

We will enter the folder we just created using the `cd` command:

`$ cd COMP293C_HW1`

### Download the necessary files

3. Now it's time to download the files we'll need for this question. 

Run the following two commands to download the two files:

`$ wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/homework1/test_fasta.fa`

`$ wget https://raw.githubusercontent.com/juliaolivieri/COMP_293C_Computational_Biology/main/homework1/greedy_superstring.py`

You can use the `ls` command to show the files present in the current folder. You should see `test_fasta.fa` and `greedy_superstring.py` present.

### Explore the files that you downloaded

4. The file `test_fasta.fa` is a text file that follows the FASTA format. This means that the first line starts with `>`, and the rest of the text on that line is a label. The second line represents the DNA sequence corresponding to that label. This pattern repeats throughout the file.

We can observe this file by opening it using the `less` command. Once the file is open, you can use the up and down arrow keys to move around. Press `q` to leave the file. 

`$ less test_fasta.fa`

5. The file `greedy_superstring.py` contains code that takes in a FASTA file as an input variable, performs the greedy superstring algorithm on the sequences in that FASTA file, and prints the result. You can use the `less` command to open this file and look at it.

`$ less greedy_superstring.py`

### Run the Python program on the test file

6. Now we'll try running the python program on `test_fasta.py`. This program has one command-line argument, which we'll use to input our FASTA file. Try running the following command:

`$ python greedy_superstring.py --fasta test_fasta.fa`

Check that the result matches up with your solution to Problem 2a.

### Submission for this problem

7. Take a screenshot of your terminal with the output of `greedy_superstring.py`. This is what you'll turn in as evidence that you completed this problem.

<!---
### Create your own FASTA file to run on

7. Now, let's try creating your own FASTA file with your own sequences. Open a new file with the text editor you practiced with in Problem 3. Create a file following the FASTA format entitled `my_fasta.fa`. Make sure that there isn't a blank line at the end. Your file should have at least 5 sequences (you can decide the length and composition of the sequences).

8. Run the greedy algorithm on your new sequences:

`$ python greedy_superstring.py --fasta my_fasta.fa`

9. Edit the sequences in `my_fasta.fa` such that the superstring returned by the algorithm has at most half the number of bases in it as the sum of the lengths of all of your sequences. For example, if your sequences were ATG, GTCC, and GTGAT, the sum of the lengths of all the sequences would be 3 + 4 + 5 = 12. The superstring that the program creates based on these sequences is GTGATGTCC, which has length 9. In order for the superstring to have half the number of bases of the sum of all the sequences in this case, it would need to have length at most 6. Essentially, you want your superstring to "condense" your input sequences by at least a factor of 2.

### Download your FASTA file to submit

10. Submit `my_fasta.fa` and the superstring that `greedy_superstring.py` returns when run on the file. You can copy `my_fasta.fa` from the cluster to your local system by running the following command from your local system:

`$ scp <your username>@ecs-cluster.serv.pacific.edu:/exports/home/<your username>/COMP293C_HW1/my_fasta.fa .`

For example, my version of the command would be:

`$ scp jolivieri@ecs-cluster.serv.pacific.edu:/exports/home/jolivieri/COMP293C_HW1/my_fasta.fa .`
---> 
