## 待整理

[本地文件包含利用](https://github.com/D35m0nd142/LFISuite)
https://github.com/We5ter/Scanners-Box/blob/master/README_CN.md]
[临时邮箱](http://mail.hrka.net/)
[目录扫描](https://github.com/Mosuan/FileScan)

### 上传绕过

[解析漏洞总结](https://www.secpulse.com/archives/3750.html)

[编辑器漏洞手册](ttp://navisec.it/%E7%BC%96%E8%BE%91%E5%99%A8%E6%BC%8F%E6%B4%9E%E6%89%8B%E5%86%8C/)

[多种文件上传漏洞演示](http://bbs.sssie.com/thread-803-1-1.html)
[上传绕过文档](http://www.owasp.org.cn/OWASP_Training/Upload_) Attack_Framework.pdf
[十一种 cms](http://m.2cto.com/article/201407/321848.html)

## XSS

工具:xsser xssfuzz xssf

## CSRF

[浅析 CSRF](http://www.cnblogs.com/wangyuyu/p/3388169.html)
[从零开始学 CSRF](http://www.freebuf.com/articles/web/55965.html)

### 怎么生成 CSRF?

- burpsuite 自动生成利用 poc
- awvs
- xss 和 csrf 结合起来

## 移动端漏洞挖掘

### 自动化检测平台

http://service.security.tencent.com/kingkong 同时支持 Android 或者 ios app 文件 腾讯

http://appscan.360.cn/app/5b074632a18a25478297a9c7e2a6c3b1/report/ 360 只支持 Android
http://jaq.alibaba.com/ 需要自己去认真申请 才能获得企业账号 同时支持 android 和 ios(很抱歉 iOS 的安全扫描功能正在建设中...)

{我使用阿里聚安全的原因是它提供了实例，给我们做参考}
http://mtc.baidu.com/my/console 百度平台 需要收费 10 块/此 一个 app 该服务目前仅支持 Android 应用测试
https://www.bangcle.com/ 梆梆安全 请上传.apk 文件

[STS 安全测试服务](http://sts.aliyun.com/index.html)
[爱内测](http://www.ineice.com/)
[APP 安全云 -通付盾](http://www.appfortify.cn/)  
[墨贝科技](http://www.mobeisecurity.com/)
[360 手机应用检测](http://scan.shouji.360.cn/index.jsp)

http://dev.360.cn/html/vulscan/scanning.html
[娜迦测试平台](http://www.nagain.com/appscan/)
[app 自动化检测系列文章](http://www.freebuf.com/author/sunnieli)

## app 常见漏洞类型

1.Java 层调试标记风险 该 Apk 中 AndroidManifest.xml 中的调试标记已被关闭，Java 层无法被调试。风险详情 android:debuggable="true"是不安全的  
2.备份标识配置 AndroidMainfest.xml 在 AndroidManifest.xml 中设置 android:allowBackup="true" 是有安全风险的  
3.java 代码保护风险(app 有没有加壳） 4.组件安全（组成 Apk 的四个组件，Activity，Service，Broadcast Receiver 和 Content Provider）

### mobsf

5.未使用 HTTPS(http+ssl)协议的数据传输风险
6.Webview 明文存储密码风险 7.敏感信息泄露 （内网测试信息残留漏洞）、
8.Webview 远程代码执行漏洞 https://security.tencent.com/index.php/opensource?&per_page=2  
移动安全框架 (MobSF) 是一个智能化、一体化的开源移动应用(Android / iOS) 自动测试框架,能够对以上两种移动应用进行静态和动态分析

drozer
手机上装 dorzer app
电脑和手机在同一局域网
http://bobao.360.cn/learning/detail/158.html

mobsf

移动安全框架 (MobSF) 是一个智能化、一体化的开源移动应用(Android / iOS)自动测试框架,能够对以上两种移动应用进行静态和动态分析
git clone https://github.com/ajinabraham/Mobile-Security-Framework-MobSF.git
https://github.com/ajinabraham/Mobile-Security-Framework-MobSF/wiki/1.-Documentation

# 二进制收集

## 资源

http://jackson.thuraisamy.me/re-resources.html

# 工具集合

## 漏洞及渗透练习平台

WebGoat 漏洞练习环境
https://github.com/WebGoat/WebGoat
https://github.com/WebGoat/WebGoat-Legacy
Damn Vulnerable Web Application(漏洞练习平台)
https://github.com/RandomStorm/DVWA

## 数据库注入练习平台

https://github.com/Audi-1/sqli-labs
用 node 编写的漏洞练习平台，like OWASP Node Goat
https://github.com/cr0hn/vulnerable-node

## 花式扫描器

本地网络扫描器
https://github.com/SkyLined/LocalNetworkScanner
子域名扫描器
https://github.com/lijiejie/subDomainsBrute
漏洞路由扫描器
https://github.com/jh00nbr/Routerhunter-2.0
迷你批量信息泄漏扫描脚本
https://github.com/lijiejie/BBScan
Waf 类型检测工具
https://github.com/EnableSecurity/wafw00f

## 信息搜集工具

社工插件，可查找以 email、phone、username 的注册的所有网站账号信息
https://github.com/n0tr00t/Sreg
Github 信息搜集，可实时扫描查询 git 最新上传有关邮箱账号密码信息
https://github.com/sea-god/gitscan
github Repo 信息搜集工具
https://github.com/metac0rtex/GitHarvester

## WEB 工具

webshell 大合集
https://github.com/tennc/webshell
渗透以及 web 攻击脚本
https://github.com/brianwrf/hackUtils
web 渗透小工具大合集
https://github.com/rootphantomer/hack_tools_for_me
XSS 数据接收平台
https://github.com/firesunCN/BlueLotus_XSSReceiver
XSS 与 CSRF 工具
https://github.com/evilcos/xssor
Short for command injection exploiter，web 向命令注入检测工具
https://github.com/stasinopoulos/commix
数据库注入工具
https://github.com/sqlmapproject/sqlmap
Web 代理，通过加载 sqlmap api 进行 sqli 实时检测
https://github.com/zt2/sqli-hunter
新版中国菜刀
https://github.com/Chora10/Cknife
浏览器攻击框架
https://github.com/beefproject/beef
自动化绕过 WAF 脚本
https://github.com/khalilbijjou/WAFNinja
http 命令行客户端，可以从命令行构造发送各种 http 请求（类似于 Curl）
https://github.com/jkbrzt/httpie
浏览器调试利器
https://github.com/firebug/firebug
一款开源 WAF
https://github.com/SpiderLabs/ModSecurity
windows 域渗透工具
windows 渗透神器
https://github.com/gentilkiwi/mimikatz
Powershell 渗透库合集
https://github.com/PowerShellMafia/PowerSploit
Powershell tools 合集
https://github.com/clymb3r/PowerShell
Fuzz
Web 向 Fuzz 工具
https://github.com/xmendez/wfuzz
HTTP 暴力破解，撞库攻击脚本
https://github.com/lijiejie/htpwdScan
漏洞利用及攻击框架
msf
https://github.com/rapid7/metasploit-framework
Poc 调用框架，可加载 Pocsuite,Tangscan，Beebeeto 等
https://github.com/erevus-cn/pocscan
Pocsuite
https://github.com/knownsec/Pocsuite
Beebeeto
https://github.com/n0tr00t/Beebeeto-framework

## 漏洞 POC&EXP

ExploitDB 官方 git 版本
https://github.com/offensive-security/exploit-database
php 漏洞代码分析
https://github.com/80vul/phpcodz
Simple test for CVE-2016-2107
https://github.com/FiloSottile/CVE-2016-2107
CVE-2015-7547 POC
https://github.com/fjserna/CVE-2015-7547
JAVA 反序列化 POC 生成工具
https://github.com/frohoff/ysoserial
JAVA 反序列化 EXP
https://github.com/foxglovesec/JavaUnserializeExploits
Jenkins CommonCollections EXP
https://github.com/CaledoniaProject/jenkins-cli-exploit
CVE-2015-2426 EXP (windows 内核提权)
https://github.com/vlad902/hacking-team-windows-kernel-lpe
use docker to show web attack(php 本地文件包含结合 phpinfo getshell 以及 ssrf 结合 curl 的利用演示)
https://github.com/hxer/vulnapp
php7 缓存覆写漏洞 Demo 及相关工具
https://github.com/GoSecure/php7-opcache-override
XcodeGhost 木马样本
https://github.com/XcodeGhostSource/XcodeGhost

## 中间人攻击及钓鱼

中间人攻击框架
https://github.com/secretsquirrel/the-backdoor-factory
https://github.com/secretsquirrel/BDFProxy
https://github.com/byt3bl33d3r/MITMf
Inject code, jam wifi, and spy on wifi users
https://github.com/DanMcInerney/LANs.py
可扩展的中间人代理工具
https://github.com/intrepidusgroup/mallory
wifi 钓鱼
https://github.com/sophron/wifiphisher

## 密码破解

密码破解工具
https://github.com/shinnok/johnny
本地存储的各类密码提取利器
https://github.com/AlessandroZ/LaZagne
二进制及代码分析工具
二进制分析工具
https://github.com/devttys0/binwalk
系统扫描器，用于寻找程序和库然后收集他们的依赖关系，链接等信息
https://github.com/quarkslab/binmap
rp++ is a full-cpp written tool that aims to find ROP sequences in PE/Elf/Mach-O (doesn't support the FAT binaries) x86/x64 binaries.
https://github.com/0vercl0k/rp
Windows Exploit Development 工具
https://github.com/lillypad/badger
二进制静态分析工具（python）
https://github.com/bdcht/amoco
Python Exploit Development Assistance for GDB
https://github.com/longld/peda
对 BillGates Linux Botnet 系木马活动的监控工具
https://github.com/ValdikSS/billgates-botnet-tracker
木马配置参数提取工具
https://github.com/kevthehermit/RATDecoders
Shellphish 编写的二进制分析工具（CTF 向）
https://github.com/angr/angr
针对 python 的静态代码分析工具
https://github.com/yinwang0/pysonar2
一个自动化的脚本（shell）分析工具，用来给出警告和建议
https://github.com/koalaman/shellcheck
基于 AST 变换的简易 Javascript 反混淆辅助工具
https://github.com/ChiChou/etacsufbo

## EXP 编写框架及工具

二进制 EXP 编写工具
https://github.com/t00sh/rop-tool
CTF Pwn 类题目脚本编写框架
https://github.com/Gallopsled/pwntools
an easy-to-use io library for pwning development
https://github.com/zTrix/zio
跨平台注入工具（ Inject JavaScript to explore native apps on Windows, Mac, Linux, iOS and Android.）
https://github.com/frida/frida
隐写相关工具
隐写检测工具
https://github.com/abeluck/stegdetect
各类安全资料
域渗透教程
https://github.com/l3m0n/pentest_study
python security 教程（原文链接http://www.primalsecurity.net/tutorials/python-tutorials/）
https://github.com/smartFlash/pySecurity
data_hacking 合集
https://github.com/ClickSecurity/data_hacking
mobile-security-wiki
https://github.com/exploitprotocol/mobile-security-wiki
书籍《reverse-engineering-for-beginners》
https://github.com/veficos/reverse-engineering-for-beginners

## 一些信息安全标准及设备配置

https://github.com/luyg24/IT_security
APT 相关笔记
https://github.com/kbandla/APTnotes
Kcon 资料
https://github.com/knownsec/KCon
ctf 及黑客资源合集
https://github.com/bt3gl/My-Gray-Hacker-Resources
ctf 和安全工具大合集
https://github.com/zardus/ctf-tools
《DO NOT FUCK WITH A HACKER》
https://github.com/citypw/DNFWAH

## 各类 CTF 资源

近年 ctf writeup 大全
https://github.com/ctfs/write-ups-2016
https://github.com/ctfs/write-ups-2015
https://github.com/ctfs/write-ups-2014
ctf Resources
https://github.com/ctfs/resources

大礼包（什么都有）
https://github.com/bayandin/awesome-awesomeness

安卓开源代码解析
https://github.com/android-cn/android-open-project-analysis

python 任务管理以及命令执行库
https://github.com/pyinvoke/invoke

一个提供底层接口数据包编程和网络协议支持的 python 库
https://github.com/CoreSecurity/impacket

python 实用工具合集
https://github.com/mahmoud/boltons
python 爬虫系统
https://github.com/binux/pyspider

## 以下内容来自：https://github.com/We5ter/Scanners-Box/blob/master/README_CN.md

子域名枚举类
https://github.com/lijiejie/subDomainsBrute (经典的子域名爆破枚举脚本)
https://github.com/ring04h/wydomain (子域名字典穷举)
https://github.com/le4f/dnsmaper (子域名枚举与地图标记)
https://github.com/0xbug/orangescan (在线子域名信息收集工具)
https://github.com/TheRook/subbrute （根据 DNS 记录查询子域名)
https://github.com/We5ter/GoogleSSLdomainFinder (基于谷歌 SSL 透明证书的子域名查询脚本)
https://github.com/mandatoryprogrammer/cloudflare_enum （使用 CloudFlare 进行子域名枚举的脚本）
https://github.com/18F/domain-scan (A domain scanner）
https://github.com/Evi1CLAY/Cool ... Python/DomainSeeker（多方式收集目标子域名信息）
数据库漏洞扫描类
https://github.com/0xbug/SQLiScanner (一款基于 SQLMAP 和 Charles 的被动 SQL 注入漏洞扫描工具)
https://github.com/stamparm/DSSS (99 行代码实现的 sql 注入漏洞扫描器)
https://github.com/LoRexxar/Feigong（针对各种情况自由变化的MySQL注入脚本）
https://github.com/youngyangyang04/NoSQLAttack (一款针对 mongoDB 的攻击工具)
https://github.com/Neohapsis/bbqsql（SQL盲注利用框架）
https://github.com/NetSPI/PowerUpSQL（攻击SQLSERVER的Powershell脚本框架）
弱口令或信息泄漏扫描类
https://github.com/lijiejie/htpwdScan (一个简单的 HTTP 暴力破解、撞库攻击脚本)
https://github.com/lijiejie/BBScan (一个迷你的信息泄漏批量扫描脚本)
https://github.com/wilson9x1/fenghuangscanner_v3 (端口及弱口令检测)
https://github.com/ysrc/F-Scrack (对各类服务进行弱口令检测的脚本)
https://github.com/Mebus/cupp （根据用户习惯生成弱口令探测字典脚本）
https://github.com/RicterZ/genpAss （中国特色的弱口令生成器）
https://github.com/netxfly/crack_ssh （go 写的协程版的 ssh\redis\mongodb 弱口令破解工具）
物联网设备扫描
https://github.com/rapid7/IoTSeeker （物联网设备默认密码扫描检测工具)
https://github.com/shodan-labs/iotdb (使用 nmap 扫描 IoT 设备)
xss 扫描器
https://github.com/shawarkhanethicalhacker/BruteXSS （Cross-Site Scripting Bruteforcer）
https://github.com/1N3/XSSTracer (A small python script to check for Cross-Site Tracing)
https://github.com/0x584A/fuzzXssPHP (PHP 版本的反射型 xss 扫描)
https://github.com/chuhades/xss_scan (批量扫描 xss 的 python 脚本）
企业网络自检
https://github.com/sowish/LNScan （详细的内部网络信息扫描器）
https://github.com/ysrc/xunfeng (网络资产识别引擎，漏洞检测引擎）
https://github.com/SkyLined/LocalNetworkScanner (javascript 实现的本地网络扫描器)
https://github.com/laramies/theHarvester （企业被搜索引擎收录敏感资产信息监控脚本：员工邮箱、子域名、Hosts）
https://github.com/x0day/Multisearch-v2 (bing、google、360、zoomeye 等搜索引擎聚合搜索，可用于发现企业被搜索引擎收录的敏感资产信息）
webshell 检测
https://github.com/We5ter/Scanners-Box/tree/master/Find_webshell/ （php 后门检测，脚本较简单，因此存在误报高和效率低下的问题）
https://github.com/yassineaddi/BackdoorMan （A toolkit find malicious, hidden and suspicious PHP scripts and shells in a chosen destination）
内网渗透
https://github.com/0xwindows/VulScritp （企业内网渗透脚本，包括 banner 扫描、端口扫描；phpmyadmin、jenkins 等通用漏洞利用等）
https://github.com/lcatro/network_backdoor_scanner（基于网络流量的内网探测框架）
https://github.com/fdiskyou/hunter（调用 Windows API 枚举用户登录信息）
中间件扫描、指纹识别类
https://github.com/ring04h/wyportmap (目标端口扫描+系统服务指纹识别)
https://github.com/ring04h/weakfilescan (动态多线程敏感信息泄露检测工具)
https://github.com/EnableSecurity/wafw00f (WAF 产品指纹识别)
https://github.com/rbsec/sslscan （ssl 类型识别)
https://github.com/urbanadventurer/whatweb (web 指纹识别)
https://github.com/tanjiti/FingerPrint (web 应用指纹识别)
https://github.com/nanshihui/Scan-T （网络爬虫式指纹识别)
https://github.com/OffensivePython/Nscan (a fast Network scanner inspired by Masscan and Zmap)
https://github.com/ywolf/F-NAScan (网络资产信息扫描, ICMP 存活探测,端口扫描，端口指纹服务识别）
https://github.com/ywolf/F-MiddlewareScan （中间件扫描）
https://github.com/maurosoria/dirsearch (Web path scanner)
https://github.com/x0day/bannerscan （C 段 Banner 与路径扫描）
https://github.com/RASSec/RASscan (端口服务扫描)
https://github.com/3xp10it/bypass_waf （waf 自动暴破）
https://github.com/3xp10it/mytools/blob/master/xcdn.py（获取cdn背后的真实ip）
https://github.com/Xyntax/BingC（基于Bing搜索引擎的C段/旁站查询，多线程，支持API）
https://github.com/Xyntax/DirBrute（多线程WEB目录爆破工具）
https://github.com/zer0h/httpscan（一个爬虫式的网段Web主机发现小工具）
https://github.com/lietdai/doom（thorn上实现的分布式任务分发的ip端口漏洞扫描器）
专用扫描器
https://github.com/blackye/Jenkins (Jenkins 漏洞探测、用户抓取爆破)
https://github.com/code-scan/dzscan (discuz 扫描)
https://github.com/chuhades/CMS-Exploit-Framework (CMS 攻击框架)
https://github.com/lijiejie/IIS_shortname_Scanner (an IIS shortname Scanner)
https://github.com/We5ter/Scanne ... ter/FlashScanner.pl (flashxss 扫描)
https://github.com/coffeehb/SSTIF（一个Fuzzing服务器端模板注入漏洞的半自动化工具）
无线网络
https://github.com/savio-code/fern-wifi-cracker/ (无线安全审计工具)
https://github.com/m4n3dw0lf/PytheM（Python网络/渗透测试工具）
https://github.com/P0cL4bs/WiFi-Pumpkin（无线安全渗透测试套件）
综合类
https://github.com/az0ne/AZScanner (自动漏洞扫描器，子域名爆破，端口扫描，目录爆破，常用框架漏洞检测)
https://github.com/blackye/lalascan (自主开发的分布式 web 漏洞扫描框架，集合 owasp top10 漏洞扫描和边界资产发现能力)
https://github.com/blackye/BkScanner (BkScanner 分布式、插件化 web 漏洞扫描器)
https://github.com/ysrc/GourdScanV2 （被动式漏洞扫描)
https://github.com/alpha1e0/pentestdb (WEB 渗透测试数据库)
https://github.com/netxfly/passive_scan (基于 http 代理的 web 漏洞扫描器)
https://github.com/1N3/Sn1per (自动化扫描器，包括中间件扫描以及设备指纹识别)
https://github.com/RASSec/pentestEr_Fully-automatic-scanner （定向全自动化渗透测试工具）
https://github.com/3xp10it/3xp10it （3xp10it 自动化渗透测试框架）
https://github.com/Lcys/lcyscan（python插件化漏洞扫描器）
https://github.com/Xyntax/POC-T（渗透测试插件化并发框架）
