//
//  LYHLoginViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/2/23.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHLoginViewController.h"
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

@interface LYHLoginViewController ()

@end

@implementation LYHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    [self setupUI];
    [self setupTarBar];
}



//设置UI
- (void)setupUI
{
    //TODO 把生成各种控件抽象出一种方法
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    vc.backgroundColor = [UIColor whiteColor];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_icon"]];
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_password_icon"]];
    [self.view addSubview:vc];
    [userImageView setFrame:CGRectMake(70, 40, 37, 37)];
    [passwordImageView setFrame:CGRectMake(70, 100, 37, 37)];
    _userImageView = userImageView;
    _passwordImageView = passwordImageView;
    
    _userTextField = [UITextField createMyTextFieldWithPlaceholder:@"用户名/手机号码/邮箱" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
#warning 利用约束布局
    [_userTextField setFrame:CGRectMake(120, 40, 200, 39)];
    //监听用户账号
    [_userTextField addTarget:self action:@selector(userTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _passwordTextField = [UITextField createMyTextFieldWithPlaceholder:@"密码" secureTextEntry:YES borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
#warning 利用约束布局    
    [_passwordTextField setFrame:CGRectMake(120, 100, 200, 39)];
    //监听密码输入
    [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _loginButton = [UIButton createMyButtonWithTitle:@"登录" backgroudColor:LYHColor(53,183,243) borderColor:LYHColor(29, 162, 234).CGColor cornerRadius:10.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
#warning 利用约束布局
    [_loginButton setFrame:CGRectMake(70, 215, 250, 40)];
    //为登录按钮添加点击事件
    [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.enabled = NO;
    

    _lostPasswordButton = [UIButton createMyButtonWithoutBorder:@"忘记密码" backgroudColor:[UIColor whiteColor] textColor:LYHColor(53,183,243)];
    [_lostPasswordButton setFrame:CGRectMake(250, 170, 100, 20)];
    [_lostPasswordButton addTarget:self action:@selector(lostPasswordClick) forControlEvents:UIControlEventTouchUpInside];

    _registerButton = [UIButton createMyButtonWithoutBorder:@"立即加入" backgroudColor:[UIColor whiteColor] textColor:LYHColor(53,183,243)];
    [vc addSubview:_registerButton];
    [_registerButton setFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width * 0.5 - 50, 265, 100, 20)];
    [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [vc addSubview:userImageView];
    [vc addSubview:passwordImageView];
    [vc addSubview:_userTextField];
    [vc addSubview:_passwordTextField];
    [vc addSubview:_loginButton];
    [vc addSubview:_lostPasswordButton];
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
    parameters[@"password"] = password;
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
    LYHLostPasswordViewController *vc = [[LYHLostPasswordViewController alloc] init];
    //在push隐藏底部工具栏TarBar 并且设置那个viewController必须是push那个和必须在push之前设置
    [self.view endEditing:YES];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark 立即加入按钮点击事件（注册）
- (void)registerButtonClick
{
    LYHRegisterViewController *vc = [[LYHRegisterViewController alloc] init];
    [self.view endEditing:YES];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    UIImage *temp;
    self.navigationItem.title = @"登录";
    self.navigationController.navigationBar.barTintColor = LYHColor(53,183,243);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
