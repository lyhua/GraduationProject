//
//  Timer.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject
+(void)shareTimer:(int)time requester:(id)requester title:(NSString*)title;

@end
