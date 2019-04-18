# 使用Let's Encrypt 进行泛解析。
## acme.sh的方式
获取acme脚本如下，注意报错，安装依赖
- `apt install socat&&curl https://get.acme.sh | sh`

- `source ~/.bashrc`

不行就去.acme.sh/里面吧
## 使用dnspod api

下面是dddd.im的脚本。
```zsh
    export DP_Id="1111"  &&
    export DP_Key="xxxxx"  &&
    acme.sh --issue --dns dns_dp -d *.dddd.im -d dddd.im
    acme.sh  --installcert  -d  *.dddd.im   \
            --key-file   /usr/local/nginx/conf/ssl/dddd.im.key \
            --fullchain-file /usr/local/nginx/conf/ssl/dddd.im.cer \
            --reloadcmd  "nginx -s reload" 
```
## 使用webroot方式
```sh
acme.sh  --issue -d blog.lomot.cn  --webroot  /var/www/blog.lomot.cn/
```

## 开启自动更新
```sh
acme.sh --upgrade --auto-upgrade
acme.sh --renew -d '*.168seo.cn' --force
```