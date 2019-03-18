//
//  NSString+Category.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/6.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonDigest.h>

@interface NSString (Category)
+ (NSString *) md5:(NSString *) input;

//获取当前星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

//根据日期字符窜格式返回字符窜
+(NSString *)dateWithFormatter:(NSString *)dateFormatter;

//字符窜的分割（用于处理图片地址）
+(NSArray<NSString *>*)stringDivisionWithString:(NSString *)string symbol:(NSString *)symbol;

//使用分割符片接字符窜数组
+(NSString *)stringJointWithArray:(NSArray<NSString *>*)stringArray symbol:(NSString *)symbol;






@end
