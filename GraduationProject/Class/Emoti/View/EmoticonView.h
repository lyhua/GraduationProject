//
//  EmoticonView.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/6.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"
#import "Base.h"

//定义表情选中闭包
typedef void(^selectedEmoticonCallBack)(Emoticon *emoticon);

@interface EmoticonView : UIView <UICollectionViewDataSource,UICollectionViewDelegate>


//
@property(strong,retain)UICollectionView *collectionView;

//顶部工具栏
@property(strong,retain)UIToolbar *toolbar;

//表情选中事件闭包
@property(nonatomic,strong)selectedEmoticonCallBack block;

//重写便利initWithFrame构造方法
- (instancetype)initWithFrame:(CGRect)frame;

//便利构造方法(闭包)
-(instancetype)initWithselectEmoticonBlock:(selectedEmoticonCallBack)block frame:(CGRect)frame;

@end
