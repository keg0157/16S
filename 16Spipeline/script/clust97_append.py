# python clust97_append.py All.fasta.uc97 read_table_derep
import sys
o = open("read_table_derep_clust97","w")
F = open(sys.argv[1],"r")
f = open(sys.argv[2],"r")
LINEs ={}
result = ""
for LINE in F:
	tmp = LINE.split("\t")
	if "S" in tmp[0]:
		LINEs[tmp[8]] = tmp[8]
	elif "H" in tmp[0]:
		LINEs[tmp[8]] = tmp[9][:-1]
	
for line in f:
	line2 = line.split("\t")
	if line2[2][:-1] in LINEs:
		result += line[:-1] + "\t" + LINEs[line2[2][:-1]] + "\n"
o.write(result)
f.close()
F.close()
