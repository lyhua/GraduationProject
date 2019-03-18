//
//  LYHPhotosPublishView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/18.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHPhotosPublishView.h"
#import <Masonry/Masonry.h>
#import "Base.h"

@implementation LYHPhotosPublishView


#pragma mark 重写init方法
-(instancetype)init
{
    self = [super init];
    
    //设置UI
    [self setupUI];
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setupUI];
    
    return self;
}

#pragma mark 设置UI
-(void)setupUI
{
    //准备文本视图
    [self prepareTextView];
    
    //准备相片显示
    [self preparePhotosView];
    
}

#pragma mark 准备文本视图
-(void)prepareTextView
{
    //创建文本视图并设置属性
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, LYHWidth, (LYHHeight - (LYHPhotosWidth * 2.5 + 20) - 248))];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.textColor = [UIColor darkGrayColor];
    //始终允许垂直滚动
    _textView.alwaysBounceVertical = YES;
#warning 在控制器中设置
    //拖拽关闭键盘
//    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //设置代理
#warning 这里可能不用代理在控制器中加代理
//    _textView.delegate = self;
    
    //进行文本视图的布局
    [self addSubview:_textView];
//    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.height.mas_equalTo(LYHHeight - (LYHPhotosWidth * 2.5 + 20) - 248);
//    }];
    //创建占位标签
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = @"分享你的悲伤与快乐";
    _placeHolderLabel.textColor = [UIColor darkGrayColor];
    [self.textView addSubview:_placeHolderLabel];
    //设置占位标签的布局
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
    }];
    
}

#pragma mark 准备相片显示
-(void)preparePhotosView
{
    //创建相片显示视图
    _photosView = [[UIView alloc] init];
    [_photosView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_photosView];
    //进行布局
    [_photosView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.textView.mas_bottom);
        make.height.mas_equalTo((2.5 * LYHPhotosWidth + 20));
    }];
    
}

@end
