//
//  LYHHMeViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/27.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHHMeViewController.h"
#import "Base.h"
#import "LYHMeCommonTableViewCell.h"
#import "LYHMeHeadTableViewCell.h"
#import "LYHMeExitTableViewCell.h"
#import "User.h"
#import "LYHMeUnloginViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "LYHIconViewController.h"
#import "LYHPublishController.h"
#import "TestViewController.h"
#import "LYHComposeViewController.h"
#import "Publish.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSString+Category.h"
#import "LYHMissionTableViewController.h"
#import "LYHRewardTableViewController.h"
#import "UIImage+Image.h"
#import "LYHUserInfoViewController.h"
#import <Masonry/Masonry.h>
#import "LYHHMeUnloginViewController.h"
#import "LYHHMeViewCell.h"
#import "LYHMeNorViewCell.h"
#import "LYHHPublishController.h"


@interface LYHHMeViewController ()

//存储保存电话号码
@property(nonatomic,strong)NSMutableArray<NSString *> *phoneNumbers;

//存储保存联系人姓名
@property(nonatomic,strong)NSMutableArray<NSString *> *contactNames;

@end

@implementation LYHHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = LYHColor(240, 240, 242);
    
    
    //设置导航条上的内容
    [self setupNav];
    
    //设置TarBar显示
    [self setupTabBar];
    
    //注册退出cell
    UINib *nib2 = [UINib nibWithNibName:NSStringFromClass([LYHMeExitTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:LYHMeExitCell];
    
    //注册用户头像是否该表观察者
    [[User shareUser] addObserver:self forKeyPath:@"headImage" options:NSKeyValueObservingOptionNew context:nil];
    
    //注册发布是否发布图片观察者
    [[Publish sharePublish] addObserver:self forKeyPath:@"isPublished" options:NSKeyValueObservingOptionNew context:nil];
}


//设置导航条透明
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYHColor(253, 185, 109)] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

//恢复导航条
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYHColor(253, 185, 109)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor grayColor]]];
}


#pragma mark 设置导航条上的内容
- (void)setupNav
{
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
    //设置标题
    self.navigationItem.title = @"我";
    //self.navigationController.navigationBar.barTintColor = LYHColor(253, 185, 109);
    
}

#pragma mark 设置TarBar显示
- (void)setupTabBar
{
    //添加个人信息表
    UIImage *temp;
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"setting_icon" width:25 height:25];
    [setButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"setting_height_icon" width:25 height:25];
    [setButton setImage:temp  forState:UIControlStateHighlighted];
    [setButton sizeToFit];
    //setButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    [setButton addTarget:self action:@selector(getUserInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 弹出个人信息页面
