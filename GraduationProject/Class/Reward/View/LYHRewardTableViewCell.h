//
//  LYHRewardTableViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/2.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reward.h"

@interface LYHRewardTableViewCell : UITableViewCell

//数据模型
@property(nonatomic,strong) Reward *reward;

//奖励图片
@property(nonatomic,strong) UIImageView *rewardImageView;

//奖励称号
@property(nonatomic,strong) UILabel *rewardLabel;

@end
