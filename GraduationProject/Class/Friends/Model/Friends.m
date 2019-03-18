//
//  Friends.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/16.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "Friends.h"

@implementation Friends

#pragma mark 朋友数组静态调用
+(NSMutableArray<Friends *>*)shareFriends
{
    static NSMutableArray<Friends *>*friends;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        friends = [[NSMutableArray alloc] init];
    });
    return friends;
}



#pragma mark content归档方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:NSStringFromSelector(@selector(userId))];
    [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeObject:self.headImage forKey:NSStringFromSelector(@selector(headImage))];
    
}

#pragma mark content解归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _userId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userId))];
        _name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        _headImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(headImage))];
    }
    return self;
}




@end
