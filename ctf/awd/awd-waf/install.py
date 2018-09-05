import os
# find /var/www/html ‐type f ‐path "*.php" | xargs sed ‐i "s/<?php/<?
# php\nrequire_once('\/tmp\/waf.php');\n/g"
base_dir = '/Users/apple/Documents/data' #web路径

def scandir(startdir) :
    
    os.chdir(startdir)
    for obj in os.listdir(os.curdir) :
        path = os.getcwd() + os.sep + obj
        if os.path.isfile(path) and '.php' in obj:
        	modifyip(path,'<?php','<?php\nrequire_once(\'waf.php\');') #强行加一句代码
        if os.path.isdir(obj) :
            scandir(obj)
            os.chdir(os.pardir) 

def modifyip(tfile,sstr,rstr):
    try:
        lines=open(tfile,'r').readlines()
        flen=len(lines)-1
        for i in range(flen):
            if sstr in lines[i]:
                lines[i]=lines[i].replace(sstr,rstr)
        open(tfile,'w').writelines(lines)
        
    except Exception,e:
        print e
        

scandir(base_dir)