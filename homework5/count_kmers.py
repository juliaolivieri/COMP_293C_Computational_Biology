import argparse
from collections import defaultdict
import random

random.seed(123)

def get_args():
    """Read in fasta path from command line"""
    parser = argparse.ArgumentParser()
    parser.add_argument("--fasta", help="path to fasta file", required=True)
    parser.add_argument("--out_directory", help="where to write output", default = ".")
    parser.add_argument("--kmer_len", help="count kmers of this length", required=True, type=int)
    args = parser.parse_args()
    return args

def read_fasta(fasta):
    """Get sequences to merge from the fasta file"""
    f = open(fasta,"r")
    seqs = []
    for line in f.readlines():
        if line[0] != ">":
            seqs.append(line[0:-1])
    f.close()
    return seqs

def main():

  # read in arguments
  args = get_args()
  
  out_file = "{}/outputs/kmer_comp_{}.tsv".format(args.out_directory, args.kmer_len)
  seqs = read_fasta(args.fasta)
  
  # load genome
  genome = "".join(seqs).upper()

  # create "random" genome of the same length
  rand_genome = "".join(random.choices(["A","C","T","G"],k=len(genome)))

  # initialize kmer counts to 0
  kmer_counts = defaultdict(lambda : 0)
  rand_kmer_counts = defaultdict(lambda : 0)

  # count each kmer in the genome and rand_genome
  for i in range(len(genome) - args.kmer_len + 1):
    kmer_counts[genome[i:i + args.kmer_len]] += 1
    rand_kmer_counts[rand_genome[i:i + args.kmer_len]] += 1

  # write sorted output
  out = open(out_file, "w")
  out.write("kmer\tcount\trand_kmer\tcount\n")
  kmer_sorted = sorted(kmer_counts.items(), key=lambda x:x[1], reverse=True)
  rand_kmer_sorted = sorted(rand_kmer_counts.items(), key=lambda x:x[1], reverse=True)
  for i in range(max(len(kmer_sorted),len(rand_kmer_sorted))):
    if i > len(kmer_sorted) - 1:
      out.write("\t\t{}\t{}\n".format(rand_kmer_sorted[i][0],rand_kmer_sorted[i][1])) 
    elif i > len(rand_kmer_sorted) - 1:
      out.write("{}\t{}\t\t\n".format(kmer_sorted[i][0],kmer_sorted[i][1])) 
    else:
      out.write("{}\t{}\t{}\t{}\n".format(kmer_sorted[i][0],kmer_sorted[i][1],rand_kmer_sorted[i][0],rand_kmer_sorted[i][1])) 
  out.close()
main()

