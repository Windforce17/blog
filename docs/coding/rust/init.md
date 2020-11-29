## install

```sh
yay -S rustup
rustup default stable
```

```sh
export RUSTUP_DIST_SERVER='https://mirrors.ustc.edu.cn/rust-static'
export RUSTUP_UPDATE_ROOT='https://mirrors.ustc.edu.cn/rust-static/rustup'
curl https://mirrors.ustc.edu.cn/rust-static/rustup/rustup-init.sh | sh
```

cargo:
```conf
#~/.cargo/config
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```


其他问题查看[这个](https://wiki.archlinux.org/index.php/Rust#Installation)

## debug 输出

如果要使用`println!("{}",a)`这类的语法，必须要实现`std::format:Display`,debug 同理，但是使用`#[derive(Debug)]`就可以输出 struct。

```rs
#[derive(Debug)]
struct rect {
    w: u32,
    h: u32,
}
fn main() {
    let r1 = rect{w:12,h:21};
    println!("{:?}", r1);
}
```
## trait、bounds、生命周期
T,E都是泛型，同时也实现了Display和Clone trait
```rs
fn some_funtion<T,E>(t:T,e:E)->i32
    where T:Display+Clone,
          E:Clone+Debug
{
}
```
生命周期也是泛型的一种：
```rs
fn longest_whith<'a, T>(x: &'a str, y: &'a str, ann: T) -> &'a str
where
    T: Display,
{
    println!("Ahhhhhh!!{}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
## 常用的 crates

1. Rayon
2. Actix
