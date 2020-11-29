#检测所有的tcp连接数量及状态
netstat ‐ant|awk |grep |sed ‐e ‐e |sort|uniq ‐c|sort ‐rn ;
#查看页面访问排名前十的IP
cat /var/log/apache2/access.log | cut ‐f1 ‐d
r | head ‐;
#查看页面访问排名前十的URL
cat /var/log/apache2/access.log | cut ‐f4 ‐d
r | head ‐;