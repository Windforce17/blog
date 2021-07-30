# re
## Hello,RE!
IDA F5 或者直接查找string

## ReadAsm2
看汇编代码
```py
input=[0x67, 0x6e, 0x62, 0x63, 0x7e, 0x74, 0x62, 0x69, 0x6d,
                  0x55, 0x6a, 0x7f, 0x60, 0x51, 0x66, 0x63, 0x4e, 0x66, 0x7b,
                  0x71, 0x4a, 0x74, 0x76, 0x6b, 0x70, 0x79, 0x66 , 0x1c]
i=1
for x in input:
    print(chr(x^i),end='')
    i=i+1
```

## dypyc
```py
import base64

def encode(message):
    s = ''
    for i in message:
        x = ord(i) ^ 32
        x = x + 16
        s += chr(x)
    return base64.b64encode(s)


def decode(message):
    s=''
    message=base64.b64decode(message)
    for i in message:
        s+=chr((i-16)^32)
    print(s)
    
correct = 'XlNkVmtUI1MgXWBZXCFeKY+AaXNt'
decode(correct)
```

### WxyVM
就是一个小型虚拟机，但是注意int和char的大小，input的是int，所以结果要&0xff
```py
i=14997
encrypt=[
  4294967236,52,34,4294967217,4294967251,17,4294967191,7,4294967259,55,4294967236,6,29,4294967292,91,4294967277,4294967192,4294967263,4294967188,4294967256,4294967219,4294967172,4294967244,8]

byte_code=[]# dump  from ida，too long

while(i>=0):
    v0=byte_code[i]
    result=byte_code[i+1]
    v3=byte_code[i+2]
    if(byte_code[i]==1):
        encrypt[result]-=v3
    if(byte_code[i]==2):
        encrypt[result]+=v3
    if(byte_code[i]==3):
        encrypt[result]^=v3
    if(byte_code[i]==4):
        encrypt[result]/=v3
        print(encrypt[result])
    if(byte_code[i]==5):
        encrypt[result]^=encrypt[v3]
    i=i-3
for x in encrypt:
    print(chr(x&0xff),end='')
```

## single
就是一个数独，不过注意输入格式，已经存在的数用0代替
```
0  3  0  6  0  0  0  0  0
6  0  0  0  3  2  4  9  0
0  9  0  1  0  7  0  6  0
7  4  6  0  0  0  0  0  0
0  1  8  0  0  0  6  3  0
0  0  0  0  0  0  1  4  7
0  8  0  9  0  4  0  7  0
0  7  4  2  1  0  0  0  6
0  0  0  0  0  3  0  1  0
```
```c
size_t __fastcall sub_40078B(const char *input, char *table)
{
  size_t result; // rax
  int i; // [rsp+1Ch] [rbp-14h]

  for ( i = 0; ; ++i )
  {
    result = strlen(input);
    if ( i >= result )
      break;
    if ( input[i] != '0' )
    {
      if ( !input[i] || table[i] ) //must false, table[i]==0 or input[i]='0'
        quit();
      table[i] = input[i] - '0';
    }
  }
  return result;
}
```

### 480 C++
看那480个函数，简单的xor
```py
#!/usr/bin/env python
key=[]
for i in range(1,481):
	n=str(i)
	key.append(n.zfill(3)*3)
final="bdacsN4jo`q_g<n[Eaw|3vWc[x1q{_tDuw)}"
flag=final
flag1=list(flag)
for i in range(479,-1,-1):
	a=key[i]
	for j in range(36):
			s=ord(flag1[j])
			s^=ord(a[j%9])^j
			flag1[j]=chr(s)
flag=''.join(flag1)
print flag
```
flag{N0body_c4n_Mast3r_c_p1us_pLus!}