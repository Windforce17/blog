## 工具简介
apachebench
zambie
MS12-020
## VoIP 压力测试工具
    　　拒绝服务器（DOS）攻击是一种危险的攻击，可能导致VoIP网络和设备崩溃。包括 iaxflood 和 inviteflood防洪攻击。
    


## THC-SSL-DOS
    　　THC-SSL-DOS是验证SSL性能的工具。建立安全的SSL连接在服务器上的处理能力要比客户端要高15倍。THC-SSL-DOS通过重载服务器并将其从互联网上掉下来来利用这种不对称属性。
    　　借助 THC-SSL-DOS 攻击工具，任何人都可以把提供 SSL 安全连接的网站攻击下线，这种 攻击方法被称为 SSL 拒绝服务攻击（SSL DOS）。德国黑客组织“The Hacker’s Choice”发 布 THC SSL DOS，利用 SSL 中的已知弱点，迅速消耗服务器资源，与传统 DDoS 工具不同的 是，它不需要任何带宽，只需要一台执行单一攻击的电脑。
    　　漏洞存在于协议的 renegotiation 过程中，renegotiation 被用于浏览器到服务器之间的验证。

## dhcpig
　　DHCPig可以发起一个高级的DHCP耗尽攻击。它将消耗局域网内的所有IP地址以及阻止新客户端获取IP，同时它也防止旧客户端释放IP地址。另外，它会发送无效的ARP去把所有的windows主机震下线

## IPv6 攻击工具包
　　THC-IPV6是一套完整的工具包，可用来攻击IPV6和ICMP6协议的固有弱点，THC-IPV6包含了易用的库文件，可二次开发。THC-IPV6由先进的主机存活扫描工具，中间人攻击工具，拒绝服务攻击工具构成。
　　增加新工具：
detect_sniffer6模块（在Windows，Linux，BSD，OS X 等）
fake_router26模块 – 提供了更多的控制选项
dnsrevenum6模块 – 反向列举DNS
inverse_lookup6模块 – 获取MAC的IPv6地址
fake_solicitate6模块

## Inundator
　　IDS/IPS/WAF 压力测试工具。Inundator 是一个IDS逃避工具，当用户执行攻击以便最小化检测时，可能会产生绝大多数的误报。淹水者的主要特点之一是通过SOCKS代理匿名发送虚假攻击的可能性， 强烈建议使用 Tor。
　　其他功能有：

多线程
队列驱动
多目标支持
　　Inundator以外的概念是读取snort规则并从先前解析的每个规则生成数据包或流量，成功的关键是目标机器上的IDS配置，良好的配置将决定是否检测到用户的错误攻击。

命令：inundator -r / etc / snort / rules -p localhost：9050 victim_ip
-r是snort规则位置的路径，
-p是SOCKS代理配置
victim_ip即受害者ip

## Macof
　　mac地址溢出攻击，可做泛洪攻击。

## Siege
　　Siege是Linux下的一个web系统的压力测试工具，支持多链接，支持get和post请求，可以对web系统进行多并发下持续请求的压力测试。
Siege可以根据配置对一个 WEB 站点进行多用户的并发访问，记录每个用户所有请求过程的相应时间，并在一定数量的并发访问下重复进行


## 压力测试工具T50
　　T50 Sukhoi PAK FA Mixed Packet Injector (f.k.a. F22 Raptor)是一个网络层压力测试工具，它功能强大且具有独特的数据包注入工具。T50 支持unix 系统可进行多种协议的数据包注入，实际上支持 15 种协议。T50可以用于在多种类型的网络基础架构上执行“压力测试”（2.45版本），使用多种协议，可以修改请求的数据包，扩展测试范围，覆盖常用的协议ICMP、TCP和UDP，基础架构协议GRE、IPSec和RSVP，一些路由协议RIP、EIGRP和OSPF。
　　其功能有：

每秒发送大量的数据包，是最快的工具
在适当的位置对多种网络基础设施、网络设备、安全解决方案进行“压力测试”。
模拟“分布式拒绝服务”和“拒绝服务”攻击，测试防火墙规则，路由器ACL，入侵检测系统和入侵阻止系统的策略。
T50除了能够修改网络路由，能够在单个SOCKET上顺序发送所有的协议数据包。


## 无线压力测试工具MDK3
　　MDK3 是一款无线DOS 攻击测试工具，能够发起Beacon Flood、Authentication DoS、Deauthentication/Disassociation Amok 等模式的攻击,另外它还具有针对隐藏ESSID 的暴力探测模式、802.1X 渗透测试、WIDS干扰等功能”。
　　beacon flood mode： 这个模式可以产生大量死亡SSID来充斥无线客户端的无线列表，从而扰乱无线使用者；我们甚至还可以自定义发送死亡SSID的BSSID和ESSID、加密方式（如wep/wpa2）等。
　　详细命令如下：
　　mdk3 mon0 b （mon0是虚拟网卡）

-n ＜ssid＞ #自定义ESSID
-f ＜filename＞ #读取ESSID列表文件
-v ＜filename＞ #自定义ESSID和BSSID对应列表文件
-d #自定义为Ad-Hoc模式
-w #自定义为wep模式
-g #54Mbit模式
-t # WPA TKIP encryption
-a #WPA AES encryption
-m #读取数据库的mac地址
-c ＜chan＞ #自定义信道
-s ＜pps＞ #发包速率mdk3 --help b #查看详细内容
　　示例：mdk3 mon0 b –f /usr/share/set/src/fasttrack/wordlist.txt –t –c 6 –s 80

## slowhttptest
使用畸形报文进行DOS
git clone https://github.com/shekyan/slowhttptest
# DDos防御
大带宽防御不了
## 常见弱点
登录认证
评论
用户动态
api
## 防御手段
1. 拼带宽，流量清洗
2. DPS转发功能，流量给域名提供商
3. IP/网段封杀，统计B段、C段连接数，超过后DROP
4. 抓HTTP报文
tcpdump -XvvennSs 0 tcp[20:2]=0x4745 or tcp[20:2]=0x4854

## 反击
1. 域名解析到127.0.0.1