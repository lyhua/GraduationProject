//
//  Publish.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/20.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Publish : NSObject

//是否发布图片文本
@property(nonatomic)BOOL isPublished;

//发布单例
+(instancetype)sharePublish;
@end
