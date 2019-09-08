## 环境配置
vs WDK windbgx要安装  
https://docs.microsoft.com/zh-cn/windows-hardware/drivers/  
VirtualKD 免去配置Windbg双击调试的步骤，提高响应速度  
http://sysprogs.com/legacy/virtualkd/download/  

## 配置
设置符号目录
```cmd
.symfix D:\win_symbol
.sympath
```
virtualKD配置：选择custom、C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe /k com:pipe,resets=0,reconnect,port=$(pipename)   
或者使用windbgx.exe

## example
新建项目,选择WDM,然后目标系统改为win7，调低并关闭警告等级

```c
//main.c
#include<ntddk.h>
VOID 
Unload(
	_In_ PDRIVER_OBJECT DriverObject
) {

}
DRIVER_INITIALIZE DriverEntry;
NTSTATUS DriverEntry(
	_In_ PDRIVER_OBJECT  DriverObject,
	_In_ PUNICODE_STRING RegistryPath
)
{
	KdBreakPoint(); //wdk breakpoint
	DriverObject->DriverUnload = Unload;
	return STATUS_SUCCESS;
}
```

要在windbgx中设置符号目录，编译后，使用InstDrv（驱动加载工具）载入驱动，安装，启动，就能自动断下来了.
或者使用命令`sxe ld DancingKeys.sys`.
## 文档和书记
https://docs.microsoft.com/zh-cn/windows-hardware/drivers/ddi/content/

* Windows驱动开发技术详解
* 天书夜读:从汇编语言到Windows内核编程
* 寒江独钓：Windows内核安全编程
* Windows内核安全和驱动开发
* Rootkits-Windows内核的安全防护
* Rootkit 系统灰色地带的潜伏者
* Windows PE权威指南
* 深入解析Windows操作系统
* windows内核情景分析
* Windows内核原理与实现
* Windows内核设计思想
* Reversing Modern Malware and Next Generation Theats
* https://github.com/ExpLife/awesome-windows-kernel-security-development