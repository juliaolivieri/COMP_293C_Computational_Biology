#!/bin/bash
#
#SBATCH --job-name=blast
#SBATCH --output=job_output/blast.%j.out
#SBATCH --error=job_output/blast.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=50M

SEED_LEN=18
SEQ_ERR=0.01

date

# load conda environment
source ~/.bashrc
conda activate alignment_env

# generate reads
a="python gen_reads.py --in_file dbs/c_elegans_chr1.fa --error_rate ${SEQ_ERR}"
echo
echo $a
eval $a
echo

# run BLAST
b="blastn -query rand_reads.fa  -db dbs/c_elegans_chr1.fa -outfmt 6 -out outputs/seedlen_${SEED_LEN}_err_${SEQ_ERR}_temp.txt -word_size ${SEED_LEN}"
echo $b
eval $b
echo

# process output
awk -v OFS='\t' '{ print $1, $4, $5, $9, $10}' outputs/seedlen_${SEED_LEN}_err_${SEQ_ERR}_temp.txt > outputs/seedlen_${SEED_LEN}_err_${SEQ_ERR}.txt

sed -i '1s/^/query\talign_len\tmismatches\ts. start\ts. end\n/' outputs/seedlen_${SEED_LEN}_err_${SEQ_ERR}.txt 

rm outputs/seedlen_${SEED_LEN}_err_${SEQ_ERR}_temp.txt

date

