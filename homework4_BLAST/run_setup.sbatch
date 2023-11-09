#!/bin/bash
#
#SBATCH --job-name=setup
#SBATCH --output=job_output/setup.%j.out
#SBATCH --error=job_output/setup.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=50M

date
source ~/.bashrc
conda activate alignment_env

makeblastdb -in dbs/c_elegans_chr1.fa -dbtype nucl
date

