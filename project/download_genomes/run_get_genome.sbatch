#!/bin/bash
#SBATCH --time=3:00:00
#SBATCH --job-name=download_genome                 
#SBATCH --output=download_genome.%j.out
#SBATCH --error=download_genome.%j.err

GENOME="hg38"

mkdir $GENOME
cd $GENOME
a="wget https://hgdownload.soe.ucsc.edu/goldenPath/${GENOME}/bigZips/${GENOME}.fa.gz"
b="wget https://hgdownload.soe.ucsc.edu/goldenPath/${GENOME}/bigZips/genes/${GENOME}.ensGene.gtf.gz"

echo $a
eval $a
echo $b
eval $b

gunzip *.gz

