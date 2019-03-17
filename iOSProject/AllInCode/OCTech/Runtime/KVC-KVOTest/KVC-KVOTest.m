//
//  KVC-KVOTest.m
//  OCTest
//
//  Created by 杨子江 on 11/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "KVC-KVOTest.h"

@implementation KVC_KVOTest
//- (void)kvcTest160424{
//    self.employee = [[Employee alloc] init];
//    [self.employee setValue:Name forKey:@"name"];  // 最简单的kvc
//    NSLog(@"%s self.employee = %@", __func__, self.employee);
//    
//    // 和字典连用的kvc
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"attributes" ofType:@"plist"];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    
//    Employee *employee = [[Employee alloc] init];
//    for (NSString *key in [dict allKeys]) {
//        [employee setValue:[dict objectForKey:key] forKey:key];
//    }
//    NSLog(@"%s employee = %@", __func__, employee);
//}
//
//- (void)kvoTest160424{
//    [self.employee addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    
//    // 只要重新赋值，哪怕是同样的值，都会调用observeValueForKeyPath方法
//    [self.employee setValue:Name forKey:@"name"];
//    //    [self.employee setValue:@"yzj1" forKey:@"name"];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"%s self.employee = %@", __func__, self.employee);
//}
//
//- (void)importDataWithKVC{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"attributes" ofType:@"plist"];
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSLog(@"dict = %@", dict);
//    
//    Employee *employee = [[Employee alloc] init];
//    
//    // 通过KVC给对象各成员变量赋值，哪怕是数组都可以，这种赋值可以放在对象初始化上
//    for (NSString *key in [dict allKeys]) {
//        [employee setValue:[dict objectForKey:key] forKey:key];
//    }
//    NSLog(@"employee%@", employee);
//    
//    Employee *employee1 = [[Employee alloc] initWithDictionary:dict];
//    NSLog(@"employee1%@", employee1);
//}
@end
