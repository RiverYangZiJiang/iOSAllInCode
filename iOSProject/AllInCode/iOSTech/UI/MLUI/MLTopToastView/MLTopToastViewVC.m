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
@property (strong, nonatomic) MLTopToastView *offlineToastView;
@property (strong, nonatomic) MLTopToastView *locationToastView;
@end

@implementation MLTopToastViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMJWeak(self);
    LMJWordItem *item00 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeDownloadSuccess" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
        [weakself.successToastView autoShowAndHide];
    }];
    LMJWordItem *item01 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeNetworkUnavailable" subTitle:@"show" itemOperation:^(NSIndexPath *indexPath) {
        [weakself.networkUnavailableToastView showWithView:weakself.tableView];
    }];
    LMJWordItem *item02 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeNetworkUnavailable" subTitle:@"hide" itemOperation:^(NSIndexPath *indexPath) {
        [weakself.networkUnavailableToastView hideWithView:weakself.tableView];
    }];
    LMJWordItem *item03 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeOffline" subTitle:nil itemOperation:^(NSIndexPath *indexPath) {
       [weakself.offlineToastView autoShowAndHide];
    }];
    LMJWordItem *item04 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeOpenLocation" subTitle:@"show" itemOperation:^(NSIndexPath *indexPath) {
        [weakself.locationToastView show];
    }];
    LMJWordItem *item05 = [LMJWordItem itemWithTitle:@"MLTopToastViewTypeOpenLocation" subTitle:@"hide" itemOperation:^(NSIndexPath *indexPath) {
        [weakself.locationToastView hide];
    }];
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01, item02, item03, item04, item05] andHeaderTitle:nil footerTitle:nil];
    [self.sections addObjectsFromArray:@[section0]];
}

#pragma mark -
- (MLTopToastView *)successToastView{
    if (!_successToastView) {
        _successToastView = [MLTopToastView toastViewWithMsg:@"The tool was successfully downloaded and added to My Tools." type:MLTopToastViewTypeDownloadSuccess superView:self.view];
    }
    return _successToastView;
}

- (MLTopToastView *)networkUnavailableToastView{
    if (!_networkUnavailableToastView) {
        _networkUnavailableToastView = [MLTopToastView toastViewWithMsg:@"Network unavailable" type:MLTopToastViewTypeNetworkUnavailable superView:self.view];
    }
    return _networkUnavailableToastView;
}

- (MLTopToastView *)offlineToastView{
    if (!_offlineToastView) {
        _offlineToastView = [MLTopToastView toastViewWithMsg:@"You are in Offline-Mode" type:MLTopToastViewTypeOffline superView:self.view];
    }
    return _offlineToastView;
}

- (MLTopToastView *)locationToastView{
    if (!_locationToastView) {
        _locationToastView = [MLTopToastView toastViewWithMsg:@"Please report your location, so the dispatcher can assign task to you." type:MLTopToastViewTypeOpenLocation superView:self.view buttonTitle:@"TURN ON" block:^{
            NSLog(@"%s", __func__);
        }];
    }
    return _locationToastView;
}

@end
