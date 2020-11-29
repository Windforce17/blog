## load public or private key
> private:
```go
	prkey, _ := ioutil.ReadFile("/Users/windforce/.ssh/id_rsa")
	prikey, _ := pem.Decode(prkey)
	x509.ParsePKCS1PrivateKey(prikey.Bytes)
```
> public:
```go
	key := `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBA。QUAA4GNADCBiQKBgQDdlatRjRjogo3WojgGHFHYLugd
UWAY9iR3fy4arWNA1KoS8kVw33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQs
HUfQrSDv+MuSUMAe8jzKE4qW+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5D
o2kQ+X5xK9cipRgEKwIDAQAB
-----END PUBLIC KEY-----`
	publicBlock, _ := pem.Decode([]byte(key))
	publickey, _ := x509.ParsePKIXPublicKey(publicBlock.Bytes)
	publicKey := publickey.(*rsa.PublicKey)
```
注意，public是`ParsePKIXPublicKey`，private是`ParsePKCS1PrivateKey`，pem.Decode实际上去掉了 *-----xxxx-----*

## jwt-rs256-verify

```go
func main() {
	jwtString:="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.TCYt5XsITJX1CxPCT8yAV-TVkIEq_PbChOMqsLfRoPsnsgw5WEuts01mq-pQy7UJiN5mgRxD-WUcX16dUEMGlv50aqzpqh4Qktb3rk-BuQy72IFLOqV0G_zS245-kronKb78cPN25DGlcTwLtjPAYuNzVBAh4vGHSrQyHUdBBPM"
	key := `-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDdlatRjRjogo3WojgGHFHYLugd
UWAY9iR3fy4arWNA1KoS8kVw33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQs
HUfQrSDv+MuSUMAe8jzKE4qW+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5D
o2kQ+X5xK9cipRgEKwIDAQAB
-----END PUBLIC KEY-----`
	publicBlock, _ := pem.Decode([]byte(key))
	publicKey, _ := x509.ParsePKIXPublicKey(publicBlock.Bytes)
	public := publicKey.(*rsa.PublicKey)
	claims:=jwt.MapClaims{}
	_,err:=jwt.ParseWithClaims(jwtString,claims, func(token *jwt.Token) (interface{}, error) {
		return public,nil
	})
	log.Println(err)
    log.Println(claims)
```

最新版本的jwt-go是支持rs256的，parsewithclaims的key的类型为*rsa.PublicKey。

