import sys
f = open(sys.argv[1],"r")
O = open(sys.argv[1] + ".id_len_filtered","w")

out = ""
for line in f:
    arr = line.split("\t")
    score,length = float(arr[2]),float(arr[3])
    if score >= 97 and length > 150:
        out += line

O.write(out)
