## go写爆破脚本
这个在强网杯中使用了,已知hash求secret
```go
/*
burst hash qwb_crack

*/
package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"math"
	"os"
	"sync"
)
var d []byte
var p []byte
var l sync.WaitGroup
var m sync.Mutex
func crack_thread(start,end int){
	s:=sha256.New()
	i:=0
	for x:=start;x<end;x++{
		int_hex:=fmt.Sprintf("%06x",x)
		s.Reset()
		guss,_:=hex.DecodeString(int_hex)
		k:=append(p, guss...)
		if x%100000==0{
			//log.Printf("%x\n",k)
		}
		s.Write(k)
		cal:=s.Sum(nil)
		for i=0;i<len(d);i++{
			if d[i]!=cal[i]{
				break
			}
		}
		if i==len(d){
			fmt.Println(hex.EncodeToString(k))
			os.Exit(0)
		}
	}
	l.Done()

}

func main(){
	//d is target
	//p is know secret
	//example ./qwb_crack 61b89771fdad01b2c08016505ed13e706cd87717b5fcc27d15c1a3d5cfe5fa9c faea4d9da
	d,_=hex.DecodeString(os.Args[1])
	p,_=hex.DecodeString(os.Args[2])
	threads:=1
	n:=int(math.Ceil(float64(0xffffff/threads)))
	for x:=0;x<0xffffff;x+=n{
		l.Add(1)
		go crack_thread(x,x+n)
	}
	l.Wait()
}
```