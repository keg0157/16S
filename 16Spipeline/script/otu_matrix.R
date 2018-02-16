"/usr/bio/src/R-3.1.1/bin/R --vanilla --slave --args read_table_derep_clust97_remChimera < otumatrix.R"
args = commandArgs(trailingOnly = T)
library(reshape2)

data = read.table(args[1],sep ="\t")
output = acast(data,V4~V1,value.var="V4",length)
write.table(output,"./otumatrix", quote=F, sep ="\t",row.names=T, col.names=T)

