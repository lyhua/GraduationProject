//
//  LYHResponViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/25.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHResponViewCell.h"
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "UIButton+Category.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LYHResponViewCell


#pragma mark 重写便利构造方法(cell初始化时调用这个不是调用init)
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置UI
        [self setupUI];
    }
    return self;
}

#pragma mark 设置模型属性
-(void)setUser:(User *)user
{
    _user = user;
    //拼接用户头像url
    NSString *headImageUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",user.headImage]];
    //占位图(如果用户没有设置头像)
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户头像(网络请求数据)
    [self.headView sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    _userNameLabel.text = user.name;
    
}


#pragma mark 设置UI
-(void)setupUI
{
    //暂时设置头像
    _headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headImage"]];
    [self.contentView addSubview:_headView];
    
    //进行头像布局
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.text = @"lyh";
    [self.contentView addSubview:_userNameLabel];
    
    //用户姓名布局
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_top);
        make.left.equalTo(_headView.mas_right).offset(10);
    }];
    
    _submitButton = [UIButton createMyButtonWithTitle:@"添加" backgroudColor:LYHColor(254, 217, 111) borderColor:LYHColor(254, 217, 111).CGColor cornerRadius:10.0 borderWidth:0.0 textColor:[UIColor whiteColor]];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_submitButton];
    //申请按钮布局
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    //为申请按钮添加事件
    [_submitButton addTarget:self action:@selector(responApplyFriend) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark 响应申请好友
-(void)responApplyFriend
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"friend/responseApplyForFriend"];
    NSLog(@"url      ------%@",url);
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"user_id"] = [User shareUser].userId;
    parameters[@"myFriend_id"] = _user.userId;
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject[@"msg"])
        {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            _submitButton.userInteractionEnabled = NO;
        }
        if(responseObject[@"error"])
        {
            [SVProgressHUD showErrorWithStatus:@"添加失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络有问题"];
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
