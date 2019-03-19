//
//  YZJMultiMedia_HardWareVC.m
//  AllInCode
//
//  Created by 杨子江 on 3/20/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJMultiMedia_HardWareVC.h"
#import "YZJAVAudioPlayer.h"

@implementation YZJMultiMedia_HardWareVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"Block" subTitle:nil];
    item00.destVc = [YZJAVAudioPlayer class];
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
    
}
@end
