//
//  YZJViewController.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "YZJViewController.h"
#import "LMJLiftCycleViewController.h"

@interface YZJViewController ()

@end

@implementation YZJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"UIViewController生命周期" subTitle:nil];
    item00.destVc = [LMJLiftCycleViewController class];
    self.addItem(item00);
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
