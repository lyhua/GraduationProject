//
//  LYHIconViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/26.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHIconViewController.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "NetworkRequest.h"
#import "User.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "UIImage+Image.h"


@interface LYHIconViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LYHIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置UI
    [self setupUI];
    
    //设置导航条
    [self setupNav];

}
#pragma mark 设置UI
-(void)setupUI
{
    self.view.backgroundColor = [UIColor blackColor];
    _iconView = [[UIImageView alloc] init];
    [self.view addSubview:_iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view.mas_left);
        make.width.mas_equalTo(LYHWidth);
        make.height.mas_equalTo(LYHWidth);
    }];
    //拼接用户头像url
    NSString *headImageUrl = [BaseURL stringByAppendingString:[NSString stringWithFormat:@"headImage/%@",[User shareUser].headImage]];
    //占位图(如果用户没有设置头像)
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    //设置用户图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:headImageUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(!image)
        {
            return;
        }
    }];
    
}


#pragma mark 设置导航条
- (void)setupNav
{
    UIImage *temp;
    self.navigationItem.title = @"头像";
    self.navigationController.navigationBar.barTintColor = LYHColor(53,183,243);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp  forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"more_icon" width:25 height:25];
    [moreButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"more_height_icon" width:25 height:25];
    [moreButton setImage:temp forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    [moreButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
}

#pragma mark 弹出提示框
- (void)changeIcon {
    [self presentViewController:self.userIconAlert animated:YES completion:nil];
}


#pragma mark 返回
- (void)backCilck
{
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载弹出底部提示
- (UIAlertController *)userIconAlert {
    if (!_userIconAlert) {
        _userIconAlert = [UIAlertController alertControllerWithTitle:@"请选择操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *chooseFromPhotoAlbum = [UIAlertAction actionWithTitle:@"从相册选择" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [[self imagePicker] setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            [self presentViewController:[self imagePicker] animated:YES completion:nil];
        }];
        UIAlertAction *chooseFromCamera = [UIAlertAction actionWithTitle:@"拍照" style:0 handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                [self presentViewController:[self imagePicker] animated:YES completion:nil];
            }
        }];
        UIAlertAction *canecelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_userIconAlert addAction:chooseFromCamera];
        [_userIconAlert addAction:chooseFromPhotoAlbum];
        [_userIconAlert addAction:canecelAction];
    }
    return _userIconAlert;
}

#pragma mark 懒加载图片选择器
- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

//#pragma mark 重写我的头像get方法(为了用户没有头像时自动返回占位图片)
//- (UIImageView *)iconView {
//    if (!_iconView) {
//        _iconView = [UIImage imageNamed:<#(nonnull NSString *)#>]
//    }
//    return _iconView;
//}

#pragma mark 发送图片给服务器更新图片
-(void)updateIcon
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"alterUserHeadImage"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] = [User shareUser].userId;
    NSLog(@"userId------%@",[User shareUser].userId);
    NSLog(@"url---%@",url);
    [[NetworkRequest getRequest] POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传的图片
        NSData *imageData = UIImagePNGRepresentation(self.myIcon);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"icon.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        //上传成功要用KVO刷新数据
        [NetworkRequest getUserWithUserId:[User shareUser].userId];
        //弹出界面
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@",error);
    }];
}


#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate(图片选择器代理方法)
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *getImage = info[UIImagePickerControllerEditedImage];
    self.myIcon = getImage;
    NSLog(@"%@",self.myIcon);
    [picker dismissViewControllerAnimated:YES completion:nil];
    //上传图片到服务器
    [self updateIcon];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
