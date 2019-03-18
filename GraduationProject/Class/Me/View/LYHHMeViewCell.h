//
//  LYHHMeViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/27.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface LYHHMeViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *backgroudImageView;

@property(nonatomic,strong)UIImageView *headView;

@property(nonatomic,strong)UILabel *userNameLabel;

//数据模型
@property(nonatomic,strong)User *user;

@end
