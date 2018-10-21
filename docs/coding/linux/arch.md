## 安装

建议使用Ultra ISO,rufus(win),dd(linux)进行写入U盘

## 联网

http://blog.csdn.net/r8l8q8/article/details/73252970#79tkjm1497440352464

## wifi 

iw工具和wpa_supplicant

更改mkinitcpio配置后，需要手动重新生成镜像：
    mkinitcpio -p linuxx
警告: lvm2、mdadm、encrypt支持默认是关闭的。
参考：https://wiki.archlinux.org/index.php/Mkinitcpio_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

## 安全设置

## ssh每次失败后重试时间设置


    /etc/pam.d/system-login
    auth optional pam_faildelay.so delay=4000000
4秒后重试

## 安装后的

```sh
#添加以下内容
sudo pacman-mirrors -b testing -c China&&
sudo vi /etc/pacman.conf
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
sudo pacman -S archlinuxcn-keyring
#/etc/parman.d/mirrorlist
Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch
```


### 环境配置
```sh
# fonts
 yay -S adobe-source-han-sans-otc-fonts
 yay -S wqy-zenhei wqy-microhei
 yay -S ttf-ms-win10-zh_cn
 yay -S wps-office
```
### qq

安装`环境配置`中的两个字体
要设置LANG为zh_CN
立即应用:`source /etc/profile.d/locale.sh`
wqy-zenhei与wqy-microhei

### wps
