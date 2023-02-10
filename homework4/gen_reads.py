import argparse
import random

parser = argparse.ArgumentParser(description="Generate reads from a fasta file")
parser.add_argument("--read_len","-l",type=int,help="length of reads to generate",default=100)
parser.add_argument("--num_reads","-n",type=int,help="number of reads to generate",default=10)
parser.add_argument("--qual","-q",help="base quality score for all bases",default="I")
parser.add_argument("--in_file","-i",help="fasta file to create reads from",default="dbs/c_elegans_chr1.fa")
parser.add_argument("--out_file","-o",help="fastq file to put reads into",default="rand_reads.fa")
parser.add_argument("--error_rate",help="sequencing error rate",default=0.01, type=float)

args = parser.parse_args()

random.seed(123)

fasta = open(args.in_file,"r")
genome = ""
for line in fasta.readlines():
  if line[0] != ">":
    genome += line[:-1]
fasta.close()

out = open(args.out_file,"w")
for i in range(args.num_reads):
  out.write(">read_{}\n".format(i))
  loc = random.choice(range(len(genome) - args.read_len))
  seq = genome[loc:loc + args.read_len].upper()
  seq = list(seq)
 
  # add sequencing errors
  for j in range(len(seq)):
    if random.random() < args.error_rate:
      seq[j] = random.choice([c for c in ["A", "T", "G", "C"] if c != seq[j]])
  seq = "".join(seq)
  out.write(seq + "\n")
out.close()
