import argparse
#import matplotlib.pyplot as plt
import pandas as pd
import scipy as sp
#import seaborn as sns
from statsmodels.stats.multitest import multipletests

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--exp_matrix", help="path to gene expression matrix", required=True)
    parser.add_argument("--outpath", help="path to store output", required=True)
    args = parser.parse_args()
    return args

def main():

  args = get_args()
  df = pd.read_csv(args.exp_matrix, index_col=0, sep="\t").dropna()
  plotdf = (df.T / df.T.sum()).T.dropna()

  # normalize rows
  df = df/df.sum()

  # perform t test for each gene
  out = {"Geneid" : [], "p_value" : []}
  for index, row in df.iterrows():

      # separate groups by tumor vs nontumor
      out["Geneid"].append(index)
      out["p_value"].append(sp.stats.ttest_ind(list(row[:3]),list(row[3:])).pvalue)

  outdf = pd.DataFrame.from_dict(out).sort_values("p_value").dropna()
  outdf["p_value_corrected"] = multipletests(outdf["p_value"],method="fdr_bh")[1]
  outdf.to_csv(args.outpath + ".csv",sep="\t",index=False)

  print("Number of genes tested: {}".format(outdf.shape[0]))
  print("Number of genes with p values < 0.05: {}".format(outdf[outdf["p_value"] < 0.05].shape[0]))
  print("Number of genes with corrected p values < 0.05: {}".format(outdf[outdf["p_value_corrected"] < 0.05].shape[0]))

  # create plot
#  g = sns.clustermap(plotdf[plotdf.index.isin(outdf[outdf["p_value_corrected"] < 0.05]["Geneid"])])
#  g.ax_row_dendrogram.set_visible(False)
#  g.ax_col_dendrogram.set_visible(False)
#  plt.savefig(args.outpath + ".png")  

main()
