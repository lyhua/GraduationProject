//
//  LYHSinglePicturesView.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pictures.h"
#import "ImageSize.h"

@interface LYHSinglePicturesView : UIView

//图片模型
@property(nonatomic,strong)Pictures *pictures;

//图片尺寸模型
@property(nonatomic,strong)ImageSize *imageSize;

//显示的图片
@property(nonatomic,strong)NSMutableArray<UIImageView *> *imagesView;

//透明按钮用于点击事件
@property(nonatomic,strong)UIButton *imagesButton;

//便利构造方法(Pictures模型)
-(instancetype)initWithpicturesModel:(Pictures *)pictures;

//便利构造方法
-(instancetype)initWithImageSize:(ImageSize *)imageSize pictures:(Pictures *)pictures;

@end
