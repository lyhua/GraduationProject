//
//  LYHMeHeadTableViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/4.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface LYHMeHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;


//用户模型
@property(nonatomic,strong)User *user;

@end
