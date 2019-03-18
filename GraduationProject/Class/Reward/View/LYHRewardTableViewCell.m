//
//  LYHRewardTableViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/2.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHRewardTableViewCell.h"
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>

@implementation LYHRewardTableViewCell

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
-(void)setReward:(Reward *)reward
{
    _reward = reward;
    _rewardLabel.text = reward.reward_name;
    
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"missionImage/"];
    NSString *realUrl = [url stringByAppendingString:_reward.reward_pic];
    
    //下载图片
    [_rewardImageView sd_setImageWithURL:[[NSURL alloc] initWithString:realUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载图片结束
        NSLog(@"下载小图完成");
    }];
}


#pragma mark 设置UI
-(void)setupUI
{
    //创建奖励图片
    _rewardImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rewardImageView];
    
    
    
    //进行奖励图片布局
    [_rewardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(39, 39));
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    
    
    //奖励称号标签布局
    _rewardLabel = [[UILabel alloc] init];
    _rewardLabel.text = _reward.reward_name;
    _rewardLabel.font = [UIFont systemFontOfSize:16];
    _rewardLabel.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:_rewardLabel];
    
    [_rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_rewardImageView.mas_centerY);
        make.left.equalTo(_rewardImageView.mas_right).offset(20);
    }];
    
}

#pragma mark 重新设置cellfram
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = frame.origin.x +10;
    frame.size.height -= 10;
    frame.size.width -= 2 * 10;
    
    [super setFrame:frame];
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
