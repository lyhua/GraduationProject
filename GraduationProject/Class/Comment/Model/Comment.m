//
//  Comment.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/15.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "Comment.h"
#import "Base.h"
#import "LYHConst.h"

@implementation Comment

-(CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    //用户头像及用户名
    _cellHeight += 10;
    _cellHeight += 45;
    //文字间隔
    _cellHeight += 10;
    CGSize textMaxSize = CGSizeMake(LYHWidth - (2 * LYHIntervel + 65), MAXFLOAT);
    _cellHeight += [self.comment boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    _cellHeight += 10;
    
    
    return _cellHeight;
}

#pragma mark 静态评论模型存储数据
+(Comment *)shareComent
{
    static Comment *comment;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comment = [[Comment alloc] init];
    });
    return comment;
}

@end
