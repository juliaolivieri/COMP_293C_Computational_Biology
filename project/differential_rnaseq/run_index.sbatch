#!/bin/bash
#
#SBATCH --job-name=create_index
#SBATCH --output=job_output/create_index.%j.out
#SBATCH --error=job_output/create_index.%j.err
#SBATCH --time=5:00:00
#SBATCH --nodes=1


date

source ~/.bashrc
conda activate diff_exp_env 

FASTA="hg38/hg38.fa.gz"
NAME="human"

a="bowtie2-build ${FASTA} index/${NAME}"
echo $a
eval $a

date

