## 环境
### 依赖安装
archlinux
```sh
yay -S community/aarch64-linux-gnu-glibc \
community/aarch64-linux-gnu-gcc \
community/aarch64-linux-gnu-binutils
```
eabi和eabihf不同，对FPU有不同的处理。
```sh
apt install -y gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf  && \
apt install -y gcc-arm-linux-gnueabi g++-arm-linux-gnueabi  && \
apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu && \
apt install -y libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi && \
apt install -y python2-pip python3-pip build-essential gcc-multilib g++-multilib   gcc-arm-linux-gnueabi libncurses5-dev && \
apt install -y gcc-mips-linux-gnu
```
qemu安装
```sh
apt install -y qemu-user-static qemu-user
```
### 运行
1. 直接运行elf
注意-L参数，选择正确的依赖库
```
qemu-arm -L /usr/arm-linux-gnueabi ./pwn
socat tcp-l:10002,fork exec:"qemu-arm -g 1234 -L /usr/arm-linux-gnueabi ./pwn",reuseaddr
```
2. 系统级模拟
下载kernel:https://people.debian.org/~aurel32/qemu/armel/
    http://ftp.sjtu.edu.cn/sites/ftp.kernel.org/pub/linux/kernel/
```
sudo tunctl -t tap0 -u `whoami`
sudo ifconfig tap0 192.168.2.1/24
qemu-system-arm -M versatilepb -kernel vmlinuz-3.2.0-4-versatile -initrd initrd.img-3.2.0-4-versatile -hda debian_wheezy_armel_standard.qcow2 -append "root=/dev/sda1"  -net nic -net tap,ifname=tap0,script=no,downscript=no -nographic

```
## arm32
数据访问根据SCTLR寄存器的值决定大小端，取指一定是小端
r11保存ebp
pc寄存器存的是`当前指令位置+2*指令长度`,因为流水线。
r0~r3用来传递参数，无需恢复r0~r3储存内容
r0储存返回值：
如果是64位整数，可能会用到r1。
如果是浮点数，可以通过浮点运算部件的寄存器f0、d0或s0来返回。
如果是复合型浮点数（如复数）时，可以通过寄存器f0～fn或d0～dn来返回。
r4~r11保存局部变量，需要保存这些寄存器，r7用于系统调用号
r12用作过程调用中间临时寄存器，记作IP。在子程序之间的连接代码段中常常有这种使用规则。
r13用作栈指针，也叫SP，不能用于其他用途。SP在进入子程序和退出时必须相等
r14保存返回地址，也叫LR。它用于保存子程序的返回地址。
bx=call，bx指令同时切换到thumb模式，指令长度为2byte。原来为5byte
arm可以直接控制pc寄存器
`STMFD SP! ,{R0-R7，LR}`和`STMFD SP ,{R0-R7，LR}`区别：不加叹号，虽然会压栈，但SP的值不改变。
`LDMFD SP! ,{R0-R7，LR}`出栈操作。
mov指令只能作用于寄存器
## arm64
一共31个寄存器，在32位下叫做Wn。64位下叫做Xn。
SP，栈指针
R29=FP，栈基地址。
x0~x7传参，
x29保存ebp
x30寄存器保存返回地址，执行ret时将x30的值给pc。
某些情况下，返回值是通过X8返回的。
bl指令用于跳转，返回地址保存在x30中。
### LDM/STM
传送指令，LDM从内存到寄存器，STM从寄存器到内存。例如
```asm
STMDB  SP!, {R0-R3,  LR}  <-->  PUSH  {R0-R3, LR}     
LDMIA  SP!, {R0-R3,  PC}  <-->  POP  {R0-R3, PC}
```
STM和LDM都有不同的方向。I代表increase，地址增长，D代表decrease，地址减小。不仅如此，还区分Before和After，控制传送和增加地址的动作的先后顺序。
`STMDB`代表Decrease和Before。意味着先减少地址，再传送。

### 指令
在ARMv8中，LDM/STM被新一代的指令LDP(Load Pair)和STP(Store Pair)所取代了，LDM/STM对寄存器列表里包含的寄存器数量并没有什么限制，而LDP/STP要求和内存之间传送数据的寄存器不超过2个。

```asm
ldp x19, x20, [sp, #0x10]     从 sp+0x10 的位置读 0x10 字节，按顺序放入 x19, x20 寄存器
ldp x29, x30, [sp], #0x40      从 sp 的位置读 0x10 字节，按顺序放入 x29, x30 寄存器，然后 sp += 0x40
MOV X1, X0  寄存器X0的值传给X1
blr x3    跳转到由Xm目标寄存器指定的地址处，同时将下一条指令存放到X30寄存器中  
```
### 移位
逻辑左移/右移(LSL/LSR)，溢出的删除
ASR，算数右移，ARM仅有算数右移，么有算数左移。溢出的位进行循环。移动一位的结果相当于/2
