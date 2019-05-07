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
## 代码审计
https://github.com/hongriSec/PHP-Audit-Labs
### 两款代码审计工具 seay ,RIPS
seay国产

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

### 更改http头 
Content-Type:image/gif



