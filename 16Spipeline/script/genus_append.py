# python genus_append.py All.fasta.fasta97.NoChimera.RDPclassified read_table_derep_clust97_remChimera
import sys
o = open("read_table_derep_clust97_remChimera_genus","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
lines = {}
result = ""
entry = "genus"
for line in f:
	line2 = line.split("\t")
	if float(line2[line2.index(entry)+1].split("\n")[0]) > 0.5:
		lines[line2[0].split(";")[0]] = line2[line2.index(entry)-1]
	else:
		lines[line2[0].split(";")[0]] = "Unclassified"
for LINE in F:
	tmp = LINE.split("\t")[3]
	if tmp in lines:
		 result += LINE[:-1] + "\t" + lines[tmp] +"\n"

o.write(result)
f.close()
F.close()

