//
//  LYHFriendsViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/16.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHFriendsViewCell.h"
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "Friends.h"


@implementation LYHFriendsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//设置模型shuxing
-(void)setFriends:(Friends *)friends
{
    //拼接用户头像url
    NSString *headImageUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",friends.headImage]];
    //占位图(如果用户没有设置头像)
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户头像(网络请求数据)
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(!image)
        {
            return;
        }
    }];
    _friends =friends;
    _userNameLabel.text = friends.name;
}

#pragma mark 重新设置cellfram
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = frame.origin.x +10;
    frame.size.height -= 10;
    frame.size.width -= 2 * 10;
    
    [super setFrame:frame];
}




@end
