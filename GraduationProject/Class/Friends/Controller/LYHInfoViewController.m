//
//  LYHInfoViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/11.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHInfoViewController.h"
#import "Info.h"
#import "Base.h"
#import "LYHInfoViewCell.h"
#import "User.h"
#import "NetworkRequest.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIImage+Image.h"

@interface LYHInfoViewController ()

//信息列表
@property(nonatomic,strong)NSMutableArray<Info *> *infos;

@end

@implementation LYHInfoViewController

//懒加载信息列表数组
/*
-(NSMutableArray<Info *> *)infos
{
    if(!_infos)
    {
        _infos = [[NSMutableArray alloc] init];
    }
    return _infos;
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNav];
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //这册信息cell
    [self.tableView registerClass:[LYHInfoViewCell class] forCellReuseIdentifier:LYHInfoCell];
    
    //请求信息数据
    [self loadInfos];
    
    //添加下拉加载控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadInfos)];
}

#pragma mark 设置导航条
-(void)setupNav
{
    self.navigationItem.title = @"消息";
    self.navigationController.navigationBar.barTintColor =LYHMyColor;
    UIImage *temp;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp  forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

#pragma mark 返回
- (void)backCilck
{
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 请求信息数据
-(void)loadInfos
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"info/getInfoWithUserId"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"] = [User shareUser].userId;
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *moreInfos = [Info mj_objectArrayWithKeyValuesArray:responseObject[@"infos"]];
         NSLog(@"%@",responseObject);
        if(_infos)
        {
            [_infos removeAllObjects];
        }else{
            _infos = [[NSMutableArray alloc] init];
            [_infos addObjectsFromArray:moreInfos];
        }
        
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _infos.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYHInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHInfoCell forIndexPath:indexPath];
    //设置用户数据模型
    cell.info = _infos[indexPath.row];
    //UITableViewCell  *cell = [[UITableViewCell alloc] init];
    return cell;
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
