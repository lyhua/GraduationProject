//
//  LYHComposeViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/12.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmoticonView.h"
#import "LYHPhotosPublishView.h"

@interface LYHComposeViewController : UIViewController

//底部工具条
@property(nonatomic,strong)UIToolbar *toolbar;

//文本编辑
@property(nonatomic,strong)UITextView *textView;

//占位文字
@property(nonatomic,strong)UILabel *placeHolderLabel;

//表情键盘视图
@property(nonatomic,strong)EmoticonView *emoticonView;

//发布图片保存
@property(nonatomic,strong)NSMutableArray<UIImage *> *images;

//显示选择相片的View
@property(nonatomic,strong)UIView *photosView;

//发布图片视图
@property(nonatomic,strong)LYHPhotosPublishView *photosPublish;

//
@property(nonatomic,strong)NSNumber *mission_id;

@end
