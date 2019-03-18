//
//  LYHSendCommentView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/21.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHSendCommentView.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "LYHSendCommentController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LYHSendCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark 设置UI
-(void)setupUI
{
    
    //分割线布局
    _division1View = [[UIView alloc] init];
    _division1View.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_division1View];
    [_division1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset([UIScreen mainScreen].bounds.size.width /3);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 25));
    }];
    
    _division2View = [[UIView alloc] init];
    _division2View.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:_division2View];
    [_division2View mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat offest = [UIScreen mainScreen].bounds.size.width /3;
        make.left.equalTo(self.mas_left).offset(offest * 2);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 25));
    }];
    
    _goodLabel = [[UILabel alloc] init];
    _goodLabel.text = @"点赞";
    _goodLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_goodLabel];
    //进行布局
    [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_division1View.mas_centerY);
        make.right.equalTo(_division1View.mas_left).offset(-15);
    }];

    
    _goodBtn = [[UIButton alloc] init];
    [_goodBtn setImage:[UIImage imageNamed:@"good_icon"] forState:UIControlStateNormal];
    [_goodBtn setImage:[UIImage imageNamed:@"good_heightlight_icon"] forState:UIControlStateHighlighted];
    CGFloat width = LYHWidth / 3;
    CGFloat temp = (LYHWidth / 3 - 25) * 0.5;
    [_goodBtn setImageEdgeInsets:UIEdgeInsetsMake(8.5, temp, 10.5, temp)];
    [self addSubview:_goodBtn];
    
    [_goodBtn addTarget:self action:@selector(goodBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //进行布局
    [_goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(width, 44));
    }];
    
    _badLabel = [[UILabel alloc] init];
    _badLabel.text = @"踩";
    _badLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_badLabel];
    //进行布局
    [_badLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_division1View.mas_centerY);
        make.left.equalTo(_division1View.mas_right).offset(temp - 15 + 25 + 10);
    }];
    
    _badBtn = [[UIButton alloc] init];
    [_badBtn setImage:[UIImage imageNamed:@"bad_icon"] forState:UIControlStateNormal];
    [_badBtn setImage:[UIImage imageNamed:@"bad_heightlight_icon"] forState:UIControlStateHighlighted];
    [_badBtn setImageEdgeInsets:UIEdgeInsetsMake(9.5, temp - 15, 9.5, temp + 15)];
    [self addSubview:_badBtn];
    [_badBtn addTarget:self action:@selector(badBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //进行布局
    [_badBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(width);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(width, 44));
    }];
    
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.text = @"评论";
    _commentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_commentLabel];
    //进行布局
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_division1View.mas_centerY);
        make.left.equalTo(_division2View.mas_right).offset(temp - 20 + 25 + 10);
    }];
    
    _commentBtn = [[UIButton alloc] init];
    [_commentBtn setImage:[UIImage imageNamed:@"comment_icon"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"comment_heightlight_icon"] forState:UIControlStateHighlighted];
    [_commentBtn setImageEdgeInsets:UIEdgeInsetsMake(9.5, temp - 20, 9.5, temp + 20)];
    [self addSubview:_commentBtn];
    [_commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //进行布局
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(width * 2);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(width, 44));
    }];
}


#pragma mark 点赞按钮点击事件
-(void)goodBtnClick
{
    [SVProgressHUD showInfoWithStatus:@"点赞成功"];
}

#pragma mark 踩按钮点击事件
-(void)badBtnClick
{
    [SVProgressHUD showInfoWithStatus:@"做人要有良心!"];
}

#pragma mark 评论按钮点击事件
-(void)commentBtnClick
{
    //发送点击发送评论按钮通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LYHSendCommentsNotification object:nil];
}




@end
