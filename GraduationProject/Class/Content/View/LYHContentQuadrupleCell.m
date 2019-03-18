//
//  LYHContentQuadrupleCell.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/3.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHContentQuadrupleCell.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
#import "LYHConst.h"
#import "Comment.h"
#import "UIImage+Image.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NetworkRequest.h"

@implementation LYHContentQuadrupleCell


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
-(void)setContent:(Content *)content
{
    //拼接用户头像url
    NSString *headImageUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",content.headImage]];
    //拼接内容图片url
    NSString *contentUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"contentImage/%2",content.contentImage]];
    //占位图(如果用户没有设置头像)
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户头像(网络请求数据)
    [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"-------------");
        if(!image)
        {
            return;
        }
    }];
    
    _content = content;
    _userNameLabel.text = content.userName;
    _contentLabel.text = content.content;
    _dateLabel.text = content.date;
    //TODO 设置心情图片
    if(_content.mood == 1)
    {
        _moodImage.image = [UIImage imageNamed:@"happy_icon"];
    }else{
        _moodImage.image = [UIImage imageNamed:@"unhappy_icon"];
    }
    //设置图片模型
    _pictures = [[Pictures alloc] init];
    _pictures.images = [NSString stringDivisionWithString:_content.contentImage symbol:@"#"];
    _pictures.smallImages = [NSString stringDivisionWithString:_content.contentSmallImage symbol:@"#"];
    _pictures.imagesCount = _pictures.images.count;
}

#pragma mark 设置UI
-(void)setupUI
{
    //设置顶部视图
    [self setupTopView];
    
    //设置底部视图
    [self setupBottomView];
    
    //设置图片视图
    //    [self setupPictures];
    
}

