## 堆数据结构
- 存放chunk的metadata的chunk的结构(header)
```c
struct malloc_chunk{
    size_t prev_size; //qword 可能存放上一个chunk的data
    size_t size;//qword
    malloc_chunk *fd; //会被data覆盖
    malloc_chunk *bk;//会被data覆盖
    malloc_chunk *fd_nextsize;//会被data覆盖
    malloc_chunk *bk_nextsize;//会被data覆盖
}
```
使用中的chunk
![inuse](heap/2019-01-21-20-38-59.png)
mem=malloc(size)
- chunk = mem-16;
- chunksize = (size+8)#16
- chunk的地址是malloc得到的地址-16
- chunksize是size+8向上对齐16的整数倍
- 一般情况下free的时候会检查前后空间是不是free，如果是free将会合并
- 带debug symbol的lib可以直接看各种bin和结构体
(gdb)p main_arena

回收的chunk
![not_inuse](heap/2019-01-21-23-42-44.png)
## Fastbin

- Chunk size <= get_max_fast()的chunk，会被放在fastbin的bin里
- 64bit是128bytes，32bit是64bytes
- global_max_fast 一开始是0
- Fastbin是single linked list，只能使用fd，以NULL结尾
- Chuk Size从32开始，共7个可用的fastbin
32、48、64、80、96、112、128
### malloc时检查
- malloc和free会对chunk进行检查，但检查fastbin的很少，比如说fastbin[2]的chunk size必须为64
- free的时候不会取消下一个chunk的prev_inuse_bit 因为fastbin chunk不会和其他chunk合并
### free时的检查
malloc.c: _int_free
- free的地址要16bit align
- chunk 头和尾size要对，size不能太大
- 下一个chunk的size不能过小
## double free
- double free可以改变fd，拿到任意地址进行读写
- fastbin只检查bin中的第一块chunk，只要不是连续free同一块chunk就没关系(fasttop)检查
```c
//假设p、q都小于global_max_fast
    free(q);
    //fastbin->q
    free(p);
    //fastbin->p->q
    free(q);
    //          <-
    //fastbin->q->p
    //不会报错
    //再malloc就会无限拿到p、q的地址...
```

## tips
64位got地址40开头，可以把0x40当作chunk_size用来绕过libc的检查。那么malloc应该是56字节，
![64bit_chunk_size](heap/2019-01-21-23-19-07.png)