//todo
https://zhuanlan.zhihu.com/p/149373777
https://zhuanlan.zhihu.com/p/37298671
https://github.com/ZhangHanDong/actix-workshop-rustconasia2019
https://rust-lang.github.io/async-book/02_execution/03_wakeups.html
https://github.com/tokio-rs/mini-redis

# 异步编程体系
异步编程依赖于三个维度，硬件、操作系统、编程范式。
现代计算机体系结构就是异步的，例如DMA、中断机制等。
操作系统提供了异步能力，epoll，io多路复用等。
编程范式在不同语言中体现也不一样，在Rust是future模型。js中是promise模型。
大部分异步编程流程是这样的：
1. 创建异步任务
2. 提交异步任务给调度器
3. 调度器执行，多个异步任务可以在一个线程中执行。在一个异步任务IO等待中去执行另一个异步任务。

操作系统提供了抽象层。实际上是硬件提供支持。CPU执行异步任务时不会再等待IO返回，而是IO操作在结束触发中断通知CPU处理。因此能剩下大量CPU资源。
不过理论上异步编程的实时性并没有同步/轮询高，但是可以显著增加吞吐量。并提高CPU利用率。
# 并发和并行
## cpu
```rust
use rand::{thread_rng, Rng};
use rayon::prelude::*;
use std::time::Duration;

fn compute_job(job: i64) -> i64 {
    let mut rng = thread_rng();
    let sleep_ms: u64 = rng.gen_range(0..10);
    std::thread::sleep(Duration::from_millis(sleep_ms));

    job * job
}

fn process_result(result: i64) {
    println!("{}", result);
}

fn main() {
    let jobs = 0..100;

    jobs.into_par_iter()
        .map(compute_job)
        .for_each(process_result);
}
```
使用rayon，默认线程数=cpu核心数

## I/O
```rust
use futures::{stream, StreamExt};
use rand::{thread_rng, Rng};
use std::time::Duration;

async fn compute_job(job: i64) -> i64 {
    let mut rng = thread_rng();
    let sleep_ms: u64 = rng.gen_range(0..10);
    tokio::time::sleep(Duration::from_millis(sleep_ms)).await;

    job * job
}

async fn process_result(result: i64) {
    println!("{}", result);
}

#[tokio::main]
async fn main() {
    let jobs = 0..100;
    let concurrency = 42;

    stream::iter(jobs)
        .for_each_concurrent(concurrency, |job| async move {
            let result = compute_job(job).await;
            process_result(result).await;
        })
        .await;
}
```