//
//  LYHMoreController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/24.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHMoreController.h"
#import "UIImage+Image.h"
#import "Base.h"
#import <Masonry/Masonry.h>
#import "UIButton+Category.h"
#import "LYHApplyFriController.h"
#import "NetworkRequest.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "NetworkRequest.h"
#import "LYHRespondViewController.h"
#import "LYHInfoViewController.h"

@interface LYHMoreController ()

@end

@implementation LYHMoreController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航条
    [self setupNav];
    
    //设置UI
    [self setupUI];
}

#pragma mark 设置UI
-(void)setupUI
{
    UIView *vc=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    vc.backgroundColor=[UIColor grayColor];
    [self.view addSubview:vc];
    
    _backgroudView = [[UIView alloc] init];
    _backgroudView.backgroundColor = [UIColor whiteColor];
    [vc addSubview:_backgroudView];
    [_backgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 64));
        make.top.equalTo(vc.mas_top).offset(64);
        make.left.equalTo(vc.mas_left);
        make.right.equalTo(vc.mas_right);
    }];
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.font = [UIFont systemFontOfSize:14];
    _phoneLabel.text = @"手机号码";
    _phoneLabel.textColor = [UIColor blackColor];
    [vc addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backgroudView.mas_top).offset(25);
        make.left.equalTo(_backgroudView.mas_left).offset(10);
    }];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [vc addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneLabel.mas_right).offset(10);
        make.centerY.equalTo(_phoneLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    _searchButton = [UIButton createMyButtonWithTitle:@"搜索" backgroudColor:LYHColor(253, 185, 109) borderColor:LYHColor(253, 185, 109).CGColor cornerRadius:10.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [vc addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.left.equalTo(_phoneTextField.mas_right).offset(10);
        make.centerY.equalTo(_phoneTextField.mas_centerY);
    }];
    
    [_searchButton addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    
    //查看申请好友
    _backgroudView1 = [[UIView alloc] init];
    _backgroudView1.backgroundColor = [UIColor whiteColor];
    [vc addSubview:_backgroudView1];
    [_backgroudView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 64));
        make.top.equalTo(_backgroudView.mas_bottom).offset(15);
        make.left.equalTo(vc.mas_left);
        make.right.equalTo(vc.mas_right);
    }];
    
    /*
    _seeButton = [[UIButton alloc] init];
    [_seeButton setTitle:@"查看申请信息" forState:UIControlStateNormal];
    [_seeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_seeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    _seeButton.titleLabel.textColor = [UIColor blackColor];
     */
    _seeButton = [UIButton createMyButtonWithTitle:@"查看申请信息" backgroudColor:LYHColor(253, 185, 109) borderColor:LYHColor(253, 185, 109).CGColor cornerRadius:10.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    _seeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [vc addSubview:_seeButton];
    [_seeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerY.equalTo(_backgroudView1.mas_centerY);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    //添加点击事件
    [_seeButton addTarget:self action:@selector(getApplyFriend) forControlEvents:UIControlEventTouchUpInside];
    
    //查看申请好友
    _backgroudView2 = [[UIView alloc] init];
    _backgroudView2.backgroundColor = [UIColor whiteColor];
    [vc addSubview:_backgroudView2];
    [_backgroudView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 64));
        make.top.equalTo(_backgroudView1.mas_bottom).offset(15);
        make.left.equalTo(vc.mas_left);
        make.right.equalTo(vc.mas_right);
    }];
    
    
    
    _getInfosButton = [UIButton createMyButtonWithTitle:@"查看悄悄话" backgroudColor:LYHColor(253, 185, 109) borderColor:LYHColor(253, 185, 109).CGColor cornerRadius:10.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    _getInfosButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [vc addSubview:_getInfosButton];
    [_getInfosButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerY.equalTo(_backgroudView2.mas_centerY);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    [_getInfosButton addTarget:self action:@selector(getInfos) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}

#pragma mark 获取信息
-(void)getInfos
{
    LYHInfoViewController *vc = [[LYHInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 搜索朋友
-(void)searchFriend
{
    __block User *user = nil;
    if(_phoneTextField.text)
    {
        //发送请求查看是否存在好友
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"phone"] = _phoneTextField.text;
        
        //拼接url
        NSString *url = [BaseURL stringByAppendingString:@"getUserWithPhone"];
        
        //请求数据
        [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(responseObject[@"error"])
            {
                [SVProgressHUD showErrorWithStatus:@"用户不存在"];
            }else{
               user = [User mj_objectWithKeyValues:responseObject[@"user"]];
                //弹出控制器
                if(user)
                {
                    LYHApplyFriController *vc = [[LYHApplyFriController alloc] init];
                    //传递模型
                    vc.user = user;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"用户不存在"];
        }];
        
#warning 验证手机号码是否为有效手机号码
    }else{
        [SVProgressHUD showErrorWithStatus:@"手机号码为空"];
    }
    
}

#pragma mark 获取申请好友列表
-(void)getApplyFriend
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"friend/getApplyForFriend"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = [User shareUser].userId;
    
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSMutableArray *users = [User mj_objectArrayWithKeyValuesArray:responseObject[@"users"]];
        if(users)
        {
            LYHRespondViewController *vc = [[LYHRespondViewController alloc] init];
            vc.users = users;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"暂无信息"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"获取信息失败"];
    }];
    
}


#pragma  mark 设置导航条
- (void)setupNav
{
    self.navigationItem.title =@"更多";
    self.navigationController.navigationBar.barTintColor=LYHMyColor;
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
