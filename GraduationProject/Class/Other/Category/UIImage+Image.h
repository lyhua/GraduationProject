//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

+ (UIImage *)imageWithColor:(UIColor *)color;

//进行图片裁剪
+ (UIImage *)imageWithCutImage:(UIImage *)cutImage;

//根据图片名字生成圆角图片
+ (instancetype)circleImageNamed:(NSString *)name;

//生成圆角图片
-(instancetype)circleImage;

//图片根据特定的宽高缩放
+ (UIImage *)resetImageSize:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height;

//生成特定的宽高没有渲染的图片
+ (UIImage *)createOriginalWithName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height;

//生成原始图片颜色且指定大小
+(UIImage *)createOriginalWithSize:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height;

@end
