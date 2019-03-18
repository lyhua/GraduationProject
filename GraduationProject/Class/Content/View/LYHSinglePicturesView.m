//
//  LYHSinglePicturesView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/2.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHSinglePicturesView.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "Base.h"
#import "Pictures.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import "UIImage+Image.h"

@implementation LYHSinglePicturesView

//便利构造方法
-(instancetype)initWithImageSize:(ImageSize *)imageSize pictures:(Pictures *)pictures
{
    self.imageSize = imageSize;
    return [self initWithpicturesModel:pictures];
}

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
    [self setupSinglePictures];
}

#pragma mark 设置单张图片
-(void)setupSinglePictures
{
    //创建图片视图
    UIImageView *vc = [[UIImageView alloc] init];
    _imagesView = [[NSMutableArray alloc] init];
    [self addSubview:vc];
    //创建透明按钮
    _imagesButton = [[UIButton alloc] init];
    _imagesButton.tag = 1;
    [_imagesButton addTarget:self action:@selector(pictureClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //拼接url
    NSString *commonurl = [BaseURL stringByAppendingString:@"contentSmallImage/"];
    NSString *bigcommonurl = [BaseURL stringByAppendingString:@"contentImage/"];
    //小图片url不能写在闭包中
    NSString *samllImage = [commonurl stringByAppendingString:_pictures.smallImages[0]];
    NSLog(@"%@",samllImage);
    //大图片url
    NSString *bigImage = [bigcommonurl stringByAppendingString:_pictures.images[0]];
    NSLog(@"%@",bigImage);
    
    //下载小图片
    [vc sd_setImageWithURL:[[NSURL alloc] initWithString:bigImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载结束后改做什么(可以什么都不做)
        NSLog(@"下载小图完成");
    }];
    
    
    //进行图片布局
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(90, 160));
        make.size.mas_equalTo(CGSizeMake([_imageSize.width floatValue] *0.5, [_imageSize.height floatValue] * 0.5));
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    [_imagesView addObject:vc];
    //进行按钮布局
    [self addSubview:_imagesButton];
    [_imagesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imagesView.firstObject.mas_centerX);
        make.centerY.equalTo(_imagesView.firstObject.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(90, 160));
        make.size.mas_equalTo(CGSizeMake([_imageSize.width floatValue] *0.5, [_imageSize.height floatValue] * 0.5));
    }];
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
