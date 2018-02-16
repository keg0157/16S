# python genus_append.py All.fasta.fasta97.NoChimera.living.parsed read_table_derep_clust97_remChimera_genus
import sys
o = open("read_table_derep_clust97_remChimera_genus_species","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
lines = {}
result = ""

for line in f:
	line2 = line.split("\t")
	lines[line2[0].split(";")[0]] = line2[1].split("rna_")[1]
for LINE in F:
	tmp = LINE.split("\t")[3]
	if tmp in lines:
		result += LINE[:-1] + "\t" + lines[tmp] +"\n"
	else:
		result += LINE[:-1] + "\t" + "Unclassified" +"\n"

o.write(result)
f.close()
F.close()

