//
//  LYHPhotosPublishView.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/18.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHPhotosPublishView : UIScrollView


//文本编辑
@property(nonatomic,strong)UITextView *textView;

//显示选择相片的View
@property(nonatomic,strong)UIView *photosView;

//占位文字
@property(nonatomic,strong)UILabel *placeHolderLabel;


//重写init方法
-(instancetype)init;

-(instancetype)initWithFrame:(CGRect)frame;


@end
