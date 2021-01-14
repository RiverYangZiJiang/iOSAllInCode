//
//  YZJVerticalStringVC.m
//  AllInCode
//
//  Created by hd on 2021/1/13.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJVerticalStringVC.h"
#import "UILabel+MLCategory.h"

@interface YZJVerticalStringVC ()

@end

@implementation YZJVerticalStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self verticalLabel2];
}

- (void)vl1 {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"你好世界 世界"];
        
        CFBooleanRef flag = kCFBooleanTrue;
        [str addAttribute:(id)kCTVerticalFormsAttributeName value:(__bridge id)flag range:NSMakeRange(0, [str length])];
        
        [str addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, [str length])];
        
        //下划线
        [str addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] range:NSMakeRange(0, 4)];
        //下划线颜色
        [str addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:NSMakeRange(0, 4)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];;
        label.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:label];
        
        label.attributedText = str;
        
        //label.transform = CGAffineTransformMakeRotation(M_PI_2);

        label.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0,1);

}
- (void)verticalLabel2 {
    NSString *string = @"北冥有鱼，其名为鲲。";
     UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(self.view.bounds.size.width * 0.5, 100, 300, 600))];
     // 实际frame为(187.5 100; 17.3333 203);
     label.textColor = [UIColor redColor];
     label.verticalText = string;
     [label sizeToFit];//顶部显示
     [self.view addSubview:label];
}

@end
