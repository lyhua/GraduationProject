//
//  Article.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/9.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

//标题
@property(nonatomic,strong) NSString *title;

//时间
@property(nonatomic,strong)NSString *time;

//类容
@property(nonatomic,strong)NSString *content;

//阅读数量
@property(nonatomic,strong)NSString *read;

//评论数量
@property(nonatomic,strong)NSString *comment;

//喜欢数量
@property(nonatomic,strong)NSString *like;

@end
