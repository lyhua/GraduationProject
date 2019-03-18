//
//  LYHCommentTextView.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/23.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHCommentTextView : UIScrollView

//文本编辑
@property(nonatomic,strong)UITextView *textView;

//占位文字
@property(nonatomic,strong)UILabel *placeHolderLabel;

@end
