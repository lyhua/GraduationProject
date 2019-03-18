//
//  EmoticonLayout.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/6.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "EmoticonLayout.h"
#import "Base.h"

@implementation EmoticonLayout


//重写布局方法
-(void)prepareLayout
{
    [super prepareLayout];
    CGFloat col = 7;
    CGFloat row = 3;
    //先写死
    CGFloat w = self.collectionView.bounds.size.width / col;
    CGFloat margin = ((self.collectionView.bounds.size.height - row * w) * 0.5);
    CGSize itemSize = CGSizeMake(w, w);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(margin, 0, margin, 0);
    //设置滚动方向为水平
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.itemSize = itemSize;
}

@end
