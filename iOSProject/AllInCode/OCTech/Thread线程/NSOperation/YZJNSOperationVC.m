//
//  YZJNSOperationVC.m
//  AllInCode
//
//  Created by hd on 2021/4/28.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJNSOperationVC.h"
#import "YZJCustomOperation.h"

@interface YZJNSOperationVC ()

@end

@implementation YZJNSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    WeakSelf
    self.addItem([LMJWordItem itemWithTitle:@"单独使用NSInvocationOperation" subTitle:@"创建线程？在哪个线程执行？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf useInvocationOperation];
    }])
    .addItem([LMJWordItem itemWithTitle:@"所在线程:" subTitle:@"" ])
    .addItem([LMJWordItem itemWithTitle:@"调用方法 addExecutionBlock:" subTitle:@"不用Queue，添加多个block，是否会开启子线程？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf useBlockOperationAddExecutionBlock];
    }])
    .addItem([LMJWordItem itemWithTitle:@"自定义Operation" subTitle:@"重写哪个方法即可？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf useCustomOperation];
    }]);
    
    
    // NSOperationQueue
    LMJWordItem *item10 = [LMJWordItem itemWithTitle:@"addOperationToQueue" subTitle:@"是否需要先创建Operation？默认是否并发执行？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf addOperationToQueue];
    }];
    LMJWordItem *item11 = [LMJWordItem itemWithTitle:@"addOperationWithBlockToQueue" subTitle:@"是否需要先创建Operation？默认是否并发执行？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf addOperationToQueue];
    }];
    LMJWordItem *item12 = [LMJWordItem itemWithTitle:@"串行队列" subTitle:@"maxConcurrentOperationCount为多少？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf setMaxConcurrentOperationCount:1];
    }];
    LMJWordItem *item13 = [LMJWordItem itemWithTitle:@"并行队列" subTitle:@"maxConcurrentOperationCount为多少？" itemOperation:^(NSIndexPath *indexPath) {
        [weakSelf setMaxConcurrentOperationCount:2];
    }];
    
    LMJItemSection *section1 = [LMJItemSection sectionWithItems:@[item10, item11, item12, item13] andHeaderTitle:@"NSOperationQueue" footerTitle:@"END"];
    
    [self.sections addObject:section1];
    
}

#pragma mark - NSOperation
/**
 * 使用子类 NSInvocationOperation
 */
- (void)useInvocationOperation {
    
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    // 2.调用 start 方法开始执行操作
    [op start];
}

/**
 * 任务1
 */
- (void)task1 {
    NSString *str = [NSString stringWithFormat:@"%@", [NSThread currentThread]];
    NSLog(@"%s, str: %@", __func__, str);
    LMJWordItem *item1 = self.sections[0].items[1];
    item1.subTitle = str;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRow:1 inSection:0 withRowAnimation:UITableViewRowAnimationFade];
    });
}

/**
 * 任务2
 */
- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);     // 打印当前线程
    }
}

/**
 * 使用子类 NSBlockOperation
 * 调用方法 addExecutionBlock:
 */
- (void)useBlockOperationAddExecutionBlock {
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 2.添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"7---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];          // 模拟耗时操作
            NSLog(@"8---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.调用 start 方法开始执行操作
    [op start];
}

/**
 * 使用自定义继承自 NSOperation 的子类
 */
- (void)useCustomOperation {
    // 1.创建 YSCOperation 对象
    YZJCustomOperation *op = [[YZJCustomOperation alloc] init];
    // 2.调用 start 方法开始执行操作
    [op start];
}

#pragma mark - NSOperationQueue
/**
 * 使用 addOperation: 将操作加入到操作队列中
 */
- (void)addOperationToQueue {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];

    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];

    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 如果只有1个操作也会开启新线程
    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1]; // [op1 start]
//    [queue addOperation:op2]; // [op2 start]
//    [queue addOperation:op3]; // [op3 start]
}

/**
 * 使用 addOperationWithBlock: 将操作加入到操作队列中
 */
- (void)addOperationWithBlockToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.使用 addOperationWithBlock: 添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

/**
 * 设置 MaxConcurrentOperationCount（最大并发操作数）
 */
- (void)setMaxConcurrentOperationCount:(NSInteger)count {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.设置最大并发操作数
    queue.maxConcurrentOperationCount = count;
//    queue.maxConcurrentOperationCount = 1; // 串行队列
// queue.maxConcurrentOperationCount = 2; // 并发队列
// queue.maxConcurrentOperationCount = 8; // 并发队列

    // 3.添加操作
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}
@end
