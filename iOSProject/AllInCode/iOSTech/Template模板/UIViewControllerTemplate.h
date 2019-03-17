//
//  UIViewControllerTemplate.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/2/15.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 生成控制器等类的模板测试，哪怕是基于基类生成控制器，模板也能生效
 Xcode系统模板的路径是/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/，文件夹里面有文件模板File Templates和工程模板Project Templates，分别对应创建文件时的选项和创建工程时的选项。我们用的最多就是File Templates/Source/Cocoa Touch Class.xctemplate里面的模板。
 
 Xcode自定义模板 http://www.cocoachina.com/ios/20170419/19087.html
 iOS自定义代码段模板（CodeSnippets）和文件模板(.xctemplate) https://www.jianshu.com/p/376f372497b5
 */
@interface UIViewControllerTemplate : UIViewController

@end
