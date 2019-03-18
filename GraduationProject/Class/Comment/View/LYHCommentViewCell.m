//
//  LYHCommentViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHCommentViewCell.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "LYHConst.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LYHCommentViewCell

#pragma mark 重写便利构造方法(cell初始化时调用这个不是调用init)
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置UI
        [self setupUI];
    }
    return self;
}

#pragma mark 设置评论数据模型
-(void)setComment:(Comment *)comment
{
    //拼接用户头像
    NSString *headImageUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",self.user.headImage]];
    //占位图
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return ;
        }
    }];
    
    _userNameLabel.text = _user.name;
    _commmentLabel.text = comment.comment;
    _dateLabel.text = comment.date;
    
    //设置comment属性
    _comment = comment;
}

#pragma mark 设置UI
-(void)setupUI
{
    _headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImageView];
    //用户头像布局
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_userNameLabel];
    //用户名
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_top);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_dateLabel];
    //日期
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImageView.mas_bottom);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
    }];

    
    _deleteCommentBtn = [[UIButton alloc] init];
    [_deleteCommentBtn setImage:[UIImage imageNamed:@"commentDelete_icon"] forState:UIControlStateNormal];
    [_deleteCommentBtn setImage:[UIImage imageNamed:@"commentDelete_heightlight_icon"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_deleteCommentBtn];
    //为删除按钮添加点击事件
    [_deleteCommentBtn addTarget:self action:@selector(deleteCommentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //删除布局
    [_deleteCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _badButton = [[UIButton alloc] init];
    [_badButton setImage:[UIImage imageNamed:@"bad_icon"] forState:UIControlStateNormal];
    [_badButton setImage:[UIImage imageNamed:@"bad_heightlight_icon"] forState:UIControlStateHighlighted];
    //为踩按钮添加点击啊事件
    [_badButton addTarget:self action:@selector(badButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_badButton];
    //踩按钮设置
    [_badButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.deleteCommentBtn.mas_left).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.size.mas_equalTo(CGSizeMake(23, 23));
    }];
    
    _goodButton = [[UIButton alloc] init];
    [_goodButton setImage:[UIImage imageNamed:@"good_icon"] forState:UIControlStateNormal];
    [_goodButton setImage:[UIImage imageNamed:@"good_heightlight_icon"] forState:UIControlStateHighlighted];
    //为点赞按钮增加
    [_goodButton addTarget:self action:@selector(goodButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_goodButton];
    //赞按钮设置
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.badButton.mas_left).offset(-15);
        make.top.equalTo(self.badButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(23, 23));
    }];
    
    
    
    
    _commmentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_commmentLabel];
    _commmentLabel.font = [UIFont systemFontOfSize:14];
    //评论内容设置
    [_commmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_left);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
}

#pragma mark 踩按钮点击事件
-(void)badButtonClick
{
    [SVProgressHUD showInfoWithStatus:@"我的心好痛啊!"];
}

#pragma mark 点赞按钮点击事件
-(void)goodButtonClick
{
    [SVProgressHUD showInfoWithStatus:@"点赞成功"];
}

#pragma mark 弹出询问删除评论框
-(void)showDelteAlert
{
    
}

#pragma mark 删除按钮点击事件
-(void)deleteCommentBtnClick
{
    //从内存中删除这条评论,传送被删除的评论id
    NSDictionary *dict = @{@"comment_id":self.comment.comment_id};
    //通知tableView重新刷新表格
    //发送删除评论通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LYHDeleteCommentsNotification object:nil userInfo:dict];
    
}




#pragma mark 重新设置cellfram
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = frame.origin.x +10;
    frame.size.height -= LYHIntervel;
    frame.size.width -= 2 * LYHIntervel;
    
    [super setFrame:frame];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
