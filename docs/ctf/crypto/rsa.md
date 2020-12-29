## RSA
这个加密算法也可以在多项式环上定义，本文先简单讨论最基础的内容和相关攻击方法。
https://www.cnblogs.com/crfshadow/p/14043770.html#_label3
https://github.com/pcw109550/write-up/tree/master/2019/KAPO/Lenstra-Lenstra-Lovasz
https://xz.aliyun.com/t/2731#toc-21
https://crypto.stackovernet.xyz/cn/q/7012
https://github.com/mimoo/RSA-and-LLL-attacks#boneh-durfee
https://lazzzaro.github.io/2020/05/06/crypto-RSA/
https://www.jianshu.com/p/5ef3284ca1b4
https://blog.csdn.net/qq_42939527/article/details/105202716
https://www.mscto.com/python/603282.html
https://zhuanlan.zhihu.com/p/76228394
https://blog.csdn.net/hiahiachang/article/details/109749551
https://blog.csdn.net/jcbx_/article/details/110182640
### 公钥、私钥

https://blog.csdn.net/qq_31481187/article/details/70448108
https://www.freebuf.com/column/148898.html
https://www.jianshu.com/p/9b44512d898f


## 工具
openssl,rsatool,RsaCtfTool,RSAtool...

### rsa各种证书格式
1. PKCS#1私钥格式文件
```
-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----
```
2. PKCS#8私钥格式文件
```
-----BEGIN PRIVATE KEY-----
-----END PRIVATE KEY-----
```

3. PEM公钥格式文件
```
-----BEGIN PUBLIC KEY-----
-----END PUBLIC KEY-----
```

4. PEM RSAPublicKey公钥格式文件
```
-----BEGIN RSA PUBLIC KEY-----
-----END RSA PUBLIC KEY-----
```
### openssl

1. 生成PKCS#1格式的证书，含有公钥和私钥
```sh
# 后面是长度
openssl genrsa -out rsa_prikey.pem 1024
```

2. 转换为PKCS#8格式
```sh
openssl pkcs8 -topk8 -inform PEM -in rsa_prikey.pem -outform PEM -nocrypt -out prikey.pem 
```

3. 由私钥生成公钥
```sh
openssl rsa -in rsa_prikey.pem -pubout -out pubkey.pem
```

4. 提取PEM RSAPublicKey格式公钥
```sh
openssl rsa -in key.pem -RSAPublicKey_out -out pubkey.pem
```

5. 公钥加密文件
```sh
openssl rsautl -encrypt -in input.file -inkey pubkey.pem -pubin -out output.file
```

6. 私钥解密文件
```sh
openssl rsautl -decrypt -in input.file -inkey key.pem -out output.file
```

### rsatool
这个工具是讲数字(n,e,d)转化为pem文件的
安装：
```sh
git clone https://github.com/ius/rsatool.git
python rsatool.py
```

根据n d直接生成私钥，含有N分解后的p和q
```sh
python rsatool.py -f PEM -o key.pem -n 13826123222358393307 -d 9793706120266356337

```

生成der格式的私钥
```sh
python rsatool.py -f DER -o key.der -p 4184799299 -q 3303891593
```


### RsaCtfTool 
比较 强大的工具，但是并不能代替前面两个
`git clone https://github.com/Ganapati/RsaCtfTool.git`,安装方法阅读readme

1. 已知公钥，自动分解N
```sh
#解密文件
python RsaCtfTool.py --publickey pubfile --uncipherfile cryptofile
# 得到私钥
python RsaCtfTool.py --publickey pubfile --private
```

2. 从PEM提取N和E 或者私钥
```sh
python RsaCtfTool.py --dumpkey --key pubfile
```

3. 将n和e转换为pem文件
``` shs
python RsaCtfTool.py --createpub -n 782837482376192871287312987398172312837182 -e 65537
```

### yafu
功能挺多，大多数用来分解大整数
直接`yafu factor(233333)` 即可，数字太大可以写到我文件里，然后执行`yafu "factor(@)" -batchfile 1.txt`，文件最后要换行，执行后文件被删除。w