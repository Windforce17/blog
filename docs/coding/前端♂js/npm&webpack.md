## 源
### 淘宝源设置
安装cnpm：`npm install -g cnpm --registry=https://registry.npm.taobao.org`
或者:`npm config set registry http://registry.npm.taobao.org/`
替换回去:`npm config set registry https://registry.npmjs.org/`
### chromedriver 报错
npm config set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver

## webpak
1. first you need npm
`npm install webpack webpack-cli --save-dev`
4.0版本不再需要配置webpack.config.ks 的entry&output，默认在input:src/index.js,
output: disk/
2. 在package.json中的scripts中添加
   `"build":"webpack"`
### --save-dev --save
1. --save-dev 指的是开发用到的工具链
2. --save js包