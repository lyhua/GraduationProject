//
//  EmoticonAttachment.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/12.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "EmoticonAttachment.h"

@implementation EmoticonAttachment

//便利构造方法
-(instancetype)initWithEmotion:(Emoticon *)emotion
{
    self.emoticon = emotion;
    return [super initWithData:nil ofType:nil];
}

@end
