## iptables
注意 --dport 在INPUT指本机端口，而在OUTPUT中相反，设置interface时，input中是 -i ，OUTPUT中是-o
```sh
#一下命令配合state模块使用可以更简化
# 删掉所有规则
iptables -F
# 设置默认行为
iptables -P INPUT DROP
# 列出所有规则带行号
iptables -L --line-number
# 放行本地回环
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# 干掉一个ip
iptables -A INPUT -s [sorce_ip] -j DROP
# 设置特定的网卡
iptables -A INPUT -i [interface] -s [sorce_ip] -j DROP
# 放行dns查询，如果使用state放行 RELATED ,ESTABLISHED 则不需要再添加INPUT 规则
iptables -A INPUT -p udp -d eth0 --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp -s eth0 --dport 53 -j ACCEPT
# 允许通过eth0 ssh连接192.168.100.0段的主机
iptables -A OUTPUT -o eth0 -p tcp -d 192.168.100.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
# 放行多个端口
iptables -A INPUT -i eth0 -p tcp -m multiport --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
# 允许外面ping进来
iptables -A INPUT -p icmp --icmp-ty外面pe echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
# 允许ping出去
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
```
## state 插件
如果将默认INPUT设置为DROP，那么对于链接建立后，后续的包将全部被DROP，因为没有设置--sport 
```sh
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```
此时需要state插件，用来放行RELATED，ESTABLISHED的数据包。(记得放行本地回环)
```sh
# not test
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEP
```
开放端口
```sh
iptables -I INPUT 3 -m state --state NEW  -p tcp --dport 2333 -j ACCEPT
```
更多用法，支持multiport， 请百度
参考资料 [iptables_51CTO](http://blog.51cto.com/nashsun/1847526)
