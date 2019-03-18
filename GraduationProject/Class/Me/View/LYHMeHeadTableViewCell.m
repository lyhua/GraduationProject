//
//  LYHMeHeadTableViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/4.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHMeHeadTableViewCell.h"
#import "User.h"
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"

@implementation LYHMeHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//设置模型数据
-(void)setUser:(User *)user
{
    //拼接用户头像
    NSString *url = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",user.headImage]];
    //占位图(如果用户没有设置头像)
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户头像
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(!image)
        {
            return;
        }
    }];
    //设置用户名称
    self.userNameLabel.text = user.name;
    
}

@end
