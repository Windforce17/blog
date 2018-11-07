## vuex

```js
//虽然分模块化，但是actions和mutations依然注册为全局
//全局store
//const store = new Vuex.Store({
export default {
  state: {
    a: 123,
    list: [1, 2, 3, 4, 5, 6]
  },
  getters: {
    filteredList(state) {
      return state.a * 2;
    }
  },
  //action中所有操作是异步的，如果increment 写入到 mutations，那么则会阻塞
  actions: {
    increment(context) {
      return new Promise(resolve => {
        setTimeout(() => {
          context.state.a++;
          resolve();
        }, 1000);
      });
    }
  },
  mutations: {
    decrease(state) {
      state.a--;
    }
  }
};
```

## v-chart

```js
import VCharts from "v-charts";
Vue.use(VCharts);
```

### 按需引入

```
|- lib/
|- line.js  -------------- 折线图

|- bar.js  --------------- 条形图

|- histogram.js  --------- 柱状图

|- pie.js  --------------- 饼图

|- ring.js  -------------- 环图

|- funnel.js  ------------ 漏斗图

|- waterfall.js  --------- 瀑布图

|- radar.js  ------------- 雷达图

|- map.js  --------------- 地图

|- bmap.js  -------------- 百度地图
```

## axios

安装：cnpm install axios --save

### 改写原型链

```js
//在main.js中引入：
import axios from "axios";
//改写原型链
Vue.prototype.$ajax = axios;
```

在组件的 methods 中使用：

```js
methods: {
 submitForm () {
 this.$ajax({
  method: 'post',
  url: '/user',
  data: {
    name: 'wise',
    info: 'wrong'
  }
 })
}
```

### 封装进 vuex 中

action 和 mutations 也很类似，主要的区别在于，action 可以包含异步操作，而且可以通过 action 来提交 mutations

```js
// store.js
import Vue from "Vue";
import Vuex from "vuex";

// 引入 axios
import axios from "axios";

Vue.use(Vuex);

const store = new Vuex.Store({
  // 定义状态
  state: {
    test01: {
      name: "Wise Wrong"
    },
    test02: {
      tell: "12312345678"
    }
  },
  actions: {
    // 封装一个 ajax 方法
    saveForm(context) {
      axios({
        method: "post",
        url: "/user",
        data: context.state.test02
      });
    }
  }
});

export default store;
```

**注意：即使已经在 main.js 中引入了 axios，并改写了原型链，也无法在 store.js 中直接使用 $ajax 命令**

### 使用别名

```js
//post
axios
  .get("/user?ID=12345")
  .then(function(response) {
    console.log(response);
  })
  .catch(function(err) {
    console.log(err);
  });
//以上请求也可以通过这种方式来发送
axios
  .get("/user", {
    params: {
      ID: 12345
    }
  })
  .then(function(response) {
    console.log(response);
  })
  .catch(function(err) {
    console.log(err);
  });
//post
axios
  .post("/user", {
    firstName: "Fred",
    lastName: "Flintstone"
  })
  .then(function(res) {
    console.log(res);
  })
  .catch(function(err) {
    console.log(err);
  });
```

## vscde 相关配置

```sh
# 安装下面的
npm install -g eslint
npm install -g eslint-plugin-html
```

```json
//添加下面的配置
  "eslint.validate": [
        "javascript",
        "javascriptreact",
        "html",
        "vue"
    ],
    "eslint.options": {
        "plugins": ["html"]
    },
```

## 打包与部署

### 部署后 static 目录为绝对路径？

将 config/index.js 下 build 参数 assetsPublicPath 清空
assetsPublicPath: '' 或者设置为'./'
