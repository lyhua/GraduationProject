//
//  NSString+NSString_emoji.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/10.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_emoji)

@property(nonatomic,strong) NSString* emoji;

//将整形转换成emoji表情
+ (NSString *)emojiWithIntCode:(long)intCode;

//将‘整形字符窜’转换成emoji表情
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

@end
