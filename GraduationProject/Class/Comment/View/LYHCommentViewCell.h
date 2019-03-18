//
//  LYHCommentViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "User.h"

@interface LYHCommentViewCell : UITableViewCell

//评论数据模型
@property(nonatomic,strong)Comment *comment;

//用户数据模型
@property(nonatomic,strong)User *user;

//用户头像
@property(nonatomic,strong)UIImageView *headImageView;

//用户名
@property(nonatomic,strong)UILabel *userNameLabel;

//发布评论日期
@property(nonatomic,strong)UILabel *dateLabel;

//评论
@property(nonatomic,strong)UILabel *commmentLabel;

//点赞按钮
@property(nonatomic,strong)UIButton *goodButton;

//踩按钮
@property(nonatomic,strong)UIButton *badButton;

//删除按钮
@property(nonatomic,strong)UIButton *deleteCommentBtn;



@end
