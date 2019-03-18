//
//  UITextField+Category.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

//创建自定义输入框(圆角 有占位符)
+(UITextField *)createMyTextFieldWithPlaceholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyboardType;
+(UITextField *)createMyTextFieldWithTextAlignment:(NSTextAlignment)textAlignment placeholder:(NSString *)placeholder secureTextEntry:(BOOL)secureTextEntry borderStyle:(UITextBorderStyle)borderStyle keyboardType:(UIKeyboardType)keyboardType;
@end
