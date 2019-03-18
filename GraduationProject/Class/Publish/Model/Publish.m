//
//  Publish.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/20.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "Publish.h"

@implementation Publish

//发布单例
+(instancetype)sharePublish
{
    static Publish *publish = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publish = [[self alloc] init];
    });
    return publish;
}

@end
