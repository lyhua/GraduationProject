//
//  LYHResponViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/25.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface LYHResponViewCell : UITableViewCell

//模型属性
@property(nonatomic,strong)User *user;

@property(nonatomic,strong)UIImageView *headView;

@property(nonatomic,strong)UILabel *userNameLabel;

@property(nonatomic,strong)UIButton *submitButton;

@end
