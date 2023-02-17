#!/bin/bash
#
#SBATCH --job-name=JOB_NAME
#SBATCH --output=job_output/JOB_NAME.%j.out
#SBATCH --error=job_output/JOB_NAME.%j.err
#SBATCH --time=JOB_TIME
#SBATCH --nodes=1
#SBATCH --mem=JOB_MEM


date

PUT COMMAND HERE

date

