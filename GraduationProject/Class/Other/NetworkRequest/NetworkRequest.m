//
//  NetworkRequest.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "NetworkRequest.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"
#import "Base.h"
#import <MJExtension/MJExtension.h>

@implementation NetworkRequest

#pragma mark 网络请求单例
+ (instancetype)sharedManager{
    static NetworkRequest *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}


#pragma mark 获取网络请求
+ (AFHTTPSessionManager *)getRequest
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    return manger;
}

#pragma mark 根据用户id获取用户信息
+(void)getUserWithUserId:(NSNumber *)userId
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"getUserWithId"];
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = userId;
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        User *user = [User mj_objectWithKeyValues:responseObject[@"user"]];
        [User shareUser].headImage = user.headImage;
        //保存完要进行归档
        [User userLogout:[User shareUser]];
        NSLog(@"------------------");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误处理
        
    }];
    //这里为什么不能用返回一个user:因为网络请求是异步的，先执行return，结果返回一个空的user
//    return user;
}


@end
