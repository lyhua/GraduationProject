//
//  LYHContentViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/13.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHContentViewController.h"
#import "LYHContentViewCell.h"
#import "Base.h"
#import "NetworkRequest.h"
#import "Content.h"
#import <MJExtension/MJExtension.h>
#import "LYHSettingController.h"
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "LYHContentSingleCell.h"
#import "LYHContentDoubleCell.h"
#import "LYHContentQuadrupleCell.h"
#import "NSString+Category.h"
#import "Pictures.h"
#import "MWPhotoBrowser.h"
#import "ImageSize.h"
#import "LYHCommentController.h"
#import "LYHMyCommentController.h"

@interface LYHContentViewController ()

//内容数组
@property(nonatomic,strong) NSMutableArray<Content *> *contents;

//图片尺寸数组
@property(nonatomic,strong)NSMutableArray<ImageSize *> *imageSizes;


@end

@implementation LYHContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell(通过xib)
    //注册内容种类的cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LYHContentViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:LYHContentCell];
    //注册单张图片cell
    [self.tableView registerClass:[LYHContentSingleCell class] forCellReuseIdentifier:LyhContentSingleCell];
    //注册两张图片cell
    [self.tableView registerClass:[LYHContentDoubleCell class] forCellReuseIdentifier:LyhContentDoubleCell];
    //注册三张或四张图片cell
    [self.tableView registerClass:[LYHContentQuadrupleCell class] forCellReuseIdentifier:LyhContentQuadrupleCell];
    
    
    
 
    //添加MJRefresh下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewContents)];
    //添加MJRefresh上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldContents)];
    //先从归档数据中去内容数据
    [self getContentsFromSerialize];
    
    //网络请求内容数据(进行自动刷新)
    [self.tableView.mj_header beginRefreshing];
    
    
    //监听评论按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CommentBtnClick:) name:LYHCellCommentBtnClickNotification object:nil];
    
    //图片浏览器通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosBrowse:) name:LYHPhotosBrowse object:nil];
    
    //注册用户头像是否改变观察者
    [[User shareUser] addObserver:self forKeyPath:@"headImage" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark 先从归档数据中去内容数据
-(void)getContentsFromSerialize
{
    [Content unserializeContents];
    self.contents = [Content shareContents];
    //先从归档数据取出图片尺寸数据
    [self getImageSizeFromSerialize];
    //刷新
    [self.tableView reloadData];
}


#pragma mark 先从归档数据取出图片尺寸数据
-(void)getImageSizeFromSerialize
{
    [ImageSize unserializeImageSizes];
    self.imageSizes = [ImageSize shareImageSize];
    
}


#pragma  mark 设置导航条
- (void)setupNav
{
    self.navigationItem.title = @"内容";
    self.navigationController.navigationBar.barTintColor = LYHMyColor;
}

#pragma mark 请求较新的数据
-(void)loadNewContents
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"content/getContentsWithContentId"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"content_id"] = self.contents.firstObject.content_id;
    parameters[@"newOrOld"] = [NSNumber numberWithInt:1];
    
    //发送请求
    [[NetworkRequest getRequest] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSMutableArray *moreContents = [Content mj_objectArrayWithKeyValuesArray:responseObject[@"contents"]];
        NSMutableArray *moreImageSize =[ImageSize mj_objectArrayWithKeyValuesArray:responseObject[@"imagesSize"]];
        NSLog(@"%@",responseObject);
        //加到旧数组后面(并对进行排序)
//        moreContents = (NSMutableArray *)[[moreContents reverseObjectEnumerator] allObjects];
        
        for(NSUInteger i=0;i<moreContents.count;i++)
        {
            //把内容数据保存到shareContents
            [[Content shareContents] insertObject:moreContents[i] atIndex:0];
            //把图片尺寸数据保存到shareImageSize
            [[ImageSize shareImageSize] insertObject:moreImageSize[i] atIndex:0];
            [Content shareContents][i].height = [ImageSize shareImageSize][i].height;
        }
        //刷新表格
        [self.tableView reloadData];
        //有下拉刷新才是需要归档数据
#warning 这里可以做优化
        [Content serializeContents];
        
        [ImageSize serializeImageSizes];
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户那里出错
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

#pragma mark 请求较旧的内容数据
-(void)loadOldContents
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"content/getContentsWithContentId"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"content_id"] = self.contents.lastObject.content_id;
    parameters[@"newOrOld"] = [NSNumber numberWithInt:0];
    
    
    //发送请求
    [[NetworkRequest getRequest] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSMutableArray *moreContents = [Content mj_objectArrayWithKeyValuesArray:responseObject[@"contents"]];
        NSMutableArray *moreImageSizes = [ImageSize mj_objectArrayWithKeyValuesArray:responseObject[@"imagesSize"]];
        
        //加到旧数组后面(并对进行排序)
        moreContents = (NSMutableArray *)[[moreContents reverseObjectEnumerator] allObjects];
        moreImageSizes = (NSMutableArray *)[[moreImageSizes reverseObjectEnumerator] allObjects];
        //我在Contents中定义了一个静态属相与这里重名
//        [self.contents addObjectsFromArray:moreContents];
        //把数据保存到shareContents
        [[Content shareContents] addObjectsFromArray:moreContents];
        //保存图片尺寸数据
        [[ImageSize shareImageSize] addObjectsFromArray:moreImageSizes];
        for (NSInteger i = 0; i < [Content shareContents].count; i++) {
            [Content shareContents][i].height = [ImageSize shareImageSize][i].height;
        }
#warning 到底要不要归档数据！！！！！！！！！！！()
        
        //刷新表格
        [self.tableView reloadData];
        //结束上拉刷新
        if(moreContents.count == 0)
        {
            //如果服务器没有数据返回就提醒用没有数据
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            NSLog(@"moreContents==nil");
        }else{
            //结束上拉刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户那里出错
        NSLog(@"error   ______--------%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        //结束下拉刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


#pragma mark CommentBtn点击的监听方法
-(void)CommentBtnClick:(id) sender
{
    LYHMyCommentController *vc = [[LYHMyCommentController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 图片下载完重新刷新表格
-(void)picturesReloadData
{
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.contents[indexPath.row].height = self.imageSizes[indexPath.row].height;
    return self.contents[indexPath.row].cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //拿出图片的数量
    NSInteger count = [NSString stringDivisionWithString:self.contents[indexPath.row].contentImage symbol:@"#"].count;
    //根据图片的数量来设置不同的图片View
    if (count == 1) {
        LYHContentSingleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if(cell == nil)
        {
            cell = [[LYHContentSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LyhContentSingleCell];
        }
        //只有是单张图片才需要设置图片尺寸模型，因为其他都处理为正方形
        cell.imageSize = self.imageSizes[indexPath.row];
        cell.content = self.contents[indexPath.row];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (count == 2)
    {
        LYHContentDoubleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[LYHContentDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LyhContentDoubleCell];
        }
        cell.content = self.contents[indexPath.row];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
//        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        return cell;
    }else{
        LYHContentQuadrupleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[LYHContentQuadrupleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LyhContentQuadrupleCell];
        }
        cell.content = self.contents[indexPath.row];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


//没一行cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //注意按钮会比这个cell的点击事件高
    NSLog(@"didSelectRowAtIndexPath");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark 图片浏览器
-(void)photosBrowse:(NSNotification *)notification
{
    Pictures *pictures = notification.userInfo[@"pictures"];
    NSString *tag = notification.userInfo[@"tag"];
    NSInteger index = [tag integerValue];
    NSMutableArray<MWPhoto *> *photos = [[NSMutableArray alloc] init];
    NSString *bigcommonurl = [BaseURL stringByAppendingString:@"contentImage/"];
    for (NSInteger i = 0; i < pictures.imagesCount; i++) {
        //拼接URL
        NSString *url = [bigcommonurl stringByAppendingString:pictures.images[i]];
        MWPhoto *photo = [[MWPhoto alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        [photos addObject:photo];
    }

    //弹出图片浏览器
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    [browser setCurrentPhotoIndex:index];
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - kvo的回调方法(用户头像发生改变时)
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSInteger count = [Content shareContents].count;
    for(NSInteger i = 0; i < count; i++)
    {
        //修改本身用户头像(其他用户需要向服务器请求，这样减少请求次数和服务器压力)
        if([Content shareContents][i].user_id == [User shareUser].userId)
        {
            [Content shareContents][i].headImage = [User shareUser].headImage;
        }
        //修改完后要进行归档
        [Content serializeContents];
    }
    [self.tableView reloadData];
}

@end


























