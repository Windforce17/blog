## 安装

### win

```cmd
mysqld --initialize //第一次安装，初始化data文件
mysqld  -install
net start mysql
mysqld  -remove //卸载
## 非root账户，localhost不能登陆
```

## 创建用户
```sql
CREATE USER 'root'@'%' IDENTIFIED BY 'iam';
```

## 创建用户并同时授权
```sql
grant all privileges on db_name.* to db_user@'%' identified by 'db_pass';
```
## 授权 root登陆，外部访问

```sql
update mysql.user set plugin = 'mysql_native_password' where User='root';
grant all privileges on *.* to 'root'@'localhost';
--所有ip都可以的登陆
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```


## 常用命令，查询

> select @@basedir;
> 返回mysql安装根目录

---
> show variables like '%plugin%';  
> 返回插件目录

## mysql 密码忘记处理

### Windows 密码忘记处理

1. 以系统管理员身份登陆系统。
2. 打开cmd-----net start 查看mysql是否启动。启动的话就停止net stop mysql
3. 我的mysql安装在d:\usr\local\mysql4\bin下。
4. 跳过权限检查启动mysql 
d:\usr\local\mysql\bin\mysqld-nt --skip-grant-tables
5. 重新打开cmd。进到d:\usr\local\mysql4\bin下：
d:\usr\local\mysql\bin\mysqladmin -u root flush-privileges password "newpassword"
d:\usr\local\mysql\bin\mysqladmin -u root -p shutdown  这句提示你重新输密码。
6. 在cmd里net start mysql
7. 搞定了。

### Linux 密码忘记处理

有可能你的系统没有 safe_MySQLd 程序(比如我现在用的 ubuntu操作系统, apt-get安装的MySQL) , 下面方法可以恢复
1. 停止MySQLd；

    sudo /etc/init.d/MySQL stop
(您可能有其它的方法,总之停止MySQLd的运行就可以了)
2. 用以下命令启动MySQL，以不检查权限的方式启动；

    MySQLd --skip-grant-tables &

3. 然后用空密码方式使用root用户登录 MySQL；

    MySQL -u root

4. 修改root用户的密码；

    MySQL> update MySQL.user set password=PASSWORD('newpassword') where User='root';  
    MySQL> flush privileges; 
    MySQL> quit 
重新启动MySQL
    /etc/init.d/MySQL restart


## mysql 导入导出数据

### 从csv 导入

load data infile "C:\\wamp64\\tmp\\14.csv"
into table vote_person_info character set utf8 
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n';

### 导出数据
C:\wamp64\bin\mysql\mysql5.7.14\bin\mysqldump.exe -h 127.0.0.1 -u root --default-character-set=utf8 hise >C:\Users\msi\Desktop\sql.sql

## mysql各种坑

### DATETIME、TIMESTAMP、DATE、时间
### 范围
一个完整的日期格式如下：YYYY-MM-DD HH:MM:SS[.fraction]，它可分为两部分：date部分和time部分，其中，date部分对应格式中的“YYYY-MM-DD”，time部分对应格式中的“HH:MM:SS[.fraction]”。对于date字段来说，它只支持date部分，如果插入了time部分的内容，它会丢弃掉该部分的内容，并提示一个warning.

timestamp所能存储的时间范围为：'1970-01-01 00:00:01.000000' 到 '2038-01-19 03:14:07.999999'。

datetime所能存储的时间范围为：'1000-01-01 00:00:00.000000' 到 '9999-12-31 23:59:59.999999'。
### 存储
对于TIMESTAMP，它把客户端插入的时间从当前时区转化为UTC（世界标准时间）进行存储。查询时，将其又转化为客户端当前时区进行返回。

而对于DATETIME，不做任何改变，基本上是原样输入和输出
### 时间比较
- 相同格式的直接进行比较 '2019-01-17'> '2019-01-10'
- `WHERE DATE_FORMAT(st.create_time,'%Y-%m-%d %H:%i')>=DATE_FORMAT('2017-12-9 10:29:00','%Y-%m-%d %H:%i' )`
- 如果你的格式是`2013-01-12 23:23:56`
  `select * from product where Date(add_time) = '2013-01-12' `
  `select * from product where date(add_time) between '2013-01-01' and '2013-01-31'`
  `select * from product where Year(add_time) = 2013 and Month(add_time) = 1 `

### 两个时间不能直接相减，不然会出错!!

```sql
    mysql> select t1,t2,t2-t1 from mytest;  
    +---------------------+---------------------+-------+  
    | t1                  | t2                  | t2-t1 |  
    +---------------------+---------------------+-------+  
    | 2013-04-21 16:59:33 | 2013-04-21 16:59:43 |    10 |  
    | 2013-04-21 16:59:33 | 2013-04-21 17:00:33 |  4100 |  
    | 2013-04-21 16:59:33 | 2013-04-21 17:59:35 | 10002 |  
    +---------------------+---------------------+-------+  
    3 rows in set  
```
#### 原因
实际是mysql的时间相减是做了一个隐式转换操作，将时间转换为`整数`但并不是用`unix_timestamp`转换，而是直接把年月日时分秒拼起来，如2013-04-21 16:59:33 直接转换为`20130421165933`，由于时间不是十进制，所以最后得到的结果**没有意义**，这也是导致上面出现坑爹的结果。

