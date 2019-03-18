//
//  LYHHMeUnloginViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/21.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHMeUnloginViewController.h"
#import "Base.h"
#import "UIImage+Image.h"
#import "UIButton+Category.h"
#import <Masonry/Masonry.h>
#import "LYHSettingController.h"
#import "LYHLoginViewController.h"
#import "LYHRegisterViewController.h"
#import "LYHMeTableViewController.h"
#import "User.h"
#import "UIImage+Image.h"
#import "LYHHRegisterController.h"
#import "LYHHLoginViewController.h"


@interface LYHHMeUnloginViewController ()

@end

@implementation LYHHMeUnloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    
    //设置UI布局
    [self setupUI];

}


//设置导航条透明
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//恢复导航条
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


#pragma mark 设置导航条
- (void)setupNav
{
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
    self.navigationItem.title  = @"我";
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor blackColor]};
    
    
}


#pragma mark 设置UI布局
- (void)setupUI
{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    vc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vc];
    
    //背景图片布局
    _backgroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gologin_pic-1"]];
    [vc addSubview:_backgroudImageView];
    [_backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 150));
        make.top.equalTo(vc.mas_top).offset(64);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    //登录按钮布局
    _loginButton = [UIButton createMyButtonWithTitle:@"登录" backgroudColor:LYHColor(253,185,109) borderColor:LYHColor(253,185,109).CGColor cornerRadius:20.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    [vc addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.top.equalTo(_backgroudImageView.mas_bottom).offset(20);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    //为登录按钮添加点击事件
    [_loginButton addTarget:self action:@selector(loginCilck) forControlEvents:UIControlEventTouchUpInside];
    
    //文字控件布局
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"登录发现更多精彩";
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [vc addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginButton.mas_bottom).offset(10);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    //这册标签布局
    _registerLabel = [[UILabel alloc] init];
    _registerLabel.text = @"还没有账号?";
    _registerLabel.textColor = [UIColor grayColor];
    _registerLabel.font = [UIFont systemFontOfSize:16];
    [vc addSubview:_registerLabel];
    [_registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(30);
        make.left.equalTo(_titleLabel.mas_left);
    }];
    
    
    
    //注册按钮布局
    //_registerButton = [UIButton createMyButtonWithTitle:@"注册" backgroudColor:[UIColor whiteColor] borderColor:[UIColor whiteColor].CGColor cornerRadius:10.0 borderWidth:1.0 textColor:LYHColor(253, 185, 109)];
    _registerButton = [[UIButton alloc] init];
    [_registerButton setTitle:@"去注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:LYHColor(253, 185, 109) forState:UIControlStateNormal];
    _registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [vc addSubview:_registerButton];
    //为注册按钮添加点击事件
    [_registerButton addTarget:self action:@selector(registerCilck) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
        make.top.equalTo(_registerLabel.mas_top);
        make.right.equalTo(_titleLabel.mas_right);
    }];
    
    
    //判断用户是否之前有登录过
    if([User userLogin].userId)
    {
#warning 如果用户之前改过密码怎么办
        //TODO 这里可能要重新登录(先向服务器请求看用户数据有没有改变)
        User *user = [User userLogin];
        [User shareUser].userId = user.userId;
        [User shareUser].name = user.name;
        [User shareUser].age = user.age;
        [User shareUser].phone = user.phone;
        [User shareUser].headImage = user.headImage;
        [User shareUser].email = user.email;
        [User shareUser].userIsLogin = @1;
    }
}

#pragma mark 登录按钮点击事件
- (void)loginCilck
{
    //弹出登录界面
    /*
     LYHLoginViewController *vc = [[LYHLoginViewController alloc] init];
     */
    LYHHLoginViewController *vc=[[LYHHLoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark 为注册按钮添加点击事件
- (void)registerCilck
{
    
    LYHHRegisterController *vc=[[LYHHRegisterController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
