//
//  YZJGCDVC.m
//  AllInCode
//
//  Created by hd on 2021/4/29.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJGCDVC.h"

@interface YZJGCDVC ()
/// <#注释#>
@property (nonatomic, assign) NSInteger ticketSurplusCount;

///
@property (nonatomic, strong) dispatch_semaphore_t semaphoreLock;
@end

@implementation YZJGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示内容不可点击
//    [self addTitle:@"title" subTitle:@"subTitle"];
    
    WeakSelf
    // 展示内容可点击不跳转
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_barrier_async" subTitle:@"" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf dispatch_barrier_async];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_semaphore" subTitle:@"使用信号量控制队列并发数" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf useSemaphoreSetQueueCorrNum];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_semaphore" subTitle:@"实现线程同步，将异步任务转换为同步任务" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf semaphoreSync];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_semaphore" subTitle:@"使用信号量加锁" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf initTicketStatusSave];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_group_notify" subTitle:@"执行顺序:notify前加入的-notify里的-notify后加入的" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf dispatch_group_notify];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_group_wait" subTitle:@"是否阻塞当前线程" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf dispatch_group_wait];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"dispatch_group_enter/leave" subTitle:@"相当于什么？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf groupEnterAndLeave];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"syncMain" subTitle:@"主线程中同步在主队列中执行任务会造成什么？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf syncMain];
    }]);
    
    // 不会开启新线程，执行完一个任务，再执行下一个任务
    self.addItem([LMJWordItem itemWithTitle:@"syncMain" subTitle:@"在其他线程中调用『同步执行 + 主队列』" itemOperation:^(NSIndexPath *indexPath) {
        // 使用 NSThread 的 detachNewThreadSelector 方法会创建线程，并自动启动线程执行 selector 任务
        [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"通知线程及同步" subTitle:@"主线程中发送通知?处理方法在哪个线程执行，是否阻塞对应线程?" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf sendNotiInMainThread];
    }]);
    
    self.addItem([LMJWordItem itemWithTitle:@"通知线程及同步" subTitle:@"新线程中发送通知?处理方法在哪个线程执行，是否阻塞对应线程?" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf sendNotiInNewThread];
    }]);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiInMainThread) name:@"sendNotiInMainThread" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiInNewThread) name:@"sendNotiInNewThread" object:nil];
}

/**
 * 栅栏方法 dispatch_barrier_async
 */
- (void)dispatch_barrier_async {
    NSLog(@"start---%@",[NSThread currentThread]);// 打印当前线程
    // 队列应该是你自己使用dispatch_queue_create函数创建的并发队列。如果传递给此函数的队列是串行队列或全局并发队列之一，则此函数的行为类似于dispatch_async函数。
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    // 提交屏障块以异步执行并立即返回，即barrier后面的代码会立即执行，barrier后面非queue里的代码会立即执行。代码块执行顺序：barrier后非队列里代码，barrier前队列里面代码，barrier里代码，barrier后队列里面代码
    dispatch_barrier_async(queue, ^{
        // 追加任务 barrier
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
    });
    NSLog(@"after barrier---%@",[NSThread currentThread]);// 打印当前线程
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 4
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"end---%@",[NSThread currentThread]);// 打印当前线程
}

#pragma mark - dispatch_semaphore_t信号量
- (void)useSemaphoreSetQueueCorrNum {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        // 每秒执行10个任务，执行完继续执行10个
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(1);
            dispatch_semaphore_signal(semaphore);
        });
    }
}

/**
 * semaphore 线程同步，利用 Dispatch Semaphore 实现线程同步，将异步执行任务转换为同步执行任务
 */
- (void)semaphoreSync {
    
    NSLog(@"start---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %zd",number);
    NSLog(@"end---%@",[NSThread currentThread]);
}

/**
 * 线程安全：使用 semaphore 加锁
 * 初始化火车票数量、卖票窗口（线程安全）、并开始卖票
 */
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    self.semaphoreLock = dispatch_semaphore_create(1);
    
    self.ticketSurplusCount = 50;
    
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe];
    });
}

/**
 * 售卖火车票（线程安全）
 */
- (void)saleTicketSafe {
    while (1) {
        // 相当于加锁
        dispatch_semaphore_wait(self.semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {  // 如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { // 如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            
            // 相当于解锁
            dispatch_semaphore_signal(self.semaphoreLock);
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(self.semaphoreLock);
    }
}

#pragma mark - 队列组：dispatch_group
/**
 * 队列组 dispatch_group_notify，当组里前面提交的块对象都完成，安排一个块对象提交到一个队列执行
 */
- (void)dispatch_group_notify {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面或后面的异步任务 1、2、4 都执行完毕后，回到主线程执行下边任务
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"dispatch_group_notify---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"group---begin");
}

/**
 * 队列组 dispatch_group_wait
 */
- (void)dispatch_group_wait {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    // (非group里任务无需等待)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 模拟耗时操作
        NSLog(@"dispatch_after---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"group---end");
    
}

/**
 * 队列组 dispatch_group_enter、dispatch_group_leave，当 group 中未执行完毕任务数为0的时候，才会使 dispatch_group_wait 解除阻塞，以及执行追加到 dispatch_group_notify 中的任务。dispatch_group_enter、dispatch_group_leave 组合，其实等同于dispatch_group_async
 */
- (void)groupEnterAndLeave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"groupEnterAndLeave---begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程

        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    
        NSLog(@"group---end");
    });
    NSLog(@"groupEnterAndLeave---end");
}

#pragma mark - 死锁
/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行，报Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
 */
- (void)syncMain {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"syncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"syncMain---end");
}

#pragma mark - 通知发送和接受线程及同步
/// 主线程发送通知
- (void)sendNotiInMainThread {
    NSLog(@"%s start, currentThread: %@", __func__, [NSThread currentThread]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendNotiInMainThread" object:nil];
    NSLog(@"%s end, currentThread: %@", __func__, [NSThread currentThread]);
}

/// 接受主线程发送通知
- (void)receiveNotiInMainThread {
    NSLog(@"%s start, currentThread: %@", __func__, [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1];  // 在主线程执行，并且会阻塞主线程一秒
    NSLog(@"%s end, currentThread: %@", __func__, [NSThread currentThread]);
}

/// 新线程发送通知
- (void)sendNotiInNewThread {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%s start, currentThread: %@", __func__, [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendNotiInNewThread" object:nil];
        NSLog(@"%s end, currentThread: %@", __func__, [NSThread currentThread]);
    });
}

/// 接受新线程发送通知
- (void)receiveNotiInNewThread {
    NSLog(@"%s start, currentThread: %@", __func__, [NSThread currentThread]);
    [NSThread sleepForTimeInterval:1];  // 在主线程执行，并且会阻塞主线程一秒
    NSLog(@"%s end, currentThread: %@", __func__, [NSThread currentThread]);
}

@end
