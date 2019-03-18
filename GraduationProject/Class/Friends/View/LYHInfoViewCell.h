//
//  LYHInfoViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/11.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"

@interface LYHInfoViewCell : UITableViewCell

//亲友头像
@property(nonatomic,strong)UIImageView *friendImageView;

//亲友名字
@property(nonatomic,strong)UILabel *friendName;

//时间标签
@property(nonatomic,strong)UILabel *timeLabel;

//内容标签
@property(nonatomic,strong)UILabel *contentLabel;

//分割线
@property(nonatomic,strong)UIView *lineView;

//模型数据
@property(nonatomic,strong)Info *info;





@end
