//
//  Emoticon.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "Emoticon.h"
#import "NSString+NSString_emoji.h"

@implementation Emoticon

//便利构造方法
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//便利构造方法(删除按钮)
-(instancetype)initWithIsRemoved:(BOOL)isRemoved
{
    self.isRemoved = isRemoved;
    return [super init];
}

//便利构造方法(空格按钮)
-(instancetype)initWithIsEmpty:(BOOL)isEmpty
{
    self.isEmpty = isEmpty;
    return [super init];
}


//重写imagePath getter方法
-(NSString *)imagePath
{
    if (self.png == nil) {
        return @"";
    }
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingString:@"/Emoticons.bundle/"];
    return [path stringByAppendingString:self.png];
}

//重写emoji getter方法
-(NSString *)emoji
{
    //返回16进制转换成Unicode字符窜
    if (self.code == nil) {
        return nil;
    }
    return self.code.emoji;
}

@end
