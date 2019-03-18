//
//  LYHPublishController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/30.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHPublishController.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "LYHConst.h"
#import "NSString+Category.h"
#import "LYHComposeViewController.h"
#import "Publish.h"

@interface LYHPublishController ()

@end

@implementation LYHPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 设置UI
-(void)setupUI
{
    //按钮之间间距
    CGFloat  btnSpace = LYHWidth / 3;
    //按钮的长度
    CGFloat btnWith = 70;
    
    //创建空白的view
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LYHWidth, LYHHeight)];
    _backgroundView.backgroundColor = LYHColor(240, 240, 240);
    [self.view addSubview:_backgroundView];
    
    //获取系统时间
    
    //设置日期文字
    _date1 = [[UILabel alloc] init];
    [self.view addSubview:_date1];
    _date1.text = [NSString dateWithFormatter:@"dd"];
    _date1.font = [UIFont systemFontOfSize:25];
    [_date1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(self.view.mas_top).offset(35);
    }];
    
    _date2 = [[UILabel alloc] init];
    [self.view addSubview:_date2];
    _date2.text = [NSString weekdayStringFromDate:[NSDate date]];
    _date2.font = [UIFont systemFontOfSize:13];
    [_date2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_date1.mas_right).offset(10);
        make.top.equalTo(self.view.mas_top).offset(35);
    }];
    
    _date3 = [[UILabel alloc] init];
    [self.view addSubview:_date3];
    _date3.text = [NSString dateWithFormatter:@"MM/YYYY"];
    _date3.font = [UIFont systemFontOfSize:13];
    [_date3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_date1.mas_right).offset(10);
        make.top.equalTo(_date2.mas_bottom).offset(5);
    }];
    
    _titleImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"publish_title_icon"];
    _titleImageView.image = image;
    [self.view addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(150);
    }];
    
    
    _wordButton = [[UIButton alloc] init];
    [_wordButton setBackgroundImage:[UIImage imageNamed:@"publish_word_icon"] forState:UIControlStateNormal];
    [self.view addSubview:_wordButton];
    [_wordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(btnSpace * 0.5 - btnWith * 0.5);
        make.top.equalTo(_titleImageView.mas_bottom).offset(25);
        make.width.mas_equalTo(btnWith);
        make.height.mas_equalTo(btnWith);
    }];
    
    _imageButton = [[UIButton alloc] init];
    [_imageButton setBackgroundImage:[UIImage imageNamed:@"publish_photo_icon"] forState:UIControlStateNormal];
    [self.view addSubview:_imageButton];
    [_imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wordButton.mas_right).offset(btnSpace - btnWith);
        make.top.equalTo(_titleImageView.mas_bottom).offset(25);
        make.width.mas_equalTo(btnWith);
        make.height.mas_equalTo(btnWith);
    }];
    //为发布图片按钮添加点击事件
    [_imageButton addTarget:self action:@selector(imageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _commentButton = [[UIButton alloc] init];
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"publish_comment_icon"] forState:UIControlStateNormal];
    [self.view addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageButton.mas_right).offset(btnSpace - btnWith);
        make.top.equalTo(_titleImageView.mas_bottom).offset(25);
        make.width.mas_equalTo(btnWith);
        make.height.mas_equalTo(btnWith);
    }];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = LYHColor(255, 255, 255);
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(LYHBottomViewHeight);
        make.width.mas_equalTo(LYHWidth);
    }];
    
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomView.mas_centerX);
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.height.mas_equalTo(LYHBottomViewHeight);
        make.width.mas_equalTo(LYHWidth);
    }];
    [_cancelButton sizeToFit];
    
    //添加取消按钮点击事件
    [_cancelButton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchDown];
    
}

#pragma mark 发布图片点击事件
-(void)imageButtonClick
{
    //让发布界面消失
    [self dismissViewControllerAnimated:NO completion:nil];
    //设置是否发布图片文本属性
    [Publish sharePublish].isPublished = YES;
    
}


#pragma mark 取消按钮点击事件
-(void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
