//
//  LYHLostPasswordViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/2/27.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHLostPasswordViewController.h"
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

@interface LYHLostPasswordViewController ()

@end

@implementation LYHLostPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //进行控件布局
    [self setupUI];
    //设置导航条
    [self setupNavBar];
}


#pragma mark 进行控件布局
- (void)setupUI
{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    vc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vc];
    _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Phone_icon"]];
    [vc addSubview:_phoneImageView];
    [_phoneImageView setFrame:CGRectMake(70, 40, 37, 37)];
    
    _phoneTextField = [UITextField createMyTextFieldWithPlaceholder:@"电弧号码/邮箱" secureTextEntry:NO borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    //监听手机号码是否合法
    [_phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [vc addSubview:_phoneTextField];
    
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneImageView.mas_right).offset(20);
        make.top.equalTo(vc).offset(40);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(39);
    }];
    
    _passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_password_icon"]];
    [vc addSubview:_passwordImageView];
    [_passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 37));
        make.top.equalTo(_phoneImageView.mas_bottom).offset(20);
        make.left.equalTo(_phoneImageView.mas_left);
    }];
    
    _passwordTextField = [UITextField createMyTextFieldWithPlaceholder:@"新密码" secureTextEntry:YES borderStyle:UITextBorderStyleRoundedRect keyboardType:UIKeyboardTypeDefault];
    //监听密码是否有输入
    [_passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [vc addSubview:_passwordTextField];
    [vc addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 39));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(20);
        make.left.equalTo(_passwordImageView.mas_right).offset(20);
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
    
    _verificationCodeButton = [UIButton createMyButtonWithTitleFont:15.0 title:@"获取验证码" backgroudColor:LYHColor(253, 112, 75) borderColor:LYHColor(243, 100, 67).CGColor cornerRadius:30 / 4 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _verificationCodeButton.enabled = NO;
    
    //为获取验证码添加点击事件
    [_verificationCodeButton addTarget:self action:@selector(verificationCodeButtonCilik) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:_verificationCodeButton];
    [_verificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.top.equalTo(_passwordTextField.mas_bottom).offset(10);
        make.left.equalTo(_verificationCodeTextField.mas_right).offset(20);
    }];
    

    _submitButton = [UIButton createMyButtonWithTitle:@"提交" backgroudColor:LYHColor(53,183,243) borderColor:LYHColor(29, 162, 234).CGColor cornerRadius:10.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _submitButton.enabled = NO;
    //添加提交按钮点击事件
    [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [vc addSubview:_submitButton];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_verificationCodeButton.mas_bottom).offset(20);
        make.left.equalTo(vc).offset(70);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    UIImage *temp;
    self.navigationItem.title = @"忘记密码";
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
    dict[@"password"] = password;
    dict[@"verificationCode"] = verificationCode;
    dict[@"code"] = code;
    //拼接URL AlterUserImformation
    NSString *url = [NSString urlWithRelativePath:@"AlterUserImformation"];

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
        if(msg && !error)
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
