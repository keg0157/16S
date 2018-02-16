# python derep_append.py All.fasta.uc100 read_table
import sys
o = open("read_table_derep","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
LINEs ={}
result = ""
for LINE in F:
	tmp = LINE.split("\t")[1][:-1]
	LINEs[tmp] = LINE.split("\n")[0]

for line in f:
	line2 = line.split("\t")
	if line2[8] in LINEs:
		if "S" in line2[0]:
			result += LINEs[line2[8]] + "\t" + line2[8] + "\n"
		elif "H" in line2[0]:
			result += LINEs[line2[8]] + "\t" + line2[9]
	
o.write(result)
f.close()
F.close()

