#!/bin/bash
#
#SBATCH --job-name=gene_pred
#SBATCH --output=job_output/gene_pred.%j.out
#SBATCH --error=job_output/gene_pred.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=500M

echo ""
echo "SCRIPT BEGINS"
date
THRESH=10
FASTA="../e_coli/sequence.fasta"
GFF="../e_coli/sequence.gff3"
to_run="python3 gene_prediction.py --fasta ${FASTA} --thresh ${THRESH} --gff ${GFF}"

echo $to_run
eval $to_run

date
echo "SCRIPT ENDS"
echo ""

