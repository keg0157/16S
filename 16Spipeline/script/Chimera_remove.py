# python Chimera_remove.py Chimera_read read_table_derep_clust 97
import sys
result = ""
o = open("read_table_derep_clust97_remChimera","w") 
f = open(sys.argv[1],"r")
Chimera_read = f.read()

F = open(sys.argv[2],"r")
for line in F:
	line2 = line.split("\t")
	if line2[3] not in Chimera_read:
		result += line[:-1] + "\t" + "N" + "\n"
o.write(result)
