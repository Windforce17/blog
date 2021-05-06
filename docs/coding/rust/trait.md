## derive
可以使用`#[derive()]`去让编译器自动impl某些trait
例如:
```rust
#[derive(Copy,Clone,Default,Debug,Eq)]
struct Foo{
    data:i32
}
fn main(){}
```

## trait对象
//todo 
## 动态分发和静态分发
//todo
