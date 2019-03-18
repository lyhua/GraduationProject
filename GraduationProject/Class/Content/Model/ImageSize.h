//
//  ImageSize.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/7.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSize : NSObject <NSCoding>

//图片宽度
@property(nonatomic,assign)NSNumber *width;

//图片高度
@property(nonatomic,assign)NSNumber *height;

// 图片数组静态调用
+(NSMutableArray<ImageSize *>*)shareImageSize;

//pragma mark 图片尺寸数组归档(最多30条数据归档)
+(void)serializeImageSizes;

//获取图片尺寸归档数据
+(void)unserializeImageSizes;

// imageSize 归档方法
-(void)encodeWithCoder:(NSCoder *)aCoder;

//imageSize 解归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder;

//静态图片模型用于向评论传递模型
+(ImageSize *)shraeSize;

//改变静态图片尺寸
+(void)changeWithImageSize:(ImageSize *)imageSize;


@end
