## 跨域处理

```go
route := gin.Default()
	route.Use(cors.New(cors.Config{
		AllowOriginFunc:  func(origin string) bool { return true },
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "PATCH"},
		AllowHeaders:     []string{"Origin", "Content-Length", "Content-Type"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
    }))
```
## staticFIle
```go
route.StaticFile("/", `send.html`)//file
route.StaticFS("/static",http.Dir("static")) //dir

```
## 返回json
```go
c.JSON(200, &CountryStatics)
```