#pragma mark 设置顶部视图
-(void)setupTopView
{
    _userHeadImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_userHeadImage];
    //设置圆角图片
    _userHeadImage.layer.masksToBounds = YES;
    _userHeadImage.layer.cornerRadius = 10;
    //自动适应,保持图片宽高比
    _userHeadImage.contentMode = UIViewContentModeScaleAspectFit;
    //进行头像布局
    [_userHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _userNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_userNameLabel];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    //进行用户名布局
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userHeadImage);
        make.left.equalTo(self.userHeadImage.mas_right).offset(10);
    }];
    
    _dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_dateLabel];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    //进行日期布局
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userHeadImage.mas_right).offset(10);
        make.bottom.equalTo(self.userHeadImage.mas_bottom);
    }];
    
    _moodImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_moodImage];
    //进行心情布局
    [_moodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 45 - 10 - 20;
    [self.contentView addSubview:_contentLabel];
    //进行内容文字布局
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
        make.left.equalTo(self.dateLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
}

#pragma mark 设置底部视图
-(void)setupBottomView
{
    _bottomView = [[UIView alloc] init];
    [self.contentView addSubview:_bottomView];
    //进行底部视图布局
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width, 44));
    }];
    
    //分割线布局
    _divisionView = [[UIView alloc] init];
    _divisionView.backgroundColor = [UIColor darkGrayColor];
    [self.bottomView addSubview:_divisionView];
    [_divisionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(self.bottomView.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width, 1));
    }];
    
    _division1View = [[UIView alloc] init];
    _division1View.backgroundColor = [UIColor darkGrayColor];
    [self.bottomView addSubview:_division1View];
    [_division1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset([UIScreen mainScreen].bounds.size.width /3);
        make.top.equalTo(self.bottomView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(1, 34));
    }];
    
    _division2View = [[UIView alloc] init];
    _division2View.backgroundColor = [UIColor darkGrayColor];
    [self.bottomView addSubview:_division2View];
    [_division2View mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat offest = [UIScreen mainScreen].bounds.size.width /3;
        make.left.equalTo(self.bottomView.mas_left).offset(offest * 2);
        make.top.equalTo(self.bottomView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(1, 34));
    }];
    
    
    
    _blessingBtn = [[UIButton alloc] init];
    [_blessingBtn setImage:[UIImage imageNamed:@"lding_con_heightlight"] forState:UIControlStateNormal];
    [_blessingBtn setImage:[UIImage imageNamed:@"lding_con"] forState:UIControlStateHighlighted];
    [self.bottomView addSubview:_blessingBtn];
    //添加祝福按钮点击事件
    [_blessingBtn addTarget:self action:@selector(blessingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //进行祝福按钮布局
    [_blessingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        double b = ([UIScreen mainScreen].bounds.size.width / (double)3 - 30) * 0.5;
        double a = (44 - 30) * 0.5;
        make.left.equalTo(self.bottomView.mas_left).offset(b);
        make.top.equalTo(self.bottomView.mas_top).offset(a);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _reportBtn = [[UIButton alloc] init];
    [_reportBtn setImage:[UIImage imageNamed:@"lgood_icon"] forState:UIControlStateNormal];
    [_reportBtn setImage:[UIImage imageNamed:@"lgood_icon_heightlight"] forState:UIControlStateHighlighted];
    [self.bottomView addSubview:_reportBtn];
    //添加举报按钮点击事件
    [_reportBtn addTarget:self action:@selector(reportBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //进行举报按钮布局
    [_reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        double a = ([UIScreen mainScreen].bounds.size.width / (double)3 - 30);
        make.left.equalTo(self.blessingBtn.mas_right).offset(a);
        make.top.equalTo(self.blessingBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _commentBtn = [[UIButton alloc] init];
    [_commentBtn setImage:[UIImage imageNamed:@"lcomment_icon"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"lcomment_icon_heightlight"] forState:UIControlStateHighlighted];
    [self.bottomView addSubview:_commentBtn];
    //添加评论按钮点击事件
    [_commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //进行评论按钮布局
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        double a = ([UIScreen mainScreen].bounds.size.width / 3 - 30);
        make.left.equalTo(self.reportBtn.mas_right).offset(a);
        make.top.equalTo(self.reportBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];

    
}

#pragma mark 设置图片视图
-(void)setupPictures
{
    _quadrupleView = [[LYHQuadruplePicturesView alloc] init];
    [self.contentView addSubview:_quadrupleView];
    //进行图片视图布局
    [_quadrupleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

#pragma mark 祝福按钮点击事件
-(void)blessingBtnClick
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"reward/createRewardUserWithMissionId"];
    NSLog(@"url      ------%@",url);
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"mission_id"] = _content.mission_id;
    parameters[@"user_id"] = _content.user_id;
    
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject[@"msg"])
        {
            [SVProgressHUD showSuccessWithStatus:@"助力成功！"];
        }
        if(responseObject[@"error"])
        {
            [SVProgressHUD showErrorWithStatus:@"网络好像有问题！"];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络好像有问题！"];
    }];
}

#pragma mark 举报按钮点击事件
-(void)reportBtnClick
{
    [SVProgressHUD showInfoWithStatus:@"点赞成功"];
}

#pragma mark 评论按钮点击事件
-(void)commentBtnClick
{
    NSLog(@"____----------commentBtnClick");
    [Comment shareComent].content_id = self.content.content_id;
    //传递内容模型和ImageSize模型
    [Content changeWithContent:self.content];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LYHCellCommentBtnClickNotification object:nil];
}

#pragma mark 懒加载图片视图
-(LYHQuadruplePicturesView *)quadrupleView
{
    if(!_quadrupleView)
    {
        LYHQuadruplePicturesView *quadrupleView = [[LYHQuadruplePicturesView alloc] initWithpicturesModel:self.pictures];
        [self.contentView addSubview:quadrupleView];
        _quadrupleView = quadrupleView;
    }
    return _quadrupleView;
}


#pragma mark 重新设置cellfram
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = frame.origin.x +10;
    frame.size.height -= LYHIntervel;
    frame.size.width -= 2 * LYHIntervel;
    
    [super setFrame:frame];
}


#pragma mark 重写layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    //进行picturesView布局
    //有图片模型才进行布局
    if (_pictures) {
        self.quadrupleView.frame = self.content.middleFrame;
    }
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
