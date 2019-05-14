#python species_append.py Allsample.fasta.uc97.LTP.id_len_filtered.parsed  read_table_derep_clust97_remChimera_genus

import sys
o = open("read_table_derep_clust97_remChimera_genus_species","w")
f = open(sys.argv[1],"r")
F = open(sys.argv[2],"r")
read_sp = {}
result = ""

for line in f:
	arr = line.split("\t")
	readname = arr[0].split(";")[0]
	speciesname = arr[1].split(":")[1]
	abundance = arr[-1].rstrip()
	if  readname not in read_sp:
		read_sp[readname] = speciesname + "\t" + abundance
	else:
		read_sp[readname] += "\n" + speciesname + "\t" + abundance

for LINE in F:
	readname = LINE.split("\t")[3]
	if readname in read_sp:
		multihit_species = read_sp[readname].split("\n")
		for item in multihit_species:
			result += LINE[:-1] + "\t" + item + "\n"
	else:
		result += LINE[:-1] + "\t" + "Unclassified\t" + str(1) + "\n"

o.write(result)
f.close()
F.close()

