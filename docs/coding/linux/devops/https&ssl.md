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
    acme.sh --issue --dns dns_dp -d *.cugapp.com
    acme.sh  --installcert  -d  *.cugapp.com   \
            --key-file   /usr/local/nginx/conf/ssl/cugapp.com.key \
            --fullchain-file /usr/local/nginx/conf/ssl/cugapp.com.cer \
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

# 下面是一些OpenSSL的东西
转载:https://www.jianshu.com/p/bc18038cc9c8
crt和cer是一个东西
```bash
# 转换为perm文件
openssl pkcs12 -in xxx.pfx -nodes -out xxx.pem 
openssl x509 -inform der -in xxx.cer -out xxx.pem

# 提取密钥对，生成打文件可以给nginx用了，不过提取需要密码
openssl pkcs12 -in xxx.pfx -clcerts -nokeys -out xxx.crt
openssl pkcs12 -in xxx.pfx -nocerts -nodes -out xxx.key
# 验证一下
openssl s_server -www -accept 443 -cert xxx.crt -key xxx.key

# 从密钥提取私钥 头部 -----BEGIN RSA PUBLIC KEY-----
openssl rsa -in  xxx.key -out private.pem
# 从密钥对提取公钥 头部：-----BEGIN RSA PRIVATE KEY-----
openssl rsa -in private.pem -RSAPublicKey_out -out public.pem
# 从密钥对提取公钥 头部：-----BEGIN PUBLIC KEY-----
openssl rsa -in private.key -pubout -out public.key
```
python相关代码
```py
import rsa

# 生成密钥
(pubkey, privkey) = rsa.newkeys(1024)

# 保存密钥
with open('public.pem', 'w+') as f:
    f.write(pubkey.save_pkcs1().decode())

with open('private.pem', 'w+') as f:
    f.write(privkey.save_pkcs1().decode())

# 导入密钥
with open('public.pem', 'r') as f:
    pubkey = rsa.PublicKey.load_pkcs1(f.read().encode())

with open('private.pem', 'r') as f:
    privkey = rsa.PrivateKey.load_pkcs1(f.read().encode())

    # 明文
    message = '123123ssss'

    # 公钥加密
    crypto = rsa.encrypt(message.encode(), pubkey)
    # print(crypto)

    # 私钥解密
    message = rsa.decrypt(crypto, privkey).decode()
    print(message)
```
