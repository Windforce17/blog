## 要复习的
进程和线程的区别和其使用等
智能指针
中序遍历的非递归写法
多线程的同步方法和如何使用
    - 锁- 中断- 信号量- 原子操作- ..
进程间通信的方法，还有它和socket通信的相同和不同点在哪儿
管道- 消息- 共享文件-unix:///.sock
linux的进程间通信和windows
malloc和alloc的区别
vector何时进行空间的搬运
大批量对象的搬运进行了怎样的优化
placement new 和operator new的不同表现
要vector的新空间为2倍
操作系统的页和操作系统对进程的内存分配方式还有段页的情况
```cpp
//运行结果
class A {
public: void f1() {} virtual void  f2() {} } A* a = nullptr; a->f1(); a->f2();
```
拥塞避免算法、操作系统的LRU、如何对反爬虫机制进行破解、判断一棵二叉树是不是二叉搜索树、嵌套数组的环形遍历、乐观锁和悲观锁有啥区别、求二叉树是否存在和为N的路径、针对每个连接维护一个线程，开销很大，如何优化、有一个单链表，奇数位是升序的，偶数位是降序的，要求进行给它进行排序1->200->10->120->30->8->88->4、中断实现机制，软硬中断的区别、redis线程模型、topk问题、聚集索引，非聚集索引、http2
### 将一棵二叉搜索树转换成双向链表
https://blog.csdn.net/zengzhen_csdn/article/details/51198530
### 红黑树
https://www.jianshu.com/p/0b68b992f688
## 安天

1. 常见的数据结构都有哪些，set的实现原理
2. 静态分析工具的使用
3. 样本分析


## 头条 安全
1. Linux基本命令、xargs，mysql花式索引，https，证书、输入url点击后背后发生的事，同源策略，xss，csrf，tcp/ip，arp、icmp、go语言数组和slice区别与坑

## 360企业安全
sql注入类型，判断注入，原理，手写payload，防护，上传所有绕过方法，原理，逻辑漏洞，XSS绕过技巧，防护，Java三大框架，序列化/反序列化，OSI七层，sqlmap各种命令，https注入参数，payload回显参数，nmap扫描存活，waf绕过，双编码绕过，nmap原理，