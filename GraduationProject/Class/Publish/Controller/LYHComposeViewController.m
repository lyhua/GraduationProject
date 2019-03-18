//
//  LYHComposeViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/12.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHComposeViewController.h"
#import <Masonry/Masonry.h>
#import "UIButton+Category.h"
#import "EmoticonAttachment.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "UIImage+Image.h"
#import "Base.h"
#import "NetworkRequest.h"
#import "User.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Publish.h"

@interface LYHComposeViewController ()<UITextViewDelegate,CTAssetsPickerControllerDelegate>

@end

@implementation LYHComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UI
    [self setupUI];
    
    //添加键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //激活键盘
    [self.photosPublish.textView becomeFirstResponder];
}

-(void)dealloc
{
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark 设置UI
-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航条
    [self prepareNavigationBar];
    
    //准备相片发布视图
    [self preparePhotosPublish];
    
    //准备工具条
    [self prepareToolbar];
    
}


#pragma mark 准备相片发布视图
-(void)preparePhotosPublish
{
    _photosPublish = [[LYHPhotosPublishView alloc] init];
    [self.view addSubview:_photosPublish];
    //进行布局
    [_photosPublish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(LYHHeight -  44);
    }];
    //拖拽关闭键盘
    _photosPublish.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //设置键盘代理
    _photosPublish.textView.delegate = self;
    
    //设置垂直滚动
    _photosPublish.alwaysBounceVertical = NO;
    
}

#pragma mark 设置导航条
-(void)prepareNavigationBar
{
    //添加取消按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnClose)];
    //添加发布按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    //标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 36)];
    self.navigationItem.titleView = titleView;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"发布内容";
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT"size:19];;
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.top.equalTo(titleView.mas_top).offset(8);
    }];
    //禁止发布按钮
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

