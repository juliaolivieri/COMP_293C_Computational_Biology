import argparse

def get_args():
    """Read in fasta path from command line"""
    parser = argparse.ArgumentParser()
    parser.add_argument("--fasta", help="path to fasta file", required=True)
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

def calc_overlap(seq1, seq2):
    """Calculate the overlap between the end of seq1 and the beginning of seq2"""
    for k in range(min(len(seq1),len(seq2)),0,-1):
        if seq1[-k:] == seq2[:k]:
            return k
    return 0

def main():
    args = get_args() # collect commandline arguments
    seqs = read_fasta(args.fasta) # collect sequences from fasta

    # continue merging while there is more than one sequence
    while len(seqs) > 1:
        max_overlap = -1
        ind1 = ""
        ind2 = ""
        for i in range(len(seqs)):
            for j in range(len(seqs)):
                if i != j:
                    overlap = calc_overlap(seqs[i],seqs[j])
                    if overlap > max_overlap:
                        max_overlap = overlap
                        ind1 = i
                        ind2 = j
        # replace two seqs with max overlap with their merged sequence
        new_seq = seqs[ind1] + seqs[ind2][max_overlap:]
        seqs = [x for i, x in zip(range(len(seqs)),seqs) if i not in [ind1, ind2]]
        seqs.append(new_seq)
    print(seqs[0])
main()
