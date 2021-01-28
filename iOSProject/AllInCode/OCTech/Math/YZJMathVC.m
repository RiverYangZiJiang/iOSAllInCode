//
//  YZJMathVC.m
//  AllInCode
//
//  Created by 杨子江 on 3/20/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJMathVC.h"

@interface YZJMathVC ()

@end

@implementation YZJMathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:@"NSIntegerMax" subTitle:@(NSIntegerMax)];
    [self addTitle:@"NSIntegerMin" subTitle:@(NSIntegerMin)];
    [self addTitle:@"0.090222120000" subTitle:[self removeFloatAllZero:@"0.090222120000"]];
}

/// 删除浮点数小数点后多余的0
- (NSString*)removeFloatAllZero:(NSString*)string
{
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}


@end
