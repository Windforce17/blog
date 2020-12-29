## 字符扩展

- wchar*t 扩展字符集，cin 和 cout 将输入输出看作是 char 流，因此不适用处理 wchar* t 类型，通过前缀 L 指示宽字符常量和宽字符串。

\*c 和 c++对有效位数要求是，float 至少 32 位，double 至少是 48 位，切不少于 float。long

- double 至少和 double 一样多，这三种类型的有效位数可以一样多。通常 float 为 32 位，double 为 64 位，long double 为 80 96 128 位。这三种指数类型至少是-37 到 37，可以从 cfloat 或 float.h 找到系统的限制。

- wchar_t a[] = L"字符串”;
- char16_t a[] = u"字符串”;
- char32_t a[] = U"字符串";
- cout<<R“(原始字符串)”;
- c++11 结构可以用列表初始化;
- {}列表初始化，不允许缩窄，变量。
- （c++11）
- 关键字 auto 可以不指定变量的类型
- cin.getline(name,int);
- 读取一行的输入。丢弃换行符
- cin.get(name,int);读取一行，留下换行符。
- cin.get()读取单个字符；
- cin.clear();清除失效位（failbit）；
- 前缀 R 表示 raw 原始字符串，此时\n 不表示换行符；

结构数组初始化:

```cpp
    struct a;
    a b[2] =
    {  {"a",1,32.3}
    {...}
     };
```

## 列表初始化

类的初始化是根据定义的顺序，这样的代码会出错。

```cpp
struct foo
{
    int i ;
    int j ;
    foo(int x):j(x), i(j){} // i值未定义
};
```

## 类大小计算

下面的输出是多少?

```cpp
#pragma packed()
#include<iostream>
using namespace std;
class CTest
{
	public:
		CTest():m_chData('\0'),m_nData(0)
		{
		}
		virtual void mem_fun(){}
	private:
		char m_chData;
		int m_nData;
		static char s_chData;
}__attribute__((packed));

char CTest::s_chData='\0';
int main(){
  cout<<sizeof(CTest);
}
```

## gcc 编译

1. 使用 gcc 生成静态库及静态库使用方法：

在此例中，test.c 用于编译生成静态库 libtest.a，test.h 为 libtest.a 对应的头文件。

第一步：生成 test.o 目标文件，使用 gcc -c test.c -o test.o 命令。

第二步：使用 ar 将 test.o 打包成 libtest.a 静态库，使用 ar rcs -o libtest.a test.o 命令

第三步：生成 libtest.a 静态库后，可以使用命令 ar t libtest.a 查看 libtest.a 文件中包含哪些文件。

第四步：编译 main.c，并使用 libtest.a 静态库，链接时-l 参数后不加空格指定所需要链接的库，这里库名是 libtest.a，但是只需要给出-ltest 即可，ld 会以 libtest 作为库的实际名字。完整的命令为：gcc -o app_static main.c -L. -ltest 或者是 gcc -o app_static main.c libtest.a

第五步：运行 app_static

直接使用命令./app_static

2. 使用 gcc 生成动态库及使用动态库的方法
   //-fpie
   　　第一步：生成 test.o 目标文件，使用如下命令。在此处需要添加-fPIC 参数，该参数用于生成位置无关代码已工生成动态库使用，使用命令：gcc -c -o test.o -fPIC test.c

第二步：使用-shared 参数生成动态库，使用如下命令：gcc -shared -o libmyshare.so test.o,上述两个命令可以连在一起，如下所示：gcc -shared -fPIC -o libmyshare.so test.c

第三步：编译 main.c，使用 libmyshare.so 动态库，命令如下 gcc -o app_share main.c -L. -lmyshare.使用 ldd app_share 命令查看 app_share 使用动态库，如果 libmyshare 无法找到，直接执行 app_share 就会出现错误。解决方法：首先使用 export LD_LIBRARY_PATH=.:\$LD_LIBRARY_PATH 将当前目录加入 LD_LIBRARY_PATH 变量中。再次运行 ldd app_share

另一种编译 main.c，并链接 libmyshare.so 的方式如下（该方式通过./libmyshare.so 直接指定使用当前目录下的 libmyshare.so 文件），使用命令：gcc -o app_share main.c ./libmyshare.so

## 动态链接库
PIE和PIC之间的问题:https://www.ibm.com/developerworks/cn/linux/l-cn-sdlstatic/index.html
### c

```c
//导出函数接口，dll中可以调用
    _declspec(dllexport) void go() //export method,call in load
    {
        int a = 2;
    }
```

## 前向声明 forward declaration

前向声明是一种，不完全类型声明，所以他并不能取代完全类型，对于编译器来说，在需要知其被声明对象大小和内容时，前向声明，己不可用。故其应用场景，仅限如下：

- 1，声明引用和指针
- 2，作函数(仅声明)，的返回类型或是参数类型。

下面给出了一个应用场景： 
A.h

```cpp
#ifndef __A__H__
#define __A__H__

#include <string>
class B;  // here is the forward declaration

class A {
public:
  B getBfromA();
  std::string who_are_you();

};
#endif
```

B.h

```cpp
#ifndef __B__H__
#define __B__H__

#include <string>

class A;  // Here is the forward declaration

class B {
public:
  A getAfromB();
  std::string who_are_you();
};

#endif
```

A.cpp

```cpp
#include "A.h"
#include "B.h"

B A::getBfromA() {
  return B();
}

std::string A::who_are_you() {
  return "I am A";
}
```

B.cpp

```cpp
#include "B.h"
#include "A.h"

A B::getAfromB() {
  return A();
}
std::string B::who_are_you() {
  return "I am B";
}
```

main.cpp

```cpp
#include "A.h"
#include "B.h"

#include <iostream>

int main() {
  A a;
  B b;

  A ab = b.getAfromB();
  B ba = a.getBfromA();

  std::cout << "ab is: " << ab.who_are_you() << endl;
  std::cout << "ba is: " << ba.who_are_you() << endl;

  return 0;
}
```

## 右值引用(std::move())

如果学完了 rust 可能理解更深了,
[深入浅出 C++ 11 右值引用](https://www.zhihu.com/collection/262759047)

## 元编程

[浅谈 C++元编程](https://zhuanlan.zhihu.com/p/87917516)
