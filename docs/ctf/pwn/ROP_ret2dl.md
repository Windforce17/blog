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
使用`readelf -r bof` 可以看到这两个段的数据结构，省略了'.rel.dyn'的输出
```
Relocation section '.rel.plt' at offset 0x330 contains 5 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
0804a00c  00000107 R_386_JUMP_SLOT   00000000   setbuf@GLIBC_2.0
0804a010  00000207 R_386_JUMP_SLOT   00000000   read@GLIBC_2.0
0804a014  00000407 R_386_JUMP_SLOT   00000000   strlen@GLIBC_2.0
0804a018  00000507 R_386_JUMP_SLOT   00000000   __libc_start_main@GLIBC_2.0
0804a01c  00000607 R_386_JUMP_SLOT   00000000   write@GLIBC_2.0
```
