记录一些ida api的技巧
## 获得范围内数据
```py
buf = idaapi.get_many_bytes(start, end)
buf.encode('hex')
```
转为C数组
```py
buf = idaapi.get_many_bytes(start, end)
buf = buf.encode('hex')
two_hex_char_seq = map(operator.add, buf[::2], buf[1::2])
c_array = "{0x" + ", 0x".join(two_hex_char_seq) + "}"
```

##插件
golang逆向：https://github.com/sibears/IDAGolangHelper