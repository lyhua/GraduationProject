//
//  LYHPublishController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/30.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHPublishController : UIViewController

//背景
@property(nonatomic,strong)UIView *backgroundView;

//日期
@property(nonatomic,strong)UILabel *date1;

@property(nonatomic,strong)UILabel *date2;

@property(nonatomic,strong)UILabel *date3;

//标题
@property(nonatomic,strong)UIImageView *titleImageView;

//发布文字按钮
@property(nonatomic,strong)UIButton *wordButton;

//发布图片按钮
@property(nonatomic,strong)UIButton *imageButton;

//查看评论按钮
@property(nonatomic,strong)UIButton *commentButton;

//发布文字的文字
@property(nonatomic,strong)UILabel *wordLabel;

//发布图片文字
@property(nonatomic,strong)UILabel *imageLabel;

//查看评论文字
@property(nonatomic,strong)UILabel *commentLabel;

//底部背景
@property(nonatomic,strong)UIView *bottomView;

//取消按钮
@property(nonatomic,strong)UIButton *cancelButton;

//任务ID
@property(nonatomic,strong)NSNumber *mission_id;



@end
