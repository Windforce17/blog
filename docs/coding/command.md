# python 
## 2.x和3.x共存 
官方先安装Python2，再安装Python3，一定要勾选add path,修改Python3目录下Python为Python3，再手动修复重新安装pip就好了，其他版本共存同理

##virtualenv安装
pip install virtualenv
默认情况下，虚拟环境会依赖系统环境中的site packages，如果不想依赖这些package，那么可以加上参数 --no-site-packages建立虚拟环境：

    `virtualenv` --no-site-packages [虚拟环境名称] -p python.exe

## 文件操作
```sh
chattr +ia attrtest
# A：访问时不修改atime，防止过度访问磁盘 
# S: 从异步改为同步 
# a：只能增加数据，禁止修改删除 
# i：禁止删除，修改收
# s：如果被删除，彻底删除
# u：只删除note

find [PATH] [OPTION] [ACTION]

# -mtime,-ctime,-atime
# -mtime +n  n天之前
# -mtime -n  n天之内
# -newer file 比file这个文件更新的
# -name filename 查找文件名filename的文件
# -size [+-] 比size大或者小的文件，有c=byte k=bytes 例如-size +50k
# -perm mode 权限刚好等于mode的文件
# -perm -mode权限必须包含mode的文件
# -perm +mode 权限必须含有mode中的一项的文件
# -user name name为账号名称
# -nouser 没有所有权
```

# VBox
## 虚拟机复制 

不能直接复制，这样uuid会重复，冲突掉
`VBoxManage clonevm d-m --mode all --name 'd-s1' --basefolder 'E:\docker' --register`

`vboxmanage clonehd` 这个命令也能clone，但貌似不能clone配置文件还没有试过

## 斐迅K2 A6 刷breed
1. 具体，先通过谷歌浏览器利用web漏洞开telnet：

```javascript
    $("#timerebootmin").val("05 | /usr/sbin/telnetd -l /bin/login.sh")
    $("#timeRebootSave").click()
```

2. 通过telnet 192.168.2.1 登录 依此运行下面的红色命令

```bash
    cd /tmp  

    wget http://breed.hackpascal.net/breed-mt7620-phicomm-psg1208.bin

    mtd unlock Bootloader

    mtd write breed-mt7620-phicomm-psg1208.bin Bootloader
```
3. 重启


