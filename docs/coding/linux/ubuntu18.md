## ubuntu1804

sudo apt-get install ttf-wqy-zenhei
sudo apt-get install xfonts-wqy
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

## 编译环境

### 32 位

```sh
 sudo apt install -y build-essential &&
 sudo apt install -y libc6-dev-i386 &&
 sudo apt install -y gcc-multilib g++-multilib
```

可以使用-m32 编译 32 位程序啦

```sh
# 32bit lib dbug info
dpkg --add-architecture i386
apt install libc6:i386 libstdc++6:i386
apt install libc6-dbg:i386
```

```sh
#arm mips
apt install python-pip python3-pip build-essential libc6-dev-i386 gcc-multilib g++-multilib gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi gcc-arm-linux-gnueabi g++-arm-linux-gnueabilibncurses5-dev gcc-mips-linux-gnu
```

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
- 还有 arch 的官方文档
- 更改/etc/exports 后，需要 exportfs -av

### stop broken nfs

umount -f -l /mnt/myfolder

## 如何重启 php

启动 php-fpm:

/usr/local/php/sbin/php-fpm
INT, TERM 立刻终止
QUIT 平滑终止
USR1 重新打开日志文件
USR2 平滑重载所有 worker 进程并重新载入配置和二进制模块
先查看 php-fpm 的 master 进程号
kill -USR2 \<master pid\>

## fbctf

https://blog.ctftools.com/2017/03/post122/
https://github.com/facebook/fbctf/wiki/Installation-Guide,-Production

http://192.168.168.42/?LanmanErrorCode=%3Cscript%3EsetTimeout(function(){alert(document.getElementById(%22password%22).value);},1000);%3C/script%3E
