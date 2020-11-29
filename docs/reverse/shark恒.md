## shark恒破解记录

## 第一期
1. nop爆破
2. jmp强制跳转爆破
3. 带壳寻找注册码
4. 文件自校验 程序大小
5. 关键call修改,重启验证，注册表
6. vmp爆破
7. vmp寻找注册码 ini重启验证
8. api断点
9. 读ini断点找注册码
10. api 字符串失效多情况 查看user32，查找二进制字符串，查找万能断点特征吗:F3 A5 8B C8 83 E1 03 F3 A4 E8 只有xp能用
11. vb程序破解，防止跳过注册成功，用nop填充
12. 破解弹窗，遇到弹窗F12暂停，k中user32.msgb显示调用，下断点。
13. die64可以查看编译器
14. asp bc++脱壳
15. bc++ 破解
16. dede查找按钮事件，在跑飞的地方下断点，jmp掉弹窗call
17. 提示框暂停，返回用户代码，关闭提示框
18. 打补丁，内存补丁
19. 网络验证，易语言push窗体，查找00401000，查找按钮，FF55，窗体FF25，查找命令:push 10001,下面第二个为窗口地址，容易出现暗桩
20. 自动退出暗装处理，在退出api下断点，反汇编窗口跟随返回地址，跳过退出函数
21. dede载入，找激活按钮
22. 找关键比较，更改所有关键跳
23. vbaend vb退出函数，过shutdown
24. 修改软件所有内容 pe explore 查看资源
25. 修改od标题


## 第二期
2. 易语言花指令
# 快捷键
1. F2断点
2. F7步入
3. F8步过
4. f4 跳过循环
5. alt+f9 到程序领空
6. ctrl+f9 到段尾
7. 搜索按钮事件，FF55FC ctrl+a 分析代码，跑丢了，右键，激活所有线程，飘零破解常见问题
8. 飘零网络验证和山寨
9. 飘零3.5山寨服务端
10. 更改网络验证地址，密码，短地址改长，查找二进制字符串000000，找到空代码处，输入内容，更改地址


## 按钮事件

mfc中特征码 sub eax,0a ，找到后下面的je跳转回车

## 去弹窗

alt+G 跟随api：
- CreateWindowEx
- DialogBoxParam
- ShellExecute
- WinExec
- CreateProcess
- CreateThread

更改IE首页方法：使用注册表：
- RegCreateKeyExA/W
- RegOpenKeyExA/W
- RegDeleteKeyExA/W


## 软件
- restorator 修改窗口，资源
- procexp 
- procmon

## F12大法
RET大法
nop大法