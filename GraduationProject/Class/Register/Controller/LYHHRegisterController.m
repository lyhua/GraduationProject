//
//  LYHHRegisterController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/3/30.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHRegisterController.h"
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
#import "NSString+Category.h"

@interface LYHHRegisterController ()

@end

@implementation LYHHRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    //进行控件的布局
    [self setupUI];
    
    //设置导航条
    [self setupNavBar];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI
{
    UIView *vc=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    vc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vc];
    
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
    
    _headImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headImage-1"]];
    [vc addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.top.equalTo(vc.mas_top).offset(230);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    //设置阴影View
    _shadowImageView =[[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [vc addSubview:_shadowImageView];
    [_shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 150));
        //make.top.equalTo(_passwordTextField.mas_bottom);
        make.top.equalTo(_headImageView.mas_bottom).offset(10);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    _phoneTextField =[UITextField createMyTextFieldWithPlaceholder:@"请输入手机号码" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypePhonePad];
    [_phoneTextField setBorderStyle:UITextBorderStyleNone];
    //监听手机号码是否合法
    [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [vc addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 39));
        make.top.equalTo(_shadowImageView.mas_top).offset(15);
        //make.left.equalTo(vc.mas_left).offset(40);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    
    
    //监听手机号码是否合法
    [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _passwordTextField = [UITextField createMyTextFieldWithPlaceholder:@"请输入密码" secureTextEntry:YES borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    [_passwordTextField setBorderStyle:UITextBorderStyleNone];
    [vc addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 39));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(15);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    //监听密码是否有输入
    [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [vc addSubview:_passwordTextField];
    
    
    //线的View
    _lineView =[[UIView alloc] init];
    _lineView.backgroundColor=LYHColor(222,222,222);
    [vc addSubview:_lineView];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 1));
        make.top.equalTo(_phoneTextField.mas_bottom);
        make.centerX.equalTo(_shadowImageView.mas_centerX);
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
    
    _verificationCodeTextField =[UITextField createMyTextFieldWithPlaceholder:@"验证码" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeNumberPad];
    _verificationCodeTextField.textAlignment = NSTextAlignmentCenter;
    
    //添加验证码长度监听事件
    [_verificationCodeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    [vc addSubview:_verificationCodeTextField];
    [_verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
        make.left.equalTo(_shadowImageView.mas_left).offset(30);
    }];
    
    _verificationCodeButton = [UIButton createMyButtonWithTitleFont:15.0 title:@"获取验证码" backgroudColor:LYHColor(254, 217, 111) borderColor:LYHColor(254, 217, 111).CGColor cornerRadius:30/4 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _verificationCodeButton.enabled = NO;
    [vc addSubview:_verificationCodeButton];
    /*
    [_verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
        make.right.equalTo(_shadowImageView.mas_right).offset(-30);
    }];
     */
    
    //为获取验证码添加点击事件
    [_verificationCodeButton addTarget:self action:@selector(verificationCodeButtonCilik) forControlEvents:UIControlEventTouchUpInside];
    _verificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [vc addSubview:_verificationCodeButton];
    [_verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
        make.left.equalTo(_verificationCodeTextField.mas_right).offset(20);
    }];
    
    _registerButton = [UIButton createMyButtonWithTitle:@"注册" backgroudColor:LYHColor(254, 217, 111) borderColor:LYHColor(254, 217, 111).CGColor cornerRadius:20.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _registerButton.enabled = NO;
    //添加注册按钮点击事件
    [_registerButton addTarget:self action:@selector(registerCilck) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_verificationCodeTextField.mas_bottom).offset(30);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
}


#pragma mark 设置导航条
- (void)setupNavBar
{
    UIImage * temp;
    self.navigationItem.title = @"注册";
    //self.navigationController.navigationBar.barTintColor = LYHColor(254, 217, 111);
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
    //dict[@"password"] = password;
    dict[@"password"] = [NSString md5:password];
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
            [SVProgressHUD showErrorWithStatus:@"验证码或手机号码有误"];
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
