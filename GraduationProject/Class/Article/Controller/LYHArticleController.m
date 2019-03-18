//
//  LYHArticleController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/9.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHArticleController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "Base.h"
#import "LYHArticleTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "Article.h"
#import "LYHArtContentViewController.h"


@interface LYHArticleController ()<SDCycleScrollViewDelegate>

@end

@implementation LYHArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //初始化图片地址
    NSArray *array = [NSArray array];
    array = [NSArray arrayWithObjects:@"qinzi1",@"qinzi2",@"qinzi3",nil];
    
    //设置headView
    SDCycleScrollView *vc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 170) shouldInfiniteLoop:YES imageNamesGroup:array];
    //为轮播图添加代理
    vc.delegate = self;
    self.tableView.tableHeaderView = vc;
    
    //这册cell
    [self.tableView registerClass:[LYHArticleTableViewCell class] forCellReuseIdentifier:LYHArticleCell];
    
    //请求文章数据
    [self loadArticle];
    
    //添加下拉加载控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadArticle)];
    
    //网络请求内容数据(进行自动刷新)
    [self.tableView.mj_header beginRefreshing];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    LYHArtContentViewController *vc = [[LYHArtContentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 请求文章数据
-(void)loadArticle
{
#warning 这里要完善请求文章数据
    //刷新表格
    [self.tableView reloadData];
    //结束刷新
    [self.tableView.mj_header endRefreshing];
}

#pragma  mark 设置导航条
- (void)setupNav
{
    self.navigationItem.title = @"文章";
    self.navigationController.navigationBar.barTintColor = LYHMyColor;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    LYHArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHArticleCell];
    Article *article = [[Article alloc] init];
    article.title = @"杭州亲子游泳，蓝旗亲子游泳暑期带娃大作战";
    article.time = @"2018-03-04";
    article.content = @"经常有家长们吐槽“熊孩子”难管，不省心，可看看“别人”明星家的孩子，跟爸妈出街或者上节目时一脸“萌逼”，微博秀也是在炫各种才艺。";
    article.read = @"537";
    article.comment = @"57";
    article.like = @"23";
    cell.article = article;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHArtContentViewController *vc = [[LYHArtContentViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
