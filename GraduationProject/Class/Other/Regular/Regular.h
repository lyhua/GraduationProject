//
//  Regular.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/5.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regular : NSObject

//手机号码验证
+(BOOL)isValidateMobile:(NSString *)mobile;

//邮箱验证
+(BOOL)isValidateEmail:(NSString *)email;


@end
