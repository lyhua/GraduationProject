//
//  Friends.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/16.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friends : NSObject<NSCoding>

//用户id
@property(nonatomic,assign) NSNumber *userId;

//用户名称
@property(nonatomic,copy)NSString *name;

//用户头像
@property(nonatomic,copy)NSString *headImage;


@end
