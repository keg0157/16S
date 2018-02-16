#!/usr/bin/env python
# coding:UTF-8
import sys
input = sys.argv[1]

a = []
b = []
tmp = []
output = []

f = open(input,'r')

a = f.read()
b = a.split('\n')
f.close()

for i in range(len(b)):
	if i % 4 ==1 and b[i].find('N') == -1:
		tmp.append(b[i-1])
		tmp.append('\n')
		tmp.append(b[i])
		tmp.append('\n')
		tmp.append(b[i+1])
		tmp.append('\n')
		tmp.append(b[i+2])	
		tmp.append('\n')	
output = "".join(tmp)

f = open(input+".N",'w')
f.write(output)
f.close()

#print output

