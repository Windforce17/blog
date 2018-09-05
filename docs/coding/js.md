# 绕过chrome检测关闭当前窗口
```javascript
    function closeWindows() {
    var userAgent = navigator.userAgent;
    if (userAgent.indexOf("Firefox") != -1
    || userAgent.indexOf("Chrome") != -1) {
    close();//直接调用JQUERY close方法关闭
    } else {
    window.opener = null;
    window.open("", "_self");
    window.close();
    }
    };

```
