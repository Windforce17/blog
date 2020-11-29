## ubuntu1804 chrome

sudo apt-get install ttf-wqy-zenhei
sudo apt-get install xfonts-wqy
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb

## 编译环境

```sh
apt install -y flex &&
apt install -y bison &&
apt install -y libxcb-keysyms1 &&
apt install -y libxrandr2 &&
apt install -y libnss3 &&
apt install -y libx11-xcb1 &&
apt install -y libxss
```

### 32 位

```sh
 sudo apt install -y build-essential &&
 sudo apt install -y libc6-dev-i386 &&
 sudo apt install -y gcc-multilib g++-multilib
```

可以使用-m32 编译 32 位程序啦

```sh
# 32bit lib dbug info
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libc6:i386 libstdc++6:i386 libc6-dbg:i386
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

```sh
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```

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

## 网络配置

ip:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: yes
    enp0s8:
      dhcp4: no
      dhcp6: no
      addresses: [192.168.66.128/24]
      gateway4: 192.168.66.2
      nameservers:
        addresses: [192.168.66.2]
```

## apt
1. 依赖查找
```sh
# 查找lvm2的依赖
apt-cache depends lvm2
# 查找依赖lvm2的包
apt-cache rdepends lvm2
```
## pop!_os
https://extensions.gnome.org/extension/945/cpu-power-manager/
有用的插件：https://support.system76.com/articles/customize-gnome/