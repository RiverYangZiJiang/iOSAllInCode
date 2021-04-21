//
//  UIButton+CPRedPointExtension.m
//  ChargePlatform
//
//  Created by 周明 on 2020/9/3.
//  Copyright © 2020 EverGrande. All rights reserved.
//

#import "UIButton+CPRedPointExtension.h"

@interface UIButton ()

@property (nonatomic, strong) UIView *redView;

@end

@implementation UIButton (CPRedPointExtension)


- (void)cp_showRedPoint:(BOOL)showOrHide {
    if(self.redView == nil){
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(17, 2, 5, 5)];
        self.redView.layer.cornerRadius = 5/2;
        self.redView.backgroundColor = [UIColor redColor];
        [self addSubview:self.redView];
    }
    self.redView.hidden = !showOrHide;
    
}
static char redViewKey ;

- (void)setRedView:(UIView *)redView {
    objc_setAssociatedObject(self, &redViewKey, redView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)redView {
    return objc_getAssociatedObject(self,  &redViewKey);
}

- (void)setPointOrign:(CGPoint )point {
    self.redView.origin = point;
}

@end
