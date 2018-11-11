## 第二章

### 请求方法

1. HEAD
    可以测试超文本链接的有效性，可访问性和最近的改变，不返回消息主题
2. PUT  
    put方法可以上传文件
    请求正文如下：
        PUT/input.txt
        HOST：www.xxx.com
        Content-Length：6

        //空一行表示响应头结束
        123456  

### 请求头

1. `Referer` 代表访问改URL上一个URL
2. `Range`可以请求实体的部分内容,多线程下载一定会用到
3. `Accept`请求报头域用于指定客户端接收哪些`MIME`类型信息,Accept: text/html表示希望客户端接受html文本
4. `Accept-Charset` 指定用户接受的字符集，例如:  
    `Accept-Charset`:gb2312  

### 响应头

1. `server` 服务器使用的 web服务器名称，管理员可以修改
2. `Set-Cookie` 向客户端发送cookie信息
3. `Refresh` 告诉浏览器定时刷新

*Fiddler*也可以拦截数据包信息，一键设置拦截HTTPS
x5s快速定位xss漏洞
*WinSock Expert* 可以监听任意进程，但是不能https协议

## 第三章

### Google hack常用搜索语法:

`site` 指定域名 *子域名收集*  
`intext` 正文关键字 *特定版本* 
`intitle` 标题关键字 *后台*  
`inurl` url关键字
`filetype` 文件类型
