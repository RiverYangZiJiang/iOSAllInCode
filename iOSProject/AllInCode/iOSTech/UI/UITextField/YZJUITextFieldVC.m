//
//  YZJUITextFieldVC.m
//  AllInCode
//
//  Created by hd on 2021/4/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUITextFieldVC.h"
#import "YZJNSPredict.h"
#import "IQKeyboardManager.h"

@interface YZJUITextFieldVC ()<UITextFieldDelegate>
///
@property (nonatomic, strong) UITextField *textField;
@end

@implementation YZJUITextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textField];
    
    // 键盘右上角Done按钮标题改为完成
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.toolbarDoneBarButtonItemText = @"完成";

    self.textField.frame = CGRectMake(100, 100, 100, 100);
    
    /// 没有输入内容后立马调用的代理方法，只能监听
    [self.textField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - UITextFieldDelegate

/// Asks the delegate whether to begin editing in the specified text field.输入之前调用
/// @param textField <#textField description#>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
    return true;
}

/// 输入之前调用
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
}

/// <#Description#>
/// @param textField The text field containing the text.此时textField只包括输入之前的字符，不包括正在输入的字符
/// @param range The range of characters to be replaced.输入第一个字符时为{0, 0}；删除最后一个字符时为{0, 1}
/// @param string The replacement string for the specified range. During typing, this parameter normally contains only the single new character that was typed, but it may contain more characters if the user is pasting text. When the user deletes one or more characters, the replacement string is empty.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%s, text: %@, range: %@, replacementString: %@", __func__, textField.text, NSStringFromRange(range), string);
    
    // 防止输入或者粘贴非数字
    if (![string isEqualToString:@""] && ![YZJNSPredict isPureNumber:string]) {
        return NO;
    }
    [super textField:textField shouldChangeCharactersInRange:range replacementString:string];

    return YES;
}

/// 点击Done按钮或者UITextField将要EndEditing时调用
/// @param textField <#textField description#>
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [super textFieldShouldClear:textField];
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [super textFieldShouldReturn:textField];
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
    return true;
}

-(void)textFieldDidEditing:(UITextField *)textField {
    NSLog(@"%s, textField.text: %@", __func__, textField.text);
}

#pragma mark - Getters & Setters
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.placeholder = @"请输入";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}
@end
