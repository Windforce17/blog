## 设计
etcd用来储存`不常更新`的数据和提供可靠的watch查询，储存啥用的b+树，根据单词顺序排序，这个特性可以使range查询变得容易(较低的复杂度)

比zookeeper的优势:
- 动态扩展，配置
- 高负载下，读写稳定
- 多版本并发控制模型
- 可靠的key监视(watch 查询)
- 有http/json 的api
- `基于gRPC框架`,语言支持多样化

## 配置与运行

### 启动脚本
默认端口为2379（client)和2380，以下脚本可以在一台机器上测试。
**`请在linux上跑`**
#### 单一节点
开发时当数据库用，启动一个就可以啦

```bash
./etcd
```
(简单粗暴，直接启动)

测试：
1. 设置api版本，默认为2:

    ```bash
        ETCDCTL_API=3
        export ETCDCTL_API
    ```
2. 使用etcdctl，如果默认端口为2379，可以不加--endpoints

    ```bash
    ./etcdctl --endpoints=127.0.0.1:2379 put a test
    # OK
    ./etcdctl --endpoints=127.0.0.1:2379 get a
    # a
    # test
    ```
    说明etcd工作正常

#### 多个节点

节点1
```bash
./etcd -name infra0  \
  --initial-advertise-peer-urls http://127.0.0.1:2380 \
  --listen-peer-urls http://127.0.0.1:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --listen-client-urls 'http://localhost:2379'\
  --advertise-client-urls 'http://localhost:2379'\
  --initial-cluster infra0=http://127.0.0.1:2380,infra1=http://127.0.0.1:2381,infra2=http://127.0.0.1:2382 \
```
节点2
```bash
./etcd -name infra1 \
  --initial-advertise-peer-urls http://127.0.0.1:2381 \
  --listen-peer-urls http://127.0.0.1:2381 \
  -initial-cluster-token etcd-cluster-1 \
  --listen-client-urls 'http://localhost:12379' \
  --advertise-client-urls 'http://lcoalhost:2379' \
  -initial-cluster infra0=http://127.0.0.1:2380,infra1=http://127.0.0.1:2381,infra2=http://127.0.0.1:2382 \
```
节点3
```bash
./etcd -name infra2 \
  -initial-advertise-peer-urls http://127.0.0.1:2382 \
  --listen-peer-urls http://127.0.0.1:2382 \
  --initial-cluster-token etcd-cluster-1 \
  --listen-client-urls 'http://localhost:22379' \
  --advertise-client-urls 'http://localhost:2379' \
  --initial-cluster infra0=http://127.0.0.1:2380,infra1=http://127.0.0.1:2381,infra2=http://127.0.0.1:2382 \
```
测试方法同上

### 各种url区别
1. listen-<client,peer>-urls
2. advertise-client-urls
3. inital-advertise-perr-urls  
三者区别

第一个用于接受客户端的请求，第一个第三用于集群内部通信(v3 api开始也能处理客户端请求，不过不推荐)，2，3的ip不要使用`localhost` or `0.0.0.0`,会导致集群间无法通信(你把集群扔到一台服务器上，端口号不同也行，不推荐..)

### initial

`--initial-advertise-peer-urls`   
`--initial-cluster`  
`--initial-cluster-state`  
`--initial-cluster-token`

只在启动时用到，重启将忽略。


## API
提供gRPC，所有的API在[这里][grpc-service]，
http版本的api属于v2，官方建议用v3

数据相关:
- KV  创建，更新，查询，删除
- Watch 监控key变化
- Lease key有效时间处理

控制集群本身：
- Auth 角色，权限控制
- Cluster 查询成员信息，进行配置
- Maintenance 创建，恢复快照，集群恢复等

更新gRPC信息，参考
https://github.com/coreos/etcd/blob/master/Documentation/learning/api.md

https://github.com/coreos/etcd/blob/master/Documentation/dev-guide/api_reference_v3.md

特别注意：gRPC并没有get之类的调用，只有一个Range：
- 当`range_end`为空时，返回key对应value
- 当key ，`range_end`都为\0时，遍历所有的key
- 当`range_end`为\0，key不为空时，返回比key大或者等于key的value

### go client

go语言有官方的client:

```bash
go get github.com/coreos/etcd/clientv3
```

doc:https://godoc.org/github.com/coreos/etcd/clientv3

往下翻有examples

## 最多可以挂(N-1)/2台

少于等于这个数，可以接受读写，客户端将失去连接，但是libraries应该隐藏这个中断 (对于ectdctl，指定`--endpoints='xxxx,xxxx,xxx'`，例如`--endpoints='127.0.0.1:2380,127.0.0.1:2381'`，当2380挂了的时候，依然可以读写)

## 部署时的一些调整

etcd默认配置是针对本地网络的，如果是跨数据中心，高网络延时，需要调整 *Heartbeat Interval* 和 *Election Timeout* ，例如启动时增加 `--heartbeat-interval=100` `--election-timeout=500`

更多调整(磁盘，快照等):
https://github.com/coreos/etcd/blob/master/Documentation/tuning.md

## 系统需求

最小：2G内存 80G SSD 双核CPU  
推荐：8G内存 4核cpu够用，1000+ watchers 100W keys，16G到64G内存
8-16核CPU


[grpc-service]: https://github.com/coreos/etcd/blob/master/etcdserver/etcdserverpb/rpc.proto