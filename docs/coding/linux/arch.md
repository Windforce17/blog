## 安装

### 制作多启动

https://wiki.archlinux.org/index.php/Multiboot_USB_drive
建议使用 Ultra ISO,rufus(win),dd(linux)进行写入 U 盘

### 步骤

1. 验证 hash，设置键盘，检查启动模式，连接互联网
2. 更新时间`timedatectl set-ntp true`
3. 分区，根目录，LVM，RAID,swap 等,然后格式化,uefi 的可以试试直接格式化/dev/sda....
4. swap 处理 `mkswap /dev/sdX2;swapon /dev/sdX2`
5. 挂载根目录 `mount /dev/sdX1 /mnt`
6. 修改`/etc/pacman.d/mirrorlist` 选择最快的地址，我使用 ustc 和清华的，或者使用`pacman-mirrors -b testing -c China`
7. 安装系统：`pacstrap /mnt base linux linux-firmware`
8. 更新启动挂载盘:`genfstab -U /mnt > /mnt/etc/fstab`
9. 更改根目录，进入系统 `arch-chroot /mnt`
10. 设置时区并同步到硬件:`ln -sf /usr/share/zoneinfo/Region/City /etc/localtime;hwclock --systohc`
11. 本地化:注释掉你需要的 locales 在`/etc/locale.gen`,然后`locale-gen`
12. 添加你的 hostname`echo you_host_name > /etc/hostname`
13. 在`/etc/hosts`中添加你的本地 ip，例如`127.0.0.1 you_hostname\n ::1 you_hostname`
14. 安装 grub 引导:`grub-install /dev/sda;grub-mkconfig -o /boot/grub/grub.cfg`
15. 改密码:`passwd;reboot`
16. 配置网络，自带了`systemd-networkd`，看[这个](https://wiki.archlinux.org/index.php/Systemd-networkd)

## 联网

http://blog.csdn.net/r8l8q8/article/details/73252970#79tkjm1497440352464

如果没有网卡，可以用手机 usb 热点：

```sh
modprobe rndis_host cdc_ether usbnet
# 然后使用dhcp之类的设置ip地址，没有dns还要设置dns ping 一下试试
```

## wifi

iw 工具和 wpa_supplicant

更改 mkinitcpio 配置后，需要手动重新生成镜像：
mkinitcpio -p linuxx
警告: lvm2、mdadm、encrypt 支持默认是关闭的。
参考：https://wiki.archlinux.org/index.php/Mkinitcpio_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

## 安全设置

## 安装后的

```sh
#添加以下内容
sudo pacman-mirrors -b testing -c China&&
sudo vi /etc/pacman.conf
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
sudo pacman -S archlinuxcn-keyring
```
### 修复ssh 连接错误
`/etc/ssh/ssh_config`添加:
```conf
IPQoS 0
TCPKeepAlive=yes
ServerAliveInterval 60
```

### vmware

```sh
yay -S gtkmm
yay -S gtkmm3
systemctl enable vmware-networks.service
systemctl enable vmware-usbarbitrator.service
systemctl enable vmware-hostd.service
```

### package
```sh

fakeroot
ntfs-3g
# network
NetworkManager
wpa_supplicant
# nvidia intel
optimus-manager
# bluetooth
bluez bluez-utils
systemctl enable  bluetooth.service
# caps2ctrl
kcmshell5 kcm_keyboard

# theme
libdbusmenu-glib
nordic-kde-git
nordic-theme-git
kcm-colorful-git
breeze-blurred-git
kvantum-qt5
kvantum-theme-nordic-git
yay -S kdecoration qt5-declarative qt5-x11extras kcoreaddons kguiaddons kconfigwidgets kwindowsystem fftw cmake extra-cmake-modules qtcurve-kde
```

```sh
# fonts amd vim
visual-studio-code-bin
 yay -S adobe-source-han-sans-otc-fonts
 yay -S wqy-zenhei wqy-microhei
 yay -S ttf-ms-win10-zh_cn
 yay -S wps-office
 yay -S gvim
````

```sh
# input method
ysy -S fcitx-googlepinyin &&
yay -S fcitx-qt5 &&
yay -S fcitx-qt4 &&
#.xprofile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```

```sh
# laptop acpi dell laptop
yay -S acpi i8utils dell-bios-fan-control-git
# control fan speed
# https://bbs.archlinux.org/viewtopic.php?id=248106
# https://wiki.archlinux.org/index.php/Fan_speed_control#Dell_laptops
```

添加/etc/locale.conf,修复乱码，中文输入问题。

```conf
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
```

添加`/etc/modules-load.d/80-bbr.conf`:

```conf
tcp_bbr
```

添加 `/etc/sysctl.d/improve_network.conf` 开启 bbr

```conf
net.core.netdev_max_backlog = 100000
net.core.netdev_budget = 50000
net.core.netdev_budget_usecs = 5000
net.core.somaxconn = 4096
net.core.rmem_default = 1048576
net.core.rmem_max = 16777216
net.core.wmem_default = 1048576
net.core.wmem_max = 16777216
net.core.optmem_max = 65536
net.ipv4.tcp_rmem = 4096 1048576 2097152
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_max_syn_backlog = 30000
net.ipv4.tcp_max_tw_buckets = 2000000
net.ipv4.tcp_mtu_probing = 1
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
```

### qq/wechat

`yay -S deepin.com.qq.im electronic-wechat`

1. /opt/deepinwine/apps/Deepin-QQ/run.sh 中添加

```conf
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcixt"
export XMODIFIERS="@im=fcitx"
```

2. 安装`环境配置`中的两个字体:wqy-zenhei 与 wqy-microhei
   要设置 LANG 为支持 utf8 的字符集

#### 图片不加载

1. 禁用 ipv6

```conf
# /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 =1
net.ipv6.conf.default.disable_ipv6 =1
net.ipv6.conf.lo.disable_ipv6 =1
```

2. 清空缓存
   `sudo rm -rf ~/.deepinwine/Deepin-QQ`

### wps

yay -S wps-office-cn

### touchpad

deepin: edit `/usr/share/dde-daemon/guesture.json`
