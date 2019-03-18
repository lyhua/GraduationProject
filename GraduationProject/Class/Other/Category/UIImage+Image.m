//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

//生成圆行图片
-(instancetype)circleImage
{
    // 1.开启图形上下文
    // 比例因素:当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域;
    [path addClip];
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

//根据图片名字生成圆行图片
+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

//生成没有被系统渲染的图片
+ (UIImage *)imageOriginalWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

//快速生成用UIColor指定纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//进行图片裁剪
+ (UIImage *)imageWithCutImage:(UIImage *)cutImage
{
    CGFloat width = cutImage.size.width;
    CGFloat height = cutImage.size.height;
    CGImageRef cgRef = cutImage.CGImage;
    UIImage *thumbScale = nil;
    CGImageRef imageRef = nil;
    //根据宽高进行截图
    if (width < height) {
        imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(0, (height - width) * 0.5, width, width));
//        thumbScale = [UIImage imageWithCGImage:imageRef];
        thumbScale = [UIImage imageWithCGImage:imageRef scale:cutImage.scale orientation:UIImageOrientationUp];
    }else{
        imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake((width - height) * 0.5, 0, height, height));
//        thumbScale = [UIImage imageWithCGImage:imageRef];
        thumbScale = [UIImage imageWithCGImage:imageRef scale:cutImage.scale orientation:UIImageOrientationUp];
    }
    return thumbScale;
}

//图片根据特定的宽高缩放
+ (UIImage *)resetImageSize:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    UIImage *image = [UIImage imageNamed:imageName];
//    UIGraphicsBeginImageContext(CGSizeMake(width,height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width,height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, width,height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

//生成特定的宽高没有渲染的图片
+ (UIImage *)createOriginalWithName:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    UIImage *image = [UIImage imageOriginalWithName:imageName];
//    UIGraphicsBeginImageContext(CGSizeMake(width,height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width,height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, width,height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

//生成原始图片颜色且指定大小
+(UIImage *)createOriginalWithSize:(NSString *)imageName width:(CGFloat)width height:(CGFloat)height
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width,height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, width,height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


@end
