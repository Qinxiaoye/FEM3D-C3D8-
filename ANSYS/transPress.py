#import numpy as np
finp = open('press.txt','r')
fout = open('press.dat','w')

text = finp.readlines()
sumLine = len(text)
print(sumLine)

for n in range(0,sumLine):
    line = text[n]
    line = line.strip('\n').split()
    if len(line) == 5:
        elem = int(line[0])
        face = int(line[1])
        pres = float(line[3])
        fout.write('%8d%8d%20.4f\n'%(elem,face,pres))


finp.close()
fout.close()