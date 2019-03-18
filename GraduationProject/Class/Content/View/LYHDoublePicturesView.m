//
//  LYHDoublePicturesView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHDoublePicturesView.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "Base.h"
#import "Pictures.h"
#import <Masonry/Masonry.h>
#import "UIImage+Image.h"

@implementation LYHDoublePicturesView

//便利构造方法(Pictures模型)
-(instancetype)initWithpicturesModel:(Pictures *)pictures
{
    self.pictures = pictures;
    return [self init];
}

//重写init方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置UI
        [self setupUI];
    }
    return self;
}

#pragma mark 设置UI
-(void)setupUI
{
    [self setupDoublePictures];
}

#pragma mark 设置两张或四张图片
-(void)setupDoublePictures
{
    //创建图片视图
    _imagesView = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _pictures.imagesCount; i++) {
        _imagesView[i] = [[UIImageView alloc] init];
    }
    //创建透明按钮
    _imagesButtons = [[NSMutableArray alloc] init];
    for (NSInteger i= 0; i < _pictures.imagesCount; i++) {
        _imagesButtons[i] = [[UIButton alloc] init];
        [_imagesButtons[i] addTarget:self action:@selector(pictureClick:) forControlEvents:UIControlEventTouchUpInside];
        //设置图片标志(以区分是第几张图片)
        _imagesButtons[i].tag = i;
    }
    //拼接url
    NSString *commonurl = [BaseURL stringByAppendingString:@"contentSmallImage/"];
    NSString *bigcommonurl = [BaseURL stringByAppendingString:@"contentImage/"];
    NSMutableArray<NSString *>*samllImages = [[NSMutableArray alloc] init];
    NSMutableArray<NSString *>*bigImages = [[NSMutableArray alloc] init];
    //拼接URL
    NSString *temp = nil;
    for (NSInteger i = 0; i < _pictures.imagesCount; i++) {
        //小图url
        temp = [commonurl stringByAppendingString:_pictures.smallImages[i]];
        [samllImages addObject:temp];
        //大图url
        temp = [bigcommonurl stringByAppendingString:_pictures.images[i]];
        [bigImages addObject:temp];
    }
    //设置图片(下载图片)
    for (NSInteger i = 0; i < _pictures.imagesCount; i++) {
        NSString *surl = samllImages[i];
        UIImageView *vc = [[UIImageView alloc] init];
        [vc sd_setImageWithURL:[[NSURL alloc] initWithString:surl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //图片下载完成后进行图片的处理(因为图片是超过一张，不能完全展示一张完整的小图,要把它变成一张正方形的)
            _imagesView[i].image = [UIImage imageWithCutImage:image];
        }];
        [_imagesView addObject:vc];
        //添加图片View
        [self addSubview:_imagesView[i]];
        //添加透明按钮
        [self addSubview:_imagesButtons[i]];
    }
    
    //进行图片视图布局
    for (NSInteger i = 0; i < _pictures.imagesCount; i++) {
        [_imagesView[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            long c = i / 2;
            long b = i % 2;
            make.top.equalTo(self.mas_top).offset(c *(90 + 10));
            double offset = pow(-1, b + 1) * 50;
            make.centerX.equalTo(self.mas_centerX).offset(offset);
            make.size.mas_equalTo(CGSizeMake(90, 90));
        }];
    }
    //进行透明按钮布局
    for (NSInteger i = 0; i < _pictures.imagesCount; i++) {
        [_imagesButtons[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imagesView[i].mas_centerX);
            make.centerY.equalTo(_imagesView[i].mas_centerY);
            make.size.mas_equalTo(CGSizeMake(90, 90));
        }];
    }
}

#pragma mark 图片点击事件
-(void)pictureClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //设置图片的值
    NSDictionary *dict = @{@"pictures":self.pictures,@"tag":[[NSString alloc] initWithFormat:@"%zd",btn.tag]};
    //发送通知让tableview弹出图片浏览器
    [[NSNotificationCenter defaultCenter] postNotificationName:LYHPhotosBrowse object:nil userInfo:dict];
}



@end
