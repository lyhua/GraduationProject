//
//  LYHFriendsController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/16.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHFriendsController.h"
#import "Base.h"
#import "LYHFriendsViewCell.h"
#import "NetworkRequest.h"
#import "Friends.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIImage+Image.h"
#import "LYHSecretViewController.h"
#import "LYHInfoViewController.h"
#import "LYHApplyController.h"
#import "LYHMoreController.h"

@interface LYHFriendsController ()

//朋友列表数组
@property(nonatomic,strong)NSMutableArray<Friends *> *friends;

@end

@implementation LYHFriendsController

//懒加载朋友列表数组
-(NSMutableArray<Friends *> *)friends
{
    if(!_friends)
    {
        _friends = [[NSMutableArray alloc] init];
    }
    return _friends;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNav];
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell(通过xib)
    //注册朋友种类的cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([LYHFriendsViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:LYHFriendsCell];
    
    //请求朋友数据
    [self loadFriends];
    
    //添加下拉加载控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFriends)];
    
}

#pragma mark 请求
-(void)loadFriends
{
    //friend/getMyFriendsList
#warning 怎样获取用户的user_id
    NSString *url = [BaseURL stringByAppendingString:@"friend/getUserAllFirendsWithUserId"];
    NSLog(@"url      ------%@",url);
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"user_id"] = [User shareUser].userId;
    /*
    NSString *myExsitFriendListString = @"";
    NSString *temp;
    NSMutableArray<NSString *> *myExsitFriendList =[[NSMutableArray alloc] init];
    for(NSInteger i=0;i<_friends.count;i++)
    {
        if(i == 0)
        {
            temp = [NSString stringWithFormat:@"%@",_friends[i].userId];
            NSLog(@"temp------------------%@",temp);
            myExsitFriendListString = [myExsitFriendListString stringByAppendingString:temp];
            NSLog(@"myExsitFriendListString------------------%@",myExsitFriendListString);
        }else{
        temp = [NSString stringWithFormat:@":%@",_friends[i].userId];
        NSLog(@"temp------------------%@",temp);
        myExsitFriendListString = [myExsitFriendListString stringByAppendingString:temp];
        NSLog(@"myExsitFriendListString------------------%@",myExsitFriendListString);
        }
    }
     
    NSLog(@"myExsitFriendListString------------------%@",myExsitFriendListString);
    parameters[@"user_id"] = @"1";
    parameters[@"myExsitFriendListString"] = myExsitFriendListString;
     */
    
    //发送请求
    [[NetworkRequest getRequest] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模式
        NSMutableArray *friendsList = [Friends mj_objectArrayWithKeyValuesArray:responseObject[@"friends"]];
        NSLog(@"-----===========%@",responseObject[@"friends"]);
        //加到旧朋友列表数组后面(进行以字符窜排序)
//        for(NSInteger i=0;i<friendsList.count;i++)
//        {
//            
//        }
        NSLog(@"paramters-------------------%@",parameters);
        NSLog(@"url-------------------%@",url);
        if(_friends!=nil)
        {
            [_friends removeAllObjects];
        }
        [self.friends addObjectsFromArray:friendsList];
        
        [_friends sortUsingComparator:^NSComparisonResult(Friends* obj1, Friends* obj2) {
            return [obj1.name compare:obj2.name];
        }];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //提醒用户那里出错
        NSLog(@"error   ______--------%@",error);
        [SVProgressHUD showErrorWithStatus:errorNetwork];
    }];
    
}




#pragma mark 设置导航条
-(void)setupNav
{
    self.navigationItem.title = @"亲友";
    NSLog(@"______---------navcontroller %@",self.navigationController);
    //添加信息按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(getMessage)];
    
    
    self.navigationController.navigationBar.barTintColor =LYHMyColor;
}

#pragma mark 获取悄悄话信息
-(void)getMessage
{
    //LYHInfoViewController *vc = [[LYHInfoViewController alloc] init];
    //LYHApplyController *vc = [[LYHApplyController alloc] init];
    LYHMoreController *vc = [[LYHMoreController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 加好友
-(void)applyFriend
{
    LYHApplyController *vc = [[LYHApplyController alloc] init];
    [self.navigationController popToViewController:vc animated:YES];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHFriendsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHFriendsCell];
    cell.friends = self.friends[indexPath.row];
    [cell.layer setMasksToBounds:YES];
    cell.layer.cornerRadius = 10;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYHSecretViewController *vc = [[LYHSecretViewController alloc] init];
    vc.friendId = _friends[indexPath.row].userId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end















