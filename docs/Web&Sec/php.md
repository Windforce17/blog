## 有问题的函数
1. end，和reset,这两个函数返回和赋值顺序有关

## 禁用某个ip
```php
<?php
$ip=$_SEVER['REMOTE_ADDR'];
$ban=file_get_contents('ban.list');
if(stripos($ban,$ip))
{
    die("forbiden");
}
>
```