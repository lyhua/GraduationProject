//
//  Pictures.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/24.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pictures : NSObject

//内容大图
@property(nonatomic,strong)NSArray<NSString *> *images;

//内容大图
@property(nonatomic,strong)NSArray<NSString *> *smallImages;

//图片的数量
@property(nonatomic,assign)NSInteger imagesCount;


@end
