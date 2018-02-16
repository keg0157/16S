# python correspond_read.py *aqv.fasta
import sys
result = ""
o = open("read_table","w")
for name in sys.argv[1:]:
	f = open(name,"r")
	for line in f:
		if ">" in line:
			result += name.split(".fastq.N.rem.trim.aqv.fasta")[0] + "\t" + line.split(" ")[0].split(">")[1] + "\n"
o.write(result)
			
