//
//  LYHArticleTableViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/9.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface LYHArticleTableViewCell : UITableViewCell

//模型属性
@property(nonatomic,strong) Article *article;

//标题
@property(strong,nonatomic)UILabel *titleLabel;

//发布时间
@property(strong,nonatomic)UILabel *timeLabel;

//具体类容
@property(strong,nonatomic)UILabel *contentLabel;

//阅读数量
@property(strong,nonatomic)UILabel *readLabel;

//评论数量
@property(strong,nonatomic)UILabel *commentLabel;

//喜欢数量
@property(strong,nonatomic)UILabel *likeLabel;

//线
@property(strong,nonatomic)UIView *lineView;

@end
