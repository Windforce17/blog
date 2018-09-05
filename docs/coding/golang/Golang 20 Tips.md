# Golang tips and traps

## 未使用的变量

```go
package main

var gvar int //not an error

func main() {  
    two := 2      //error, unused variable
    var three int //error, even though it's assigned 3 on the next line
    three = 3
	_=two

}
```

## 包导入
```go
package main
import . "fmt"
func main() {
	Println()
}
```

## init 
```go
package main
import . "fmt"

const Hello="hello"
var world string

func init(){
	world = "world"
	Println(Hello, world)
}

func main(){}
```

## nil pointer

```go
	var m *int //nil int pointer
	var n map[string]int //nil map[string]int reference
	*m=4	//error
	//m=new(int)

```

## bitwise Operator
```go
func main() {
	a:=2
	fmt.Println(^a)
	//~ XOR
	//优先级
}
```
## map , slice is reference


```go
func main() {
	s:=make([][]int,0)
	d:=[]int{6,6,6}
 	s=append(s, d)
	s=append(s, d)
	d[0]=7
	fmt.Println(s)
}s
```

## connect multi slice
```go 
package concat

func concatCopyPreAllocate(slices [][]byte) []byte {
    var totalLen int
    for _, s := range slices {
        totalLen += len(s)
    }
    tmp := make([]byte, totalLen)
    var i int
    for _, s := range slices {
        i += copy(tmp[i:], s)
    }
    return tmp
}

func concatAppend(slices [][]byte) []byte {
    var tmp []byte
    for _, s := range slices {
        tmp = append(tmp, s...)
    }
    return tmp
}
```

## rune

```go
func main() {
	data2 := "青云"
	fmt.Println(len([]rune(data2)))
}

func main() {
	data := "é"//two codpoints ,combining character
	fmt.Println(len(data)) //prints: 3
	fmt.Println(len([]rune(data)))//print:2
}
```

## composistion

```go
package main

import "fmt"

type Person interface {
	Introduce()
}
type Student struct {
	name string
}
type Teacher struct {
	name string
}
func (s Student) Introduce(){
	fmt.Println("Hi, I'm ",s.name)
}
func (s *Teacher) Introduce(){
	fmt.Println("Hi, I'm teacher",s.name)
}
type School struct {
	Person
	number int
}
func main() {

	zhichen:=School{
		Student{"wzc"},
		123,
	}
	zhichen.Introduce()
}

```
## struct compare
只有`struct`中数据都可以比较时，才能用 `==`
```go
type data struct {  
    num int
    fp float32
    complex complex64
    str string
    char rune
    yes bool
    events <-chan string
    handler interface{}
    ref *byte
    raw [10]byte //array
}

func main() {  
    v1 := data{}
    v2 := data{}
    fmt.Println("v1 == v2:",v1 == v2) //prints: v1 == v2: true
}
```

## DeepEqual() & bytes.Equal
```go
package main

import (
	"fmt"
	"bytes"
	"reflect"
)

func main() {
	//nil and empty
	var b1 []byte
	b2 := []byte{}
	fmt.Println("b1 == b2:", bytes.Equal(b1, b2)) //print: b1 == b2: true
	fmt.Println("b1 == b2",reflect.DeepEqual(b1,b2))//print: b1 == b2:false
}
```

```go
package main

import (
	"fmt"
	"reflect"
	"encoding/json"
)

func main() {
	var str string = "one"
	var in interface{} = "one"
	fmt.Println("str == in:",str == in,reflect.DeepEqual(str, in))
	//prints: str == in: true true

	v1 := []string{"one","two"}
	v2 := []interface{}{"one","two"}
	fmt.Println("v1 == v2:",reflect.DeepEqual(v1, v2))
	//prints: v1 == v2: false (not ok)

	data := map[string]interface{}{
		"code": 200,
		"value": []string{"one","two"},
	}
	encoded, _ := json.Marshal(data)
	var decoded map[string]interface{}
	json.Unmarshal(encoded, &decoded)
	fmt.Println("data == decoded:",reflect.DeepEqual(data, decoded))
	//prints: data == decoded: false (not ok)
}
```


