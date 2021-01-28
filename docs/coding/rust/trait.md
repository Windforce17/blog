## derie
可以使用`#[derive()]`去让编译器自动impl某些trait
例如:
```rust
#[derive(Copy,Clone,Default,Debug,Eq)]
struct Foo{
    data:i32
}
fn main(){}
```
