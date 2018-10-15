# pwntools



## 运行时变量
```py
context.log_level = 'debug'
context.arch      = 'i386'
context.os        = 'linux'
context.endian    = 'little'
context.word_size = 32
```

## 连接
sh = porcess("./level0")
sh = remote("127.0.0.1",10001)
sh.close()  
## IO

```py
sh.send(data)  发送数据
sh.sendline(data)  发送一行数据，相当于在数据后面加\n
sh.recv(numb = 2048, timeout = dufault)  接受数据，numb指定接收的字节，timeout指定超时
sh.recvline(keepends=True)  接受一行数据，keepends为是否保留行尾的\n
sh.recvuntil("Hello,World\n",drop=fasle)  接受数据直到我们设置的标志出现
sh.recvall()  一直接收直到EOF
sh.recvrepeat(timeout = default)  持续接受直到EOF或timeout
sh.interactive()  直接进行交互，相当于回到shell的模式，在取得shell之后使用
```
##  汇编和反汇编

```py
asm('nop')
asm('nop',arch='arm')
disasm('6a0258cd80ebf9'.decode('hex'))
```

## ELF

```py
e = ELF('/bin/cat')
print hex(e.address)  # 文件装载的基地址
print hex(e.symbols['write']) # 函数地址
print hex(e.got['write']) # GOT表的地址
print hex(e.plt['write']) # PLT的地址
print hex(e.search('/bin/sh').next())# 字符串/bin/sh的地
```

## ROP

```py
elf = ELF('ropasaurusrex')
rop = ROP(elf)
rop.read(0, elf.bss(0x80))
rop.dump()
str(rop)
```