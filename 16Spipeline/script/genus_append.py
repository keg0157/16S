# python genus_append.py All.fasta.fasta97.NoChimera.RDPclassified read_table_derep_clust97_remChimera
import sys
o = open("read_table_derep_clust97_remChimera_genus","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
lines = {}
result = ""
entry = "genus"
for line in f:
	arr = line.split("\t")
	samplename = arr[0].split(";")[0]
	column_genus = arr.index(entry)
	identity = float(arr[column_genus + 1].split("\n")[0])
	if identity > 0.5:
		lines[samplename] = arr[column_genus - 1]
	else:
		lines[samplename] = "Unclassified"

for LINE in F:
	tmp = LINE.split("\t")[3]
	if tmp in lines:
		 result += LINE[:-1] + "\t" + lines[tmp] +"\n"

o.write(result)
f.close()
F.close()