#pragma 取消按钮点击事件
-(void)btnClose
{
    //关闭键盘
    [self.photosPublish.textView resignFirstResponder];
    //让发布图片界面消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 发布按钮点击事件
-(void)sendStatus
{
    //获取文本中的内容
    __block NSAttributedString  *attrText = self.photosPublish.textView.attributedText;
    __block NSMutableString *strM = [[NSMutableString alloc] initWithString:@""];
    [attrText enumerateAttributesInRange:NSMakeRange(0, attrText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        EmoticonAttachment *attachment = (EmoticonAttachment *)attrs[@"NSAttachment"];
        if(attachment)
        {
            if (attachment.emoticon.chs) {
                [strM appendString:attachment.emoticon.chs];
            }else{
                [strM appendString:@""];
            }
        }else{
            NSString *str = [attrText.string substringWithRange:range];
            [strM appendString:str];
        }
    }];
    NSLog(@"---------------------%@",strM);
    //发布内容模块
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"content/createContent"];
    //拼接参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"user_id"] = [User shareUser].userId;
    NSLog(@"userid ---------%@",[User shareUser].userId);
    parameter[@"content"] = strM;
    parameter[@"mood"] = @"1";
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd HH:mm"];
    NSString *date = [dateFormat stringFromDate:[NSDate date]];
    parameter[@"date"] = date;
    [NetworkRequest getRequest].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [[NetworkRequest getRequest] POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传的图片
        if (self.images.count > 0) {
            for (NSInteger i = 0; i < self.images.count; i++) {
                NSData *imageData = UIImageJPEGRepresentation(self.images[i], 0.9);
                //设置文件名,让服务器收到的图片的名字不一样才能区分
                NSString *name = [@"content" stringByAppendingString:[[NSString alloc] initWithFormat:@"%zd",i]];
                NSString *fileName = [name stringByAppendingString:@".jpg"];
                NSLog(@"fileName==============%@",fileName);
                [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //判断操作如何
        if (responseObject[@"msg"]) {
            //发布成功退回主界面
            //暂定操作
            //修改发布图片属性
            [Publish sharePublish].isPublished = NO;
            //关闭键盘
            [self.photosPublish.textView resignFirstResponder];
            //让发布图片界面消失
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }
        if (responseObject[@"error"]) {
            //发布不成功,服务器问题,提醒用户稍后再试
            [SVProgressHUD showErrorWithStatus:@"网络好像有点问题!"];
            NSLog(@"%@",responseObject[@"error"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户上传失败
        [SVProgressHUD showErrorWithStatus:@"发布失败,稍后再试!"];
    }];
    
}

#pragma mark 准备工具条
-(void)prepareToolbar
{
    //创建工具条
    _toolbar = [[UIToolbar alloc] init];
    [self.view addSubview:_toolbar];
    //设置背景颜色
    _toolbar.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    //添加子控件
    NSMutableArray<UIBarButtonItem *> *items = [[NSMutableArray alloc] init];
    NSMutableArray<UIButton *> *btnArray = [[NSMutableArray alloc] init];
    UIButton *btn = [UIButton createMyButtonWithImage:@"compose_toolbar_picture"];
    [btnArray addObject:btn];
    UIButton *btn1 = [UIButton createMyButtonWithImage:@"compose_mentionbutton_background"];
    [btnArray addObject:btn1];
    UIButton *btn2 = [UIButton createMyButtonWithImage:@"compose_trendbutton_background"];
    [btnArray addObject:btn2];
    UIButton *btn3 = [UIButton createMyButtonWithImage:@"compose_emoticonbutton_background"];
    [btnArray addObject:btn3];
    [btn addTarget:self action:@selector(pickPicture) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(selectEmoticon) forControlEvents:UIControlEventTouchUpInside];
    for (NSInteger i = 0; i <btnArray.count; i++) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnArray[i]];
        [btnArray[i] sizeToFit];
        [items addObject:item];
        [items addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    }
    //移除最后一个弹簧
    [items removeLastObject];
    //设置工具条items
    _toolbar.items = items;
    
}

#pragma mark 底部工具条表情选择按钮
-(void)selectEmoticon
{
    //系统的键盘退出
    [self.photosPublish.textView resignFirstResponder];
    //设置键盘
    self.photosPublish.textView.inputView = self.photosPublish.textView.inputView == nil ? self.emoticonView : nil;
    //重新激活键盘
    [self.photosPublish.textView becomeFirstResponder];
}


#pragma mark 键盘变化处理
-(void)keyboardChanged:(NSNotification *)n
{
    //字典中rect为NSValue
    NSDictionary *d  = n.userInfo;
    CGRect rect = [(NSValue *)d[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘弹出动画时长
    double duration = [(NSNumber *)d[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //拿到键盘左上点的y值
    CGFloat offset = -[UIScreen mainScreen].bounds.size.height + rect.origin.y;
    [self.toolbar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(offset);
    }];
    //动画曲线
    NSInteger curve = [(NSNumber *)d[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //底部工具条随键盘移动动画
    [UIView animateWithDuration:duration animations:^{
        //设置动画曲线
        [UIView setAnimationCurve:curve];
        //重新布局
        [self.view layoutIfNeeded];
    }];
}

#pragma mark 懒加载表情键盘
-(EmoticonView *)emoticonView
{
    if(!_emoticonView)
    {
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.size.height = 258;
        //解决循环引用
        __weak __typeof(self) weakSelf = self;
        self.emoticonView = [[EmoticonView alloc] initWithselectEmoticonBlock:^(Emoticon *emoticon) {
            [weakSelf insertEmoticon:emoticon];
        } frame:rect];
    }
    return _emoticonView;
}

#warning 这里把方法集成到EmoticonView中
#pragma mark 插入表情键盘
-(void)insertEmoticon:(Emoticon *)emoticon
{
    if (emoticon.isEmpty) {
        NSLog(@"isEmpty");
        return ;
    }
    if (emoticon.isRemoved) {
        //调用自身删除
        [self.photosPublish.textView deleteBackward];
        return;
    }
    if (emoticon.emoji) {
        [self.photosPublish.textView replaceRange:self.photosPublish.textView.selectedTextRange withText:emoticon.emoji];
    }
    [self insertImageEmoticon:emoticon];
}

#pragma mark 插入图片表情
-(void)insertImageEmoticon:(Emoticon *)emoticon
{
    //图片的属性高度
    EmoticonAttachment *attachment = [[EmoticonAttachment alloc] initWithEmotion:emoticon];
    attachment.image = [UIImage imageWithContentsOfFile:emoticon.imagePath];
    //线宽表示字体高度
    CGFloat lineHeight =  self.photosPublish.textView.font.lineHeight;
    attachment.bounds = CGRectMake(0, -4, lineHeight, lineHeight);
    //获取图片文本
    NSMutableAttributedString *imageText = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    //添加字体
    [imageText addAttribute:NSFontAttributeName value:self.photosPublish.textView.font range:NSMakeRange(0, 1)];
    //转换成可变文本
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:self.photosPublish.textView.attributedText];
    //插入图片
    [strM replaceCharactersInRange:self.photosPublish.textView.selectedRange withAttributedString:imageText];
    //替换属性文本
    //记录光标位置
    NSRange range = self.photosPublish.textView.selectedRange;
    //设置属性文本
    self.photosPublish.textView.attributedText = strM;
    //恢复光标位置
    self.photosPublish.textView.selectedRange = NSMakeRange(range.location + 1, 0);
}

#pragma mark 图片选择
-(void)pickPicture
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //判断用户有没有授权
        if (status != PHAuthorizationStatusAuthorized) {
            return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //初始化相簿
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            //设置相簿代理
            picker.delegate = self;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                 picker.modalPresentationStyle = UIModalPresentationFormSheet;
            }
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        });
    }];
}


#pragma mark 图片选择代理方法
-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    //关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    //显示图片
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeExact;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        
        _images = [[NSMutableArray alloc] init];
        //请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            //保存原图(方便进行图片浏览功能和发送给服务器)
            [_images addObject:result];
            //进行图片处理
            UIImage *cutImage = [UIImage imageWithCutImage:result];
            
            //添加UIImageView
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = cutImage;
            [self.photosPublish.photosView addSubview:imageView];
            //将图片显示并且进行布局
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.photosPublish.photosView.mas_top).offset((i / 4) * (LYHPhotosWidth + 10) + 10);
                make.left.equalTo(self.photosPublish.photosView.mas_left).offset((i % 4) *(LYHPhotosWidth + 10) + 15);
                make.size.mas_equalTo(CGSizeMake(LYHPhotosWidth, LYHPhotosWidth));
            }];
        }];
    }
    NSLog(@"");
}

