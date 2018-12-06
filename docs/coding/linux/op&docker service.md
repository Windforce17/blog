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


## pmm

```bash
# 拉取服务器镜像

docker pull percona/pmm-server:latest

# 创建PMM数据容器

docker create \
   -v /opt/prometheus/data \
   -v /opt/consul-data \
   -v /var/lib/mysql \
   -v /var/lib/grafana \
   --name pmm-data \
   percona/pmm-server:latest /bin/true

# 创建PMM服务器容器, 同时设置登录用户名(SERVER_USER)和密码(SERVER_PASSWORD), 根据需要进行修改. 默认使用80端口, 如果需要可以更改.

docker run -d -p 9001:80 \
  --volumes-from pmm-data \
  --name pmm-server \
  -e SERVER_USER=test \
  -e SERVER_PASSWORD=test \
  --restart always \
  percona/pmm-server:latest
```

## 运维常用服务
* 日志收集graylog
* 客户端收集:fluentd
* 阿里云 logsearch
* 自定义nginx日志字段
* 网络质量：smokeping