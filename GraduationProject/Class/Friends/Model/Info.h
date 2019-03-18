//
//  Info.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/11.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject

//信息ID
@property(nonatomic,strong) NSNumber *info_id;

//信息内容
@property(nonatomic,strong)NSString *info_content;

//发送者ID
@property(nonatomic,strong)NSNumber *send_id;

//接受者ID
@property(nonatomic,strong)NSNumber *receive_id;

//发送日期
@property(nonatomic,strong)NSString *send_date;

//接受者ID
@property(nonatomic,strong)NSString *receive_date;

//发送信息的头像
@property(nonatomic,strong)NSString *senderHeadImage;

//发送者姓名
@property(nonatomic,strong)NSString *senderName;

@end
