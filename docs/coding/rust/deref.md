## 定义
```rs
pub trait Deref {
    type Target: ?Sized;
    #[must_use]
    pub fn deref(&self) -> &Self::Target;
}
```

## 用处
1. 相当于指针取值，重载操作符*
2. 在函数调用时会调用Defer
## example
```rs
fn main() {
    let h = Box::new("hello");
    assert_eq!(h.to_uppercase(), "HELLO");
}
```
h是Box类型，没有实现to_uppercase，使用`.`时会触发defer调用。直接操作`Box<T>`中储存的T类型


