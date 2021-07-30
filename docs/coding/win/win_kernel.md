## 小工具
https://github.com/AxtMueller/Windows-Kernel-Explorer
## 内存布局和内核加载
寻址：和linux比较像，64位下，win的最大寻址是64T
内核加载阶段：ntldr会从注册表读取安装的驱动程序，然后加载。
会话管理启动：启动smss.exe，创建系统环境变量，加载win32k.sys csrss.exe 启动 winlogon.exe,创建虚拟内存等..
登录:启动SCM服务控制管理器,启动lsass.exe授权，lsass验证用户凭据，显示登录界面。

## r3和r0通信
实际上系统api在ntdll..dll中，名称分别为Nt和Zw开头，本质是一样的，名字不同。完成参数检查工作后，调用一个中断`int 2Eh`或`SysEnter`，进入r0。在内科ntokrnl.exe中有一个SSDT，与ntdll.dll中函数对应。
从用户模式调用Nt的api，连接到ntdll.lib，从内核模式调用则会连接到ntoskrnl.lib。其中Zw*的API不会对参数进行严格检查，通过KiSystemService最终跳转到对应代码处。

## 驱动加载和运行
1. 在注册表下建立一个与驱动相关的键。
2. 对象管理器生成驱动对象并传递给DriverEntry()函数，执行入口函数。
3. 创建控制设备对象。
4. 创建控制设备符号链接。
5. 如果是过滤驱动，创建过滤设备对象并绑定。
6. 注册特定的分发派遣函数。
7. 其他初始化动作，Hook，过滤，回调等。

## 内核对象
内核对象分为对象头和对象体，对象头至少有OBJECT_HEADER，紧接着是对象体，对象指针指向对象体。对象体有一个type和size成员。内核对象是可以等待的。可以作为参数传递给内核的KeWaitForSingalObject()、KeWaitForMultipleObjects()函数以及应用层WaitForSingalObject()函数WaitForMultipleObject()
### dispatch对象
对象体开头放置了一个DISPATCHER_HEADER，以K开头的内核对象名表明这是一个内核对象。
### I/O 对象
I/O对象开始位置没有DISPATCHER_HEADER，会放置一个type和size有关的成员。
常见的I/O对象包括DEVICE_OBJECT DRIVER_OBJECT FILE_OBJECT IRP VPB KPROFILE。

### 其他
EPROCESS和ETHREAD对象。未导出。可以将自己从EPROCESS链表摘除，隐藏进程。
使用PsLookupProcessByProcessId拿到进程的EPROCESS结构，PsGetCurrentProcss拿到当前EPROCESS结构。