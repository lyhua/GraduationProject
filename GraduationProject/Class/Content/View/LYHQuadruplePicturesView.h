//
//  LYHQuadruplePicturesView.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pictures.h"

@interface LYHQuadruplePicturesView : UIView

//图片模型
@property(nonatomic,strong)Pictures *pictures;

//显示的图片
@property(nonatomic,strong)NSMutableArray<UIImageView *> *imagesView;

//透明按钮用于点击事件
@property(nonatomic,strong)NSMutableArray<UIButton *> *imagesButtons;

//便利构造方法(Pictures模型)
-(instancetype)initWithpicturesModel:(Pictures *)pictures;

@end
