# python rdp_append.py All.fasta.fasta97.NoChimera.RDPclassified otumatrix
import sys
o = open("otumatrix_rdp","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
LINEs = {}
colname = F.readline()
result = "\t" + colname
entry =["domain","phylum","class","order","family","genus"]
for LINE in F:
	tmp = LINE.split("\t")[0]
	LINEs[tmp] = LINE[:-1]

for line in f:
	line2 = line.split("\t")
	if line2[0].split(";")[0] in LINEs:	
		for name in entry:		
			if name in line:
				if float(line2[line2.index(name)+1].split("\n")[0]) < 0.5:
					line2[line2.index(name)-1] = "Unclassified"
		result += LINEs[line2[0].split(";")[0]][:-1] + "\t".join(line2[2:])			

o.write(result)
f.close()
F.close()

