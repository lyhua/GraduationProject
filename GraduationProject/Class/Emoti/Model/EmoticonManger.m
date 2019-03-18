//
//  EmoticonManger.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "EmoticonManger.h"

@implementation EmoticonManger

#pragma mark 重写init方法
- (instancetype)init
{
    NSLog(@"EmoticonManger -----construction");
    self = [super init];
    if (self) {
        NSDictionary *dict = nil;
        NSArray *array = nil;
        NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
        d[@"group_name_cn"] = @"最近A";
        d[@"id"] = nil;
        d[@"emoticons"] = nil;
        _packages = [[NSMutableArray alloc] init];
        [_packages addObject:[[EmoticonPackage alloc] initWithDictionary:d]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist" inDirectory:@"Emoticons.bundle"];
        if(path){
            dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        }
        if(dict)
        {
            array = [[NSArray alloc] initWithArray:(NSArray *)dict[@"packages"]];
        }
        if(array)
        {
            for (NSInteger i = 0; i < array.count; i++) {
                [self loadInfoPlist:(NSString *)array[i][@"id"]];
            }
        }
        
    }
    return self;
}


#pragma mark 在Bundle中的内容
-(void)loadInfoPlist:(NSString *)pid
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"plist" inDirectory:[@"Emoticons.bundle/" stringByAppendingString:pid]];
//    NSLog(@"path ---------%@",path);
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    [self.packages addObject:[[EmoticonPackage alloc] initWithDictionary:dict]];
    
}

#pragma mark 单例
+(instancetype)sharedManager;
{
    static EmoticonManger *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}




@end
