//
//  Mission.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Mission : NSObject

//任务ID
@property(nonatomic,strong) NSNumber *mission_id;

//任务是否有效
@property(nonatomic,copy) NSNumber *flag;

//任务类容
@property(nonatomic,copy) NSString *mission_content;

//任务发布时间
@property(nonatomic,copy) NSString *mission_starttime;

//任务结束时间
@property(nonatomic,copy) NSString *mission_endtime;


//额外属性

//根据当前模型计算出来的cell高度
@property (nonatomic, assign) CGFloat cellHeight;

//内容数组静态调用方法
+(NSMutableArray<Mission*>*)shareMissions;


@end
