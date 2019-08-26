## 工具
//TODO  
[wabt](https://github.com/WebAssembly/wabt/)

## 方法
先反编译`./wasm2c test.wasm -o test.c`
其实这个.c就能看了不过会耗费稍多一点时间，然后同样将wabt工具包里面wasm2c文件夹下`wasm-rt.h`，`wasm-rt-impl.c`，`wasm-rt-impl.h`三个文件放到和`test.c`同一个文件，然后编译，这里就不需要链接了，因为链接肯定通不过了，所以我们只需要得到未链接的文件即可：`gcc -c test.c -o test.o` 最后拖到ida里f5