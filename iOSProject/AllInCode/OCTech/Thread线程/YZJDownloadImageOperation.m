//
//  YZJDownloadImageOperation.m
//  IOSTest-1603
//
//  Created by 杨子江 on 5/22/16.
//  Copyright © 2016 杨子江. All rights reserved.
//

#import "YZJDownloadImageOperation.h"

@implementation YZJDownloadImageOperation
//
//- (id)initWithURL:(NSURL *)url imageView:(UIImageView *)imageView{
//    self = [super init];
//    
//    if (self) {
//        _url = url;
//        _imageView = imageView;
//    }
//    return self;
//}
//
//// 重写main方法，该方法将作为线程执行体
//- (void)main{
//    NSData *data = [NSData dataWithContentsOfURL:self.url];
//    UIImage *image = [UIImage imageWithData:data];
//    if (image) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = image;
//        });
//    }
//}
//
//#pragma mark - NSThread
//- (void)NSThreadTest{
//    // 创建线程方式1：创建并启动线程
//    //    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
//    
//    // 创建线程方式2：先创建再手动启动
//    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    [self.thread start];
//    // 线程的状态
//    NSLog(@"1 isCancelled = %d, isExecuting = %d, isFinished = %d", [self.thread isCancelled], [self.thread isExecuting], [self.thread isFinished]);
//}
//
//
//- (void)exitThread{
//    [NSThread exit];  // 终止当前正在执行的线程 注：只能在当前线程里终止自己，而不能被别的线程终止
//}
//- (void)run{
//    NSLog(@"%@", [NSThread currentThread]);
//    
//    [NSThread sleepForTimeInterval:3];  // 让当前正在执行的线程休眠一段时间
//    
//    [NSThread exit];  // 终止当前正在执行的线程 注：只能在当前线程里终止自己，而不能被别的线程终止
//    
//    NSLog(@"2 isCancelled = %d, isExecuting = %d, isFinished = %d", [self.thread isCancelled], [self.thread isExecuting], [self.thread isFinished]);
//}
//
//#pragma mark - GCD
//- (void)serialQueueDeadLockTest{
//    NSLog(@"start %@", [NSThread currentThread]);
//    
//    // 创建串行队列
//    dispatch_queue_t q = dispatch_queue_create("yzj", DISPATCH_QUEUE_SERIAL);
//    
//    // 异步
//    dispatch_async(q, ^{
//        NSLog(@"async %@", [NSThread currentThread]);
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{  // 不会死锁
//            NSLog(@"sync %@", [NSThread currentThread]);  // sync <NSThread: 0x7fa5b85069a0>{number = 1, name = main}
//        });
//        
//        dispatch_async(dispatch_get_main_queue(), ^{  // 不会死锁
//            NSLog(@"async1 %@", [NSThread currentThread]);
//        });
//        
//        dispatch_sync(q, ^{  // 死锁
//            NSLog(@"sync1 %@", [NSThread currentThread]);
//        });
//        
//        NSLog(@"async1 %@", [NSThread currentThread]);
//    });
//    
//    // 同步
//    dispatch_sync(q, ^{
//        NSLog(@"async %@", [NSThread currentThread]);
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{  // 死锁
//            NSLog(@"sync %@", [NSThread currentThread]);  // sync <NSThread: 0x7fa5b85069a0>{number = 1, name = main}
//        });
//        
//        dispatch_sync(q, ^{  // 死锁
//            NSLog(@"sync1 %@", [NSThread currentThread]);
//        });
//        
//    });
//    
//    NSLog(@"end %@", [NSThread currentThread]);
//}
//
//#pragma mark 执行多次块代码
//- (void)dispatch_apply_test{
//    NSLog(@"start %@", [NSThread currentThread]);
//    
//    //    dispatch_queue_t q = dispatch_queue_create("yzj", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t q = dispatch_queue_create("yzj", DISPATCH_QUEUE_CONCURRENT);
//    
//    // 在串行队列中默认会阻塞当前线程；在并行队列中也会阻塞当前线程，虽然会并发执行
//    dispatch_apply(5, q, ^(size_t time) {  // time这个参数名需要手动添加
//        NSLog(@"time = %zu %@", time, [NSThread currentThread]);
//    });
//    
//    NSLog(@"end %@", [NSThread currentThread]);
//}
//
//#pragma mark 只能执行一次块代码
//// 只执行一次的任务，哪怕被调用多次，dispatch_once里的块代码也只会执行一次，常用来创建单例
//- (void)dispatch_once_test{
//    NSLog(@"start %@", [NSThread currentThread]);
//    
//    static dispatch_once_t q;
//    dispatch_once(&q, ^{
//        NSLog(@"dispatch_once %@", [NSThread currentThread]);
//    });
//    
//    NSLog(@"end %@", [NSThread currentThread]);
//}
//
//#pragma mark - NSOperation
///*使用NSOperationQueue和NSOperation开发多线程非常简单，只需要简单地三步
// 1.创建队列
// 2.创建操作
// 3.将操作添加到队列，就能自动开始运行了
// */
//- (void)downloadImageWithNSOperation{
//    NSLog(@"start %@", [NSThread currentThread]);
//    // 1.创建队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];  // 没办法像GCD那样在创建时指定是串行还是并发队列，估计设置最大线程数为1则是串行队列，非1则是并发队列
//    
//    // 2.创建操作
//    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"operation start %@", [NSThread currentThread]);
//        NSURL *url = [NSURL URLWithString:@"http://img1.gtimg.com/sports/pics/hv1/27/154/2072/134771097.jpg"];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        if (data) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = [UIImage imageWithData:data];
//            });
//        }
//        NSLog(@"operation end %@", [NSThread currentThread]);
//    }];
//    NSLog(@"operation.isAsynchronous = %d", operation.isAsynchronous);  // operation.isAsynchronous = 0
//    
//    // While the current thread is blocked, the receiver continues to launch already queued operations and monitor those that are executing. During this time, the current thread cannot add operations to the queue, but other threads may.【并不会阻塞主线程。只是不能继续往queue增加操作，要等queue里已经有的操作执行完毕，才能增加新的操作。】
//    [queue waitUntilAllOperationsAreFinished];
//    
//    // 3.将操作添加到队列
//    [queue addOperation:operation];  // 不会阻塞主线程
//    //    [queue addOperations:@[operation] waitUntilFinished:YES];  // 会阻塞主线程，但仍然会在number = 2的线程执行block里的代码
//    
//    NSLog(@"operation.isAsynchronous = %d", operation.isAsynchronous);  // operation.isAsynchronous = 0
//    
//    NSLog(@"end %@", [NSThread currentThread]);
//}
//
//- (void)YZJDownloadImageOperationTest{
//    NSURL *url = [NSURL URLWithString:@"http://img1.gtimg.com/sports/pics/hv1/27/154/2072/134771097.jpg"];
//    YZJDownloadImageOperation *operation = [[YZJDownloadImageOperation alloc] initWithURL:url imageView:self.imageView];
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
//}
@end
