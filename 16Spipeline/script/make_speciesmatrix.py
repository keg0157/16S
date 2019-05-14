import sys
import numpy as np
import pandas as pd

file = sys.argv[1]
df = pd.read_table(file)
df.columns=["sample","read","OTU100","OTU97","flag_Chimera","genus","species","species_abundance"]
res = pd.pivot_table(df,index="species",columns="sample",aggfunc="sum")
res = res.replace(np.nan,0)
res.to_csv("species_matrix.txt",sep="\t")
