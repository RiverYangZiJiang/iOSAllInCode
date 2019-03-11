//
//  OCDevelopmentNorms.h
//  OCTest
//
//  Created by yangzijiang on 07/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 Objective-C开发规范
 */
@interface OCDevelopmentNorms : UIViewController

/**
 名称
 */
@property (copy, nonatomic) NSString *name;

/**
 获取用户信息

 @param name 名称
 @param age 年龄
 */
- (void)getUserInfo:(NSString *)name age:(NSUInteger)age;
@end



