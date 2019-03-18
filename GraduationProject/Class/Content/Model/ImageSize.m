//
//  ImageSize.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/7.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "ImageSize.h"
#import "LYHConst.h"
#import "Base.h"

@implementation ImageSize


#pragma mark 改变静态图片尺寸
+(void)changeWithImageSize:(ImageSize *)imageSize
{
    [ImageSize shraeSize].width = imageSize.width;
    [ImageSize shraeSize].height = imageSize.height;
}

#pragma mark 静态图片模型用于向评论传递模型
+(ImageSize *)shraeSize
{
    static ImageSize *imageSize;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageSize = [[ImageSize alloc] init];
    });
    return imageSize;
}

#pragma mark 图片数组静态调用
+(NSMutableArray<ImageSize *>*)shareImageSize
{
    static NSMutableArray<ImageSize *>* imageSizes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageSizes = [[NSMutableArray alloc] init];
    });
    return imageSizes;
}

#pragma mark 图片尺寸数组归档(最多30条数据归档)
+(void)serializeImageSizes
{
    //可以归档的数据(因为归档条数和内容一样就不定义新的宏了)
    NSInteger saveCount = (LYHSaveContentsCount <[ImageSize shareImageSize].count) ? LYHSaveContentsCount : [ImageSize shareImageSize].count;
    //图片尺寸归档
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    for (NSInteger i = 0; i < saveCount; i++) {
        NSString *fileName = [LYHImageSizesData stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)i]];
        NSString *filePath = [documentsDir stringByAppendingPathComponent:fileName];
        [NSKeyedArchiver archiveRootObject:[ImageSize shareImageSize][i] toFile:filePath];
    }
}

#pragma mark 获取图片尺寸归档数据
+(void)unserializeImageSizes
{
    //内容解归档
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //从归档取出一共有多少(应为和内容一样)
    NSString *countFilePath = [documentsDir stringByAppendingPathComponent:LYHContentsCount];
    NSString *myCount = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithFile:countFilePath];
    NSInteger count = [myCount integerValue];
    //取出归档数据
    for(NSInteger i=0; i<count; i++)
    {
        NSString *fileName = [LYHImageSizesData stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)i]];
        NSString *filePath = [documentsDir stringByAppendingPathComponent:fileName];
        //取出内容数据然后添加到Contents中
        ImageSize *imageSize = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        [[ImageSize shareImageSize] addObject:imageSize];
        
    }
}


#pragma mark imageSize 归档方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.width forKey:NSStringFromSelector(@selector(width))];
    [aCoder encodeObject:self.height forKey:NSStringFromSelector(@selector(height))];
}


#pragma mark imageSize 解归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _width = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(width))];
        _height = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(height))];
    }
    return self;
}

@end
