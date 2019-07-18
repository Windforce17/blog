## 调用 scipy 计算排列组合的具体数值

```python
from scipy.special import comb, perm
# 排列
perm(3, 2)
6.0
# 组合 
comb(3, 2)
3.0
```

## 调用 itertools 获取排列组合的全部情况数

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