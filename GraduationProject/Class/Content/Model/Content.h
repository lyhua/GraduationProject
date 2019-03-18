//
//  Content.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/14.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Content : NSObject<NSCoding>

//内容文字
@property (nonatomic,copy) NSString *content;

//内容图片
@property (nonatomic,copy)NSString *contentImage;

//内容图片小图
@property(nonatomic,copy)NSString *contentSmallImage;

//内容ID
@property (nonatomic,assign) NSNumber *content_id;


//发布日期
@property (nonatomic,copy) NSString *date;

//用户头像
@property(nonatomic ,copy)NSString *headImage;
//发布内容时的心情
@property (nonatomic,assign) NSNumber *mood;

//用户名
@property (nonatomic,copy) NSString *userName;

//用户ID
@property(nonatomic,assign)NSNumber *user_id;

//任务ID
@property(nonatomic,assign)NSNumber *mission_id;

//额外属性

//根据当前模型计算出来的cell高度 
@property (nonatomic, assign) CGFloat cellHeight;

//中间控件的frame
@property(nonatomic,assign)CGRect middleFrame;

//小图片高度
@property(nonatomic,assign)NSNumber *height;

//判断是否是内容还是评论(用于重用)
@property(nonatomic,assign)BOOL isContent;


//内容数组静态调用方法
+(NSMutableArray<Content *>*)shareContents;

//content归档方法
-(void)encodeWithCoder:(NSCoder *)aCoder;

//content解归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder;

//内容数组归档(最多30条数据归档)
+(void)serializeContents;

//获取内容归档数据
+(void)unserializeContents;

//单个内容静态方法(用于向评论创达数据)
+(Content *)shareContent;

//用于改变静态内容
+(void)changeWithContent:(Content *)content;





@end














