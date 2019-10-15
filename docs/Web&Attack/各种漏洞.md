##  各种漏洞

### OWASP 
1. SQL注入防护方法：
2. 失效的身份认证和会话管理
3. 跨站脚本攻击XSS
4. 直接引用不安全的对象
5. 安全配置错误
6. 敏感信息泄露
7. 缺少功能级的访问控制
8. 跨站请求伪造CSRF
9. 使用含有已知漏洞的组件
10. 未验证的重定向和转发

### web扫描器
- https://github.com/1120362990/vulnerability-list
- https://github.com/ysrc/xunfeng
- https://github.com/1N3/Sn1per
- wmap
- OpenVAS
- nessus
### 逻辑漏洞
![任意用户注册](4%20各种漏洞/2018-02-06-13-27-00.png)
![任意支付密码修改](4%20各种漏洞/2018-02-06-13-29-30.png)


## 上传漏洞
直接fuzz吧： https://github.com/c0ny1/upload-fuzz-dic-builder



## win下的通配符
`http://localhost:9000/upload/self_include.php?c=../tmp/php<<`  
`<<`相当于*

## kindeditor 
目录遍历: `/kindeditor/php/file_manager_json.php?path=../../../../tmp/`

4.1.7：泄漏路径问题，漏洞根源位于/php/file_manager_json.php。

## FCKeditor
截断，改文件名，突破目录上传  
Todo:
https://blog.csdn.net/lizhengnanhua/article/details/38451737
## eWebEditor 2.8 5.5