//
//  LYHInfoViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/11.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHInfoViewCell.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "UIImage+Image.h"


@implementation LYHInfoViewCell

#pragma mark 重写便利构造方法(cell初始化时调用这个不是调用init)
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置UI
        [self setupUI];
    }
    return self;
}


#pragma mark 设置模型数据
-(void)setInfo:(Info *)info
{
    _info = info;
    _friendName.text = info.senderName;
    _timeLabel.text = info.receive_date;
    _contentLabel.text = info.info_content;
    
    
    //拼接用户头像url
    NSString *url = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",info.senderHeadImage]];
    
    NSLog(@"-----url-----%@",url);
    
    [_friendImageView sd_setImageWithURL:[[NSURL alloc] initWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载图片结束
        NSLog(@"下载图片完成");
        _friendImageView.image = [image circleImage];
    }];
    
    
    
    
}


#pragma mark 设置UI
-(void)setupUI
{
    //亲友头像布局
    _friendImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_friendImageView];
    [_friendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    //亲友名字布局
    _friendName = [[UILabel alloc] init];
    _friendName.font = [UIFont systemFontOfSize:12];
    _friendName.textColor = [UIColor grayColor];
    [self.contentView addSubview:_friendName];
    [_friendName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_friendImageView.mas_top);
        make.left.equalTo(_friendImageView.mas_right).offset(3);
    }];
    
    //时间标签布局
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_friendName.mas_left);
        make.bottom.equalTo(_friendImageView.mas_bottom);
    }];
    
    //内容标签布局
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = LYHWidth - 20;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_friendImageView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYHWidth - 20, 1));
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









