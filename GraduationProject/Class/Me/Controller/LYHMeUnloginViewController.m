//
//  LYHMeUnloginViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/5.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHMeUnloginViewController.h"
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

@interface LYHMeUnloginViewController ()

@end

@implementation LYHMeUnloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    
    //设置UI布局
    [self setupUI];
    
    //设置Tarbar
    [self setupTarbar];
}

#pragma mark 设置Tarbar
- (void)setupTarbar
{
//    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark 设置导航条
- (void)setupNav
{
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    self.navigationItem.title  = @"我";
    self.navigationController.navigationBar.barTintColor = LYHMyColor;
    //设置设置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"settting1_icon"] forState:UIControlStateNormal];
    [settingButton sizeToFit];
    //为设置按钮设置点击事件
    [settingButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    
    
}


#pragma mark 设置UI布局
- (void)setupUI
{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    vc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vc];
    //背景图片布局
    _backgroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meBackgroud"]];
    [vc addSubview:_backgroudImageView];
    [_backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 255));
        make.top.equalTo(vc.mas_top);
        make.left.equalTo(vc.mas_left);
        
    }];
    //文字控件布局
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"分享你的快乐与悲伤";
    _titleLabel.textColor = LYHColor(222, 215, 222);
    _titleLabel.font = [UIFont systemFontOfSize:20];
    [vc addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroudImageView.mas_bottom).offset(25);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    //登录按钮布局
    _loginButton = [UIButton createMyButtonWithTitle:@"登录" backgroudColor:LYHColor(53,183,243) borderColor:LYHColor(29, 162, 234).CGColor cornerRadius:10.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    [vc addSubview:_loginButton];
    //为登录按钮添加点击事件
    [_loginButton addTarget:self action:@selector(loginCilck) forControlEvents:UIControlEventTouchUpInside];
    CGFloat len = (LYHWidth - 110 * 2 - 10) * 0.5;
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 40));
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.left.equalTo(vc.mas_left).offset(len);
    }];
    //注册按钮布局
    _registerButton = [UIButton createMyButtonWithTitle:@"注册" backgroudColor:LYHColor(53,183,243) borderColor:LYHColor(29, 162, 234).CGColor cornerRadius:10.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    [vc addSubview:_registerButton];
    //为注册按钮添加点击事件
    [_registerButton addTarget:self action:@selector(registerCilck) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 40));
        make.top.equalTo(_loginButton.mas_top);
        make.left.equalTo(_loginButton.mas_right).offset(10);
                                                         
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
    /*
    LYHRegisterViewController *vc = [[LYHRegisterViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
     */
     
    
    LYHHRegisterController *vc=[[LYHHRegisterController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 点击设置按钮触发事件
-(void)setting
{
    LYHSettingController *setting = [[LYHSettingController alloc] init];
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark - kvo的回调方法(系统提供的回调方法) 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //登录后做的界面切换
//    BOOL newUserIsLogin = NO;
    BOOL newUserIsLogin = [change objectForKey:NSKeyValueChangeNewKey];
    if ([User shareUser].userIsLogin)
    {
        [self.navigationController popViewControllerAnimated:NO];
        LYHMeTableViewController *vc = [[LYHMeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:vc animated:YES];
//        [[User shareUser] removeObserver:self forKeyPath:@"userIsLogin"];
    }
}

- (void)dealloc
{
    //移除User userIsLogin 的观察者 (不移除可能会观察者方法会调用多次影响性能)
//    [[User shareUser] removeObserver:self forKeyPath:@"userIsLogin"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
