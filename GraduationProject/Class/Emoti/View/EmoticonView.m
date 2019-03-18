//
//  EmoticonView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/6.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "EmoticonView.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import "Base.h"
#import "EmoticonLayout.h"
#import "EmoticonViewCell.h"
#import "EmoticonManger.h"


@implementation EmoticonView

//重写initWithFrame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    
    //设置UI
    [self setupUI];
    
    //没有最近分组直接滚到默认emoji表情
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:1];
#warning 不能滚到指定位置
    //开启主线程，应为只有在主线程中才能设置UI
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    });
    
    return self;
}

//便利构造方法(闭包)
-(instancetype)initWithselectEmoticonBlock:(selectedEmoticonCallBack)block frame:(CGRect)frame
{
    self.block= block;
    return [self initWithFrame:frame];
}

#pragma mark 设置UI
-(void)setupUI
{
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[EmoticonLayout alloc] init]];
    
    _toolbar = [[UIToolbar alloc] init];
    
    [self addSubview:_collectionView];
    [self addSubview:_toolbar];
    
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(36);
    }];
    //设置工具栏Item
    [self prepareToolbar];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(_toolbar.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    //设置cell
    [self prepareCollectionView];
}

#pragma mark 设置工具栏Item
-(void)prepareToolbar
{
    _toolbar.tintColor = [UIColor darkGrayColor];
    NSMutableArray<UIBarButtonItem *> *items = [[NSMutableArray alloc] init];
    NSInteger count = [EmoticonManger sharedManager].packages.count;
    NSArray<EmoticonPackage *> *packageArray = [EmoticonManger sharedManager].packages;
    for ( NSInteger index = 0; index < count; index++)
    {
        [items addObject:[[UIBarButtonItem alloc] initWithTitle:packageArray[index].group_name_cn style:UIBarButtonItemStylePlain target:self action:@selector(clickItem:)]];
        items.lastObject.tag = index;
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    }
    //多加一个弹簧,需要移除
    [items removeLastObject];
//    NSLog(@"-----------%zd",items.count);
    _toolbar.items = items;
}
#pragma mark 工具栏Item点击事件
-(void)clickItem:(UIBarButtonItem *)item
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:item.tag];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark 设置collectionView Cell
-(void)prepareCollectionView
{
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    //注册cell
    [_collectionView registerClass:[EmoticonViewCell class] forCellWithReuseIdentifier:LYHEmoticonViewCell];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}


//表情包的数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [EmoticonManger sharedManager].packages.count;
    
}

//表情包中的表情的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [EmoticonManger sharedManager].packages[section].emoticons.count;
}


//返回表情cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmoticonViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:LYHEmoticonViewCell forIndexPath:indexPath];
    cell.emoticon = [EmoticonManger sharedManager].packages[indexPath.section].emoticons[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Emoticon *emoticon = [EmoticonManger sharedManager].packages[indexPath.section].emoticons[indexPath.item];
    //执行闭包
    self.block(emoticon);
}



////懒加载表情视图
//-(UICollectionView *)collectionView
//{
//    if(!_collectionView)
//    {
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
//    }
//    return _collectionView;
//}
//
////懒加载工具栏
//-(UIToolbar *)toolbar
//{
//    if(!_toolbar)
//    {
//        _toolbar = [[UIToolbar alloc] init];
//    }
//    return _toolbar;
//}



@end
