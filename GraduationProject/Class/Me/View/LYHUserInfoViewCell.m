//
//  LYHUserInfoViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/13.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHUserInfoViewCell.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import "Base.h"

@implementation LYHUserInfoViewCell

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
    //内容标签布局
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    //文本修改布局
    _contentTextField = [[UITextField alloc] init];
    _contentTextField.textAlignment = NSTextAlignmentLeft;
    _contentTextField.borderStyle = UITextBorderStyleNone;
    [self.contentView addSubview:_contentTextField];
    [_contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_top);
        make.left.equalTo(_contentLabel.mas_right).offset(20);
    }];
    
    
    //线布局
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = LYHColor(241, 241, 241);
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth-20, 1));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.centerX.equalTo(self.contentView.mas_centerX);
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
