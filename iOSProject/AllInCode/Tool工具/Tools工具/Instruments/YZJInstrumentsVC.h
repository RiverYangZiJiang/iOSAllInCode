//
//  YZJInstrumentsVC.h
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "LMJStaticTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZJInstrumentsVC : LMJStaticTableViewController
/**
 1.可能会查看不到源码，只是显示16进制的数据。此时需要你在Xcode的Build Setting的Debug Information Format中检查是否有dSYM File生成，如选择DWARF with dSYM File即可[1]。
 2.选择Call Tree勾选两个选项,Invert Call Tree 和Hide System Libraries。Invert Call Tree 这个选项可以快捷的看到方法调用路径最深方法占用CPU耗时.把调用层级最深的方法显示在最上面，更容易找到最耗时的操作。
 Hide System Libraries英文再不好的也可以看懂,应该不用解释(隐藏系统的函数)。
 3.双击右边的堆栈信息(E下的Stack Trace)，直接定位到代码[2]
 4.修改代码之后要重新Profile，并且要重新打开Leaks
 5.声明delegate为strong类型，简而言之，如果父VC持有子VC，并设置子VC的delegate为self（也就是父VC），这样的结果就是子VC也间接持有了父VC，造成循环引用，在Pop子VC的时候不会调用delloc。[3]
 6.CoreFoundation对象(C对象) : 只要函数中包含了create\new\copy\retain等关键字, 那么这些方法产生的对象, 就必须在不再使用的时候调用1次CFRelease或者其他release函数[3]
 7.图片没释放，instrument调试后，发现没被释放的全是imageIO，差不多就知道了，把读图的方式，从[UIImage imageNamed:@""],改成imageWithContentsOfFile，就可以了。[3][4]
 8.大次数循环内存暴涨问题，解决方法为在循环中创建自己的autoReleasePool，及时释放占用内存大的临时变量，减少内存占用峰值。[7]
 
 使用通知，别忘了移除; 使用presentViewController弹出新的控制器,别忘了dismiss等等。
 
 1.https://www.jianshu.com/p/e499ce63ed72 两分钟让你学会使用instruments leaks检测内存泄漏
 2.https://blog.csdn.net/kevintang158/article/details/79027274
 Instruments的Leaks检测内存泄漏
 3.https://www.jianshu.com/p/1d2f0cb0c2bf iOS内存泄漏的常见情况
 4.https://blog.csdn.net/u014773226/article/details/51536313 ios 内存使用陷阱 和imageNamed 、imageWithContentsOfFile:
 5.https://blog.csdn.net/qq_16121273/article/details/50176825 iOS性能优化之内存管理：Analyze、Leaks、Allocations的使用和案例代码
 6.https://www.aliyun.com/jiaocheng/357961.html iOS八种内存泄漏问题
 7.https://www.jianshu.com/p/f5bc47607613 ios的几种内存泄漏
 */

/**
 内存空间的划分: 我们知道，一个进程占用的内存空间，包含5种不同的数据区：（1）BSS段：通常是存放未初始化的全局变量；（2）数据段：通常是存放已初始化的全局变量。（3）代码段：通常是存放程序执行代码。（4）堆：通常是用于存放进程运行中被动态分配的内存段 ， OC对象（所有继承自NSObject的对象）就存放在堆里。（5）栈：由编译器自动分配释放，存放函数的参数值，局部变量等值。
 
 栈内存是系统来管理的，因此我们常说的内存管理，指的是堆内存的管理，也就是所有OC对象的创建和销毁的管理。伴随着iOS5的到来，苹果推出了ARC（自动引用计数）技术，此模式下编译器会自动在合适的地方插入retain、release、autorelease语句，也就是说编译器会自动生成内存管理的代码，解放了广大程序猿的双手，也基本上避免了内存泄露问题[5]
 */
@end

NS_ASSUME_NONNULL_END
