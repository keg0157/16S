import sys
import re
f = open(sys.argv[1],'r')
O = open(sys.argv[1] + "_forblast",'w')
out = ""
for line in f:
    if line.startswith(">"):
        out +=  "\n" + line.split("\t")[0] + ":" + line.split("\t")[-2].replace(" ","_") + "\n"
    else:
        out += line.replace(" ","").rstrip()

O.write(out)
