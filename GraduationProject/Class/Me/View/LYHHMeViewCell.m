//
//  LYHHMeViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/27.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHMeViewCell.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "User.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "UIImage+Image.h"

@implementation LYHHMeViewCell


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
    _backgroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_user"]];
    [self.contentView addSubview:_backgroudImageView];
    [_backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    _headView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
        make.size.mas_equalTo(CGSizeMake(66, 64));
    }];
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.textColor = [UIColor whiteColor];
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(_headView.mas_bottom).offset(5);
    }];
}

-(void)setUser:(User *)user
{
    _user = user;
    
    //拼接用户头像
    NSString *url = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",user.headImage]];
    //占位图(如果用户没有设置头像)
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户头像
    [self.headView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[placeholder circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image)
        {
            //设置圆形图片
            _headView.image = [image circleImage];
        }
    }];
    _userNameLabel.text = user.name;
    
    
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
