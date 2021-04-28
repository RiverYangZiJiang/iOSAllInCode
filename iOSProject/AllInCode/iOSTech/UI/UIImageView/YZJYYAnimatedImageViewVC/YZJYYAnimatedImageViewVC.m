//
//  YZJYYAnimatedImageViewVC.m
//  AllInCode
//
//  Created by hd on 2021/4/28.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJYYAnimatedImageViewVC.h"
/*YYAnimatedImageView能显示各种图片，详情可以参考官方demo。支持以下类型动画图像的播放/编码/解码:WebP, APNG, GIF。
支持以下类型静态图像的显示/编码/解码:WebP, PNG, GIF, JPEG, JP2, TIFF, BMP, ICO, ICNS。
支持以下类型图片的渐进式/逐行扫描/隔行扫描解码:PNG, GIF, JPEG, BMP。
 
 iOS14，YYAnimatedImageView加载图片失败问题分析https://www.jianshu.com/p/9c117dbe22a8
 */
@interface YZJYYAnimatedImageViewVC ()
///
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@end

@implementation YZJYYAnimatedImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    self.imageView.frame = self.view.bounds;
}

- (YYAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [[YYAnimatedImageView alloc] initWithImage:[YYImage imageNamed:@"pia"]];
    }
    return _imageView;
}

@end
