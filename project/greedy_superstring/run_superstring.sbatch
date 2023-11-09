#!/bin/bash
#
#SBATCH --job-name=superstring
#SBATCH --output=job_output/superstring.%j.out
#SBATCH --error=job_output/superstring.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1

FASTA="rand_reads.fa"
OUTPUT="output.txt"

date


# generate reads
a="python greedy_superstring.py --fasta ${FASTA} --output ${OUTPUT}"
echo
echo $a
eval $a
echo 

date

