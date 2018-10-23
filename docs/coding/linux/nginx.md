## proxy_pass详解
在nginx中配置proxy_pass代理转发时，如果在proxy_pass后面的url加/，表示绝对根路径；如果没有/，表示相对路径，把匹配的路径部分也给代理走.

### http://192.168.1.1/proxy/test.html 
```conf
location /proxy/ {
    proxy_pass http://127.0.0.1/;
}
```
http://127.0.0.1/test.html
```conf
location /proxy/ {
    proxy_pass http://127.0.0.1;
}
```
http://127.0.0.1/proxy/test.html
```conf
location /proxy/ {
    proxy_pass http://127.0.0.1/aaa/;
}
```
http://127.0.0.1/aaa/test.html
```conf
location /proxy/ {
    proxy_pass http://127.0.0.1/aaa;
}
```
http://127.0.0.1/aaatest.html
