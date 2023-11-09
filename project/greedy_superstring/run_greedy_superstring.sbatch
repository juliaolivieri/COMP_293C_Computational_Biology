#!/bin/bash
#
#SBATCH --job-name=greedy_superstring
#SBATCH --output=job_output/greedy_superstring.%j.out
#SBATCH --error=job_output/greedy_superstring.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1

SEQ_ERR=0.05
READ_LEN=100
ANIMAL="mouse"
NUM_READS=20

date
FASTA="fastas/${ANIMAL}.fa"

# load conda environment
source ~/.bashrc
conda activate alignment_env

# generate reads
a="python gen_reads.py --in_file ${FASTA} --error_rate ${SEQ_ERR} --read_len ${READ_LEN} --num_reads ${NUM_READS}"
b="python greedy_superstring.py --fasta rand_reads.fa --fasta_orig ${FASTA} --output output_seqerr_${SEQ_ERR}_readlen_${READ_LEN}_numreads_${NUM_READS}_${ANIMAL}.txt"

echo $a
eval $a
echo $b
eval $b

date

