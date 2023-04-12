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

NAME="positive3"
INDEX="hg38_index/hg38"

a="bowtie2 -x ${INDEX} -U reads/${NAME}.fq -S output/${NAME}.sam --no-unal"
echo $a
eval $a

date

