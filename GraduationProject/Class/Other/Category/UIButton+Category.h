//
//  UIButton+Category.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIButton (Category)
//创建一个自定义按钮
+(UIButton *)createMyButtonWithTitle:(NSString *)title backgroudColor:(UIColor *)backgroudColor borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat )borderWidth textColor:(UIColor *)textColor;

//创建一个自定按钮(没有边界)
+(UIButton *)createMyButtonWithoutBorder:(NSString *)title backgroudColor:(UIColor *)backgroudColor textColor:(UIColor *)textColor;

//创建一个自定义按钮有字体大小
+(UIButton *)createMyButtonWithTitleFont:(CGFloat)font title:(NSString *)title backgroudColor:(UIColor *)backgroudColor borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat )borderWidth textColor:(UIColor *)textColor;

//设置按钮有图片
+(UIButton *)createMyButtonWithImage:(NSString *)image;

@end
