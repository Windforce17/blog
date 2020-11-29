## 初始化／新建项目
```
yarn install vue-cli
vue create [name]
vue add vuetify
```
## 关于路由
vue-router是用`<router-view></router-view>`进行渲染，在执行`vue add vuetify`后默认没有这个标签，所以需要加上

## 网格，布局
和bootstrap相似，[可以使用网格系统](https://vuetifyjs.com/zh-Hans/layout/grid)
```html
<template>
<v-container fluid>
  <v-layout row>
    <v-flex xs3>
<v-textarea v-model=exp>
</v-textarea>
    </v-flex>
    <v-flex xs3>
      <v-textarea v-model=exp>
</v-textarea>
    </v-flex>
  </v-layout>
</v-container>
</template>
```