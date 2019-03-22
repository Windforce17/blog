## 函数指针
```c
char * (*fun1)(char * p1,char * p2);
char * *fun2(char * p1,char * p2);
char * fun3(char * p1,char * p2);
```

- fun3是函数，不用多说了。
- fun2也是函数，返回是char **
- fun1是一个变量，指向一个函数，有两个类型为char的参数，于`char* (*)(char *p1,char* p2)func1等价
  

```c
//这个是函数指针数组
char * (*pf[3])(char * p);
// 函数指针数组的指针,上面的指针
char * (*(*pf)[3])(char * p);
```