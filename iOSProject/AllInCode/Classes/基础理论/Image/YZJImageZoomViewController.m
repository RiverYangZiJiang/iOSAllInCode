//
//  YZJImageZoomViewController.m
//  iOSProject
//
//  Created by 杨子江 on 4/22/18.
//  Copyright © 2018 github.com/njhu. All rights reserved.
//

#import "YZJImageZoomViewController.h"

@interface YZJImageZoomViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation YZJImageZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = self.imageView.size;
    
    self.scrollView.delegate = self;
    
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.minimumZoomScale = 0.2;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    // 如果缩放大于1，则回到原大小
    if (self.scrollView.zoomScale > 1.0) {
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.scrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.view.width / newZoomScale;
        CGFloat ysize = self.view.height / newZoomScale;
        // 以点击位置为焦点进行缩放，这样点击位置会看得更清楚
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

#pragma mark - Custom Accessors
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        self.imageView.frame = _scrollView.bounds;
        [_scrollView addSubview:self.imageView];
        
        UITapGestureRecognizer *doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGR.numberOfTapsRequired = 2;
        [_scrollView addGestureRecognizer:doubleTapGR];
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_feature_1"]];
    }
    return _imageView;
}

@end
