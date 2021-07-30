## 工具
//TODO  
[wabt](https://github.com/WebAssembly/wabt/)
https://github.com/athre0z/wasm
https://anee.me/reversing-web-assembly-wasm-dd59eb2a52d4
https://medium.com/@pnfsoftware/reverse-engineering-webassembly-ed184a099931

## 方法
https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/instantiate
https://zhuanlan.zhihu.com/p/43986042
https://xz.aliyun.com/t/5170
https://www.52pojie.cn/thread-962068-1-1.html
先反编译`./wasm2c test.wasm -o test.c`
其实这个.c就能看了不过会耗费稍多一点时间，然后同样将wabt工具包里面wasm2c文件夹下`wasm-rt.h`，`wasm-rt-impl.c`，`wasm-rt-impl.h`三个文件放到和`test.c`同一个文件，然后编译，这里就不需要链接了，因为链接肯定通不过了，所以我们只需要得到未链接的文件即可：`gcc -c test.c -o test.o` 最后拖到ida里f5。
或者反编译到wat文件，然后再编译回去。注意，使用python开http server测试的时候可能会有cache，导致替换的webasm文件没有更新。