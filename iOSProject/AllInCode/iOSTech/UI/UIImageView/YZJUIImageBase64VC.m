//
//  YZJUIImageBase64VC.m
//  AllInCode
//
//  Created by hd on 2021/2/20.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUIImageBase64VC.h"
//#import "MF_Base64Additions.h"

@interface YZJUIImageBase64VC ()
///
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *imageView1;

@end


@implementation YZJUIImageBase64VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
    self.imageView.image = [YZJUIImageBase64VC stringToImage:MLBase64Str];
    
    [self.view addSubview:self.imageView1];
    self.imageView1.frame = CGRectMake(100, 200, 100, 100);
    self.imageView1.image = [YZJUIImageBase64VC stringToImage:MLBase64Str1];
}

/// 64base字符串转图片
+ (UIImage *)stringToImage:(NSString *)str {
    
    // MLBase64Str1必须使用下行代码，在后面加==；MLBase64Str加了==反而不行
//    str = [MF_Base64Codec base64StringFromBase64UrlEncodedString:str];
    // 删除data:image/png;base64,   否则转换图片失败
    NSRange range = [str rangeOfString:@"base64,"];
    if (range.length > 0) {
        str = [str substringFromIndex:NSMaxRange(range)];
    }
    
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData];
    return photo;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_activity"]];
    }
    return _imageView;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_activity"]];
    }
    return _imageView1;
}
@end


