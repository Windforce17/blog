## redis start
docker run --name redis -p 6379:6379 -d redis
docker run -it  --rm redis:alpine redis-cli -h qing.cugctf.top -p 6379

## mysql start
docker run --name iam-mysql -v ~/mysql/data:/var/lib/mysql/:rw -v ~/mysql/my.cnf:/etc/mysql/my.cnf:ro -p 3306:3306 -e MYSQL_ROOT_PASSWORD=iam -e MYSQL_DATABASE=public -d mysql:5.7 