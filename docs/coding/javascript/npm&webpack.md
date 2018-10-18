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