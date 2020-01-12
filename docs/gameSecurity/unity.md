## 逆向和调试

使用dnspy可以调试。release版本需要修改文件 mono.dll/mono-2.0-bdwgc.dll,也可以转换为debug版。
1. 右键exe属性拿到版本号
2. 找到两个dll位置：
``` 
<root> \ <GAME> _Data \ Mono \ mono.dll <root> \ <GAME> _Data \ Mono \ EmbedRuntime \ mono.dll <root> \ <GAME> _Data \ MonoBleedingEdge \  EmbedRuntime \ mono-2.0-bdwgc.dll <root> \ Mono \ EmbedRuntime \ mono.dll <root> \ MonoBleedingEdge \ EmbedRuntime \ mono-2.0bdwgc.dll
```
3. patch dll :https://github.com/0xd4d/dnSpy/releases
4. debug->start debugging并选择Unity debug engine