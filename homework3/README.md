# Homework 3, Problem 4 Instructions

In this problem we are going to install Anaconda onto the cluster, in preparation for homework 4. 

Anaconda is a package manager. Have you ever had a situation while coding where you tried downloading a package, but it conflicted with a package you already had downloaded, and you didn't know how to resolve the issues without it getting messy? Package managers help with these situations by allowing you to install exactly the packages you need into a specific "environment." Environments are kept separate from each other, so you can jump in and out of them as needed.

## Installing Anaconda

Start off by logging into the cluster and using `cd` to navigate to the directory `COMP_293C_Computational_Biology`. Remember, you can always use `ls` to show you what's in your current directory, to help you figure out where you are. `cd ~` will always bring you back to your home directory.

Once you're in `COMP_293C_Computational_Biology`, you'll need to run a command to copy the homework 3 files onto the cluster (remember, only run the command after the dollar sign):

`$ git pull` 

If you use `ls`, you should be able to see that a directory called `homework3` has appeared in the current directory. Use `cd` to enter this directory (`cd homework3`).

This directory should contain a file called `install_anaconda.sh`. This is a bash script that contains instructions for installing Anaconda (feel free to check it out with the `less` command). To run the bash script, use the following command:

`$ bash install_anaconda.sh`

Follow the prompts that come up on the screen. In response to:

```
In order to continue the installation process, please review the license
agreement.
Please, press ENTER to continue
```

Press ENTER. Continue pressing ENTER to scroll through the agreement.

When the following message appears:

`Do you accept the license terms? [yes|no]`

Type `yes` and press ENTER.

When the following prompt appears on the screen:

```
Anaconda3 will now be installed into this location:
/exports/home/<username>/anaconda3

  - Press ENTER to confirm the location
  - Press CTRL-C to abort the installation
  - Or specify a different location below
```

Press ENTER. Anaconda should now install. This will take a few minutes.

When the following prompt comes up on the screen:

```
installation finished.
Do you wish the installer to initialize Anaconda3
by running conda init? [yes|no]
```

Type `yes` and press ENTER. Once it finishes running, anaconda should be installed. If you use `cd ~` to navigate to your home directory and `ls` to look around, you should see a new directory called `anaconda3`.

## Testing out Anaconda

Now that we've installed Anaconda, let's try creating our first environment. 

Input the following command to create an environment called `anaconda_env` that has Python3 loaded into it:

`$ conda create --name alignment_env python=3`

This may take a few minutes to run. You will need to press `y` to proceed.

To start using this environment after it's created, use the command:

`$ conda activate alignment_env `

You should now see `(alignment_env)` to the left of your prompt in the terminal:

`(alignment_env) [jolivieri@node1 COMP_293C_Computational_Biology]$ `

Now, let's try installing some software into our environment:

`$ conda install -c bioconda blast`

This command will install the BLAST software. You will need to press `y` to proceed.

Next, we'll install Bowtie2 with the following command (you'll need to press `y` to proceed again):

`$ conda install -c bioconda bowtie2`

Let's test out whether BLAST and Bowtie2 were successfully installed. Enter the following command:

`$ blastn -h`

This should show the `help` information for `blastn`. You can scroll through it a bit if you're interested.

Similarly, try:

`$ bowtie2 -h`

This should show the `help` information for `bowtie2`. Again, feel free to scroll through.

Finally, we are going to deactivate our environment using the following command:

`$ conda deactivate`

Now that we've deactivated the environment, the packages we just loaded aren't accessible. You can check this by running 

`$ blastn -h`

This is the magic of conda environments! You can have multiple environments, each of which has exactly what you need for the given project. We'll try out using the environment you created today in the next assignment.

As evidence that you completed this problem, run the following command and submit a screenshot of the output in your assignment:

`$ conda list -n alignment_env | head`

This command lists all the packages loaded in the given environment (and `head` causes it to only print the first 10 lines).
