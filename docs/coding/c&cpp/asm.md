## 关于汇编一些琐碎的知识
- 使用`nasm [sourcecode] -o [target] -felf32`编译一个汇编文件 

## 字符串计数
- edi:存放字符串
- al：存放字符x
- repne scas byte ptr es:[edi] ：遍历字符串，每循环一次ecx-1，遇到字符x则停止
  
```c
#include<stdio.h>

int main()
{
    char str[] = "123456789";
    int strCount=0;
    int c = 0;
    _asm
    {
        lea edi,str
        mov ecx,0xFFFFFFFF
        xor al,al
        repne scas byte ptr es:[esi]
        mov eax,0xFFFFFFFE
        sub eax,ecx
        mov c,ecx

        mov strCount,eax
    }
    printf("ecx=%d  count = %d",c,strCount);
    return 0;
}
```


## 傻逼AT&T
```asm
at&t                             intel
movl -4(%ebp, %edx, 4), %eax     mov eax, [ebp-4+edx*4]
movl -4(%ebp), %eax              mov eax, [ebp-4]
movl (%ecx), %edx                mov edx, [ecx]
leal 8(,%eax,4), %eax            lea eax, [eax*4+8]
leal (%eax,%eax,2), %eax         lea eax, [eax*2+eax]

```