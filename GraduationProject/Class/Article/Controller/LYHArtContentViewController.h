//
//  LYHArtContentViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/9.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHArtContentViewController : UIViewController

//类容图片
@property(nonatomic,strong)UIImageView *imageView;

//类容标题
@property(nonatomic,strong)UILabel *titleLabel;

//文章类容
@property(nonatomic,strong)UILabel *contentLabel;

//时间标签
@property(nonatomic,strong)UILabel *timeLabel;


//显示内容View
@property(nonatomic,strong)UIScrollView *contentScrollView;

@end
