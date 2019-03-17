//
//  UILabelViewController.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/4/27.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "UILabelViewController.h"
#import "YZJScrollLabel.h"

@interface UILabelViewController ()
@property (strong, nonatomic) YZJScrollLabel *scrollLabel;
@end

@implementation UILabelViewController

/**
 对于输入内容可能超过一行的情况，用UITextView，限制其高度和一行差不多高即可
 对于显示内容可能超过一行的情况
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    CGFloat y = 50;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, y, 200, 50)];
    lable.text = @"In a storyboard-based application, you will often want to do a little preparation before navigation";
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    lable.font = [UIFont systemFontOfSize:18];
    // 如果没有超出
//    [lable setAdjustsFontSizeToFitWidth:YES];
//    [lable setMinimumScaleFactor:0.7];
    [self.view addSubview:lable];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, y += 70, 200, 50)];
    textView.text = @"In a storyboard-based application, you will often want to do a little preparation before navigation";
    textView.textContainer.maximumNumberOfLines = 1;
    textView.textContainer.lineBreakMode = NSLineBreakByCharWrapping;
    textView.editable = NO;
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
//    textView.alwaysBounceHorizontal = YES;
//    textView.alwaysBounceVertical = NO;
    textView.font = [UIFont systemFontOfSize:15];
    textView.backgroundColor = [UIColor clearColor];
//    CGSize s = [textView.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(3100, 50)  lineBreakMode:UILineBreakModeCharacterWrap];//求文本的大小
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    textView.contentSize = textSize;
    // 这样就会导致很多内容没办法显示
//    textView.frame = CGRectMake(100, y, s.width, 50);
    [self.view addSubview:textView];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(100, y += 70, 200, 50)];
    field.text = @"In a storyboard-based application, you will often want to do a little preparation before navigation";
//    field.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:field];
    
    YZJScrollLabel *scrollLabel = [[YZJScrollLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) text:@"In a storyboard-based application, you will often want to do a little preparation before navigation" font:[UIFont systemFontOfSize:18]];
//    scrollLabel.label.font = [UIFont systemFontOfSize:30];
    
    [self.view addSubview:scrollLabel];
    self.scrollLabel = scrollLabel;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
    self.scrollLabel.frame = CGRectMake(100, 400, 200, 50);
    self.scrollLabel.label.text = @"[[YZJScrollLabel alloc] initWithFrame:CGRectMake(100, y += 70, 10, 50)";
    [self.scrollLabel setNeedsLayout];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"%s", __func__);
//    self.scrollLabel.frame = CGRectMake(100, 400, 200, 50);
//    self.scrollLabel.label.text = @"[[YZJScrollLabel alloc] initWithFrame:CGRectMake(100, y += 70, 10, 50)";
//    [self.scrollLabel setNeedsLayout];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
