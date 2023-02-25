#!/bin/bash
#
#SBATCH --job-name=align
#SBATCH --output=job_output/align.%j.out
#SBATCH --error=job_output/align.%j.err
#SBATCH --time=1:00:00
#SBATCH --nodes=1


date

source ~/.bashrc
conda activate diffexp_env

NAME="tumor1"

a="bowtie2 -x index/chr22 -U data/${NAME}.fastq.gz -S output/${NAME}.sam --no-unal"
echo $a
eval $a

date