#### 解决
要得到正确的时间相减秒值，有以下3种方法：
1. `time_to_sec(timediff(t2, t1))`,
2. `timestampdiff(second, t1, t2)`,
3. `unix_timestamp(t2) - unix_timestamp(t1)`,

## mysql密码验证插件 

为了加强安全性，MySQL5.7为root用户随机生成了一个密码，在error log中，关于error log的位置，如果安装的是RPM包，则默认是/var/log/mysqld.log。

一般可通过log_error设置

<pre>mysql> select @@log_error;
+---------------------+
| @@log_error         |
+---------------------+
| /var/log/mysqld.log |
+---------------------+
1 row in set (0.00 sec)</pre>

可通过# grep "password" /var/log/mysqld.log 命令获取MySQL的临时密码

<pre>2016-01-19T05:16:36.218234Z 1 [Note] A temporary password is generated for root@localhost: waQ,qR%be2(5</pre>

用该密码登录到服务端后，必须马上修改密码，不然会报如下错误：

<pre>mysql> select user();
ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.</pre>

如果只是修改为一个简单的密码，会报以下错误：

<pre>mysql>  ALTER USER USER() IDENTIFIED BY '12345678';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements</pre>

这个其实与validate_password_policy的值有关。

validate_password_policy有以下取值：

| Policy | Tests Performed |
| --- | --- |
| `0` or `LOW` | Length |
| `1` or `MEDIUM` | Length; numeric, lowercase/uppercase, and special characters |
| `2` or `STRONG` | Length; numeric, lowercase/uppercase, and special characters; dictionary file |

默认是1，即MEDIUM，所以刚开始设置的密码必须符合长度，且必须含有数字，小写或大写字母，特殊字符。

有时候，只是为了自己测试，不想密码设置得那么复杂，譬如说，我只想设置root的密码为123456。

必须修改两个全局参数：

首先，修改validate_password_policy参数的值

<pre>mysql> set global validate_password_policy=0;
Query OK, 0 rows affected (0.00 sec)</pre>

这样，判断密码的标准就基于密码的长度了。这个由validate_password_length参数来决定。

<pre>mysql> select @@validate_password_length;
+----------------------------+
| @@validate_password_length |
+----------------------------+
|                          8 |
+----------------------------+
1 row in set (0.00 sec)</pre>

validate_password_length参数默认为8，它有最小值的限制，最小值为：

<pre>validate_password_number_count
+ validate_password_special_char_count
+ (2 * validate_password_mixed_case_count)</pre>

其中，validate_password_number_count指定了密码中数据的长度，validate_password_special_char_count指定了密码中特殊字符的长度，validate_password_mixed_case_count指定了密码中大小字母的长度。

这些参数，默认值均为1，所以validate_password_length最小值为4，如果你显性指定validate_password_length的值小于4，尽管不会报错，但validate_password_length的值将设为4。如下所示：

<pre>mysql> select @@validate_password_length;
+----------------------------+
| @@validate_password_length |
+----------------------------+
|                          8 |
+----------------------------+
1 row in set (0.00 sec)

mysql> set global validate_password_length=1;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@validate_password_length;
+----------------------------+
| @@validate_password_length |
+----------------------------+
|                          4 |
+----------------------------+
1 row in set (0.00 sec)</pre>

如果修改了validate_password_number_count，validate_password_special_char_count，validate_password_mixed_case_count中任何一个值，则validate_password_length将进行动态修改。

<pre>mysql> select @@validate_password_length;
+----------------------------+
| @@validate_password_length |
+----------------------------+
|                          4 |
+----------------------------+
1 row in set (0.00 sec)

mysql> select @@validate_password_mixed_case_count;
+--------------------------------------+
| @@validate_password_mixed_case_count |
+--------------------------------------+
|                                    1 |
+--------------------------------------+
1 row in set (0.00 sec)

mysql> set global validate_password_mixed_case_count=2;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@validate_password_mixed_case_count;
+--------------------------------------+
| @@validate_password_mixed_case_count |
+--------------------------------------+
|                                    2 |
+--------------------------------------+
1 row in set (0.00 sec)

mysql> select @@validate_password_length;
+----------------------------+
| @@validate_password_length |
+----------------------------+
|                          6 |
+----------------------------+
1 row in set (0.00 sec)</pre>

当然，前提是validate_password插件必须已经安装，MySQL5.7是默认安装的。

那么如何验证`validate_password`插件是否安装呢？可通过查看以下参数，如果没有安装，则输出将为空。

<pre>mysql> SHOW VARIABLES LIKE 'validate_password%';
+--------------------------------------+-------+
| Variable_name                        | Value |
+--------------------------------------+-------+
| validate_password_dictionary_file    |       |
| validate_password_length             | 6     |
| validate_password_mixed_case_count   | 2     |
| validate_password_number_count       | 1     |
| validate_password_policy             | LOW   |
| validate_password_special_char_count | 1     |
+--------------------------------------+-------+
6 rows in set (0.00 sec)</pre>
</pre>