#pragma mark 监听文本代理方法
-(void)textViewDidChange:(UITextView *)textView
{
    //监听发布和占位文字的隐藏
    self.navigationItem.rightBarButtonItem.enabled = self.photosPublish.textView.hasText;
    self.photosPublish.placeHolderLabel.hidden = self.photosPublish.textView.hasText;
    
    return ;
    //监听换行
    //获取文本中字体的size
    NSInteger number = 0;
    CGSize size = [self sizeWithString:self.photosPublish.textView.text font:[UIFont systemFontOfSize:17] width:LYHWidth];
    //获取一行的高度
    CGSize size1 = [self sizeWithString:@"Hello" font:[UIFont systemFontOfSize:17] width:LYHWidth];
    NSInteger i = size.height/size1.height;
    if (i > number) {
        //换行
#warning 要换行
        number = i;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark 自适应字体
-(CGSize)sizeWithString:(NSString*)string font:(UIFont*)font     width:(float)width {
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,   80000) options:NSStringDrawingTruncatesLastVisibleLine |   NSStringDrawingUsesFontLeading    |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

#pragma mark 相簿最大返回多少张图片
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 9;
    if (picker.selectedAssets.count < 9) {
        return YES;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:[NSString stringWithFormat:@"最多选择%zd张图片",max] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
    [picker presentViewController:alert animated:YES completion:nil];
    return NO;
}



//#pragma mark 懒加载保存图片原图数组
//-(NSMutableArray<UIImage *>*)images
//{
//    if(!_images)
//    {
//        _images = [[NSMutableArray alloc] init];
//    }
//    return _images;
//}

@end
