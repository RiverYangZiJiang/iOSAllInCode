//
//  YZJUITextFieldVC.m
//  AllInCode
//
//  Created by hd on 2021/4/12.
//  Copyright © 2021 github.com/njhu. All rights reserved.
//

#import "YZJUITextFieldVC.h"

@interface YZJUITextFieldVC ()<UITextFieldDelegate>
///
@property (nonatomic, strong) UITextField *textField;
@end

@implementation YZJUITextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textField];
    self.textField.frame = CGRectMake(100, 100, 100, 100);
}

#pragma mark - UITextFieldDelegate

/// <#Description#>
/// @param textField The text field containing the text.此时textField只包括输入之前的字符，不包括正在输入的字符
/// @param range The range of characters to be replaced.输入第一个字符时为{0, 0}；删除最后一个字符时为{0, 1}
/// @param string The replacement string for the specified range. During typing, this parameter normally contains only the single new character that was typed, but it may contain more characters if the user is pasting text. When the user deletes one or more characters, the replacement string is empty.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
    NSLog(@"%s, text: %@, range: %@, replacementString: %@", __func__, textField.text, NSStringFromRange(range), string);
    return YES;
}


- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.delegate = self;
        _textField.placeholder = @"请输入";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}
@end
