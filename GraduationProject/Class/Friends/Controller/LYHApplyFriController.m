//
//  LYHApplyFriController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/21.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHApplyFriController.h"
#import <MJExtension/MJExtension.h>
#import "User.h"
#import <Masonry/Masonry.h>
#import "UIImage+Image.h"
#import "Base.h"
#import "UIButton+Category.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

@interface LYHApplyFriController ()

@end

@implementation LYHApplyFriController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNavBar];
    
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
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 144));
        make.top.equalTo(vc.mas_top).offset(74);
        make.left.equalTo(vc.mas_left);
        make.right.equalTo(vc.mas_right);
    }];
    
    //拼接用户头像
    NSString *url = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",_user.headImage]];
    
    _headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headImage"]];
    [vc addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.top.equalTo(_backgroudView.mas_top).offset(10);
        make.left.equalTo(_backgroudView.mas_left).offset(10);
    }];
    
    //设置用户头像
    [_headImage sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.text = _user.name;
    _userNameLabel.textColor = [UIColor blackColor];
    [vc addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(10);
        make.top.equalTo(_headImage.mas_top);
    }];
    
    _searchButton = [UIButton createMyButtonWithTitle:@"添加" backgroudColor:LYHColor(254, 217, 111) borderColor:LYHColor(254, 217, 111).CGColor cornerRadius:20.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    [vc addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(300, 40));
        make.size.mas_equalTo(CGSizeMake(300, 40));
        //make.top.equalTo(_backgroudView.mas_bottom).offset(20);
        make.top.equalTo(_headImage.mas_bottom).offset(20);
        make.centerX.equalTo(vc.mas_centerX);
    }];
    
    [_searchButton addTarget:self action:@selector(applyForFriend) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 申请好友
-(void)applyForFriend
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"friend/applyForFriend"];
    NSLog(@"url      ------%@",url);
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"] = [User shareUser].userId;
    parameters[@"myFriend_id"] = _user.userId;
    
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject[@"msg"])
        {
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        }
        if(responseObject[@"error"])
        {
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
}

#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    self.navigationItem.title = @"详细资料";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
