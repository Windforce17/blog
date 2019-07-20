## py反编译
[支持3.7, `pip install uncompyle`](https://github.com/rocky/python-uncompyle6)

https://rednaxelafx.iteye.com/blog/382423  
https://github.com/zrax/pycdc  
### 在线工具
https://wcf1987.iteye.com/blog/1672542

### 包
https://blog.csdn.net/zhongbeida_xue/article/details/79082174  
https://blog.csdn.net/chpllp/article/details/76254927 
https://wcf1987.iteye.com/blog/1672542  

### 查看字节码
```py
import opcode  
for op in range(len(opcode.opname)):  
  print('0x%.2X(%.3d): %s' % (op, op, opcode.opname[op])) 
```