//
//  NSString+URL.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "NSString+URL.h"
#import "Base.h"

@implementation NSString (URL)

+ (NSString *)urlWithRelativePath:(NSString *)relativePath
{
    return [BaseURL stringByAppendingString:relativePath];
}

@end
