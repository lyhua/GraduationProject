//
//  EmoticonPackage.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "EmoticonPackage.h"
#import "Emoticon.h"

@implementation EmoticonPackage


//便利构造方法
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.emoticons = [[NSMutableArray alloc] init];
        NSArray *array = nil;
        if(dict[@"id"]){
            self.id = [[NSString alloc] initWithString:dict[@"id"]];
        }
        if(dict[@"group_name_cn"])
        {
            self.group_name_cn = [[NSString alloc] initWithString:dict[@"group_name_cn"]];
        }
        if(dict[@"emoticons"])
        {
           array = [[NSArray alloc] initWithArray:dict[@"emoticons"]];
        }
        NSString *temp = nil;
        NSInteger index = 0;
        for (NSInteger i = 0; i < array.count; i++) {
            //判断index是否等于20
            if(index == 20)
            {
                [self.emoticons addObject:[[Emoticon alloc] initWithIsRemoved:YES]];
                index = 0;
                i--;
                continue;
            }
            index++;
            if (array[i][@"png"]) {
                temp = [self.id stringByAppendingString:@"/"];
                array[i][@"png"] = [temp stringByAppendingString:array[i][@"png"]];
            }
            [self.emoticons addObject:[[Emoticon alloc] initWithDictionary:array[i]]];
        }
        //添加空白按钮
        [self appendEmptyEmoticon];
    }
    return self;
}

//添加空白按钮
-(void)appendEmptyEmoticon
{
    //取表情的余数
    NSInteger count = self.emoticons.count % 21;
    //刚好有21个就不用添加空白按钮
    if (self.emoticons.count > 0 && count == 0) {
        return ;
    }
    for (NSInteger i = 0; i < (20 - count); i++) {
        [self.emoticons addObject:[[Emoticon alloc] initWithIsEmpty:YES]];
    }
    //最后一个添加删除按钮
    [self.emoticons addObject:[[Emoticon alloc] initWithIsRemoved:YES]];
}

@end
