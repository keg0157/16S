import sys
f = open(sys.argv[1],"r")
o = open(sys.argv[1] + ".parsed","w")
out = ""
dic = {}
for line in f:
    arr = line.split("\t")
    que,sub,sco = arr[0],arr[1],float(arr[-2])
    if que not in dic:
        dic[que] = line.rstrip()
        sco_max = sco
        sub_max = sub
    else:
        que_pre = dic[que].split("\t")[1]
        sub_pre = dic[que].split("\t")[0]
        sco_pre = float(dic[que].split("\t")[-2])
        if sco < sco_pre:
            dic[que] = line.rstrip()
            sco_max,sub_max = sco,sub
        elif sco == sco_max:
            dic[que] += "\n" + line.rstrip()
        
    line_pre = line

for key in dic:
    item = dic[key].split("\n")
    for i in range(len(item)):
        out +=  item[i] + "\t" + str(float(1/len(item))) + "\n"

o.write(out)


