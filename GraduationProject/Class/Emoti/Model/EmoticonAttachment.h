//
//  EmoticonAttachment.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/12.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

@interface EmoticonAttachment : NSTextAttachment

@property(nonatomic,strong)Emoticon *emoticon;

//便利构造方法
-(instancetype)initWithEmotion:(Emoticon *)emotion;

@end
