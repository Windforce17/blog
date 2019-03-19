## gdb-peda
`vmmap`
查看process mapping信息，得到每个地址的权限
`find` 在内存中搜索字符串，还有一种方法，`cat /proc/{pid}/maps` 
本地调试的时候利用gdb绕过ALSR:`ncat -vc 'gdbserver 127.0.0.1:5000 ./pwn1' -kl 127.0.0.1 4000`
## readelf、objdump
使用`readelf -a /lib32/libc.so.6 |grep '__libc_start_main'`查找libc中的函数地址

`objdump -d -M intel [elf_file]` 进行反汇编elf文件

## pwntools
### 运行时变量
```py
context.log_level = 'debug'
context.arch      = 'i386' # 32 bit
context.arch      = 'amd64'# 64 bit
context.os        = 'linux'
context.endian    = 'little'
context.word_size = 32
```

### 连接
sh = porcess("./level0")
sh = remote("127.0.0.1",10001)
sh.close()  
### IO

```py
sh.send(data)  #发送数据
sh.sendline(data)  #发送一行数据，相当于在数据后面加
sh.recv(numb = 2048, timeout = dufault) # 接受数据，numb指定接收的字节，timeout指定超时
sh.recvline(keepends=True)  #接受一行数据，keepends为是否保留行尾的
sh.recvuntil("Hello,World\n",drop=fasle) # 接受数据直到我们设置的标志出现
sh.recvall() # 一直接收直到EOF
sh.recvrepeat(timeout = default)  #持续接受直到EOF或timeout
sh.interactive() # 直接进行交互，相当于回到shell的模式，在取得shell之后使用
```
###  汇编和反汇编

```py
asm('nop')
asm('nop',arch='arm')
disasm('6a0258cd80ebf9'.decode('hex'))
```

### ELF

```py
e = ELF('/bin/cat')
print hex(e.address)  # 文件装载的基地址
print hex(e.symbols['write']) # 函数地址
print hex(e.got['write']) # GOT表的地址
print hex(e.plt['write']) # PLT的地址
print hex(e.search('/bin/sh').next())# 字符串/bin/sh的地
```

### ROP

```py
elf = ELF('ropasaurusrex')
rop = ROP(elf)
rop.read(0, elf.bss(0x80))
rop.dump()
str(rop)
```

### shellcraft
shellcode=asm(shellcraft.sh())

## 有用的站
libc databases:http://libcdb.com
系统调用表：http://syscalls.kernelgrok.com/

## dockerfile
运行的时候需要赋予相应的权限：`--cap-add=SYS_PTRACE --security-opt seccomp=unconfined`,或者直接给root，`--privileged`
```dockerfile
# ubuntu 18.04
FROM ubuntu:18.04
RUN echo ' deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse \n \
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse \n \ 
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse \n \
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse \n '> /etc/apt/sources.list
RUN apt update && \
    apt install -y vim python python3 python-pip\
    python-dev python3-dev python-pip python3-pip libglib2.0-dev libc6-dbg \
    build-essential libc6-dev-i386 \
    gcc-multilib g++-multilib git
WORKDIR /
RUN echo 'LANG=en_US.UTF-8 \n \
LANGUAGE="en_US.UTF-8" \n \
LC_ALL="en_US.UTF-8"\n '>/etc/default/locale
# RUN git clone https://github.com/pwndbg/pwndbg \
    # && cd pwndbg \
    # && ./setup.sh \
COPY ./pwndbg pwndbg
RUN mkdir ctf \
    && pip install  -i https://pypi.tuna.tsinghua.edu.cn/simple pwntools \
    && cd pwndbg \
    && ./setup.sh \
    apt clean 
WORKDIR /ctf
```

```dockerfile
# ubuntu 18.04
FROM ubuntu:16.04
RUN echo ' deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse \n \
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse \n \ 
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse \n \
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse \n '> /etc/apt/sources.list
RUN apt update && \
    apt install -y vim python python3 python-pip\
    python-dev python3-dev python-pip python3-pip libglib2.0-dev libc6-dbg \
    build-essential libc6-dev-i386 \
    gcc-multilib g++-multilib git
RUN echo 'LANG=en_US.UTF-8 \n \
LANGUAGE="en_US.UTF-8" \n \
LC_ALL="en_US.UTF-8"\n '>/etc/default/locale
WORKDIR /
# ENV LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8
# RUN git clone https://github.com/pwndbg/pwndbg \
    # && cd pwndbg \
    # && ./setup.sh \
COPY ./pwndbg pwndbg
RUN mkdir ctf \
    && pip install  -i https://pypi.tuna.tsinghua.edu.cn/simple pwntools \
    && cd pwndbg \
    && ./setup.sh \
    apt clean 
WORKDIR /ctf
```