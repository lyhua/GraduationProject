//
//  LYHContentSingleCell.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Content.h"
#import "Pictures.h"
#import "LYHSinglePicturesView.h"
#import "ImageSize.h"

@interface LYHContentSingleCell : UITableViewCell

//数据模型
@property(nonatomic,strong) Content *content;

//图片模型
@property(nonatomic,strong)Pictures *pictures;

//图片尺寸模型
@property(nonatomic,strong)ImageSize *imageSize;

//图片控件
@property(nonatomic,strong)LYHSinglePicturesView *singleView;

//用户头像
@property(nonatomic,strong)UIImageView *userHeadImage;

//用户名称
@property(nonatomic,strong)UILabel *userNameLabel;

//日期
@property(nonatomic,strong)UILabel *dateLabel;

//心情
@property(nonatomic,strong)UIImageView *moodImage;

//内容
@property(nonatomic,strong) UILabel *contentLabel;

//祝福按钮
@property(nonatomic,strong)UIButton *blessingBtn;

//举报按钮
@property(nonatomic,strong) UIButton *reportBtn;

//评论按钮
@property(nonatomic,strong)UIButton *commentBtn;

////顶部视图
//@property(nonatomic,strong)UIView *topView;

//底部视图
@property(nonatomic,strong)UIView *bottomView;

//分割线
@property(nonatomic,strong)UIView *divisionView;

//分割线
@property(nonatomic,strong)UIView *division1View;

//分割线
@property(nonatomic,strong)UIView *division2View;


// 设置UI
-(void)setupUI;

//设置顶部视图
-(void)setupTopView;

@end
