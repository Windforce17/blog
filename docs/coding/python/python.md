# 各种小玩意
## 查看当前环境

```python
import sys
print('\n'.join(sys.path))
```


## Mac OS X 上如何切换默认的 Python 版本
https://www.zhihu.com/question/30941329

## shellcode检测
pylibemu
## 各种库
1. distorm3 反编译引擎 pip安装
## pyv8
js处理，google出品，macos安装

[](https://github.com/emmetio/pyv8-binaries/)

```bash
cd pyv8 //进入解压后的目录
sudo cp * /Library/Python/2.7/site-packages/
/usr/local/lib/python3.6/site-packages
```

## libemu
shellcode 检测工具  preepdf依赖之一
https://github.com/buffer/libemu
aclocal
autoreconf -v -i
./configure --prefix=/opt/libemu;  
sudo make install
pip3 install pylibemu