//
//  YZJScrollLabel.m
//  iosTest2017
//
//  Created by yangzijiang on 2018/4/27.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "YZJScrollLabel.h"

@implementation YZJScrollLabel

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        self.label = [[UILabel alloc] init];
        self.label.numberOfLines = 1;
        self.label.text = text;
        self.label.font = font;
        
        [self.scrollView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%s, self.frame = %@", __func__, NSStringFromCGRect(self.frame));
    
    self.scrollView.frame = self.bounds;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:self.label.font forKey:NSFontAttributeName];
    CGSize textSize = [self.label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    self.scrollView.contentSize = textSize;
    
    self.label.frame = CGRectMake(0, 0, textSize.width, self.bounds.size.height);
}

@end
