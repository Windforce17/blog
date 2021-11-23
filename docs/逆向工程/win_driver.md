## 环境配置

vs WDK windbgx 要安装  
https://docs.microsoft.com/zh-cn/windows-hardware/drivers/  
VirtualKD 免去配置 Windbg 双击调试的步骤，提高响应速度  
http://sysprogs.com/legacy/virtualkd/download/
https://github.com/4d61726b/VirtualKD-Redux

## 配置

设置符号目录

```cmd
.symfix D:\win_symbol
.sympath
```

virtualKD 配置：选择 custom、C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\windbg.exe /k com:pipe,resets=0,reconnect,port=\$(pipename)  
或者使用 windbgx.exe

## example

新建项目,选择 WDM,然后目标系统改为 win7，调低并关闭警告等级

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

要在 windbgx 中设置符号目录，编译后，使用 InstDrv（驱动加载工具）载入驱动，安装，启动，就能自动断下来了.
或者使用命令`sxe ld DancingKeys.sys`.

## DbgPrint 无法输出

设置下 log_level:`ed Kd_DEFAULT_MASK 0x8`(DPFLTR_INFO_LEVEL)，0xf 是所有

## 文档和书记
windbg命令大全：http://www.windbg.info/doc/1-common-cmds.html
https://docs.microsoft.com/zh-cn/windows-hardware/drivers/ddi/content/

- Windows 驱动开发技术详解
- 天书夜读:从汇编语言到 Windows 内核编程
- 寒江独钓：Windows 内核安全编程
- Windows 内核安全和驱动开发
- Rootkits-Windows 内核的安全防护
- Rootkit 系统灰色地带的潜伏者
- Windows PE 权威指南
- 深入解析 Windows 操作系统
- windows 内核情景分析
- Windows 内核原理与实现
- Windows 内核设计思想
- Reversing Modern Malware and Next Generation Theats
- https://github.com/ExpLife/awesome-windows-kernel-security-development
