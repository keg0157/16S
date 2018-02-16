"/usr/bio/src/R-3.1.1/bin/R --vanilla --slave --args read_table_derep_clust97_remChimera < otumat.R"
args = commandArgs(trailingOnly = T)
library(reshape2)

data = read.table(args[1],sep ="\t")
data2 = acast(data,V6~V1,value.var="V6",length)
write.table(data2,"./genus_matrix", quote=F, sep ="\t",row.names=T, col.names=T)

