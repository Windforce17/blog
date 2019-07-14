## 存放用来编码/解码/格式转换相关的脚本
```py
# process ROPgadget generated file
rop = []
# i = 1
for line in open("ropc"):
    # print line,
    if "pack" in line and '+=' in line:
        print line
        # print i
        # print str(line).split(", ")[1].split(")")[0]
        rop.append(str(line).split(", ")[1].split(")")[0])
    if 'pack' not in line and '+=' in line:
        # print i
        # print line
        rop.append(str(line).split("+= ")[1][1:-2])
    # i += 1
i=0
while(i<len(rop)):
    if rop[i]=='/bin':
        rop[i]='0x6e69622f'
    if rop[i]=='//sh':
        rop[i]='0x68732f2f'
    i+=1
print rop
```