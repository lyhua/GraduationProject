//
//  EmoticonViewCell.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "EmoticonViewCell.h"
#import "NSString+NSString_emoji.h"

@implementation EmoticonViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _emoticonButton = [[UIButton alloc] init];
        [self.contentView addSubview:_emoticonButton];
        _emoticonButton.backgroundColor = [UIColor whiteColor];
        [_emoticonButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _emoticonButton.frame = CGRectInset(self.bounds, 4, 4);
        _emoticonButton.titleLabel.font = [UIFont systemFontOfSize:32];
        //为了不让按钮截取crollectionVuiew点击事件，使它不能交互
        _emoticonButton.userInteractionEnabled = NO;
    }
    return self;
}

-(void)setEmoticon:(Emoticon *)emoticon
{
    
    if(emoticon.imagePath)
    {
        [self.emoticonButton setImage:[UIImage imageWithContentsOfFile:emoticon.imagePath] forState:UIControlStateNormal];
    }
    
    if (emoticon.code) {
        [self.emoticonButton setTitle:emoticon.emoji forState:UIControlStateNormal];
    }else
    {
        [self.emoticonButton setTitle:@"" forState:UIControlStateNormal];
    }
    
    if (emoticon.isRemoved) {
        [self.emoticonButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    }
}

@end
