## 交叉编译

```bash
#linux x64
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
# win x64
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
# mac x64
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build
# 32bit GOARCH=386
```
## debug
1. 删除debug信息
```sh
go build -ldflags “-s -w”
```
2. 有用的函数
```go
runtime.Breakpoint()//触发调试器断点。
runtime/debug.PrintStack()//显示调试堆栈。
```

## vscode 需要的包

go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/sqs/goreturns
go get -u -v github.com/ramya-rao-a/go-outline 
go get -u -v golang.org/x/tools/cmd/guru 
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/cweill/gotests/...
go get -u -v github.com/fatih/gomodifytags
go get -u -v github.com/josharian/impl
go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -u -v github.com/haya14busa/goplay/cmd/goplay
go get -u -v github.com/godoctor/godoctor
go get -u -v github.com/go-delve/delve/cmd/dlv
go get -u -v github.com/stamblerre/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v golang.org/x/lint/golint

## 常用包

1. https://github.com/urfave/cli
   A simple, fast, and fun package for building command line apps in Go
2. gopkg.in/yaml.v2
   yaml decoder
