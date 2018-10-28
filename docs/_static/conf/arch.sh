echo 'Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch' > /etc/pacman.d/mirrorlist
echo '[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
' >> /etc/pacman.conf
pacman -Syu &&
pacman -S yay &&
# input method
#fcitx-sogoupinyin fcitx-im
yay -S fcitx-qt5 &&
yay -S fcitx-gtk3 &&
yay -S fctix-googlepinyin &&
yay -S shadowsocks-qt5 &&
yay -S google-chrome &&
yay -S go &&
yay -S goland &&
yay -S pycharm &&
yay -S datagrip &&
yay -S netease-cloud-music &&
yay -S wps-offie &&
yay -S ttf-wps-fonts &&
yay -S ttf-dejavu wqy-zenhei wqy-microhei &&
yay -S wireshark-qt &&
#don't forget gpasswd -a username wireshark

#deepin.com.qq.im
# add env to .xinitrc or profile

#vmware 
yay -S linux-headers &&

vmware-modconfig --console --install-all &&
modprobe vmmon &&
modprobe vmci &&
modprobe vmnet &&
# need start service
#vmware-hostd vmware-networks vmware-usbarbitrator

# uninstall
yay -Rsn firefox &&
yay -Rsn steam-manjaro &&