-(void)getUserInfo
{
    LYHUserInfoViewController *vc = [[LYHUserInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0)
    {
        LYHHMeViewCell *cell = [[LYHHMeViewCell alloc] init];
        cell.user = [User shareUser];
        return cell;
    }else if(indexPath.section == 1)
    {
        LYHMeNorViewCell *cell = [[LYHMeNorViewCell alloc] init];
        cell.norLabel.text = @"任务";
        cell.norImageView.image = [UIImage imageNamed:@"icon_add"];
        return cell;
    }else if(indexPath.section == 2)
    {
        LYHMeNorViewCell *cell = [[LYHMeNorViewCell alloc] init];
        cell.norLabel.text = @"通讯";
        cell.norImageView.image = [UIImage imageNamed:@"icon_add"];
        return cell;
    }else if(indexPath.section == 3)
    {
        LYHMeNorViewCell *cell = [[LYHMeNorViewCell alloc] init];
        cell.norLabel.text = @"发布";
        cell.norImageView.image = [UIImage imageNamed:@"icon_add"];
        return cell;
    }else if(indexPath.section == 4)
    {
        LYHMeNorViewCell *cell = [[LYHMeNorViewCell alloc] init];
        cell.norLabel.text = @"奖励";
        cell.norImageView.image = [UIImage imageNamed:@"icon_add"];
        return cell;
    }
    LYHMeExitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHMeExitCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 200;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LYHIconViewController *vc = [[LYHIconViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.section == 1)
    {
        LYHMissionTableViewController *vc =[[LYHMissionTableViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
#warning 暂时用于获取联系人信息
        [self getgetAddressBookArr];
        [self saveContacts];
    }
    
    if (indexPath.section == 3)
    {
        //LYHPublishController *vc = [[LYHPublishController alloc] init];
        LYHHPublishController *vc = [[LYHHPublishController alloc] init];
        self.definesPresentationContext = YES;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
    if(indexPath.section == 4)
    {
        LYHRewardTableViewController *vc =[[LYHRewardTableViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 5)
    {
        //设置用户是否登录属性(然后KVO)
        
        [User shareUser].userId = nil;
        [User shareUser].name = @"";
        [User shareUser].age = nil;
        [User shareUser].phone = @"";
        [User shareUser].headImage = @"";
        [User shareUser].email = @"";
         
        [User shareUser].userIsLogin = nil;
#warning 这里可以用remove
        //把归档设置为空
        [User userLogout:[User shareUser]];
        
    }

}


#pragma mark 获取获取联系人授权
-(void)getgetAddressBookArr
{
    _phoneNumbers = [[NSMutableArray alloc] init];
    _contactNames = [[NSMutableArray alloc] init];
    CNContactStore *contacStore = [[CNContactStore alloc] init];
    //创建请求时，需要告诉请求对象，在检索时要返回哪些属性，否则后面使用未检索的属性程序会崩
    CNContactFetchRequest *request=[[CNContactFetchRequest alloc]initWithKeysToFetch:@[CNContactFamilyNameKey,CNContactGivenNameKey,CNContactPhoneNumbersKey]];
    [contacStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        if (contact.phoneNumbers.count > 0) {
            [_contactNames addObject:contact.familyName];
            [_phoneNumbers addObject:[contact.phoneNumbers[0].value stringValue]];
            NSLog(@"phoneNumbers-------------------%@",contact.familyName);
            NSLog(@"contactNames-------------------%@",[contact.phoneNumbers[0].value stringValue]);
        }
    }];
}

#pragma mark 请求保存联系人
-(void)saveContacts
{
    //片接url
    NSString *url = [BaseURL stringByAppendingString:@"telephone/saveContacts"];
    NSLog(@"url-----------------%@",url);
    //片接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *temp = [NSString stringJointWithArray:_phoneNumbers symbol:@","];
    NSString *temp1 = [NSString stringJointWithArray:_contactNames symbol:@","];
    parameters[@"phoneNumber"] = temp;
    parameters[@"contactName"] = temp1;
    parameters[@"user_id"] = [User userLogin].userId;
    NSLog(@"temp---------------%@",temp);
    NSLog(@"temp1---------------%@",temp1);
    NSLog(@"phoneNumber--------------------%@",parameters[@"phoneNumber"]);
    NSLog(@"contactName--------------------%@",parameters[@"contactName"]);
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"msg"] != nil) {
            [SVProgressHUD showSuccessWithStatus:@"保存联系人成功!"];
        }
        if (responseObject[@"error"] != nil) {
            [SVProgressHUD showErrorWithStatus:@"保存联系人失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:errorNetwork];
    }];
}


#pragma mark - kvo的回调方法(系统提供的回调方法)用户头像改变时调用
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //如果用户头像有发生改变重新加载数据
    if ([keyPath isEqualToString:@"headImage"]) {
        [self.tableView reloadData];
    }
    //观察发布图片属性是否改变
    if([keyPath isEqualToString:@"isPublished"])
    {
        //如果是发布图片
        if ((BOOL)object) {
            LYHComposeViewController *vc = [[LYHComposeViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
    }
    
}



@end
