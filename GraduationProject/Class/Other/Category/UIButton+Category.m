//
//  UIButton+Category.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "UIButton+Category.h"
#import "UIImage+Image.h"
#import "Base.h"

@implementation UIButton (Category)


//创建一个自定义按钮
+(UIButton *)createMyButtonWithTitle:(NSString *)title backgroudColor:(UIColor *)backgroudColor borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat )borderWidth textColor:(UIColor *)textColor
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateDisabled];
    //设置背景灰色
    [btn setBackgroundImage:[UIImage imageWithColor:LYHColor(232, 230, 232)] forState:UIControlStateDisabled];
    btn.backgroundColor = backgroudColor;
    btn.titleLabel.textColor = textColor;
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:cornerRadius];
    [btn.layer setBorderWidth:borderWidth];
    [btn.layer setBorderColor:borderColor];
    return btn;
}


//创建一个自定按钮(没有边界)
+(UIButton *)createMyButtonWithoutBorder:(NSString *)title backgroudColor:(UIColor *)backgroudColor textColor:(UIColor *)textColor
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateDisabled];
    btn.backgroundColor = backgroudColor;
//    btn.titleLabel.textColor = textColor;
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    return btn;
}

//创建一个自定义按钮有字体大小
+(UIButton *)createMyButtonWithTitleFont:(CGFloat)font title:(NSString *)title backgroudColor:(UIColor *)backgroudColor borderColor:(CGColorRef)borderColor cornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat )borderWidth textColor:(UIColor *)textColor
{
    UIButton *btn = [UIButton createMyButtonWithTitle:title backgroudColor:backgroudColor borderColor:borderColor cornerRadius:cornerRadius borderWidth:borderWidth textColor:textColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}

//设置按钮有图片
+(UIButton *)createMyButtonWithImage:(NSString *)image
{
    UIButton *btn = [[UIButton alloc] init];
    //设置普通图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //设置高亮图片
    [btn setImage:[UIImage imageNamed:[image stringByAppendingString:@"_highlighted"]] forState:UIControlStateHighlighted];
    return btn;
}




@end
