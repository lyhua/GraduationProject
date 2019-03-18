//
//  LYHHPublishController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/28.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHPublishController.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "LYHConst.h"
#import "NSString+Category.h"
#import "LYHComposeViewController.h"
#import "Publish.h"

@interface LYHHPublishController ()

@end

@implementation LYHHPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行控件布局
    [self setupUI];
    
}


#pragma mark 设置UI
-(void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    _backgroudView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LYHWidth, LYHHeight)];
    _backgroudView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:_backgroudView1];
    
    _backgroudView = [[UIView alloc] init];
    _backgroudView.layer.cornerRadius = 10.0;
    _backgroudView.layer.masksToBounds = YES;
    _backgroudView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backgroudView];
    [_backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth -40 , 150));
        make.bottom.equalTo(self.view.mas_bottom).offset(-64);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    _wordButton = [[UIButton alloc] init];
    [_wordButton setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
    [_wordButton setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateHighlighted];
    [self.view addSubview:_wordButton];
    [_wordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(_backgroudView.mas_top).offset(25);
        make.centerX.equalTo(_backgroudView.mas_centerX).offset(-40);
    }];
    
    //为文字按钮添加点击事件
    [_wordButton addTarget:self action:@selector(imageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _imageButton = [[UIButton alloc] init];
    [_imageButton setImage:[UIImage imageNamed:@"icon_img"] forState:UIControlStateNormal];
    [_imageButton setImage:[UIImage imageNamed:@"icon_img"] forState:UIControlStateHighlighted];
    [self.view addSubview:_imageButton];
    [_imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(_backgroudView.mas_top).offset(25);
        make.centerX.equalTo(_backgroudView.mas_centerX).offset(40);
    }];
    
    //为发布图片按钮添加点击事件
    [_imageButton addTarget:self action:@selector(imageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [_cancelButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [self.view addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.equalTo(_backgroudView.mas_centerX);
        make.bottom.equalTo(_backgroudView.mas_bottom).offset(-20);
    }];
    
    [_cancelButton addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
