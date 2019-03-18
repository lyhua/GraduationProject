//
//  LYHCommentTextView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/23.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHCommentTextView.h"
#import "Base.h"
#import <Masonry/Masonry.h>

@implementation LYHCommentTextView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark 设置UI
-(void)setupUI
{
    //准备文本视图
    [self prepareTextView];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setupUI];
    
    return self;
}


#pragma mark 准备文本视图
-(void)prepareTextView
{
    //创建文本视图并设置属性
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, LYHWidth, LYHHeight - 320)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.textColor = [UIColor darkGrayColor];
    //始终允许垂直滚动
    _textView.alwaysBounceVertical = YES;
    
    [self addSubview:_textView];
    
    //创建占位标签
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = @"发表你的见解";
    _placeHolderLabel.textColor = [UIColor darkGrayColor];
    [self.textView addSubview:_placeHolderLabel];
    //设置占位标签的布局
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
    }];
}

@end
