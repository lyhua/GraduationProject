//
//  LYHFriendsViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/16.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Friends;

@interface LYHFriendsViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//模型属性
@property(nonatomic,strong)Friends *friends;

@end
