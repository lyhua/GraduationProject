//
//  LYHPicturesView.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/24.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHPicturesView.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "Base.h"
#import "Pictures.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import "UIImage+Image.h"

@implementation LYHPicturesView

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
    if (_pictures.imagesCount >0 && _pictures.imagesCount <= 1) {
        
        //设置单张图片
        [self setupSinglePictures];
        
    }else if (_pictures.imagesCount > 1 && _pictures.imagesCount <=4)
    {
        //设置两张或四张图片
        [self setupDoublePictures];
    }else if (_pictures.imagesCount > 4 && _pictures.imagesCount <= 9)
    {
        
    }
}

#pragma mark 设置单张图片
-(void)setupSinglePictures
{
    UIImageView *vc = [[UIImageView alloc] init];
    _imagesView = [[NSMutableArray alloc] init];
//    _imagesView[0] = [[UIImageView alloc] init];
    [self addSubview:vc];
    //拼接url
    NSString *commonurl = [BaseURL stringByAppendingString:@"contentSmallImage/"];
    NSString *bigcommonurl = [BaseURL stringByAppendingString:@"contentImage/"];
    //小图片url不能写在闭包中
    NSString *samllImage = [commonurl stringByAppendingString:_pictures.smallImages[0]];
    NSLog(@"%@",samllImage);
    //大图片url
    NSString *bigImage = [bigcommonurl stringByAppendingString:_pictures.images[0]];
    NSLog(@"%@",bigImage);
    //下载图片(根据用户当前网络类型选择下载那种类型图片)
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
        //蜂窝网络
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //下载小图片
                [vc sd_setImageWithURL:[[NSURL alloc] initWithString:samllImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    //下载结束后改做什么(可以什么都不做)
                }];
                break;
        //wifi
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //下载大图片
                [vc sd_setImageWithURL:[[NSURL alloc] initWithString:bigImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                break;
        //没有网络
            case AFNetworkReachabilityStatusNotReachable:
                //设置占位图片(这个要服务器预先发送图片的大小过来才行)
                NSLog(@"没有网络");
                //TODO 提醒用户
                break;
        //未知网络
            default:
                NSLog(@"未知网络");
                break;
        }
    }];
    //开始监控
//    [manager stopMonitoring];
    
    //下载小图片
    [vc sd_setImageWithURL:[[NSURL alloc] initWithString:bigImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载结束后改做什么(可以什么都不做)
        NSLog(@"下载小图完成");
    }];
    //处理PicturesView图片的大小(等比例)
    
    
    //进行图片布局
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 160));
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    [_imagesView addObject:vc];
    
}

#pragma mark 设置两张或四张图片
-(void)setupDoublePictures
{
    _imagesView = [[NSMutableArray alloc] init];
    for (NSInteger i= 0; i < _pictures.imagesCount; i++) {
        _imagesView[i] = [[UIImageView alloc] init];
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
    }
    //进行布局
    for (NSInteger i = 0; i < _pictures.imagesCount; i++) {
        [_imagesView[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            long c = i / 2;
            long b = i % 2;
            make.top.equalTo(self.mas_top).offset(c *(100 + 10));
            double offset = pow(-1, b + 1) * 55;
            make.centerX.equalTo(self.mas_centerX).offset(offset);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    
    
}





@end
