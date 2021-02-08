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
    [self addTitle:@"1.00030" subTitle:[self removeFloatAllZero:@"1.00030" decimalPointNum:2]];
    [self addTitle:@"1.00030" subTitle:[self removeFloatAllZero:@"1.00030" decimalPointNum:4]];
    [self addTitle:@"1234.1 * 0.05" subTitle:[self textChange:@"1234.1" rate:0.05]];
    
    [self addTitle:@"roundingOff:1.246" subTitle:[self roundingOff:1.246]];  // 1.25
    [self addTitle:@"roundingOff:1.244" subTitle:[self roundingOff:1.244]];  // 1.24
}

///
- (NSString*)roundingOff:(CGFloat)num
{
    // 会四舍五入，1.246的结果为1.25，1.244的结果为1.24
    NSString *str = [NSString stringWithFormat:@"%.2f", num];
    return str;
}

/// 删除浮点数小数点后多余的0
- (NSString*)removeFloatAllZero:(NSString*)string
{
    NSString * testNumber = string;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}

/// 删除浮点数多余的0，并且能做到最多保留num位小数，如1.00030，num为2，则结果为1；1.00030，num为4，则结果为1.0003
/// @param num 小数点位数
- (NSString*)removeFloatAllZero:(NSString*)string decimalPointNum:(NSUInteger)num
{
    NSString *format = [NSString stringWithFormat:@"%@%lu%@", @"%0.", (unsigned long)num, @"f"];
    NSString *str = [NSString stringWithFormat:format, string.floatValue];
    NSString *str1 = [NSString stringWithFormat:@"%@",@(str.floatValue)];
    return str1;
}

#pragma mark - 精度
/*
 iOS float存储占用4字节，32位，有效位数为7位，小数点后6位精度没有问题，小数点后10位会存在精度问题[3]
 double或CGFloat是64位，有效位数为16位，小数点后15位精度没有问题
有两种方法： 一是手动修正手续费的值，如加0.000001；二是使用NSDecimalNumber，也是最推荐的方式
 参考文献：1.iOS恶心的Double精度
 2.iOS开发NSDecimalNumber的基本使用，加、减、乘、除、指数、比较
 3.iOS浮点数精度问题
 
*/
- (NSString*)textChange:(NSString *)text rate:(CGFloat)rate{
    NSDecimalNumber *inputNumber = [[NSDecimalNumber alloc] initWithString:text];
    NSDecimalNumber *rateNumber = [[NSDecimalNumber alloc] initWithFloat:rate];
    // 四舍五入
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:false raiseOnOverflow:false raiseOnUnderflow:false raiseOnDivideByZero:false];
    NSDecimalNumber *resultNumber = [inputNumber decimalNumberByMultiplyingBy:rateNumber withBehavior:handler];;
    NSLog(@"resultNumber%@",resultNumber);
    return resultNumber.stringValue;
}

@end
