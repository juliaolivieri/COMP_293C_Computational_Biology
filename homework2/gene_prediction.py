import argparse
import math
import pandas as pd

def get_args():
    """Read in fasta path from command line
    Example usage: python3 gene_prediction.py --fasta ../e_coli/sequence.fasta --thresh 1000 --gff ../e_coli/sequence.gff3"""
    parser = argparse.ArgumentParser()
    parser.add_argument("--fasta", help="path to fasta file", required=True)
    parser.add_argument("--gff", help="path to gff file", required=True)

    parser.add_argument("--thresh", help="only consider stopless segments of length > thresh", required=True, type=int)
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

def read_gff(gff_file):
  gff = pd.read_csv(gff_file,sep="\t",skiprows=5,names=["seqname", "source", "feature", "start", "end", "score", "strand", "frame","attribute"])
  gff = gff[gff["feature"] == "CDS"]
  return gff

def find_stopless_lengths(seq, thresh):
  stops = ["TAG", "TGA", "TAA"]
  stopless_positions = []
  stopless_lengths = []
  
  stopless_length = 0
  for i in range(math.ceil(len(seq)/3)):
    codon = seq[3*i:3*i+3]
    if codon in stops:
      if stopless_length > thresh:
        stopless_positions.append(int(3*i))

        stopless_lengths.append(stopless_length)
      stopless_length = 0
    else:
      stopless_length += 1 
  return stopless_positions, stopless_lengths

def get_rev_comp(seq):
  rev_seq = seq[::-1]
  rev_seq = rev_seq.replace("A","t")
  rev_seq = rev_seq.replace("T","a")
  rev_seq = rev_seq.replace("G","c")
  rev_seq = rev_seq.replace("C","g")
  return rev_seq.upper()

def find_gene(position, strand, gff):
  temp = gff[(gff["start"] < position) & (gff["end"] > position) & (gff["strand"] == strand)]
  if temp.shape[0] == 0:
    return False
  else:
    return True

def main():
  args = get_args()
  seqs = read_fasta(args.fasta)
  genome = "".join(seqs).upper()
  print("genome length:",len(genome))
  gff = read_gff(args.gff)
  print("beginning of genome:",genome[:100])
  
  genome_strands = [genome, get_rev_comp(genome)]
  strands = ["+","-"]

  for base in ["A","T","G","C"]:
    print("fraction {}: {}".format(base,genome.count(base)/len(genome)))

  all_stopless_positions = []
  all_stopless_lengths = []
  gene_exists = []

  # check each reading frame
  for i in range(1):
    for j in range(3):
      stopless_positions, stopless_lengths = find_stopless_lengths(genome[j:], args.thresh)
      all_stopless_positions.extend(stopless_positions)
      all_stopless_lengths.extend(stopless_lengths)
      for pos in all_stopless_positions:
        if i == 0:
          pos -= 3
        gene_exists.append(find_gene(pos, strands[i], gff))
        
  print("\n{} genes are annotated out of {} predicted: {:.2f}%".format(sum(gene_exists),len(gene_exists),100*sum(gene_exists)/len(gene_exists)))


main()
