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
## 两款代码审计工具 seay ,RIPS
这也是一个坑,seay国产

## phpmyadmin 密码修改
1. 更改用户中的密码
2. `config.inc.php`中password修改

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
### preg_replace()
正则表达式替换，第一个参数/e结束时，会将第二个参数当成代码执行

### 序列化与反序列化
unserialize 会调用__wakeup 函数

### assert()

当第一参数是字符串时，执行字符串代码

### 更改http头 
Content-Type:image/gif

## 文件包含漏洞
　　服务器通过php的特性（函数）去包含任意文件时，由于要包含的这个文件来源过滤不严，从而可以去包含一个恶意文件，而我们可以构造这个恶意文件来达到邪恶的目的。


## php伪协议 php://
挖坑待填
### 涉及到的危险函数
include(),require()和include_once(),require_once()
#### include
包含并运行指定文件，当包含外部文件发生错误时，系统给出警告，但整个php文件继续执行。
#### require
跟include唯一不同的是，当产生错误时候，include下面继续运行而require停止运行了。
#### include_once
这个函数跟include函数作用几乎相同，只是他在导入函数之前先检测下该文件是否被导入。如果已经执行一遍那么就不重复执行了。
#### require_once
这个函数跟require的区别 跟上面我所讲的include和include_once是一样的。所以我就不重复了