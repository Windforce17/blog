# linux 设备驱动第三版
[官方代码](https://resources.oreilly.com/examples/9780596005900)  
[编译不过用这个](https://github.com/martinezjavier/ldd3)


## Semaphore
线程/进程同步手段之一 
threads/processes sync method
```c
// init
void sema_init(struct semaphore *sem, int val);
//mutex mode
// init semaphore variable to 1
DECLEAR_MUTEX(name);
// init semaphore variable to 0(locked state)
DECLEAR_MUTEX_LOCKED(name)

void init_MUTEX(struct semaphore *sem);
void inti_MUTEX_LOCAKED(struct semaphore *sem);
// "P" function
//always use interruptible version, because nointerruptible version may stuck the process
void down(struct semaphore *sem);
int down_interruptible(struct semaphore *sem);
int down_trylocal(struct semaphore *sem);

//"V" function
void up(struct semaphore *sem)
```
## memory
设备通常提供一组寄存器来进行控制，这些寄存器可能在I/O空间中，也能在内存空间中，在I/O空间中时要用IN/OUT 汇编指令进行读写，在I/O 空间时，被称为I/O 端口，反之为I/O 内存。
|  用途 |                        范围                |
|:-------|:-------------------------------------: |
|系统空间| `0xffff800000000000~0xffffffffffffffff`  |
|NULL| 就是个空洞|
|用户|    `0x0000000000000000~0x00007ffffffff000`|
| 这64T直接和物理内存进行映射|`0xffff880000000000~0xffffc7ffffffffff`   |
|这32T用于vmalloc/ioremap的地址空间| `0xffffc90000000000~0xffffe8ffffffffff` |



前两个字节都为0xff是因为高16位没用上，只用了48位  

文档`Documentation\x86_64\mm.txt`没有和代码同步。。
### 32位
支持最大内存为64G，开启PAE选项。
### 64位
pgd、pud、pmd、pte各占了9位，加上12位的页内index，共用了48位。即可管理的地址空间为2^48=256T，支持最大物理内存为64T，在MAX_ARCH_PFN 定义，

### 地址类型

用户虚拟地址: 32/64 bit 长度，每个进程都有自己的虚拟地址空间
物理地址: 略。
bus地址：用于外设和内存，x86和物理地址一样，但是某些架构实现了IOMMU，进行重映射，
内核逻辑地址：：These addresses map some portion (perhaps all) of main memory and are often treated as if they were physical addresses，经常被当作物理地址，但实际上和物理地址差一个固定偏移,kmalloc 返回的就是属于这个。
内核虚拟地址：不一定是线性映射物理地址，内核逻辑地址一定是内核虚拟地址，内核虚拟地址不一定是逻辑地址(vmalloc)
如果你拿到了一个逻辑地址，__pa()可以得到物理地址, __wa()是逆操作，仅能操作低地址页面。
![看这些坑爹的地址](2019-08-06-11-03-18.png)   

低内存: 内核中所有逻辑地址，你见到的都是低内存
高内存：超过了内核虚拟地址，不在内核逻辑地址中。例如用户空间地址
申请内存主要函数:
```c
void *kmalloc(size_t size,int flags)
/*
    第一个参数是大小，第二个是分配标志
    GFP_KERNEL 在内核空间进程申请内存，不能满足则等待空闲页，最常用
    GFP_ATOMIC 不存在空闲页立即返回
    GFP_HIGHUSER 和GFP_USER
    GFP_DMA 从DMA分配
    GFP_NOIO 不允许I/O 初始化
    GFP_NOFS 不允许进行任何文件系统系统调用
    __GFP_HIGHMEM 在高端内存分配
    __GFP_COLD 请求一块较长时间不访问的页(不在cache中)
    __GFP_NOWARN 当分配不满足时，不发出警告
    __GFP_HIGH 高优先级，允许获得内核给紧急状况预留内存
    __GFP_REPEAT 分配失败，则尽力重试
    __GFP_NOFAIL 只允许申请成功
    __GFP_NORETRY 申请不到就放弃

kmallo内部使用__get_ree_pages实现，但和glibc一样进行二次管理，基于buddy实现上使用slab算法。
创建slab 缓存: ...kmem_cache_create()...
分配slab 缓存: void *kmem_cache_alloc(struct kmem_cache *cachep,gfp_t flags)
释放slab 缓存: void kmem_cache_free(struct kmem_cache *cachep,void *objp)
收回slab 缓存: int kmem_cache_destory(struct kmem_cache *cachep)

__get_free_pages(unsigned int flags,unsigned int order)，使用buddy算法，每次申请都为2^order页面
__get_zeroed_page(unsigned int flags) 清零
__get_free_page 实际上是
__get_free_page(gfp_mask,0)

内存池: mempool_create()
*/
vmalloc()
//远大于kmalloc开销，区别是在物理地址上不连续，他会进行内存映射，改变页表项，释放应使用vfree(),
remap_pfn_range() //映射物理地址，保留页到用户空间上，不能用于常规地址。例如__get_free_pages(),尽管如此，依然可以remap high PCI buffers and ISA memory
ioremap()//将设备寄存器，缓冲，映射到虚拟地址上,多用于PCI video 设备，可以超过高地址范围外（在开机时映射页表)，不能映射到用户地址

int get_user_page()// 直接从current-mm拿到pages direct I/O 内核不进行缓存
```