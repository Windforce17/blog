## firewalld

**注意**:cetnos7 用firewalld 代替iptables

不会设置CentOS的 selinux 防火墙，最好关掉，默认屏蔽80端口 

## yum自己建立源 
首先你要有自己的http服务

1. 安装createrepoyum –y install createrepo  
2. 创建目录 mkdir –p /var/www/html/x64 //你自己www目录
3. 扔进rpm包
4. 创建repo: createrepo -p -d -o /var/www/html/x64/ /var/www/html/x64/  
//路径一定要写两遍径  

## REPL源
这个源补充了官方源的不足  
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

To install ELRepo for RHEL-7, SL-7 or CentOS-7:

rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

To make use of our mirror system, please also install yum-plugin-fastestmirror.

To install ELRepo for RHEL-6, SL-6 or CentOS-6:

rpm -Uvh http://www.elrepo.org/elrepo-release-6-8.el6.elrepo.noarch.rpm


## selinx相关
getenforce //查看
/etc/selinux/config 设置
## 将网卡eth1->eth0
    vi /etc/udev/rules.d/70-persistent-net.rules
    删除eth0
    修改：vim /etc/sysconfig/network-scripts/ifcfg-eth0
## 使yum只下载不安装  

    yum install yum-plugin-downloadonly
使用方法:  

    yum install --downloadonly（只下载不安装） --downloaddir=rpm包下载的目录 安装的组件名

## CentOS 装VBox
1. `yum install gcc kernel-devel`  
2. `ln -s /usr/src/kernels/[TAB] /usr/src/linux`  
3. `sh ./VBoxLinuxAdditions.run`  

## 装Nginx
    cd /etc/yum.repos.d/
    vim nginx.repo

    [nginx]
    name=nginx repo
    baseurl=http://nginx.org/packages/centos/`版本`/$basearch/
    gpgcheck=0
    enabled=1  

    yum install nginx

## 装mysql
```sh
    yum install mysql
    yum install mysql-server
    yum install mysql-devel
```
注意:CentOS7用Mariadb代替mysql  
**！有systemd的可以使用systemctl来管理mysql！**  
装好后:获取工作状态:  

    mysqladmin --version  
设置root密码:  

    mysqladmin -u root password "new_password"  
关闭命令：
`mysqladmin -u root -p password shutdown`



## goole-chrome
```conf
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
```
`yum -y install google-chrome-stable --nogpgcheck`


