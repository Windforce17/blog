## docker 常用容器
### mssql
```sh
# 注意，PASSWORD必须足够复杂，否则会报错
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Str0ngPassword!' -p 1433:1433 -d microsoft/mssql-server-linux
```
### postgresql
```sh
docker run -d  -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword  postgres 
```

```sh
docker run -it --rm postgres psql -h host -U postgres
```

## 运维常用服务
* 日志收集graylog
* 客户端收集:fluentd
* 阿里云 logsearch
* 自定义nginx日志字段
* 网络质量：smokeping