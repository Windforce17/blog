## ES6
### 获得对象的所有key
```js
// >IE9
let k = Object.keys(target)
//lodash
let k = _.keys(target)

var jsonObject1 = {
            "name": "xiaoming",
            "age": 29
        },
        var keys1 = [];
    for (var p1 in jsonObject1) {
        if (jsonObject1.hasOwnProperty(p1))
            keys1.push(p1);
    }

//不使用hasOwnPropert,给object添加的属性也会输出
Object.prototype.test = "I am test";
    var jsonObject = {
            "name": "xiaoming",
            "age": 29
        },
        keys = [];
    for (var p in jsonObject)
        keys.push(p);
```
## 绕过 chrome 检测关闭当前窗口

```javascript
function closeWindows() {
  var userAgent = navigator.userAgent;
  if (userAgent.indexOf("Firefox") != -1 || userAgent.indexOf("Chrome") != -1) {
    close(); //直接调用JQUERY close方法关闭
  } else {
    window.opener = null;
    window.open("", "_self");
    window.close();
  }
}
```

## 使用 nativefier 打包 web 应用

[github](https://github.com/jiahaog/nativefier)

[api](https://github.com/jiahaog/nativefier/blob/master/docs/api.md#dest)

```bash
npm i -g nativefier

# 基本使用

nativefier --name "blog" "https://windforce17.github.io/blog"

# 转化本地网页应用

nativefier --name "Sample" --insecure --ignore-certificate index.html

# then 将本地网页所有相关文件放到和基本目录中去，和Sample.exe处于同一级别

# 找到 \app\nativefier.json文件，"更改 targetUrl"："file:///index.html"

```
