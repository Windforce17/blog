## 课程资料
https://gitee.com/ipads-lab/chcore-lab
https://www.cnmooc.org/portal/course/5610/14956.mooc
https://ipads.se.sjtu.edu.cn/mospi/
## 向量中断控制器
## GIC 通用中断控制器
中断类型多，将中断分发给不同的核（对称或非对称）
主要功能：
分发：管理所有中断、决定优先级、路由
CPU接口：给每个CPU核有对应的接口（物理）
### GIC中断来源
SPI：共享外围中断
- 可以被路由到一个或多个核，找到可用的核进行处理
- 如UART中断
- 中断id范围：32-1019
PPI：私有外围中断
- 指定核心处理
- 如watchdog->A5 core
- 中断ID：16-31
SGI：软件产生中断
- 核间通信
- 中断ID：0-15