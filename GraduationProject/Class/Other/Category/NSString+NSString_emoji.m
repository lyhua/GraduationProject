//
//  NSString+NSString_emoji.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/10.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

#import "NSString+NSString_emoji.h"

@implementation NSString (NSString_emoji)

//重写emoji getter方法
-(NSString *)emoji
{
    return [NSString emojiWithStringCode:self];
}

-(void)setEmoji:(NSString *)emoji
{
    self.emoji = emoji;
}

#pragma mark 将整形转换成emoji表情
+ (NSString *)emojiWithIntCode:(long)intCode {
    NSString * s = [NSString stringWithFormat:@"%ld",intCode];
    int symbol = EmojiCodeToSymbol([s intValue]);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

#pragma mark 将‘整形字符窜’转换成emoji表情
+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    long intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}


@end
