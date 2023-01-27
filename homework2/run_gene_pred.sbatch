#!/bin/bash
#
#SBATCH --job-name=gene_pred
#SBATCH --output=job_output/gene_pred.%j.out
#SBATCH --error=job_output/gene_pred.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=50M

THRESH=1600
FASTA="e_coli/sequence.fasta"
GFF="e_coli/sequence.gff3"
TO_RUN="python3 gene_prediction.py --fasta ${FASTA} --gff ${GFF} --thresh ${THRESH} "

echo 
echo "SCRIPT BEGINS"
date
echo $TO_RUN
eval $TO_RUN
date
echo "SCRIPT ENDS"
echo 

