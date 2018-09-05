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
* http://ctf5.shiyanbar.com/web/index_3.php
* 写一个爆破字段爆破工具
* mysql一键安装脚本
* 开3389 c++
* oj 平台搭建
* 跨平台抓包，支持https
* 各种后门隐藏与发现,制作 asp php python c
* webshell checker
* 后台路径文件合并 表，字段
* phpmyadmin ssh 批量暴力破解工具，字典
* 中国特色字典
* 端口扫描
* Cain4.9 多口令破解测试
* arp欺骗工具
* Wordpress 综合检测工具
* 各大cms shell
* 提权脚本
* 改cd ls..
* 删解释器
* netstat：端口，连接排查
* 如何kill进程/防止kill
* sql防注入代码
* 上传漏洞防护
* 日志管理
* 文件监控
* umask?
* 网络端口监控
* waf过滤sqlmap  //sql改head
* 后门批量上传，管理
* 目录禁止写入
* 后门开机启动 定时运行
* 自动化程度提高
* 编译所有的py
* php 5.10 poc
* xss 打cookie
* 《redis设计与实现》

## 服务
* owasp
* meta vuln
* wooyun
* ubuntu博客
* 武器库
* autopwn
* 团队协作 dingidng
* 日志收集graylog
* 客户端收集:fluentd
* 阿里云logsearch
* 自定义nginx日志字段
* 网络质量：smokeping
* 审计源代码，分析后门、命令执行、上传、SQL等威胁 * 现成CMS注意DIFF
* 弱口令更改
* 根据漏洞PATCH
* 根据漏洞写出EXP，发动攻击 * 被攻击后完成EXP，PATCH
* 自动化种马，权限维持
* 自动化收割
* 批量扫描http服务
* 数据库备份表，dump，shell测试！权限维持!提权