## goroutines sync group
```go
func main() {
	var wg sync.WaitGroup
	workerCount := 2

	for i := 0; i < workerCount; i++ {
		wg.Add(1)
		go doit(i,&wg)
	}
	wg.Wait()
	fmt.Println("all done!")
}

func doit(workerId int,group *sync.WaitGroup) {//must pointer
	defer group.Done()
	fmt.Printf("[%v] is running\n",workerId)
	time.Sleep(3 * time.Second)
	fmt.Printf("[%v] is done\n",workerId)
}
```

## chan buffer size 

```go
func main() {
	a:=make(chan bool,1)
	a<-true
	var vg sync.WaitGroup
	vg.Add(1)
	go func() {
		defer vg.Done()
		log.Println(<-a)

		}()
		vg.Wait()

}
```

## nil channel & closed channel
```go
 //close a nil chan will panic
 //send or read nil chan will lock
 //sent a closed chan will panic
 //you can read close chan
 //a closed chan never blocked
func WaitMany(a, b chan bool) {
        var aclosed, bclosed bool
        for !aclosed || !bclosed {
                select {
                case <-a:
                        aclosed = true
                case <-b:
                        bclosed = true
                }
		}
		//do something
}

package main
 
import (
        "fmt"
        "time"
)

func WaitMany(a, b chan bool) { 
        for a != nil || b != nil {
                select {
                case <-a:
                        a = nil
                case <-b:
                        b = nil
                }
        }
}
 
func main() {
        a, b := make(chan bool), make(chan bool)
        t0 := time.Now()
        go func() {
                close(a)
                close(b)
        }()
        WaitMany(a, b)
        fmt.Printf("waited %v for WaitMany\n", time.Since(t0))
}

```
https://dave.cheney.net/2013/04/30/curious-channels
```go
package main

import (
	"fmt"
	"time"
)

func main() {
	a := make(chan bool)
	go sentTrue(a)//no buffer will be sending...
	time.Sleep(20*time.Millisecond)
	close(a)
	fmt.Println("channel has closed")
	fmt.Println(<-a)

}

func sentTrue(a chan bool) {
	a <- true

}

```
## variables in loop
```go
func main() {
	data := []string{"one", "two", "three"}
	for _, v := range data {
		go func() {
			fmt.Println(v)

		}()
	}

	time.Sleep(3 * time.Second)
}
```

## break loop
```go
func main() {  
    loop:
        for {
            switch {
            case true:
                fmt.Println("breaking out...")
                break loop
            }
        }

    fmt.Println("out!")
}
```
## close http body
```go
func main() {  
    resp, err := http.Get("https://www.qingcloud.com/")
  	if resp != nil {
        defer resp.Body.Close()
	}
	if err != nil {
		fmt.Println(err)
		return
    }
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println(err)
        return
    }

    fmt.Println(string(body))
}
```

## defer call

```go
package main

import "fmt"

func main() {  
    var i int = 1

    defer fmt.Println("result =>",func() int { return i * 2 }())
    i++
    //prints: result => 2 (if you expected 4)
}
```

## map not addressable

```go
type data struct {
	name string
}

func (p *data) print() {
	fmt.Println("name:",p.name)
}


func main() {
	d1 := data{"one"}
	d1.print() //ok
	m := map[string]data {"3":data{"three"}}
	m["3"].print()
}
```

```go
package main

type data struct {
	name string
}
//how to set value
func main() {
	m := map[string]data {"x":{"one"}}
	m["x"].name = "two" //error
	r := m["x"]
    r.name = "two"
    m["x"] = r
    fmt.Printf("%v",m) //prints: map[x:{two}]
}
```

```go
package main

type data struct {
	name string
}

func main() {
	m := map[string]*data {"x":{"one"}}
	m["z"].name = "what?" //???
}
```

## "nil" Interfaces and "nil" Interfaces Values
```go
package main

import "fmt"

func main() {
	var data *byte
	var in interface{}

	fmt.Println(data,data == nil) //prints: <nil> true
	fmt.Println(in,in == nil)     //prints: <nil> true
	in = data
	fmt.Println(in,in == nil)     //prints: <nil> false
}
```

```go
package main

import "fmt"

func retnil()interface{}{
	var result *struct{}=nil
	return result
}
func main() {
	fmt.Println(nil)
}
```