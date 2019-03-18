//
//  LYHMissionTableViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHMissionTableViewCell.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "LYHConst.h"

@implementation LYHMissionTableViewCell

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
-(void)setMission:(Mission *)mission
{
    _mission = mission;
    _startTimeLabel.text = [NSString stringWithFormat:@"%@%@",@"开始时间:",mission.mission_starttime];
    _endTimeLabel.text = [NSString stringWithFormat:@"%@%@",@"结束时间:",mission.mission_endtime];
    _contentLabel.text = mission.mission_content;
    
    //
    /*
    if(mission.flag == 0)
    {
        _flagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
    }else{
        _flagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]];
    }
     */
    
    
}
#pragma mark 设置UI
-(void)setupUI
{
    //任务类型图片布局
    _typeImageView = [[UIImageView alloc] init];
    _typeImageView.image = [UIImage imageNamed:@"common"];
    [self.contentView addSubview:_typeImageView];
    [_typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(self.contentView.mas_top).offset(LYHIntervel);
        make.left.equalTo(self.contentView.mas_left).offset(LYHIntervel);
    }];
    
    //开始时间布局
    _startTimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_startTimeLabel];
    _startTimeLabel.font = [UIFont systemFontOfSize:13];
    _startTimeLabel.textColor = [UIColor blackColor];
    [_startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeImageView.mas_top);
        make.left.equalTo(_typeImageView.mas_right).offset(10);
    }];
    
    //结束时间布局
    _endTimeLabel = [[UILabel alloc] init];
    _endTimeLabel.font = [UIFont systemFontOfSize:13];
    _endTimeLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_endTimeLabel];
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_typeImageView.mas_bottom);
        make.left.equalTo(_startTimeLabel.mas_left);
    }];
    
    //线空间布局
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = LYHColor(222, 222, 222);
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width -30, 1));
        make.top.equalTo(_typeImageView.mas_bottom).offset(1);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    //类容布局
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width -30;
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endTimeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    _flagImageView = [[UIImageView alloc] init];
    //根据flag设置图片
    if(_mission.flag == 0)
    {
        _flagImageView.image = [UIImage imageNamed:@"tick"];
    }else{
        _flagImageView.image = [UIImage imageNamed:@"cross"];
    }
    //自动适应,保持图片宽高比
    _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_flagImageView];
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView.mas_centerX);
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
