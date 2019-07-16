## 环境配置
vs WDK windbg要安装
VirtualKD 免去配置Windbg双击调试的步骤，提高响应速度
http://sysprogs.com/legacy/virtualkd/download/
## windbg
设置符号目录
```cmd
.symfix D:\win_symbol
.sympath


C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe /k com:pipe,resets=0,reconnect,port=$(pipename)