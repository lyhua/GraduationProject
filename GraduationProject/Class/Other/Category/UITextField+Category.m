//
//  UITextField+Category.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)
+(UITextField *)createMyTextFieldWithPlaceholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.borderStyle = borderStyle;
    textField.secureTextEntry = secureTextEntry;
    textField.keyboardType = keyboardType;
    return textField;
}
+(UITextField *)createMyTextFieldWithTextAlignment:(NSTextAlignment)textAlignment placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textField = [UITextField createMyTextFieldWithPlaceholder:placeholder secureTextEntry:secureTextEntry borderStyle:borderStyle keyboardType:keyboardType];
    textField.textAlignment = textAlignment;
    return textField;
}


@end
