//
//  Mission.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "Mission.h"
#import "Base.h"
#import "LYHConst.h"
#import "NSString+Category.h"

@implementation Mission

#pragma mark 内容数组静态调用方法
+(NSMutableArray<Mission*>*)shareMissions
{
    static NSMutableArray<Mission *> *missions;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        missions = [[NSMutableArray alloc] init];
    });
    return missions;
}


@end
