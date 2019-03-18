//
//  LYHMissionTableViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mission.h"

@interface LYHMissionTableViewCell : UITableViewCell

//数据模型
@property(nonatomic,strong) Mission *mission;

//任务类型图片
@property(nonatomic,strong) UIImageView *typeImageView;

//开始时间
@property(nonatomic,strong) UILabel *contentLabel;

//结束时间按
@property(nonatomic,strong) UILabel *startTimeLabel;

//任务类容
@property(nonatomic,strong) UILabel *endTimeLabel;

//是否有效图片
@property(nonatomic,strong) UIImageView *flagImageView;

//额外控件
@property(nonatomic,strong) UIView *lineView;

@end
