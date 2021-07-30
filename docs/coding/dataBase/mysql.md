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
CREATE USER 'git_cugapp_com'@'%' IDENTIFIED BY '12345';
```

## 创建用户并同时授权

```sql
grant all privileges on db_name.* to db_user@'%' identified by 'db_pass';
```

## 授权 root 登陆，外部访问

```sql
--兼容5.7以前的mysql
update mysql.user set plugin = 'mysql_native_password' where User='root';
grant all privileges on git_cugapp_com.* to 'git_cugapp_com'@'localhost';
--所有ip都可以的登陆
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
```

## 改密码

```sql
update user set authentication_string=password('cug666') where user='root';
```

## 排错

### 从 5.7 前不正确的升级 or 导入

```
ERROR 1805 (HY000): Column count of mysql.user is wrong. Expected 45, found 48. The table is probably corrupted
```

输入下面命令解决，如果提示密码错误，跳过授权表启动 mysql

```bash
mysql_upgrade --force -u root -p
```

```sql
alter table user drop column is_role;
alter table user drop column default_role;
alter table user drop column max_statement_time;
alter table user modify max_user_connections int(11) unsigned NOT NULL DEFAULT '0';
flush privileges;
```

## 常用命令，查询

> select @@basedir;
> 返回 mysql 安装根目录

---

> show variables like '%plugin%';  
> 返回插件目录

### 各个库的大小

```sql
select table_schema, sum(data_length+index_length)/1024/1024 as total_mb, \
sum(data_length)/1024/1024 as data_mb, sum(index_length)/1024/1024 as index_mb, \
count(*) as tables, curdate() as today from information_schema.tables group by table_schema order by 2 desc;
```

### 单库下所有表的状态

```sql
 select table_name, (data_length/1024/1024) as data_mb , (index_length/1024/1024) \
as index_mb, ((data_length+index_length)/1024/1024) as all_mb, table_rows \
from tables where table_schema = 'data_1234567890';
```

## mysql 密码忘记处理

### Windows 密码忘记处理

1. 以系统管理员身份登陆系统。
2. 打开 cmd-----net start 查看 mysql 是否启动。启动的话就停止 net stop mysql
3. 我的 mysql 安装在 d:\usr\local\mysql4\bin 下。
4. 跳过权限检查启动 mysql
   d:\usr\local\mysql\bin\mysqld-nt --skip-grant-tables
5. 重新打开 cmd。进到 d:\usr\local\mysql4\bin 下：
   d:\usr\local\mysql\bin\mysqladmin -u root flush-privileges password "newpassword"
   d:\usr\local\mysql\bin\mysqladmin -u root -p shutdown 这句提示你重新输密码。
6. 在 cmd 里 net start mysql
7. 搞定了。

### Linux 密码忘记处理

有可能你的系统没有 safe_MySQLd 程序(比如我现在用的 ubuntu 操作系统, apt-get 安装的 MySQL) , 下面方法可以恢复

1.  停止 MySQLd；

        sudo /etc/init.d/MySQL stop

    (您可能有其它的方法,总之停止 MySQLd 的运行就可以了)

2.  用以下命令启动 MySQL，以不检查权限的方式启动；

```sh
    MySQLd --skip-grant-tables & #下面的也行
    mysqld_safe --skip-grant-tables --skip-networking &
