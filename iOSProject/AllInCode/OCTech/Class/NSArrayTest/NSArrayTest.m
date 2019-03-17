//
//  NSArrayTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/4/30.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSArrayTest.h"

@interface NSArrayTest()

@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation NSArrayTest

- (void)arrayTest{
    [self enumerateObjectsUsingBlockTest];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self sortAndRemoveCrash];
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self sortAndRemoveCrash];
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self sortAndRemoveCrash];
//    });
}

- (void)sortAndRemoveCrash{
    @synchronized(self){
        NSLog(@"%s, currentThread = %@", __func__, [NSThread currentThread]);
        self.arrayM = [NSMutableArray array];
        for(NSInteger i = 0; i <1000; i++){
            [self.arrayM addObject:[NSString stringWithFormat:@"%ld", (long)i]];
        }
        
        [self.arrayM sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSLog(@"%s, obj1 = %@, obj2 = %@", __func__, obj1, obj2);
            return obj1 > obj2;
        }];
        
        if(self.arrayM.count > 10){
            [self.arrayM removeObjectsInRange:NSMakeRange(10, self.arrayM.count - 10)];
            NSLog(@"%s after arrayM removeObjectsInRange", __func__);
        }
    }
}

/**
 enumerateObjectsUsingBlockTest跳出循环，其中return相当于for里面的continue；*stop类似于break，不过其只是一个标识，其后的代码会继续执行，只是下一次循环不再执行；return+*stop相当于for里面的break
 */
- (void)enumerateObjectsUsingBlockTest{
    // *stop
    NSArray *names = @[@"lzh", @"ysh", @"yys"];
    [names enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"lzh"]) {
            *stop = YES; // !!!这里并不会马上退出循环，而是执行完 block 中的代码才退出循环
        }
        NSLog(@"Name %@\n", obj);
    }];
    
    // return
    NSArray *arr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"return Before if - obj = %@", obj);
        if ([obj isEqualToString:@"3"]) {
            return;      // 仅跳出本次循环，相当于for里面的continue
        }
        NSLog(@"return After if - obj = %@", obj);
    }];
    
    // stop + return
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"stop + return Before if - obj = %@", obj);
        if ([obj isEqualToString:@"3"]) {
            *stop = YES;
            return;
            //stop 和 return配合使用，跳出本enum遍历，相当于for里面的break
        }
        NSLog(@"stop + return After if - obj = %@", obj);
    }];
    
    // 双层循环，stop + return仅跳出本enum，对外层enum无影响
    NSArray *arrson = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e", nil];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"@@@@@@@@@@@@@@@@ Before if - obj = %@", obj);
        [arrson enumerateObjectsUsingBlock:^(id  _Nonnull objson, NSUInteger idxson, BOOL * _Nonnull stopson) {
            NSLog(@"---------------------Before if - obj = %@", objson);
            if ([objson isEqualToString:@"b"]) {
                *stopson = YES;
                return;
            }
            NSLog(@"------------After if - obj = %@", objson);
        }];
        NSLog(@"@@@@@@@@@@@@@@@@ After if - obj = %@", obj);
    }];
//    作者：sunflower1518
//    链接：https://www.jianshu.com/p/9b71c1898211
//    來源：简书
//    简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
}
@end
