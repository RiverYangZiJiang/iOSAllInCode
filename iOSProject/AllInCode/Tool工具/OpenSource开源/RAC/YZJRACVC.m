//
//  YZJRACVC.m
//  AllInCode
//
//  Created by hd on 2021/7/11.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJRACVC.h"
#import <ReactiveObjC.h>
#import "CPButton.h"
@interface YZJRACVC ()
/// <#注释#>
@property (nonatomic, copy) NSString *userName;

///
@property (nonatomic, strong) CPButton *cancelButton;

///
@property (nonatomic, strong) UITextField *textField;
@end

@implementation YZJRACVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RACObserve(self, userName) subscribeNext:^(NSString *newName) {
        NSLog(@"newName: %@", newName);
    }];
    // 展示内容不可点击
//    [self addTitle:@"title" subTitle:@"subTitle"];
    
    // 展示内容可点击不跳转
    WeakSelf
    self.addItem([LMJWordItem itemWithTitle:@"subscribeNext" subTitle:@"监听属性值的变化" itemOperation:^(NSIndexPath *indexPath) {
        weakSelf.userName = @"abc";
    }]);
    
    [self.view addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        make.height.mas_equalTo(44);
    }];
    //
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"button点击事件");
    }];
    
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(10);
        make.height.mas_equalTo(44);
    }];
    @weakify(self);
    // 监听了输入框内所有的变化，包括准备编辑，和退出编辑。再也不用写delegate了，编码起来方便快捷！！
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
    @strongify(self);
        NSLog(@"self.textField x: %@", x);
//        self.textField.text = @"Hello";
    }];
    
    // 监听通知的各种事件，最重要的一点就是不需要移除通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
           NSLog(@"UIApplicationDidEnterBackgroundNotification: %@",x);
       }];
    
    // 展示内容可点击可跳转，默认加入section0
//    self.addItem([LMJWordArrowItem itemWithTitle:<#(NSString *)#> subTitle:<#(NSString *)#> destVc:<#(NSString *)#>]);
    
    // 展示内容可点击不可跳转，默认加入section0
//    self.addItem([LMJWordArrowItem itemWithTitle:<#(NSString *)#> subTitle:<#(NSString *)#> itemOperation:^(NSIndexPath *indexPath) {
//        <#code#>
//    }]);
    
    // 展示内容并且可以点击，section和item
//    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"MLUI" subTitle:@"自定义UI" destVc:@"destVc"];
//    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00] andHeaderTitle:@"UI" footerTitle:nil];
//    [self.sections addObjectsFromArray:@[section0]];
    
}

- (CPButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[CPButton alloc] initWithTitle:@"取消按钮" titleColor:[UIColor colorWithHexString:@"#5A6B80"] titleFont:[UIFont PingFangSC_RegularOfSize:12] doneBlock:nil];
    }
    return _cancelButton;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"监听了输入框内所有的变化";
        _textField.font = [UIFont PingFangSC_RegularOfSize:14];
        _textField.textColor = [UIColor colorWithHexString:@"#0F1C33"];
        _textField.textAlignment = NSTextAlignmentCenter;
    }
    return _textField;
}
@end
