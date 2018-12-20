## 安装
```sh
apt install libssl-dev
apt install libpcre3-dev
apt-get install zlib1g-dev
./configure  --prefix=/usr/local/nginx  --sbin-path=/usr/local/nginx/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log   --user=www --group=www --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_gzip_static_module --with-http_v2_module --with-pcre --add-module=../ngx_http_google_filter_module --add-module=../ngx_http_substitutions_filter_module
```
## proxy_pass详解
在nginx中配置proxy_pass代理转发时，如果在proxy_pass后面的url加/，表示绝对根路径；如果没有/，表示相对路径，把匹配的路径部分也给代理走.

### 'http://192.168.1.1/proxy/test.html'
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


## google镜像站
https://github.com/cuber/ngx_http_google_filter_module/tree/dev