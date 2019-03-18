//
//  NetworkRequest.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "User.h"

@interface NetworkRequest : NSObject

//网络请求单例
+ (instancetype)sharedManager;

//获得网络请求
+ (AFHTTPSessionManager *)getRequest;

//根据用户id获取用户信息
+(void)getUserWithUserId:(NSNumber *)userId;

@end
