//
//  LYHContentViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/14.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHContentViewCell.h"
#import "Content.h"
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "LYHConst.h"
#import "LYHPicturesView.h"
#import "NSString+Category.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>

@implementation LYHContentViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LYHContentViewCell class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}

#pragma mark 设置模型数据
//-(void)setContent:(Content *)content
//{
//    //拼接用户头像url
//    NSString *headImageUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",content.headImage]];
//    //拼接内容图片url
//    NSString *contentUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"contentImage/%2",content.contentImage]];
//    //占位图(如果用户没有设置头像)
//    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
//    //设置用户头像(网络请求数据)
//    [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"-------------");
//        if(!image)
//        {
//            return;
//        }
//    }];
//    
//    _content = content;
//    _userNameLabel.text = content.userName;
//    _contentLabel.text = content.content;
//    //TODO 设置心情图片
//    if(_content.mood == 1)
//    {
//        _moodImage.image = [UIImage imageNamed:@"happy_icon"];
//    }else{
//        _moodImage.image = [UIImage imageNamed:@"unhappy_icon"];
//    }
//    //设置图片模型
//    _pictures = [[Pictures alloc] init];
//    _pictures.images = [NSString stringDivisionWithString:_content.contentImage symbol:@"#"];
//    _pictures.smallImages = [NSString stringDivisionWithString:_content.contentSmallImage symbol:@"#"];
//    _pictures.imagesCount = _pictures.images.count;
//}

#pragma mark 懒加载picturesView
//- (LYHPicturesView *)picturesView
//{
//    if (!_picturesView) {
//        LYHPicturesView *picturesView = [[LYHPicturesView alloc] initWithpicturesModel:self.pictures];
//        [self.contentView addSubview:picturesView];
//        _picturesView = picturesView;
//    }
//    return _picturesView;
//}


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= LYHIntervel;
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

#pragma mark 重写layoutSubviews
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    //进行picturesView布局
//    //有图片模型才进行布局
//    if (_pictures) {
//        self.picturesView.frame = self.content.middleFrame;
//    }
//}

#pragma mark 祝福按钮点击事件
- (IBAction)blessingBtnClick:(id)sender {
    NSLog(@"---------blessingBtnClick");
}

#pragma mark 举报按钮点击事件
- (IBAction)reportBtnClick:(id)sender {
    NSLog(@"----------reportBtnClick");
}


#pragma mark 评论按钮点击事件
- (IBAction)commentBtnClick:(id)sender {
    NSLog(@"____----------commentBtnClick");
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LYHCellCommentBtnClickNotification object:nil];
}
@end
