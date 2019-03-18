//
//  LYHMeNorViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/27.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHMeNorViewCell.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "User.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "UIImage+Image.h"

@implementation LYHMeNorViewCell


#pragma mark 重写便利构造方法(cell初始化时调用这个不是调用init)
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置UI
        [self setupUI];
    }
    return self;
}

/*
-(void)setFlag:(NSNumber *)flag
{
    _norImageView.image = [UIImage imageNamed:@"icon_add"];
}
*/
#pragma mark 设置UI
-(void)setupUI
{
    _norImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_norImageView];
    [_norImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    _norLabel = [[UILabel alloc] init];
    _norLabel.font = [UIFont systemFontOfSize:15];
    _norLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_norLabel];
    [_norLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(_norImageView.mas_right).offset(10);
    }];
    
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RightAccessory"]];
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = LYHColor(249, 249, 249);
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth - 40, 1));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom);
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
