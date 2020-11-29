## license显示
在RVA=B24BC0的地方，IDA对QT优化的很棒。
![license](2019-08-27-00-41-23.png)

## check位置
在RVA=707870的地方，ida f5不了，参数计算的有问题，似乎是QT的信号槽机制。
![check](2019-08-27-01-03-53.png)

想办法patch这两个地方就可以了