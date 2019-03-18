//
//  EmoticonPackage.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Emoticon.h"

@interface EmoticonPackage : NSObject

@property(nonatomic,strong)NSString *id;

@property(nonatomic,strong)NSString *group_name_cn;

@property(nonatomic,strong)NSMutableArray<Emoticon *> *emoticons;

//便利构造方法
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
