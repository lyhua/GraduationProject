//
//  LYHArticleTableViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/9.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHArticleTableViewCell.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "LYHConst.h"

@implementation LYHArticleTableViewCell

#pragma mark 重写便利构造方法(cell初始化时调用这个不是调用init)
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置UI
        [self setupUI];
    }
    return self;
}

#pragma mark 设置文章模型
-(void)setArticle:(Article *)article
{
    _article = article;
    _titleLabel.text = article.title;
    _timeLabel.text =  article.time;
    _contentLabel.text = article.content;
    _readLabel.text = [NSString stringWithFormat:@"阅读:%@",article.read];
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",article.comment];
    _likeLabel.text = [NSString stringWithFormat:@"喜欢:%@",article.like];
}

#pragma mark 设置UI
-(void)setupUI
{
    //标题布局
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(1);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    //时间标签布局
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_left);
    }];
    
    //内容布局
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width -20;
    
    
    
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    //阅读数量标签布局
    _readLabel = [[UILabel alloc] init];
    _readLabel.font = [UIFont systemFontOfSize:11];
    _readLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview: _readLabel];
    [_readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(5);
        make.left.equalTo(_contentLabel.mas_left);
    }];
    
    //评论数量标签布局
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:11];
    _commentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_commentLabel];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_readLabel.mas_top);
        make.left.equalTo(_readLabel.mas_right).offset(2);
    }];
    
    //喜欢数量标签布局
    _likeLabel = [[UILabel alloc] init];
    _likeLabel.font = [UIFont systemFontOfSize:11];
    _likeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_likeLabel];
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentLabel.mas_top);
        make.left.equalTo(_commentLabel.mas_right).offset(2);
    }];
    
    //线的布局
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 1));
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
