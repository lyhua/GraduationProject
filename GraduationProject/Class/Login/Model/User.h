//
//  User.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/7.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

//用户ID
@property(nonatomic,strong) NSNumber *userId;

//用户名称
@property(nonatomic,strong) NSString *name;

//用户年龄
@property(nonatomic,strong) NSNumber *age;

//用户手机号码
@property(nonatomic,strong) NSString *phone;

//用户头像
@property(nonatomic,strong) NSString *headImage;

//用户邮箱
@property(nonatomic,strong) NSString *email;

@property(nonatomic,strong)NSNumber *gender;

//额外shuxing
@property (nonatomic,strong) NSNumber *userIsLogin;




//用户单例
+ (instancetype)shareUser;

//用户登录
+(User *)userLogin;

//用户退出
+(void)userLogout:(User *)user;





@end
