//
//  YZJWaterWaveVC.m
//  AllInCode
//
//  Created by 杨子江 on 1/6/21.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJWaterWaveVC.h"

@interface YZJWaterWaveVC ()

@property (strong, nonatomic) UILabel *percentLabel;
@property (strong, nonatomic) UILabel *chargeStatusLabel;
@end

@implementation YZJWaterWaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.waterWaveView];
    self.waterWaveView.percent  = 0;
    [self.waterWaveView startWave];
    
    [self.view addSubview:self.percentLabel];
    [self.view addSubview:self.chargeStatusLabel];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.waterWaveView.percent >= 1.0) {
        [self.waterWaveView stopWave];
    } else {
        self.waterWaveView.percent  += 0.1;
    }
    
    [self.waterWaveView startWave];
}

- (void)viewDidLayoutSubviews {
    self.waterWaveView.size = CGSizeMake(200, 200);
    self.waterWaveView.lmj_centerX = self.view.lmj_centerX;
    self.waterWaveView.lmj_centerY = self.view.lmj_centerY;
    
    self.waterWaveView.layer.cornerRadius = self.waterWaveView.width * 0.5;
    
    [self.percentLabel sizeToFit];
    self.percentLabel.lmj_x = self.waterWaveView.lmj_x;
    self.percentLabel.lmj_y = self.waterWaveView.lmj_y + 96;
    self.percentLabel.width = self.waterWaveView.width;
    
    [self.chargeStatusLabel sizeToFit];
    self.chargeStatusLabel.lmj_x = self.waterWaveView.lmj_x;
    self.chargeStatusLabel.lmj_y = self.percentLabel.lmj_bottom;
    self.chargeStatusLabel.width = self.waterWaveView.width;

}

- (TYWaterWaveView *)waterWaveView {
    if (!_waterWaveView) {
        _waterWaveView = [[TYWaterWaveView alloc] init];
        _waterWaveView.layer.borderColor = HEX_COLOR(0x3598F0).CGColor;
        _waterWaveView.layer.borderWidth = 0.5;
        _waterWaveView.backgroundColor = [UIColor whiteColor];
    }
    return _waterWaveView;
}

- (UILabel *)percentLabel {
    if (!_percentLabel) {
        _percentLabel = [UILabel labelWithText:@"52%" font:[UIFont fontWithName:@"DINAlternate" size: 37] textColor:[UIColor colorWithRed:8/255.0 green:21/255.0 blue:48/255.0 alpha:1.0] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    }
    return _percentLabel;
}

- (UILabel *)chargeStatusLabel {
    if (!_chargeStatusLabel) {
        _chargeStatusLabel = [UILabel labelWithText:@"充电中" font:[UIFont fontWithName:@"PingFangSC" size: 15] textColor:[UIColor colorWithRed:8/255.0 green:21/255.0 blue:48/255.0 alpha:1.0] textAlignment:NSTextAlignmentCenter numberOfLines:1];
    }
    return _chargeStatusLabel;
}


@end
