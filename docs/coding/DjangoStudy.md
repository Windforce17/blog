# Django学习

## 创建工程

django startproject name 
 了解4个生成文件意义

## 创建应用
django startapp name
* migrations 数据迁移
* apps.py 应用配置
* models.py 数据模块 使用ORM框架 MVC结构模型  
* tests.py 自动化测试模块，在这里编写测试脚本
* views.py 执行相应的代码
* 所有url在urls.py中 

## 开发templates
1. 在app目录下创建templates目录
2. 在该目录下创建html文件
3. 在views.py中返回render()
4. 坑：Django按照INSTALLED_APPS中顺序查找templates，不同app目录下templates目录中的同名.html会冲突
    
    解决：在template目录下创建以app名为名称的目录
    将html文件放进去 
5. 模板for循环: 
{% for xx in xxs %}
{% endfo %}
6. 超链接:
"{% url 'app_name:url_name' parm %}"

## Models
### 使用ORM框架
    一个Model对应数据库的一张数据表，Django中MOdels以类的形式表现，包含基本字段和数据行为

###表创建
应用根目录下创建models，并引入model模块，创建类，集成models.Model ,类即数据表
### 字段创建
字段即类里面的属性
CharField...TextField
### 生成数据表
1. 命令行进入manage.py同级目录，执行python manage.py makemigrations app名(可选)
2. 在执行 python manage.py migrate  

### 查看
Django自动会在app/migrations/目录下生成移植文件，执行python manage.py sqlmigrate 应用名 id 查看sql语句

### 页面呈现数据
后台步骤:
    views.py中import models
    artcle = models.Article.objects.get(pk=1)
url.py 
    url(r'^article/(?P<article_id>[0-9]+)$', views.article_page), 匹配id
    //组名必须和函数参数名相同
前端步骤:
    调用实例对象:使用.操作符。{{article.title}}

## admin
被授权用户可以直接管理数据库

### 创建
`python manage.py createsuperuser` //要先创建数据(migrations)

### 配置
    默认只能看到user表
1. 在应用下admin.py引入自身的models模块，或模块类
2. 编辑admin.py,添加admin.site.register(models.Article)
3. 修改数据默认显示名称
 根据python版本选择__str__(self)和__unicode__(self)

