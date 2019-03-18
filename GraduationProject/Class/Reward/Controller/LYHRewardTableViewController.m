//
//  LYHRewardTableViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/2.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHRewardTableViewController.h"
#import "Base.h"
#import "UIButton+Category.h"
#import "UIImage+Image.h"
#import "LYHMissionTableViewCell.h"
#import "Mission.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "Reward.h"
#import "LYHRewardTableViewCell.h"
#import "User.h"

@interface LYHRewardTableViewController ()

@property(nonatomic,strong) NSMutableArray<Reward *> *rewards;

@end

@implementation LYHRewardTableViewController

//懒加载奖励列表
-(NSMutableArray<Reward *> *)rewards
{
    if(!_rewards)
    {
        _rewards = [[NSMutableArray alloc] init];
    }
    return _rewards;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNav];
    
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [self.tableView registerClass:[LYHRewardTableViewCell class] forCellReuseIdentifier:LYHRewardCell];
    
    //请求奖励数据
    [self loadRewards];
    
    //添加下拉加载控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRewards)];
    
}


#pragma mark 请求奖励数据
-(void)loadRewards
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"reward/getRewardWithUserId"];
    NSLog(@"url      ------%@",url);
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"] = [User shareUser].userId;
    
    //发送请求
    [[NetworkRequest getRequest] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSMutableArray *moreRewards = [Reward mj_objectArrayWithKeyValuesArray:responseObject[@"rewards"]];
        NSLog(@"%@",responseObject);
        if(_rewards)
        {
            [_rewards removeAllObjects];
        }
        [_rewards addObjectsFromArray:moreRewards];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户那里出错
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        //结束下拉刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma  mark 设置导航条
- (void)setupNav
{
    self.navigationItem.title =@"奖励";
    self.navigationController.navigationBar.barTintColor=LYHMyColor;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rewards.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHRewardCell];
    cell.reward = self.rewards[indexPath.row];
    
    //设置圆角
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
