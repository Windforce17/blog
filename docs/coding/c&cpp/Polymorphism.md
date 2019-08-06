## 为什么要用基类指针指向派生类对象
在基类与派生类之间，有一个规定：派生类对象的地址可以赋给指向基类对象的指针变量（简称基类指针），即基类指针也可以指向派生类对象。为什么有这一规定呢？因为它可以实现多态性【1】，即向不同的对象发送同一个消息，不同的对象在接受时会产生不同的行为。

### 举例

```cpp
#include <iostream>
using namespace std;
class Shape {
public:
    virtual double area() const = 0; //纯虚函数
};
 class Square : public Shape {
    double size;
public:
    Square(double s) {
        size = s;
    }
    virtual double area() const {
        return size * size;
    }
};
 
class Circle : public Shape {
    double radius;
public:
    Circle(double r) {
        radius = r;
    }
    virtual double area() const {
        return 3.14159 * radius * radius;
    }
};
 int main()
 {
     Shape* array[2]; //定义基类指针数组
     Square Sq(2.0);
     Circle Cir(1.0);
    array[0] = &Sq;
    array[1] =&Cir;
    for (int i = 0; i < 2; i++) /
    {
        cout << array[i]->area() << endl;
    }
    return 0;
}
```
### 解释
 上面的不同对象Sq,Cir(来自继承同一基类的不同派生类)接受同一消息（求面积，来自基类的成员函数area()）,但是却根据自身情况调用不同的面积公式（执行了不同的行为，它是通过虚函数实现的）。我们可以理解为，继承同一基类的不同派生对象，对来自基类的同一消息执行了不同的行为，这就是多态，它是通过继承和虚函数实现的。而接受同一消息的实现就是基于基类指针。

 [1]: C++支持两种形式的多态性。第一种是编译时的多态性，称为静态联编。第二种是运行时的多态性，也称为动态联编。运行时的多态性是指必须在运行中才可以确定的多态性，是通过继承和虚函数来实现的。


## 一些库
`libffi` 动态调用&定义C函数