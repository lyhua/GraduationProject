//
//  LYHSecretViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/10.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHSecretViewController.h"
#import "Base.h"
#import "UIImage+Image.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import "Base.h"
#import "UITextField+Category.h"
#import "User.h"
#import <AFNetworking/AFNetworking.h>
#import "NetworkRequest.h"


@interface LYHSecretViewController ()<UITextFieldDelegate>

@end

@implementation LYHSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    
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
    //受导航条影响控件都会下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 64, LYHWidth, LYHHeight-64)];
    vc.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vc];
    _contentTextView = [[UITextView alloc] init];
    
    //设置键盘代理
    _contentTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
     //设置垂直滚动
    _contentTextView.alwaysBounceVertical = YES;
    //设置边框颜色
    _contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    //设置边框边界线条大小
    _contentTextView.layer.borderWidth = 1;
    //设置边框圆角
    _contentTextView.layer.cornerRadius = 10;
    _contentTextView.layer.masksToBounds = YES;
    //设置键盘属性
    _contentTextView.keyboardType = UIKeyboardTypeDefault;
    
    
    
    [vc addSubview:_contentTextView];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 200));
        make.top.equalTo(vc.mas_top).offset(5);
        make.left.equalTo(vc.mas_left).offset(10);
        make.right.equalTo(vc.mas_right).offset(-10);
    }];
    
    _dateTextField = [[UITextField alloc] init];
    _dateTextField.textAlignment = NSTextAlignmentCenter;
    _dateTextField.placeholder = @"选择发送日期";
    _dateTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    _dateTextField.delegate = self;
    
    _datePicker = [[UIDatePicker alloc] init];
    //挑选显示日期的模式
    _datePicker.datePickerMode = UIDatePickerModeDate;
    //设置语言：中文
    _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //为选择器添加事件
    [_datePicker addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    
    
    [vc addSubview:_dateTextField];
    //把日期选择器的输入改成日期输入
    _dateTextField.inputView = _datePicker;
    [_dateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 40));
        make.top.equalTo(_contentTextView.mas_bottom).offset(10);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    
}

#pragma mark 日期选择器事件
-(void)changeValue
{
    NSDate *date = _datePicker.date;
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyy-MM-dd";
    _dateTextField.text = [dateForm stringFromDate:date];
    
}


#pragma mark 设置导航条
-(void)setupNav
{
    //设置导航条标题
    self.navigationItem.title = @"悄悄话";
    //设置导航台颜色
    self.navigationController.navigationBar.barTintColor = LYHColor(254, 217, 111);
    //设置返回按钮
    UIImage *temp;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp  forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //添加发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    
    
    
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

#pragma mark 发送悄悄话
-(void)sendMessage
{
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *send_date = [formatter stringFromDate:date];
    NSString *receive_date = _dateTextField.text;
    NSNumber *send_id = [User shareUser].userId;
    NSNumber *receive_id = _friendId;
    
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"info/createInfo"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"send_date"] = send_date;
    parameters[@"receive_date"] = receive_date;
    parameters[@"send_id"] = send_id;
    parameters[@"receive_id"] = receive_id;
    parameters[@"info_content"] = _contentTextView.text;
    
    //发送请求
    
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        
        //返回
        self.hidesBottomBarWhenPushed = NO;
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户那里出错
        NSLog(@"error   ______--------%@",error);
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
    
    
}

#pragma mark 点击空白处关闭键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
