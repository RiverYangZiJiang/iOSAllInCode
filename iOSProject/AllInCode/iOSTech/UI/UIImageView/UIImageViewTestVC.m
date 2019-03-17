//
//  UIImageViewTestVC.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/18.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UIImageViewTestVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageViewTestVC ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation UIImageViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    self.imageView.frame = self.view.bounds;
    
    [self SDWebImageTest];
}

#pragma mark - SDWebImage
- (void)SDWebImageTest{
    NSURL *url = [NSURL URLWithString:@"https://s3-us-west-1.amazonaws.com/answermj-s3/icons/ic_scan_oval.png"];
    [self.imageView sd_setImageWithURL:url placeholderImage:IMAGE_BY_NAME(@"ic_star_big-1") options:SDWebImageRetryFailed];
}

#pragma mark - Custom Accessors
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
    }
    return _imageView;
}

@end
