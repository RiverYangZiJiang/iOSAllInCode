#  术语

```
dispatch_async 异步操作，在新的线程中执行任务，具备开启新线程的能力(不是百分百开启新线程，会取决于任务所在队列类型)，会并发执行，无法确定任务的执行顺序；
dispatch_sync  同步操作，在当前线程中执行任务，不具备开启新线程的能力，会依次顺序执行；
```

| 术语           | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
| dispatch_after | Enqueue a block for execution at the specified time(在指定的时间将一个block加入队列执行). This function waits until the specified time and then asynchronously adds `block` to the specified `queue`(这个函数等到指定的时间，然后异步地将block加入指定的队列).<br>延时插入block执行入队列，需要注意的是：dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。 |
| dispatch_apply | Submits a block to a dispatch queue for multiple invocations(提交一个block到一个派遣队列，进行多次调用). |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |
|                |                                                              |