```

3.  然后用空密码方式使用 root 用户登录 MySQL；

    MySQL -u root

4.  修改 root 用户的密码；

        MySQL> update MySQL.user set password=PASSWORD('newpassword') where User='root';
        MySQL> flush privileges;
        MySQL> quit

    重新启动 MySQL
    /etc/init.d/MySQL restart

## mysql 导入导出数据

### 从 csv 导入

load data infile "C:\\wamp64\\tmp\\14.csv"
into table vote_person_info character set utf8
fields terminated by ',' optionally enclosed by '"' escaped by '"'
lines terminated by '\r\n';

### 导出数据

C:\wamp64\bin\mysql\mysql5.7.14\bin\mysqldump.exe -h 127.0.0.1 -u root --default-character-set=utf8 hise >C:\Users\msi\Desktop\sql.sql

## mysql 各种坑

### DATETIME、TIMESTAMP、DATE、时间

### 范围

一个完整的日期格式如下：YYYY-MM-DD HH:MM:SS[.fraction]，它可分为两部分：date 部分和 time 部分，其中，date 部分对应格式中的“YYYY-MM-DD”，time 部分对应格式中的“HH:MM:SS[.fraction]”。对于 date 字段来说，它只支持 date 部分，如果插入了 time 部分的内容，它会丢弃掉该部分的内容，并提示一个 warning.

timestamp 所能存储的时间范围为：'1970-01-01 00:00:01.000000' 到 '2038-01-19 03:14:07.999999'。

datetime 所能存储的时间范围为：'1000-01-01 00:00:00.000000' 到 '9999-12-31 23:59:59.999999'。

### 存储

对于 TIMESTAMP，它把客户端插入的时间从当前时区转化为 UTC（世界标准时间）进行存储。查询时，将其又转化为客户端当前时区进行返回。

而对于 DATETIME，不做任何改变，基本上是原样输入和输出

### 时间比较

- 相同格式的直接进行比较 '2019-01-17'> '2019-01-10'
- `WHERE DATE_FORMAT(st.create_time,'%Y-%m-%d %H:%i')>=DATE_FORMAT('2017-12-9 10:29:00','%Y-%m-%d %H:%i' )`
- 如果你的格式是`2013-01-12 23:23:56`
  `select * from product where Date(add_time) = '2013-01-12'`
  `select * from product where date(add_time) between '2013-01-01' and '2013-01-31'`
  `select * from product where Year(add_time) = 2013 and Month(add_time) = 1`

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

实际是 mysql 的时间相减是做了一个隐式转换操作，将时间转换为`整数`但并不是用`unix_timestamp`转换，而是直接把年月日时分秒拼起来，如 2013-04-21 16:59:33 直接转换为`20130421165933`，由于时间不是十进制，所以最后得到的结果**没有意义**，这也是导致上面出现坑爹的结果。

#### 解决

要得到正确的时间相减秒值，有以下 3 种方法：

1. `time_to_sec(timediff(t2, t1))`,
2. `timestampdiff(second, t1, t2)`,
3. `unix_timestamp(t2) - unix_timestamp(t1)`,

## mysql 密码验证插件

为了加强安全性，MySQL5.7 为 root 用户随机生成了一个密码，在 error log 中，关于 error log 的位置，如果安装的是 RPM 包，则默认是/var/log/mysqld.log。

一般可通过 log_error 设置

<pre>mysql> select @@log_error;
+---------------------+
| @@log_error         |
+---------------------+
| /var/log/mysqld.log |
+---------------------+
1 row in set (0.00 sec)</pre>

可通过# grep "password" /var/log/mysqld.log 命令获取 MySQL 的临时密码

<pre>2016-01-19T05:16:36.218234Z 1 [Note] A temporary password is generated for root@localhost: waQ,qR%be2(5</pre>

用该密码登录到服务端后，必须马上修改密码，不然会报如下错误：

<pre>mysql> select user();
ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.</pre>

如果只是修改为一个简单的密码，会报以下错误：

<pre>mysql>  ALTER USER USER() IDENTIFIED BY '12345678';
ERROR 1819 (HY000): Your password does not satisfy the current policy requirements</pre>

这个其实与 validate_password_policy 的值有关。

validate_password_policy 有以下取值：

| Policy          | Tests Performed                                                               |
| --------------- | ----------------------------------------------------------------------------- |
| `0` or `LOW`    | Length                                                                        |
| `1` or `MEDIUM` | Length; numeric, lowercase/uppercase, and special characters                  |
| `2` or `STRONG` | Length; numeric, lowercase/uppercase, and special characters; dictionary file |

默认是 1，即 MEDIUM，所以刚开始设置的密码必须符合长度，且必须含有数字，小写或大写字母，特殊字符。

有时候，只是为了自己测试，不想密码设置得那么复杂，譬如说，我只想设置 root 的密码为 123456。

必须修改两个全局参数：

首先，修改 validate_password_policy 参数的值

<pre>mysql> set global validate_password_policy=0;
Query OK, 0 rows affected (0.00 sec)</pre>

这样，判断密码的标准就基于密码的长度了。这个由 validate_password_length 参数来决定。

<pre>mysql> select @@validate_password_length;
+----------------------------+
| @@validate_password_length |
+----------------------------+
|                          8 |
+----------------------------+
1 row in set (0.00 sec)</pre>

validate_password_length 参数默认为 8，它有最小值的限制，最小值为：

<pre>validate_password_number_count
+ validate_password_special_char_count
+ (2 * validate_password_mixed_case_count)</pre>

其中，validate_password_number_count 指定了密码中数据的长度，validate_password_special_char_count 指定了密码中特殊字符的长度，validate_password_mixed_case_count 指定了密码中大小字母的长度。

这些参数，默认值均为 1，所以 validate_password_length 最小值为 4，如果你显性指定 validate_password_length 的值小于 4，尽管不会报错，但 validate_password_length 的值将设为 4。如下所示：

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

如果修改了 validate_password_number_count，validate_password_special_char_count，validate_password_mixed_case_count 中任何一个值，则 validate_password_length 将进行动态修改。

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

当然，前提是 validate_password 插件必须已经安装，MySQL5.7 是默认安装的。

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

## 性能优化

### 建表

- 表字段避免 null 值出现，null 值很难查询优化且占用额外的索引空间，推荐默认数字 0 代替 null。
- 尽量使用 INT 而非 BIGINT，如果非负则加上 UNSIGNED（这样数值容量会扩大一倍），当然能使用 TINYINT、SMALLINT、MEDIUM_INT 更好。
- 使用枚举或整数代替字符串类型
- 尽量使用 TIMESTAMP 而非 DATETIME
- 单表不要有太多字段，建议在 20 以内
- 用整型来存 IP

### 索引

- 索引并不是越多越好，要根据查询有针对性的创建，考虑在 WHERE 和 ORDER BY 命令上涉及的列建立索引，可根据 EXPLAIN 来查看是否用了索引还是全表扫描
- 应尽量避免在 WHERE 子句中对字段进行 NULL 值判断，否则将导致引擎放弃使用索引而进行全表扫描
- 值分布很稀少的字段不适合建索引，例如"性别"这种只有两三个值的字段
- 字符字段只建前缀索引
- 字符字段最好不要做主键
- 不用外键，由程序保证约束
- 尽量不用 UNIQUE，由程序保证约束
- 使用多列索引时注意顺序和查询条件保持一致，同时删除不必要的单列索引

### 使用合适的数据类型

简言之就是使用合适的数据类型，选择合适的索引

1. 选择合适的数据类型
   1. 使用可存下数据的最小的数据类型，整型 < date,time < char,varchar < blob
   2. 使用简单的数据类型，整型比字符处理开销更小，因为字符串的比较更复杂。如，int 类型存储时间类型，bigint 类型转 ip 函数
   3. 使用合理的字段属性长度，固定长度的表会更快。使用 enum、char 而不是 varchar
   4. 尽可能使用 not null 定义字段
   5. 尽量少用 text，非用不可最好分表
2. 选择合适的索引列
   1. 查询频繁的列，在 where，group by，order by，on 从句中出现的列
   2. where 条件中<，<=，=，>，>=，between，in，以及 like 字符串+通配符（%）出现的列
   3. 长度小的列，索引字段越小越好，因为数据库的存储单位是页，一页中能存下的数据越多越好
   4. 离散度大（不同的值多）的列，放在联合索引前面。查看离散度，通过统计不同的列值来实现，count 越大，离散程度越高

### sql 的编写需要注意优化

- 使用 limit 对查询结果的记录进行限定
- 避免 select \*，将需要查找的字段列出来
- 使用连接（join）来代替子查询
- 拆分大的 delete 或 insert 语句
- 可通过开启慢查询日志来找出较慢的 SQL
- 不做列运算：SELECT id WHERE age + 1 = 10，任何对列的操作都将导致表扫描，它包括数据库教程函数、计算表达式等- 等，查询时要尽可能将操作移至等号右边
- sql 语句尽可能简单：一条 sql 只能在一个 cpu 运算；大语句拆小语句，减少锁时间；一条大 sql 可以堵死整个库
- OR 改写成 IN：OR 的效率是 n 级别，IN 的效率是 log(n)级别，in- 的个数建议控制在 200 以内
- 不用函数和触发器，在应用程序实现
- 避免%xxx 式查询
- 少用 JOIN
- 使用同类型进行比较，比如用'123'和'123'比，123 和 123 比
- 尽量避免在 WHERE 子句中使用!=或<>操作符，否则将引擎放弃使用索引而进行全表扫描
- 对于连续数值，使用 BETWEEN 不用 IN：SELECT id FROM t WHERE num BETWEEN 1 AND 5
- 列表数据不要拿全表，要使用 LIMIT 来分页，每页数量也不要太- 大
