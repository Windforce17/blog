## 命令执行绕过

### 空格过滤

```sh
CMD=$'\x20a\x20b\x20c';echo$CMD
```
## 区别
1. eval
代码执行而不是命令执行
2. system
命令执行
3. popen
类似于创建进程，不会等待执行完成