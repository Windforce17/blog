
## Scanner

1. 导入java.util.Scanner
2. 创建Scanner对象
3. 接受并保存用户输入的值  

```java
    import java.util.Scanner
    Scanner input=new Scanner(System.in);
    score=input.next……()
    input.next();//读入一个单词,标志是的空格
    in.nextLine();//读入一整行
    println //输出信息后进行换行，print不会
```
final:
     修饰类,不允许被继承;
     修饰方法,不允许重写;
     修饰属性,不会进行隐式初始化(类的初始化属性必有值),或在构造方法中赋值;
     变量->常量;
`super()`,调用父类构造方法
`super.xxx()`,调用父类的方法
`.getClass()` 返回类的信息,
多态:
     通过父类的引用,不能调用子类的方法;
      用instanceof解决强制转换的安全性问题;
抽象类:
     约束子类有哪些方法,
     包含抽象方法的类是抽象类;
     抽象类不能直接创建,可以定义引用变量
     抽象方法没有方法体;
接口:
     全局常量,公共方法组成;
      修饰符  inerface 接口名extends 父接口1,父接口2....implements 接口1,接口2
`Math.random()`//0-1随机
`Math.round(double)`//四舍五入
`import java.util.Arrays`;//导入Arrays类
字符串:  

```java
     //所有字符串对象都是指针,
     string a;
     string b=a;//把a地址给b,共同管理一个字符串;
     s1.cahrAt(int)//访问单个字符;
     s.substring(n)//得到从n号位置到末尾的全部内容
     s.substring(b,e)//得到从b号位置到e号位置!之前!的内容;
     s.indexOf('c',a)//从a寻找字符串,字符c,返回位置,从左向右
     s.toUpperCase()//转换为大写
     s.trim//去除两边空格
     可以用字符串做switch-case
     String[] hobbys = { "sports", "game", "movie" };
              System.out.println("循环输出数组中元素的值：");

              // 使用循环遍历数组中的元素
              for(String i:hobbys)
        {
           System.out.println(i);
        }
```
static
       静态方法中可以直接调用同类中的静态成员，但不能直接调用非静态成员.

## gradle
### 设置全局代理
`.gradle`目录下创建一个gradle.properties文件 加入
```conf
systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=1080
systemProp.https.nonProxyHosts=10.*|localhost


systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=1080
systemProp.https.nonProxyHosts=10.*|localhost
```