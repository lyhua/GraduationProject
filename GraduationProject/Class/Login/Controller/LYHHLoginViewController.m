//
//  LYHHLoginViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHLoginViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LYHLostPasswordViewController.h"
#import "Base.h"
#import <Masonry/Masonry.h>
#import "LYHRegisterViewController.h"
#import "UIButton+Category.h"
#import "UITextField+Category.h"
#import "Regular.h"
#import "NSString+Category.h"
#import "LYHMeTableViewController.h"
#import "User.h"
#import "UIImage+Image.h"
#import "LYHHRegisterController.h"
#import "LYHHLostPasswordViewController.h"
#import "LYHHMeViewController.h"
#import "NSString+Category.h"

@interface LYHHLoginViewController ()

@end

@implementation LYHHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNavBar];
    
    //设置UI
    [self setupUI];
}

//设置导航条透明
/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
 */

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYHColor(253, 185, 109)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor grayColor]]];
}

 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置UI
-(void)setupUI
{
    
    UIView *vc=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    vc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:vc];
    
    //背景设置
    _backgroudView1 = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:LYHColor(253, 185, 109)]];
    [vc addSubview:_backgroudView1];
    [_backgroudView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 65));
        make.top.equalTo(vc.mas_top);
        make.left.equalTo(vc.mas_left);
        make.right.equalTo(vc.mas_right);
    }];
    
    _backgroudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_backgroudImg"]];
    [vc addSubview:_backgroudView];
    [_backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 200));
        make.top.equalTo(vc.mas_top).offset(64);
        make.left.equalTo(vc.mas_left);
        make.right.equalTo(vc.mas_right);
    }];
    
    
    _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headImage-1"]];
    [vc addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.top.equalTo(vc.mas_top).offset(230);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    _shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [vc addSubview:_shadowImageView];
    [_shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 150));
        make.top.equalTo(_headImageView.mas_bottom).offset(10);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    _userTextField = [UITextField createMyTextFieldWithPlaceholder:@"手机号码" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeNumberPad];
    
    [_userTextField setBorderStyle:UITextBorderStyleNone];
    [vc addSubview:_userTextField];
    
    [_userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_shadowImageView.mas_top);
        make.centerX.equalTo(_shadowImageView.mas_centerX);
    }];
    
    //监听用户账号
    [_userTextField addTarget:self action:@selector(userTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _passwordTextField = [UITextField createMyTextFieldWithPlaceholder:@"密码" secureTextEntry:YES borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    [_passwordTextField setBorderStyle:UITextBorderStyleNone];
    [vc addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_userTextField.mas_bottom).offset(10);
        make.centerX.equalTo(_shadowImageView.mas_centerX);
    }];
    
    //监听密码输入
    [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = LYHColor(222,222,222);
    [vc addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 1));
        make.top.equalTo(_userTextField.mas_bottom).offset(1);
        make.centerX.equalTo(_userTextField.mas_centerX);
    }];
    
    //线VIEW1
    _lineView1 =[[UIView alloc] init];
    _lineView1.backgroundColor = LYHColor(222, 222, 222);
    [vc addSubview:_lineView1];
    
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 1));
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.centerX.equalTo(_shadowImageView.mas_centerX);
    }];
    
    
    
    
    _loginButton = [UIButton createMyButtonWithTitle:@"登录" backgroudColor:LYHColor(254, 217, 111) borderColor:LYHColor(254, 217, 111).CGColor cornerRadius:20.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _loginButton.enabled = NO;
    [vc addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(30);
        make.centerX.equalTo(_passwordTextField.mas_centerX);
    }];
    //为登录按钮添加点击事件
    [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _lostPasswordButton = [UIButton createMyButtonWithoutBorder:@"忘记密码" backgroudColor:[UIColor whiteColor] textColor:LYHColor(254, 217, 111)];
    [vc addSubview:_lostPasswordButton];
    [_lostPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(_shadowImageView.mas_bottom).offset(45);
        make.left.equalTo(_shadowImageView.mas_left);
    }];
    
    //为忘记密码添加点击事件
    [_lostPasswordButton addTarget:self action:@selector(lostPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton = [UIButton createMyButtonWithoutBorder:@"立即加入" backgroudColor:[UIColor whiteColor] textColor:LYHColor(254, 217, 111)];
    [vc addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(_shadowImageView.mas_bottom).offset(45);
        make.right.equalTo(_shadowImageView.mas_right);
    }];
    
    //为注册按钮添加点击事件
    [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}


#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    UIImage *temp;
    self.navigationItem.title = @"登录";
    
    /*
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = LYHColor(253, 185, 109);
     */
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp  forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
}

