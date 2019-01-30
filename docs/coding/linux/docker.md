## swarm 
网络隔离
代理
-v 挂载

## 一些命令
- 删除所有None镜像`docker rmi -f $(docker images -f "dangling=true" -q)`  
- 删除所有运行中镜像docker rm -f $(docker ps -aq)