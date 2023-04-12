#!/bin/bash
#
#SBATCH --job-name=ttest
#SBATCH --output=job_output/ttest.%j.out
#SBATCH --error=job_output/ttest.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1


date

source ~/.bashrc
conda activate diffexp_env 

OUTPUT="output/diffexp"
INPUT="output/ge.mat"
a="python t_test.py --exp_matrix ${INPUT} --outpath ${OUTPUT}"
echo $a
eval $a

date

