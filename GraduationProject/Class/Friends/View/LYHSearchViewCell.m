//
//  LYHSearchViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/21.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHSearchViewCell.h"
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "UIButton+Category.h"
#import "LYHApplyFriController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LYHSearchViewCell


#pragma mark 重写便利构造方法(cell初始化时调用这个不是调用init)
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置UI
        [self setupUI];
    }
    return self;
}



#pragma mark 设置UI
-(void)setupUI
{
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.font = [UIFont systemFontOfSize:14];
    _phoneLabel.textColor = [UIColor blackColor];
    _phoneLabel.text =@"手机号码";
    [self.contentView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.textAlignment = NSTextAlignmentLeft;
    _phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneLabel.mas_right).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    _searchButton = [UIButton createMyButtonWithTitle:@"搜索" backgroudColor:LYHColor(253, 185, 109) borderColor:LYHColor(253, 185, 109).CGColor cornerRadius:10.0 borderWidth:1.0 textColor:[UIColor whiteColor]];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.left.equalTo(_phoneTextField.mas_right).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [_searchButton addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark 搜索朋友
-(void)searchFriend
{
    
    if(_phoneTextField.text)
    {
        //LYHApplyFriController *vc = [[LYHApplyFriController alloc] init];
    }else
    {
        //提示空窜
    }
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
