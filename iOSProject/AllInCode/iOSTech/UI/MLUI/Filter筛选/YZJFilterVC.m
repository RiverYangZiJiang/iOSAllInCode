//
//  YZJFilterVC.m
//  AllInCode
//
//  Created by hd on 2021/3/25.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJFilterVC.h"
#import "YZJFilterView.h"
#import "MOFSPickerManager.h"
#import "NSDate+YZJNSDate.h"

@interface YZJFilterVC ()
///
@property (nonatomic, strong) YZJFilterView *statusView;
///
@property (nonatomic, strong) YZJFilterView *dateView;
///
@property (nonatomic, strong) NSDate *currDate;
///
@property (nonatomic, strong) YZJFilterView *allDayView;
@end

@implementation YZJFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.statusView];
    [self.view addSubview:self.dateView];
    [self.view addSubview:self.allDayView];
    
    CGFloat allDayViewW = 24 + ceil([self.allDayView.titleLabel widthForSingleLine]) + 2 + 16;
    [self.allDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-18);
        make.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(allDayViewW);
        make.height.mas_equalTo(24);
    }];
    
    CGFloat dateViewW = 24 + ceil([self.dateView.titleLabel widthForSingleLine]) + 2 + 16;
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allDayView.mas_left);
        make.top.equalTo(self.allDayView);
        make.width.mas_equalTo(dateViewW);
        make.height.mas_equalTo(24);
    }];
    
    CGFloat statusViewW = 24 + ceil([self.statusView.titleLabel widthForSingleLine]) + 2 + 16;
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateView.mas_left);
        make.top.equalTo(self.dateView);
        make.width.mas_equalTo(statusViewW);
        make.height.mas_equalTo(24);
    }];
}

- (YZJFilterView *)statusView {
    if (!_statusView) {
        _statusView = [[YZJFilterView alloc] initWitiTitle:@"充电中"];
        MJWeakSelf
        _statusView.viewTappedBlock = ^(YZJFilterView * _Nonnull view) {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"充电中" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DLog(@"充电中");
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"已完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DLog(@"已完成");
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                DLog(@"取消");
            }];
            
            [ac addAction:action1];
            [ac addAction:action2];
            [ac addAction:action3];
            
            [weakSelf presentViewController:ac animated:YES completion:nil];
        };
    }
    return _statusView;
}

- (YZJFilterView *)dateView {
    if (!_dateView) {
        self.currDate = [NSDate date];
        NSString *dateStr = [self.currDate stringWithFormat:@"MM月dd日"];
        _dateView = [[YZJFilterView alloc] initWitiTitle:dateStr];
        MJWeakSelf
        _dateView.viewTappedBlock = ^(YZJFilterView * _Nonnull view) {
//            [weakSelf showSystemUIDatePicker];
            [weakSelf showMOFSPicker];
        };
    }
    return _dateView;
}

/* 继承自UIDatePicker，上方的取消、确认按钮，用UIToolBar实现
 
 */
- (void)showMOFSPicker {
    MJWeakSelf
    [[MOFSPickerManager shareManger].datePicker showWithSelectedDate:[NSDate date] commit:^(NSDate * _Nullable date) {
        DLog(@"commit date %@", [NSDate getCurr13BitTimeOfDate:date]);
        weakSelf.dateView.titleLabel.text = [date stringWithFormat:@"MM月dd日"];
    } cancel:^{
        DLog(@"cancel");
    }];
}
/* 系统DatePicker上方没有取消、确定按钮，要自己在上方加一个ToolBar
 1.iOS 14.0 UIDatePicker坑
 2.iOS之UIDatePicker实现时间日期选择
 3.时间选择器UIDatePicker的使用
 */
- (void)showSystemUIDatePicker {
    //创建一个UIPickView对象
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    //自定义位置
    CGFloat height = 150;

    //设置背景颜色
    datePicker.backgroundColor = [UIColor whiteColor];
    //datePicker.center = self.center;
    //设置本地化支持的语言（在此是中文)
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //显示方式是只显示年月日
    if (@available(iOS 13.4, *)) {
        datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    } else {
        // Fallback on earlier versions
    }
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.frame = CGRectMake(0, ScreenHeight - height, ScreenWidth, height);
    //放在盖板上
    [self.view addSubview:datePicker];
}

- (YZJFilterView *)allDayView {
    if (!_allDayView) {
        _allDayView = [[YZJFilterView alloc] initWitiTitle:@"全天"];
    }
    return _allDayView;
}

@end
