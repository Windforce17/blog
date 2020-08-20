## 排列组合
### scipy 计算排列组合的具体数值

```python
from scipy.special import comb, perm
# 排列
perm(3, 2)
6.0
# 组合 
comb(3, 2)
3.0
```

### itertools 获取排列组合的全部情况数

```python

    from itertools import combinations, permutations
    permutations([1, 2, 3], 2)
    <itertools.permutations at 0x7febfd880fc0>
                    # 可迭代对象
    list(permutations([1, 2, 3], 2))
    [(1, 2), (1, 3), (2, 1), (2, 3), (3, 1), (3, 2)]

    list(combinations([1, 2, 3], 2))
    [(1, 2), (1, 3), (2, 3)]
```
## numpy

1. 矩阵求逆
```py
import numpy as np

a  = np.array([[1, 2], [3, 4]])  # 初始化一个非奇异矩阵(数组)
print(np.linalg.inv(a))  # 对应于MATLAB中 inv() 函数

# 矩阵对象可以通过 .I 更方便的求逆
A = np.matrix(a)
print(A.I)
```
2. 求广义逆
```py
import numpy as np

# 定义一个奇异阵 A
A = np.zeros((4, 4))
A[0, -1] = 1
A[-1, 0] = -1
A = np.matrix(A)
print(A)
# print(A.I)  将报错，矩阵 A 为奇异矩阵，不可逆
print(np.linalg.pinv(a))   # 求矩阵 A 的伪逆（广义逆矩阵），对应于MATLAB中 pinv() 函数
```

3. 小数转换为分数

使矩阵里的小数转为分数
```py
import fractions
np.set_printoptions(formatter={'all':lambda x: str(fractions.Fraction(x).limit_denominator())})
print(A_inv)
```

## sage 中常用操作
1. 求逆元
```py
inv=inverse_mod(30,1373)
print(30*inv%1373)
#1
```
2. 扩展的欧几里得算法
```py
d,u,v=xgcd(20,30)
#d:10 u:-1 v:1
```
3. 求离散对数
```py
# 2**x mod 23==13
x=discrete_log(mod(13,23),mod(2,23))
#或discrete_log(13,mod(2,23))
print(x)
```

4. 求摸根
```py
# x**22==5 mod 41
x=mod(5,41)
r=x.nth_root(22)
```

5. 欧拉函数
```py
print(euler_phi(71)) 
#70
```

6. 讲表达式转换为近似值
```py
result=pi^2
result.numerical_approx()
```

7. 素数分布pi(x)
```py
result=prime_pi(1000)/(1000/log(1000))
result.numerical_approx() #1.16050288686900
```

8. 在整数域中的椭圆曲线
```py
# 输出所有点
a4=2;a6=3;F=GF(7);
E=EllipticCurve(F,[0,0,0,a4,a6])
print(E.cardinality()) #6
print(E.points()) #[(0 : 1 : 0), (2 : 1 : 1), (2 : 6 : 1), (3 : 1 : 1), (3 : 6 : 1), (6 : 0 : 1)]
```

9. 创建点
```py
point1=E([2,1])
point2=E([3,6])
print(point1+point2)#(6 : 0 : 1)
print(point1-point2)#(2 : 6 : 1)
```