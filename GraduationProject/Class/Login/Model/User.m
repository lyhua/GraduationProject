//
//  User.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/7.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "User.h"
#import "Base.h"



@implementation User

static User * user = nil;

//用户单例
+ (instancetype)shareUser
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([User userLogin] != nil) {
            user = [User userLogin];
        }else
        {
            user = [[self alloc] init];
        }
    });
    return user;
}


#pragma mark 用户登录进APP(进行解归档)
+(User *)userLogin
{
    //用户解归档
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:LYHUserData];
    User * user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return user;
}

#pragma mark 用户退出APP(进行归档)
+(void)userLogout:(User *)user
{
    //用户归档
     NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:LYHUserData];
    [NSKeyedArchiver archiveRootObject:user toFile:filePath];
}

#pragma mark 归档方法

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:NSStringFromSelector(@selector(userId))];
    [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeObject:self.age forKey:NSStringFromSelector(@selector(age))];
    [aCoder encodeObject:self.phone forKey:NSStringFromSelector(@selector(phone))];
    [aCoder encodeObject:self.headImage forKey:NSStringFromSelector(@selector(headImage))];
    [aCoder encodeObject:self.email forKey:NSStringFromSelector(@selector(email))];
}

#pragma mark 解归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _userId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userId))];
        _name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        _age = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(age))];
        _phone = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(phone))];
        _headImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(headImage))];
        _email = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(email))];
    }
    return self;
}


@end
