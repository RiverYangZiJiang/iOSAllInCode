//
//  NSTimerTest.h
//  OCTest
//
//  Created by yangzijiang on 10/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimerTest : NSObject
+ (instancetype)defaultInstance;
- (void)startTimer;
- (void)startTimerFire;

@end
/**
 使用MSWeakTimer来代替NSTimer，在delloc方法中invalidate即可。以避免循环引用(retain it's target)、必须保持创建NSTimer和发送消息的线程一致(否则定时器可能不会被从它的runloop removed)、定时不准(和模式相关)的问题。https://github.com/mindsnacks/MSWeakTimer
 NSTimer会retain target对象，如果在控制器中使用循环定时器或者返回时定时时间还没到，如果这个控制器也强引用了定时器，则控制器返回之后也不会被释放，即控制器的delloc方法不会被调用
 NSTimer不支持暂停和继续，只能停止
 NSTimer不支持后台运行（真机），但是模拟器上App进入后台的时候，NSTimer还会持续触发。真机进入后台timer会停。
 timer会在未来的某个时刻执行一次或者多次我们指定的方法，这也就牵扯出一个问题，如何保证timer在未来的某个时刻触发指定事件的时候，我们指定的方法是有效的呢？
 解决方法很简单，只要将指定给timer的方法的接收者retain一份就搞定了，实际上系统也是这样做的。不管是重复性的timer还是一次性的timer都会对它的方法的接收者进行retain，这两种timer的区别在于“一次性的timer在完成调用以后会自动将自己invalidate，而重复的timer则将永生，直到你显示的invalidate它为止”。
 
 参考文章：NSTimer的坑 https://www.jianshu.com/p/26977c7bfb19?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 关于定时器NSTimer的深入理解
 https://www.jianshu.com/p/0994b907450d?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 NSTimer定时器进阶——详细介绍，循环引用分析与解决
 https://www.jianshu.com/p/9e7e8c806ea3
 */