#pragma mark 设置底部TarBar隐藏
- (void)setupTarBar
{
    //    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark 返回
- (void)backCilck
{
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 设置键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



#pragma mark 登录按钮的点击事件
- (void)loginButtonClick
{
    //TODO 区分用户名还是电话号码
    NSString *phone = nil;
    NSString *email = nil;
    NSString *userName = nil;
    NSString *password = _passwordTextField.text;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if ([Regular isValidateMobile:_userTextField.text])
    {
        phone = _userTextField.text;
    }else if([Regular isValidateEmail:_userTextField.text])
    {
        email = _userTextField.text;
    }else{
        userName = _userTextField.text;
    }
    parameters[@"name"] = userName;
#pragma mark 这里做了md5
    parameters[@"password"] = [NSString md5:password];
    parameters[@"phone"] = phone;
    parameters[@"email"] = email;
    //TODO 把密码MD5加密后才发送
    //    NSLog(@"%@",userName);
    //    NSLog(@"%@",password);
    //    NSLog(@"md5 password   -------------%@",[NSString md5:password]);
    //    return;
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"Login"];
    
    //请求登录
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    [manger GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //TODO 请求成功后做的事情 1登录成功后显示个人页面 2登录失败显示用户名或密码错误提醒用户
        if (responseObject[@"error"])
        {
            NSLog(@"-------------------------%@",responseObject[@"error"]);
            //提醒用户用户名或密码错误
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
        //用户登录成功
        if(responseObject[@"msg"])
        {
#warning 用户授权码
            //TODO 登录成功后服务器应该返回用户信息(用户授权码:这个最重要)然后跳转到我的界面
            //字典转模型
            User *user = [User mj_objectWithKeyValues:responseObject[@"user"]];
            //设置用户是否登录属性(然后KVO)(能够判断用户是否登录，然后退出我的界面)
#warning 进行优化(对象之间的赋值)
            [User shareUser].userId = user.userId;
            [User shareUser].name = user.name;
            [User shareUser].age = user.age;
            [User shareUser].phone = user.phone;
            [User shareUser].headImage = user.headImage;
            [User shareUser].email = user.email;
            [User shareUser].userIsLogin = @1;
            NSLog(@"single username%@",[User shareUser].name);
            //(首次或者退出后重新登录)进行用户归档
            [User userLogout:[User shareUser]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        //如果不能请求服务器显示网络问题
        [SVProgressHUD showErrorWithStatus:@"网络有点问题，请稍后尝试!"];
    }];
    
}

#pragma mark 忘记密码按钮点击事件
- (void)lostPasswordClick
{
    //跳转的忘记密码页面
    /*
    LYHLostPasswordViewController *vc = [[LYHLostPasswordViewController alloc] init];
     */
    LYHHLostPasswordViewController *vc =[[LYHHLostPasswordViewController alloc] init];
    //在push隐藏底部工具栏TarBar 并且设置那个viewController必须是push那个和必须在push之前设置
    [self.view endEditing:YES];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark 立即加入按钮点击事件（注册）
- (void)registerButtonClick
{
    /*
    LYHRegisterViewController *vc = [[LYHRegisterViewController alloc] init];
     */
    LYHHRegisterController *vc=[[LYHHRegisterController alloc] init];
    [self.view endEditing:YES];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 监听用户账号
-(void)userTextFieldDidChange:(id) sender
{
    UITextField *textField = (UITextField *)sender;
    //    _userTextFieldLenIsOk = [Regular isValidateMobile:textField.text];
    //    //改变登录按钮可被点击属性
    
#warning 处理判断用户名 电话号码 邮箱
    _userTextFieldLenIsOk = YES;
    _loginButton.enabled = (_userTextFieldLenIsOk && _passwordTextFieldLenIsOk) ? YES : NO;
    
}

#pragma mark 监听密码输入
- (void)passwordTextFieldDidChange:(id) sender
{
    UITextField *textField = (UITextField *)sender;
    //判断密码输入框输入的长度是否大于 5
    _passwordTextFieldLenIsOk = (textField.text.length > 5) ? YES : NO;
    //改变登录按钮可被点击属性
    _loginButton.enabled = (_userTextFieldLenIsOk && _passwordTextFieldLenIsOk) ? YES : NO;
}





@end
