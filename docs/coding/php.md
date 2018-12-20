## nginx中到配置
```conf
  location ~ [^/]\.php(/|$) {
    fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
    #fastcgi_pass unix:/dev/shm/php-cgi.sock;
    #fastcgi_pass remote_php_ip:9000;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    include fastcgi.conf;
  }
  ```

## 任意环境下调试php,debug php

在不管php.ini配置的情况下开启php调试,php debug.
```php
ini_set('display_errors',1);            //错误信息
ini_set('display_startup_errors',1);    //php启动错误信息
error_reporting(-1);                    //打印出所有的 错误信息
ini_set('error_log', dirname(__FILE__) . '/error_log.txt'); //将出错信息输出到一个文本文件
```

## debug php.ini

;显示错误信息
display_errors = On
;显示php开始错误信息
display_startup_errors = On
;日志记录错误信息
log_errors = On

## 一些函数

### extract()

数从数组中将变量导入到当前的符号表。

```php
<?php
$a = "Original";
$my_array = array("a" => "Cat","b" => "Dog", "c" => "Horse");
extract($my_array);
echo "\$a = $a; \$b = $b; \$c = $c";
?>
```

### parse_str()

将查询到的字符串解析到变量中

```php
<?php
parse_str("name=Bill&age=60");
echo $name."<br>";
echo $age;
?>
```

### import_request_variables()

将 GET／POST／Cookie 变量导入到全局作用域中
