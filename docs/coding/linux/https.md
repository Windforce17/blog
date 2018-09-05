# 使用Let's Encrypt 进行泛解析。
## acme.sh的方式
获取acme脚本如下，注意报错，安装依赖
- `curl https://get.acme.sh | sh`

- `source ~/.bashrc`

不行就去.acme.sh/里面吧
## 获取证书

下面是dddd.im的脚本。
```zsh
    export DP_Id="1111"  &&
    export DP_Key="xxxxx"  &&
    acme.sh --issue --dns dns_dp -d *.dddd.im -d dddd.im
    # sed -i '4,5c ssl_certificate /usr/local/nginx/conf/ssl/cugapp.com.cer;\
    # ssl_certificate_key /usr/local/nginx/conf/ssl/cugapp.com.key;' ./*.cugapp* &&
    ./acme.sh  --installcert  -d  *.dddd.im   \
            --key-file   /usr/local/nginx/conf/ssl/dddd.im.key \
            --fullchain-file /usr/local/nginx/conf/ssl/dddd.im.cer \
            --reloadcmd  "nginx -s reload" 
```
