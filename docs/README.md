## Material color palette 颜色主题

### Primary colors 主色

> 默认 `white`

点击色块可更换主题的主色

<button data-md-color-primary="red">Red</button>
<button data-md-color-primary="pink">Pink</button>
<button data-md-color-primary="purple">Purple</button>
<button data-md-color-primary="deep-purple">Deep Purple</button>
<button data-md-color-primary="indigo">Indigo</button>
<button data-md-color-primary="blue">Blue</button>
<button data-md-color-primary="light-blue">Light Blue</button>
<button data-md-color-primary="cyan">Cyan</button>
<button data-md-color-primary="teal">Teal</button>
<button data-md-color-primary="green">Green</button>
<button data-md-color-primary="light-green">Light Green</button>
<button data-md-color-primary="lime">Lime</button>
<button data-md-color-primary="yellow">Yellow</button>
<button data-md-color-primary="amber">Amber</button>
<button data-md-color-primary="orange">Orange</button>
<button data-md-color-primary="deep-orange">Deep Orange</button>
<button data-md-color-primary="brown">Brown</button>
<button data-md-color-primary="grey">Grey</button>
<button data-md-color-primary="blue-grey">Blue Grey</button>
<button data-md-color-primary="white">White</button>

<script>
  var buttons = document.querySelectorAll("button[data-md-color-primary]");
  Array.prototype.forEach.call(buttons, function(button) {
    button.addEventListener("click", function() {
      document.body.dataset.mdColorPrimary = this.dataset.mdColorPrimary;
      localStorage.setItem("data-md-color-primary",this.dataset.mdColorPrimary);
    })
  })
</script>

### Accent colors 辅助色

> 默认 `red`

点击色块更换主题的辅助色

<button data-md-color-accent="red">Red</button>
<button data-md-color-accent="pink">Pink</button>
<button data-md-color-accent="purple">Purple</button>
<button data-md-color-accent="deep-purple">Deep Purple</button>
<button data-md-color-accent="indigo">Indigo</button>
<button data-md-color-accent="blue">Blue</button>
<button data-md-color-accent="light-blue">Light Blue</button>
<button data-md-color-accent="cyan">Cyan</button>
<button data-md-color-accent="teal">Teal</button>
<button data-md-color-accent="green">Green</button>
<button data-md-color-accent="light-green">Light Green</button>
<button data-md-color-accent="lime">Lime</button>
<button data-md-color-accent="yellow">Yellow</button>
<button data-md-color-accent="amber">Amber</button>
<button data-md-color-accent="orange">Orange</button>
<button data-md-color-accent="deep-orange">Deep Orange</button>

<script>
  var buttons = document.querySelectorAll("button[data-md-color-accent]");
  Array.prototype.forEach.call(buttons, function(button) {
    button.addEventListener("click", function() {
      document.body.dataset.mdColorAccent = this.dataset.mdColorAccent;
      localStorage.setItem("data-md-color-accent",this.dataset.mdColorAccent);
    })
  })
</script>

## Todo List
- 准备环境 qemu... awvs appscan
- cg
- extractvalue()函数报错注入
- 短url api
- vue
- 编译原理
- https://www.leavesongs.com/
- ?name=admin' and 1=2 union select 1,2,group_concat(flag) from flag--+ 
- 上面的group_concat 作用
### coding...

* oj 平台
* 书签整理
* git平台
* 写一个爆破字段爆破工具
* 开3389 c++
* 跨平台抓包，支持https
* 各种后门隐藏与发现,制作 asp php python c
* 分布式肉鸡
* 《redis设计与实现》
* http://ctf5.shiyanbar.com/web/index_3.php
  
### book
[21st Century C: C Tips from the New School 1st Edition](https://www.amazon.com/21st-Century-Tips-New-School/dp/1449327141/ref=as_li_ss_tl?ie=UTF8&linkCode=sl1&tag=thegroovycorpora&linkId=2118b794f9d0816d53bff771c54f309e&language=en_US)
q-buffer-overflow-tutoral
逆向工程核心原理
《XSS跨站脚本攻击剖析与防御》
加密与解密
IDA Pro权威指南
0day安全
angr
https://docs.angr.io/
### 刷题
http://www.shiyanbar.com/ctf/
http://ctf.nuptzj.cn/
https://www.jarvisoj.com/
https://www.ichunqiu.com/competition
http://www.whaledu.com/
http://ddctf.didichuxing.com/
http://pwnable.kr/
https://pwnable.tw/
https://pwnhub.cn/
https://hackme.inndy.tw/
http://www.exploit-exercises.com
[hakcmeinndy wp](http://carlstar.club/)
[pwanable wp](https://bbs.ichunqiu.com/thread-46026-1-1.html)

### url
[在线执行代码](https://www.dooccn.com)
[ctftools](https://www.ctftools.com/down)
[新闻](https://www.sitedirsec.com/)
[cmd5](https://www.cmd5.com/)
[cmd51](http://www.xmd5.org/)
[js解密](http://tmxk.org/jother/)
[gps](http://www.gpsspg.com/bs.htm)
### 社工
[be pwn?](https://haveibeenpwned.com/)
### 要搭建的服务
* oj
* owasp
* msf vuln
* wooyun
* file server

### 未验证的一些玩意
#### mysql 协议加密算法
```
hash1 = SHA1(password) //password是用户输入的密码
result = hash1 ^ sha1(scramble+sha1(hash1)) //scamble 是mysql server端发送的，当密码为空，固定为0x00
```