#!/bin/bash
#
#SBATCH --job-name=rand_reads
#SBATCH --output=job_output/rand_reads.%j.out
#SBATCH --error=job_output/rand_reads.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1

SEQ_ERR=0.01
READ_LEN=100
FASTA="hg38.fa"

date

# load conda environment
source ~/.bashrc
conda activate alignment_env

# generate reads
a="python gen_reads.py --in_file ${FASTA} --error_rate ${SEQ_ERR} --read_len ${READ_LEN}"
echo
echo $a
eval $a
echo 

date

