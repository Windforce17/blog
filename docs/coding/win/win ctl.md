## 激活

### kms清除

1. 打开管理员cmd
2. `slmgr /upk`  (此命令用于删除当前KMS密匙)
3. `slmgr /ckms`---此命令用于清除系统KMS信息
4. `slmgr /rearm`---此命令用于重置计算机的授权状态

### kms激活

```bat
win10 pro key:

    slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    slmgr /skms 202.114.205.214
    slmgr /ato

cd office路径:

    cd "C:\Program Files (x86)\Microsoft Office\Office16"

    cscript ospp.vbs /sethst:192.168.1.1
    cscript ospp.vbs /act
```
### kms服务器测试

    nslookup -type=srv _vlmcs._tcp.lan

## 用户管理
1. net user 显示所有用户
2. net user [用户名] [密码]/add 添加用户并创建密码
3. net localgroup administrators [用户名] [密码] /del 退出管理员组
4. net user [用户名] /active:no 停用刚才用户
