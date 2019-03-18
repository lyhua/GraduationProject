//
//  LYHHLostPasswordViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHLostPasswordViewController.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSString+URL.h"
#import "NetworkRequest.h"
#import "UIButton+Category.h"
#import "UITextField+Category.h"
#import "Timer.h"
#import "Regular.h"
#import "UIImage+Image.h"
#import "NSString+Category.h"

@interface LYHHLostPasswordViewController ()

@end

@implementation LYHHLostPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行控件布局
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

#pragma mark 进行控件布局
- (void)setupUI
{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    vc.backgroundColor = [UIColor whiteColor];
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
    
    _phoneTextField = [UITextField createMyTextFieldWithPlaceholder:@"手机号码" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeNumberPad];
    [_phoneTextField setBorderStyle:UITextBorderStyleNone];
    //监听手机号码是否合法
    [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [vc addSubview:_phoneTextField];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_shadowImageView.mas_top).offset(1);
        make.centerX.equalTo(_shadowImageView.mas_centerX);
    }];
    
    _passwordTextField = [UITextField createMyTextFieldWithPlaceholder:@"新密码" secureTextEntry:YES borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    [_passwordTextField setBorderStyle:UITextBorderStyleNone];
    
    [vc addSubview:_passwordTextField];
    
    //监听密码是否有输入
    [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(15);
        make.centerX.equalTo(_phoneTextField.mas_centerX);
    }];
    
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
    
    _verificationCodeTextField = [UITextField createMyTextFieldWithTextAlignment:NSTextAlignmentCenter placeholder:@"验证码" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeNumberPad];
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
    _verificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [vc addSubview:_verificationCodeButton];
    [_verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
        make.right.equalTo(_shadowImageView.mas_right).offset(-30);
    }];
    
    //为获取验证码添加点击事件
    [_verificationCodeButton addTarget:self action:@selector(verificationCodeButtonCilik) forControlEvents:UIControlEventTouchUpInside];
    
    _submitButton = [UIButton createMyButtonWithTitle:@"修改密码" backgroudColor:LYHColor(254, 217, 111) borderColor:LYHColor(254, 217, 111).CGColor cornerRadius:20.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _submitButton.enabled = NO;
    
    //添加提交按钮点击事件
    [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [vc addSubview:_submitButton];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_verificationCodeTextField.mas_bottom).offset(30);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    
}

#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    UIImage *temp;
    self.navigationItem.title = @"忘记密码";
    self.navigationController.navigationBar.barTintColor = LYHColor(254, 217, 111);
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


#pragma mark 监听验证码的输入长度
- (void)textFieldDidChange:(id) sender
{
    UITextField *field = (UITextField *)sender;
    if (field.text.length > 3)
    {
        _verificationCodeTextFieldLenIsOk = YES;
        if (_phoneTextFieldLenIsOk && _passwordTextFieldLenIsOk && _verificationCodeTextFieldLenIsOk)
        {
            self.submitButton.enabled = YES;
        }
    }else{
        _verificationCodeTextFieldLenIsOk = NO;
        self.submitButton.enabled = NO;
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
            self.submitButton.enabled = YES;
        }
    }else{
        self.submitButton.enabled = NO;
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
            self.submitButton.enabled = YES;
        }
    }else{
        _passwordTextFieldLenIsOk = NO;
        self.submitButton.enabled = NO;
    }
}



#pragma mark 提交按钮点击事件
- (void)submitButtonClick
{
    NSLog(@"submitButtonClick Click");
#warning 要请求数据 判断是手机号码还是邮箱
    //获得所有数据和 判断是手机号码还是邮箱
    NSString *phone = _phoneTextField.text;
    //TODO 密码要进行加密 MD5或三重螺旋加密
    NSString *password = _passwordTextField.text;
    NSString *verificationCode = _verificationCodeTextField.text;
    NSString *code = @"1003";//修改密码发给服务器的操作码
    //TODO 把参数进行封装的抽象
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = phone;
#pragma mark 这里md5
    //dict[@"password"] = password;
    dict[@"password"] = [NSString md5:password];
    dict[@"verificationCode"] = verificationCode;
    dict[@"code"] = code;
    //拼接URL AlterUserImformation
    NSString *url = [NSString urlWithRelativePath:@"alterUserPasswordWithPhone"];
    
    //向服务器请求数据
    [[NetworkRequest getRequest] GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 修改失败
        NSString *error = responseObject[@"error"];
        if(error)
        {
#warning 根据返回的json数据提醒用户哪里出错
            //根据返回的json数据提醒用户哪里出错
            [SVProgressHUD showErrorWithStatus:usualError];
            return ;
        }
        NSString *msg = responseObject[@"msg"];
        if(msg)
        {
            [SVProgressHUD showSuccessWithStatus:alterPasswordSuccess];
            [self backCilck];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求服务器失败 提醒用户网络故障
        [SVProgressHUD showErrorWithStatus:errorNetwork];
    }];
}

#pragma mark 返回
- (void)backCilck
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //使提示信息消失然后在回退
        [SVProgressHUD dismiss];
    });
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
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
    //请求服务器
    [[NetworkRequest getRequest] GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"+++++++++sendCode");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提示用户网络有问题
        [SVProgressHUD showErrorWithStatus:errorNetwork];
    }];
    
    //定时器
    [Timer shareTimer:10 requester:self.verificationCodeButton title:@"获取验证码"];
    
}

#warning 监听电话文本输入单有电话号码或者邮箱时才允许获取验证码按钮能够交互


#pragma mark 键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
