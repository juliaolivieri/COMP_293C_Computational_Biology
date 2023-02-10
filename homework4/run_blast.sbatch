#!/bin/bash
#
#SBATCH --job-name=blast
#SBATCH --output=job_output/blast.%j.out
#SBATCH --error=job_output/blast.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=50M

date

source ~/.bashrc
conda activate alignment_env

WORD=11
SEQ_ERR=0.0

python gen_reads.py --in_file dbs/c_elegans_chr1.fa --error_rate ${SEQ_ERR}

blastn -query rand_reads.fa  -db dbs/c_elegans_chr1.fa -outfmt 6 -out outputs/wordlen_${WORD}_err_${SEQ_ERR}_temp.txt -word_size ${WORD}
awk -v OFS='\t' '{ print $1, $2, $3, $4, $5, $9, $10}' outputs/wordlen_${WORD}_err_${SEQ_ERR}_temp.txt > outputs/wordlen_${WORD}_err_${SEQ_ERR}.txt
sed -i '1s/^/query acc.ver\tsubject acc.ver\t% identity\talignment length\tmismatches\ts. start\ts. end\n/' outputs/wordlen_${WORD}_err_${SEQ_ERR}.txt 
rm outputs/wordlen_${WORD}_err_${SEQ_ERR}_temp.txt

date

