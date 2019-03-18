//
//  NSString+Category.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/6.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
+ (NSString *) md5:(NSString *) str
{
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [str UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}

#pragma mark 获取当前星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

#pragma mark 根据日期字符窜格式返回字符窜
+(NSString *)dateWithFormatter:(NSString *)dateFormatter
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:dateFormatter];
    return [dateformatter stringFromDate:date];
}

#pragma mark 字符窜的分割（用于处理图片地址）
+(NSArray<NSString *>*)stringDivisionWithString:(NSString *)string symbol:(NSString *)symbol
{
    NSArray *array = [string componentsSeparatedByString:symbol];
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:array];
    [array1 removeLastObject];
    return array1;
}

#pragma mark 使用分割符片接字符窜数组
+(NSString *)stringJointWithArray:(NSArray<NSString *>*)stringArray symbol:(NSString *)symbol
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    NSInteger i = 0;
    for ( i = 0; i < stringArray.count - 1; i++) {
        [string appendString:stringArray[i]];
        [string appendString:@","];
    }
    [string appendString:stringArray[i]];
    NSLog(@"Joint--------------%@",string);
    return string;
}

@end
