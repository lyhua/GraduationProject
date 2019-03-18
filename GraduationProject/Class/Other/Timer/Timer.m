//
//  Timer.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "Timer.h"
#import <UIKit/UIKit.h>

@implementation Timer
//定时器(仅限于按钮)
+(void)shareTimer:(int)time requester:(id)requester title:(NSString*)title
{
    //取出按钮控件
    UIButton *verificationCodeButton =(UIButton *)requester;
    
   //设置Button的文字 __block相对于全局变量
   __block int timeout = time;
    // 创建一个默认队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建一个定时器类型的调度源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 1)
        {
            // 取消源
            dispatch_source_cancel(timer);
            // 在主线程中修改UI 只有在主线程中才能修改UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [verificationCodeButton setTitle:title forState:UIControlStateNormal];
                //重新发送用户可以点击按钮，按钮有fanying
                [verificationCodeButton setUserInteractionEnabled:YES];
            });
        }else{
            // 在主线程中修改UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [verificationCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",(long)timeout] forState:UIControlStateNormal];
                //正在发送中不允许用户与按钮进行交互
                [verificationCodeButton setUserInteractionEnabled:NO];
            });
        }
        timeout -= 1;
    });
    //释放定时器资源
    dispatch_resume(timer);

    
    
}

@end
