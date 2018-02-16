# python Chimera.py All.fasta.fasta97.uchimedenovo All.fasta.fasta97.uchimeref
import sys
o = open("Chimera_read","w")
denovo = sys.argv[1]
denovo_array=[]
result = ""
f = open(denovo,'r')
for line in f:
    line2 = line.split("\t")
    if "Y" in line2[17]:
        denovo_array.append(line2[1].split(";")[0])
ref = sys.argv[2]
F = open(ref,"r")
count =0
for LINE in F:
	LINE2 = LINE.split("\t")
	if "Y" in LINE2[17]:
		if LINE2[1].split(";")[0] in denovo_array:
			result += LINE2[1].split(";")[0] + "\n"
o.write(result)		
