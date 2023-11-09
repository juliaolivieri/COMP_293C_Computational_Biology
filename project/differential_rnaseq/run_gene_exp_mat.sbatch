#!/bin/bash
#
#SBATCH --job-name=geneexp
#SBATCH --output=job_output/geneexp.%j.out
#SBATCH --error=job_output/geneexp.%j.err
#SBATCH --time=10:00
#SBATCH --nodes=1
##SBATCH --mem=50M


date

source ~/.bashrc
conda activate diffexp_env 

GTF="hg38.ensGene.gtf"
OUTPUT="output/ge"
INPUT="output/*.sam"
a="featureCounts -a ${GTF} -o ${OUTPUT} ${INPUT} "
b="cat ${OUTPUT} | cut -f1,7- | sed 1d > ${OUTPUT}.mat"
echo $a
eval $a

echo $b
eval $b

date

