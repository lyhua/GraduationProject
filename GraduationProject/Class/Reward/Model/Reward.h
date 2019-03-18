//
//  Reward.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/2.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reward : NSObject

//奖励id
@property(nonatomic,strong) NSNumber *reward_id;

//奖励名称
@property(nonatomic,strong) NSString *reward_name;

//奖励徽章图片
@property(nonatomic,strong)NSString *reward_pic;

//任务id
@property(nonatomic,strong)NSNumber *mission_id;



@end
