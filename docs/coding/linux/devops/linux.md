## locale  issue
```sh
locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8" #to bashrc
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
```
## kill 进程
`kill -l` 信号列表
`pgrep` = ps -ef |grep \[process\]
`pidof` = pid of xxx
`pkill` = pgrep+kill
`killall` 必须给出全名
## partition
对于大于5T or gpt的分区，推荐使用parted进行分区.
https://blog.csdn.net/dufufd/article/details/53508367

## 时间戳
docker container的时区往往是错误的，这里给出Linux通用更改时区的方法
`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

## iscsi

1. 发现： `iscsiadm -m discovery -t st -p <ip>`

2. 登录：
`iscsiadm -m node -T <target> -l`（登陆某个目标器）
`iscsiadm -m node -L all`（登陆发现的所有目标器）
登入需验证码的节点，在登陆前需执行：
- 开启认证
`iscsiadm -m node -T  <target> --op update --name node.session.auth.authmethod --value=CHAP`
- 添加用户
`iscsiadm -m node -T  <target> --op update --name node.session.auth.username --value=mychap`
- 添加密码
`iscsiadm –m node –T  <target> --op update –name node.session.auth.password –value=mypassword`

3. 退出:
`iscsiadm -m node -T <target> -u`（退出某个目标器)
`iscsiadm -m node -U all`（退出所有登陆的目标器）

4. 连接死掉（断网或者target端断掉）时，使用如下指令：

- `iscsiadm -m node -o delete –T  <target> -p <ip>`
- `iscsiadm -m node -o delete -p <ip>`

5. 查看session:

`iscsiadm -m session` （相当于iscsiadm -m session -P 0）
`iscsiadm -m session -P 3`  (0-3均可，默认为0)

6. 设置开机自动登录
`sudo iscsiadm -m node -o update -n node.startup -v automatic` （manual为手动的）

https://wiki.archlinux.org/index.php/Open-iSCSI
https://blog.csdn.net/imliuqun123/article/details/73873321

## multipath 配置
10.90.1.76
https://console.bluemix.net/docs/infrastructure/BlockStorage/accessing_block_storage_linux.html#-linux-mpio-iscsi-lun
## LVM configure
PV Physical Volume 
VG Volume Group
LV Logical Volume
PV -> VG -> LV
### 创建
```bash
[root@station55 ~]# pvcreate /dev/sd{b,c}1
Physical volume "/dev/sdb1" successfully created
Physical volume "/dev/sdc1" successfully created
```

- `vgcreate <VGNAME> <dev name>`
- `lvcreate -L <SIZE> -n <LV_NAME> <VG_NAME>`
- `lvcreate -l <SIZE%>vg -n <LV_NAME> <VG_NAME>`
- `lvcreate -l <SIZE>free -n <LV_NAME> <VG_NAME>`

### 扩展

- `vgextend <vgname> <pv path>`

- `lvextend -L [+]SIZE <lv path>` Physical boundary
- `resize2fs <lv path>` Logical boundary
- `e2fsck   <lv path>` Check file system

### 减小
- `e2fsck -f <lv path>` Check file system
- `resize2fs <lv path> <SIZE>` Reduce logical boundary
-  `lvreduce -L [-]SIZE <lv path>` Physical boundary

## 如何查看Linux系统的带宽流量

- 按网卡查看流量： vnstat ifstat、dstat -nf或sar -n DEV 1 2
- 按进程查看流量：nethogs
- 按连接查看流量：iptraf、iftop或tcptrack
- 查看流量最大的进程：sysdig -c topprocs_net
- 查看流量最大的端口：sysdig -c topports_server
- 查看连接最多的服务器端口：sysdig -c fdbytes_by fd.sport

## ssh 各种问题
### 权限问题
```sh
chmod 700 ~ 
chmod 700 ~/.ssh 
chmod 644 ~/.ssh/authorized_keys 
chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/known_hosts
```
服务端开启文件AuthorizedKeysFile .ssh/authorized_keys
### vm machine ssh不出去
`/etc/ssh/ssh_config` 中添加 `IPQoS lowdelay throughput`

## system analyse
```sh
# 查看启动耗时
 systemd-analyze                                                                                       
# 查看每个服务的启动耗时
 systemd-analyze blame

# 显示瀑布状的启动过程流
 systemd-analyze critical-chain

# 显示指定服务的启动流
 systemd-analyze critical-chain atd.service

# 显示当前主机的信息
 hostnamectl

# 设置主机名。
 sudo hostnamectl set-hostname rhel7
```


## 时间设置
```sh
 timedatectl list-timezones                   
 timedatectl   

# 设置当前时区
 sudo timedatectl set-timezone America/New_York
 sudo timedatectl set-time YYYY-MM-DD
 sudo timedatectl set-time HH:MM:SS
```
## session和用户

```sh
# 列出session
 loginctl list-sessions

# 列出当前登录用户
 loginctl list-users

# 列出显示指定用户的信息
 loginctl show-user ruanyf
```

## 日志操作
```sh
#查看所有日志（默认情况下 ，只保存本次启动的日志）
 sudo journalctl

#查看内核日志（不显示应用日志）
 sudo journalctl -k

#查看系统本次启动的日志
 sudo journalctl -b
 sudo journalctl -b -0

#查看上一次启动的日志（需更改设置）
 sudo journalctl -b -1

#查看指定时间的日志
 sudo journalctl --since="2012-10-30 18:17:16"
 sudo journalctl --since "20 min ago"
 sudo journalctl --since yesterday
 sudo journalctl --since "2015-01-10" --until "2015-01-11 03:00"
 sudo journalctl --since 09:00 --until "1 hour ago"

#查看指定服务的日志
 sudo journalctl /usr/lib/systemd/systemd

#查看指定进程的日志
 sudo journalctl _PID=1

#查看某个路径的脚本的日志
 sudo journalctl /usr/bin/bash

#查看指定用户的日志
 sudo journalctl _UID=33 --since today

#查看某个 Unit 的日志
 sudo journalctl -u nginx.service
 sudo journalctl -u nginx.service --since today

#实时滚动显示某个 Unit 的最新日志
 sudo journalctl -u nginx.service -f



#查看指定优先级（及其以上级别）的日志，共有8级
# 0: emerg
# 1: alert
# 2: crit
# 3: err
# 4: warning
# 5: notice
# 6: info
# 7: debug
 sudo journalctl -p err -b

#日志默认分页输出，--no-pager 改为正常的标准输出
 sudo journalctl --no-pager

#以 JSON 格式（单行）输出
 sudo journalctl -b -u nginx.service -o json

#以 JSON 格式（多行）输出，可读性更好
 sudo journalctl -b -u nginx.serviceqq
 -o json-pretty

#显示日志占据的硬盘空间
 sudo journalctl --disk-usage

#指定日志文件占据的最大空间
 sudo journalctl --vacuum-size=1G

#指定日志文件保存多久
 sudo journalctl --vacuum-time=1years
```

## tree
https://github.com/cuber/ngx_http_google_filter_module/tree/dev