# python silva_append.py All.fasta.fasta97.NoChimera.living.parsed otumatrix_rdp
import sys
o = open("otumatrix_rdp_silva","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
colname = F.readline()
result = "\t" + colname
lines = {}
for line in f:
        line2 = line.split("\t")
	lines[line2[0].split(";")[0]] = line2[1].split("rna_")[1]

for LINE in F:
	tmp = LINE.split("\t")[0]
	if tmp in lines:
		result += LINE[:-1] + "\t" + lines[tmp] + "\n"
	else:
		result += LINE[:-1] + "\t" + "Unclassified" + "\n" 

o.write(result)
f.close()
F.close()

