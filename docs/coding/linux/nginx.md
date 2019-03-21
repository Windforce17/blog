## 安装
```sh
apt install libssl-dev
apt install libpcre3-dev
apt-get install zlib1g-dev
./configure  --prefix=/usr/local/nginx  --sbin-path=/usr/local/nginx/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log   --user=www --group=www --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_gzip_static_module --with-http_v2_module --with-pcre --add-module=../ngx_http_google_filter_module --add-module=../ngx_http_substitutions_filter_module
```

## 常用的配置
```conf
# https+proxy_pass
server {
  listen 80;
  listen 443 ssl http2;
  ssl_certificate /usr/local/nginx/conf/ssl/cugapp.com.cer;
  ssl_certificate_key /usr/local/nginx/conf/ssl/cugapp.com.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
  ssl_ciphers TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
  ssl_prefer_server_ciphers on;
  ssl_session_timeout 10m;
  ssl_session_cache builtin:1000 shared:SSL:10m;
  ssl_buffer_size 1400;
  add_header Strict-Transport-Security max-age=15768000;
  ssl_stapling on;
  ssl_stapling_verify on;
  server_name gitlab.cugapp.com;
  access_log /data/wwwlogs/gitlab.cugapp.com_nginx.log combined;
  index index.html index.htm index.php;
  root /data/wwwroot/gitlab.cugapp.com;
#  if ($ssl_protocol = "") { return 301 https://$host$request_uri; }

  include /usr/local/nginx/conf/rewrite/none.conf;
  #error_page 404 /404.html;
  #error_page 502 /502.html;
  location / {
    proxy_pass http://gitlab.cugapp.com:3000;
    include proxy.conf;
  }
  location ~ /\.ht {
    deny all;
  }
}
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