//
//  EmoticonManger.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmoticonPackage.h"

@interface EmoticonManger : NSObject

@property(nonatomic,strong) NSMutableArray<EmoticonPackage *> *packages;

//重写init
-(instancetype)init;

//单例
+ (instancetype)sharedManager;

@end
