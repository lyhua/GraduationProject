//
//  LYHRegisterViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/1.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHRegisterViewController.h"
#import "Base.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSString+URL.h"
#import "NetworkRequest.h"
#import "UIButton+Category.h"
#import "UITextField+Category.h"
#import "Timer.h"
#import "Regular.h"
#import "UIImage+Image.h"

@interface LYHRegisterViewController ()

@end

@implementation LYHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行控件的布局
    [self setupUI];
    
    //设置导航条
    [self setupNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 进行控件的布局
- (void)setupUI
{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    vc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vc];
    _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Phone_icon"]];
    [vc addSubview:_phoneImageView];
    [_phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 37));
        make.left.equalTo(vc.mas_left).offset(70);
        make.top.equalTo(vc.mas_top).offset(40);
    }];
    
    _phoneTextField = [UITextField createMyTextFieldWithPlaceholder:@"电话号码/邮箱" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    //监听手机号码是否合法
    [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [vc addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 39));
        make.top.equalTo(vc.mas_top).offset(40);
        make.left.equalTo(_phoneImageView.mas_right).offset(20);
    }];
    
    _passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_password_icon"]];
    [vc addSubview:_passwordImageView];
    [_passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 37));
        make.top.equalTo(_phoneImageView.mas_bottom).offset(20);
        make.left.equalTo(_phoneImageView.mas_left);
    }];
    
    _passwordTextField = [UITextField createMyTextFieldWithPlaceholder:@"密码" secureTextEntry:YES borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    //监听密码是否有输入
    [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [vc addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 39));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(20);
        make.left.equalTo(_phoneImageView.mas_right).offset(20);
    }];
    
    _verificationCodeTextField = [UITextField createMyTextFieldWithTextAlignment:NSTextAlignmentCenter placeholder:@"验证码" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeNumberPad];
    //添加验证码长度监听事件
    [_verificationCodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [vc addSubview:_verificationCodeTextField];
    [_verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 40));
        make.left.equalTo(_passwordImageView.mas_left);
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
    }];
    
    _verificationCodeButton = [UIButton createMyButtonWithTitleFont:15.0 title:@"获取验证码" backgroudColor:LYHColor(253, 112, 75) borderColor:LYHColor(243, 100, 67).CGColor cornerRadius:30 /4 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _verificationCodeButton.enabled = NO;
    
    //为获取验证码添加点击事件
    [_verificationCodeButton addTarget:self action:@selector(verificationCodeButtonCilik) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:_verificationCodeButton];
    [_verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
        make.left.equalTo(_verificationCodeTextField.mas_right).offset(20);
    }];
    
    _registerButton = [UIButton createMyButtonWithTitle:@"注册" backgroudColor:LYHColor(53,183,243) borderColor:LYHColor(29, 162, 234).CGColor cornerRadius:10.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _registerButton.enabled = NO;
    //添加注册按钮点击事件
    [_registerButton addTarget:self action:@selector(registerCilck) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260, 40));
        make.top.equalTo(_verificationCodeButton.mas_bottom).offset(20);
        make.left.equalTo(vc).offset(70);
    }];
    
    
    
}

#pragma mark 设置导航条
- (void)setupNavBar
{
    UIImage * temp;
    self.navigationItem.title = @"注册";
    self.navigationController.navigationBar.barTintColor = LYHColor(53,183,243);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    //为返回按钮增加点击事件
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

#pragma mark 添加注册按钮点击事件
- (void)registerCilck
{
//    NSLog(@"____________registerCilck");
    //拼接url
    NSString *url = [NSString urlWithRelativePath:@"Register"];
    
    //获得参数并且拼接参数
    NSString *phone = _phoneTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *verificationCode = _verificationCodeTextField.text;
    
    //封装参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = phone;
    dict[@"password"] = password;
    dict[@"verificationCode"] = verificationCode;

    //发起请求
    [[NetworkRequest getRequest] GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功，根据返回json提醒用户
        //如果error不为空提醒用户
        NSString *error = responseObject[@"error"];
        if (error)
        {
#warning 根据不同错误码提醒用户
            //根据不同错误码提醒用户
            [SVProgressHUD showErrorWithStatus:@"有错误"];
            return;
            
        }
        
        //如果error为空并且msg不为空跳转到登录界面
        NSString *msg = responseObject[@"msg"];
        if(msg && !error)
        {
            //提醒用户注册成功并且跳转到登录界面
            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
            //返回登录界面
#warning 这里太快返回 用户看不到提醒信息
            [self backCilck];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败提醒用户
        [SVProgressHUD showErrorWithStatus:errorNetwork];
    }];
}

#pragma mark 验证码点击事件
- (void)verificationCodeButtonCilik
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"sendCode"];
    //封装参数
    NSString *phone = _phoneTextField.text;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = phone;
    //TODO 请求服务器
    [[NetworkRequest getRequest] GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"+++++++++sendCode");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提示用户网络有问题
        [SVProgressHUD showErrorWithStatus:errorNetwork];
    }];
    
    //定时器
    [Timer shareTimer:10 requester:self.verificationCodeButton title:@"获取验证码"];
    
}

#pragma mark 监听验证码的输入长度
- (void)textFieldDidChange:(id) sender
{
    UITextField *field = (UITextField *)sender;
    if (field.text.length > 3)
    {
        _verificationCodeTextFieldLenIsOk = YES;
        if (_phoneTextFieldLenIsOk && _passwordTextFieldLenIsOk && _verificationCodeTextFieldLenIsOk)
        {
            self.registerButton.enabled = YES;
        }
    }else{
        _verificationCodeTextFieldLenIsOk = NO;
        self.registerButton.enabled = NO;
    }
}


#pragma mark 监听手机号码是否为合法
- (void)phoneTextFieldDidChange:(id) sender
{
    UITextField *field = (UITextField *)sender;
    _phoneTextFieldLenIsOk = [Regular isValidateMobile:field.text];
    //设置获取验证码是否被点击
    if(_phoneTextFieldLenIsOk)
    {
        _verificationCodeButton.enabled = YES;
    }else{
        _verificationCodeButton.enabled = NO;
    }
    if (_phoneTextFieldLenIsOk)
    {
        if (_phoneTextFieldLenIsOk && _passwordTextFieldLenIsOk && _verificationCodeTextFieldLenIsOk)
        {
            self.registerButton.enabled = YES;
        }
    }else{
        self.registerButton.enabled = NO;
    }
}


#pragma mark 监听密码长度
- (void)passwordTextFieldDidChange:(id) sender
{
    UITextField *field = (UITextField *)sender;
    if (field.text.length > 5)
    {
        _passwordTextFieldLenIsOk = YES;
        if (_phoneTextFieldLenIsOk && _passwordTextFieldLenIsOk && _verificationCodeTextFieldLenIsOk)
        {
            self.registerButton.enabled = YES;
        }
    }else{
        _passwordTextFieldLenIsOk = NO;
        self.registerButton.enabled = NO;
    }
}

#warning 监听电话文本输入单有电话号码或者邮箱时才允许获取验证码按钮能够交互


#pragma mark 为返回按钮增加点击事件
- (void)backCilck
{
    //底部工具条显示
    self.hidesBottomBarWhenPushed = NO;
    //使提示信息消失 消失延迟
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SVProgressHUD dismiss];
    });
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
