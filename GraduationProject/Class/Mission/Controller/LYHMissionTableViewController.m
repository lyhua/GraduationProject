//
//  LYHMissionTableViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHMissionTableViewController.h"
#import "Base.h"
#import "UIButton+Category.h"
#import "UIImage+Image.h"
#import "LYHMissionTableViewCell.h"
#import "Mission.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "LYHPublishController.h"
#import "LYHComposeViewController.h"
#import "LYHPubController.h"

@interface LYHMissionTableViewController ()

//任务列表
@property(nonatomic,strong) NSMutableArray<Mission *> *missions;

@end

@implementation LYHMissionTableViewController

//懒加载任务列表
-(NSMutableArray<Mission *> *)missions
{
    if(!_missions)
    {
        _missions = [[NSMutableArray alloc] init];
    }
    return _missions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册任务cell
     [self.tableView registerClass:[LYHMissionTableViewCell class] forCellReuseIdentifier:LYHMissionCell];
    
    //请求数据
    [self loadMission];
    
    //添加下拉加载控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMission)];
}

#pragma  mark 设置导航条
- (void)setupNav
{
    self.navigationItem.title =@"任务";
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

    return self.missions.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHMissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHMissionCell];
    cell.mission = self.missions[indexPath.row];
    //设置圆角
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.mission = mission;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHPubController *vc = [[LYHPubController alloc] init];
    //LYHPublishController *vc = [[LYHPublishController alloc] init];
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    
    LYHMissionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.mission_id = cell.mission.mission_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 请求任务
-(void)loadMission
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"mission/getMission"];
    NSLog(@"url      ------%@",url);
    //发送请求
    [[NetworkRequest getRequest] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典转模型
        NSMutableArray *moreMissions = [Mission mj_objectArrayWithKeyValuesArray:responseObject[@"missions"]];
        NSLog(@"%@",responseObject);
        
        
        if(_missions){
            [_missions removeAllObjects];
        }
        
        [self.missions addObjectsFromArray:moreMissions];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error------%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        //这里结束下来刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


@end
