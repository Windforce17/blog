## axios
安装：cnpm install axios --save
### 改写原型链

```js
//在main.js中引入：
import axios from 'axios'
//改写原型链
Vue.prototype.$ajax = axios
```
在组件的methods中使用：
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

### 封装进vuex中
action 和 mutations 也很类似，主要的区别在于，action 可以包含异步操作，而且可以通过 action 来提交 mutations
```js
// store.js
import Vue from 'Vue'
import Vuex from 'vuex'
 
// 引入 axios
import axios from 'axios'
 
Vue.use(Vuex)
 
const store = new Vuex.Store({
 // 定义状态
 state: {
 test01: {
  name: 'Wise Wrong'
 },
 test02: {
  tell: '12312345678'
 }
 },
 actions: {
 // 封装一个 ajax 方法
 saveForm (context) {
  axios({
  method: 'post',
  url: '/user',
  data: context.state.test02
  })
 }
 }
})
 
export default store
```

**注意：即使已经在 main.js 中引入了 axios，并改写了原型链，也无法在 store.js 中直接使用 $ajax 命令**

### 使用别名
```js
//post
axios.get('/user?ID=12345')
  .then(function(response){
    console.log(response);
  })
  .catch(function(err){
    console.log(err);
  });
//以上请求也可以通过这种方式来发送
axios.get('/user',{
  params:{
    ID:12345
  }
})
.then(function(response){
  console.log(response);
})
.catch(function(err){
  console.log(err);
});
//post
axios.post('/user',{
  firstName:'Fred',
  lastName:'Flintstone'
})
.then(function(res){
  console.log(res);
})
.catch(function(err){
  console.log(err);
});
```

## 打包与部署
### 部署后static目录为绝对路径？
将config/index.js下build参数assetsPublicPath清空
assetsPublicPath: '' 或者设置为'./'