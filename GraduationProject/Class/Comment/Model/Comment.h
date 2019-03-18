//
//  Comment.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/15.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Comment : NSObject

//评论id
@property(nonatomic,strong)NSNumber *comment_id;

//用户id
@property(nonatomic,strong)NSNumber *user_id;

//内容id
@property(nonatomic,strong)NSNumber *content_id;

//评论的内容
@property(nonatomic,strong)NSString *comment;

//点赞数
@property(nonatomic,strong)NSNumber *comment_good;

//踩数
@property(nonatomic,strong)NSNumber *comment_bad;

//日期
@property(nonatomic,strong)NSString *date;

//所属内容用户ID
@property(nonatomic,strong)NSNumber *ownerId;

//额外属性

//评论cell的高度
@property(nonatomic,assign)CGFloat cellHeight;

//是否刷新评论
@property(nonatomic,assign)BOOL isRefreshComment;


//静态评论模型存储数据
+(Comment *)shareComent;

@end







