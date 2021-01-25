## .git .DS_store泄露
.git泄露利用EXP:https://github.com/lijiejie/GitHack  
https://github.com/BugScanTeam/GitHack
https://github.com/denny0223/scrabble
`git reset--hard HEAD^` 回滚到上一个版本
`git log-stat` 查看修改的文件
`git diff commit-id` 查看差异
.DS_Store 利用: https://github.com/lijiejie/ds_store_exp
进程环境变量: /proc/self/environ 

```
/index.php.bak
/index.php~
/.index.php~
/.index.php.swp~
/.index.php.swp
/.index.php.swo
/.index.php.swp~
/.login.php.swp
/.login.php.swo
/.login.php.swp~
/.login.php.bak
/login.php.swp
/login.php.bak

/.register.php.swp
/.register.php.swo
/.register.php.swp~
/.register.php.bak
/register.php.swp
/register.php.bak


/.admin.php.swp
/.admin.php.bak
/login.php.bak
/.login.php.swp
/file.php.bak
/.file.php.swp
/code.zip
/code.rar
/code.7z
/code.tar.gz
/www.rar
/www.zip
/www.7z
/www.tar.gz
/index.txt
/index.html
/.idea
/.git/
/.hg/
/.ds_store
/.svn/
/WEB-INF/
/WEB-INF/web.xml
/WEB-INF/classes/
/CVS/Root
/CVS
/.bzr
/CVS/Entries
/flag.php
/flag.php.txt
/index.php.txt
/user.php.bak
/index.php.bak
/login.php.bak
/view.php.bak
/blog_manage

/robots.txt 
/.git/
/.svn/
/*.zip 
/*.rar 
/.DS_Store/
```