//
//  YZJDownloadImageOperation.h
//  IOSTest-1603
//
//  Created by 杨子江 on 5/22/16.
//  Copyright © 2016 杨子江. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! 定义NSOperation子类(类似Java的Runnable接口)，必须实现main方法，将该operation加到队列中时，会自动执行main方法里的代码
@interface YZJDownloadImageOperation : NSOperation

@property (strong, nonatomic) NSURL *url;
@property(nonatomic,weak) UIImageView *imageView;

- (id)initWithURL:(NSURL *)url imageView:(UIImageView *)imageView;

@end
