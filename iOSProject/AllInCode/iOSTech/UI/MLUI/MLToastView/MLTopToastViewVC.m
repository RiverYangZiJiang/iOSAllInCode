//
//  MLTopToastViewVC.m
//  AllInCode
//
//  Created by 杨子江 on 3/17/19.
//  Copyright © 2019 github.com/njhu. All rights reserved.
//

#import "MLTopToastViewVC.h"
#import "MLTopToastView.h"

@interface MLTopToastViewVC ()
@property (strong, nonatomic) MLTopToastView *successToastView;
@property (strong, nonatomic) MLTopToastView *networkUnavailableToastView;
@property (strong, nonatomic) MLTopToastView *offlineleToastView;
@property(assign, nonatomic) BOOL hadShownNetworkUnavailableToastView;
@end

@implementation MLTopToastViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWordItem *item00 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeDownloadSuccess" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [self showSuccessToastView];
    }];
    LMJWordItem *item01 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeNetworkUnavailable" subTitle:@"show" itemOperation:^(NSIndexPath *indexPath) {
        [self showNetworkUnavailableToastView];
    }];
    LMJWordItem *item02 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeNetworkUnavailable" subTitle:@"hide" itemOperation:^(NSIndexPath *indexPath) {
        [self hideNetworkUnavailableToastView];
    }];
    LMJWordItem *item03 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeOffline" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [self showOfflineleToastView];
    }];
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01, item02, item03] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
    
    [self.view addSubview:self.networkUnavailableToastView];
    CGFloat networkUnavailableToastViewH = [MLTopToastView heightForMsg:@"Network unavailable"];
    self.networkUnavailableToastView.frame = CGRectMake(0, -networkUnavailableToastViewH + NavigationBar_Height + StatusBar_Height, kScreenWidth, networkUnavailableToastViewH);
 
    [self.view addSubview:self.offlineleToastView];
    CGFloat offlineleToastViewH = [MLTopToastView heightForMsg:@"You are in Offline-Mode"];
    self.offlineleToastView.frame = CGRectMake(0, -offlineleToastViewH + NavigationBar_Height + StatusBar_Height, kScreenWidth, offlineleToastViewH);
    
    [self.view addSubview:self.successToastView];
    CGFloat successToastViewH = [MLTopToastView heightForMsg:@"The tool was successfully downloaded and added to My Tools."];
    self.successToastView.frame = CGRectMake(0, -successToastViewH + NavigationBar_Height + StatusBar_Height, kScreenWidth, successToastViewH);
}

- (void)showSuccessToastView{
    [UIView animateWithDuration:1 animations:^{
        self.successToastView.lmj_y += self.successToastView.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            self.successToastView.lmj_y -= self.successToastView.height;
        }];
    }];
}

- (void)showOfflineleToastView{
    [UIView animateWithDuration:1 animations:^{
        self.offlineleToastView.lmj_y += self.offlineleToastView.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            self.offlineleToastView.lmj_y -= self.offlineleToastView.height;
        }];
    }];
}

- (void)showNetworkUnavailableToastView{
    if (self.hadShownNetworkUnavailableToastView) {
        return;
    }
    
    self.hadShownNetworkUnavailableToastView = YES;
    
    self.networkUnavailableToastView.lmj_y += self.networkUnavailableToastView.height;
    self.tableView.lmj_y += self.networkUnavailableToastView.height;
    self.tableView.height -= self.networkUnavailableToastView.height;
}

- (void)hideNetworkUnavailableToastView{
    if (!self.hadShownNetworkUnavailableToastView) {
        return;
    }
    
    self.hadShownNetworkUnavailableToastView = NO;
    
    self.networkUnavailableToastView.lmj_y -= self.networkUnavailableToastView.height;
    self.tableView.lmj_y -= self.networkUnavailableToastView.height;
    self.tableView.height += self.networkUnavailableToastView.height;
}

#pragma mark -
- (MLTopToastView *)successToastView{
    if (!_successToastView) {
        _successToastView = [MLTopToastView successToastViewWithMsg:@"The tool was successfully downloaded and added to My Tools." type:MLTopToastViewTypeDownloadSuccess];
    }
    return _successToastView;
}

- (MLTopToastView *)networkUnavailableToastView{
    if (!_networkUnavailableToastView) {
        _networkUnavailableToastView = [MLTopToastView successToastViewWithMsg:@"Network unavailable" type:MLTopToastViewTypeNetworkUnavailable];
    }
    return _networkUnavailableToastView;
}

- (MLTopToastView *)offlineleToastView{
    if (!_offlineleToastView) {
        _offlineleToastView = [MLTopToastView successToastViewWithMsg:@"You are in Offline-Mode" type:MLTopToastViewTypeOffline];
    }
    return _offlineleToastView;
}


@end
