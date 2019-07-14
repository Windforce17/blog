## vscode 配置开发环境

## Golang
```bash
#go version >=1.11
export GO111MODULE=on
export GOPROXY=https://goproxy.io
go get -u -v github.com/mdempsky/gocode
go get -u -v github.com/ramya-rao-a/go-outline
go get -u -v github.com/acroca/go-symbols
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/sqs/goreturns
go get -u -v golang.org/x/lint/golint
```