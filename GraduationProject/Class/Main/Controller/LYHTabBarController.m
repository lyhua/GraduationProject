//
//  LYHTabBarController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/2/23.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHTabBarController.h"
#import "LYHLoginViewController.h"
#import "LYHNavigationController.h"
#import "UIImage+Image.h"
#import "UIBarButtonItem+Item.h"
#import "LYHMeTableViewController.h"
#import "LYHMeUnloginViewController.h"
#import "LYHContentViewController.h"
#import "User.h"
#import "LYHFriendsController.h"
#import "LYHArticleController.h"
#import "LYHHMeUnloginViewController.h"
#import "LYHHMeUnloginViewController.h"
#import "LYHHMeViewController.h"
#import "Base.h"

@interface LYHTabBarController ()

@end

@implementation LYHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置子控件
    [self setChildController];
    
    //设置tabBar的按钮
    [self setupAllTitleButton];
    
    
    //可以用重载cell的方法来判断是否登录
    //登录就把登录的视图加进到我的导航控制器下，退出就把他移除，把未登录的视图加到我的导航控制器下(这样做简单但要写很多代码)
    //注册用户是否登录观察者
    [[User shareUser] addObserver:self forKeyPath:@"userIsLogin" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 设置子控件
- (void) setChildController
{
    //设置亲自文章子空间
    UIViewController *article = [[LYHArticleController alloc] init];
    LYHNavigationController *articleNav = [[LYHNavigationController alloc] initWithRootViewController:article];
    [self addChildViewController:articleNav];
    
    //设置内容子控件
    LYHContentViewController *contentVc = [[LYHContentViewController alloc] init];
    LYHNavigationController *nav = [[LYHNavigationController alloc] initWithRootViewController:contentVc];
    [self addChildViewController:nav];
    
    //设置朋友子控件
    LYHFriendsController *friendsVc = [[LYHFriendsController alloc] init];
    LYHNavigationController *friendsNav = [[LYHNavigationController alloc] initWithRootViewController:friendsVc];
    [self addChildViewController:friendsNav];
    
    
    //设置我的子控件
    //LYHMeUnloginViewController *unLogin = [[LYHMeUnloginViewController alloc] init];
    LYHHMeUnloginViewController *unLogin = [[LYHHMeUnloginViewController alloc] init];
    LYHNavigationController *meNav = [[LYHNavigationController alloc] initWithRootViewController:unLogin];
    _meNav = meNav;
    [self addChildViewController:_meNav];
    

    
}

#pragma 设置tabBar的按钮
- (void) setupAllTitleButton
{
    
    //设置亲自文章轮播图
    UINavigationController *nav3 = self.childViewControllers[0];
    UIImage *image3 = [[UIImage imageNamed:@"article_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSel3 = [[UIImage imageNamed:@"article_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tab3 = [[UITabBarItem alloc] initWithTitle:@"文章" image:image3 selectedImage:imageSel3];
    [tab3 setTitleTextAttributes:@{NSForegroundColorAttributeName: LYHMyColor} forState:UIControlStateSelected];
    nav3.tabBarItem = tab3;
    
    
    
    
    //设置底部工具条(内容)
    UINavigationController *nav = self.childViewControllers[1];
    UIImage *image11 = [[UIImage imageNamed:@"cms_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSel11 = [[UIImage imageNamed:@"cms_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tab11 = [[UITabBarItem alloc] initWithTitle:@"内容" image:image11 selectedImage:imageSel11];
    [tab11 setTitleTextAttributes:@{NSForegroundColorAttributeName: LYHMyColor} forState:UIControlStateSelected];
    nav.tabBarItem = tab11;
    
    
    
    
    
    //设置底部工具条(朋友)
    UINavigationController *nav1 = self.childViewControllers[2];
    UIImage *image1 = [[UIImage imageNamed:@"friend_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSel1 = [[UIImage imageNamed:@"friend_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@"亲友" image:image1 selectedImage:imageSel1];
    [tab1 setTitleTextAttributes:@{NSForegroundColorAttributeName: LYHMyColor} forState:UIControlStateSelected];
    nav1.tabBarItem = tab1;
    
    
    
    //设置底部工具条(我)
    UINavigationController *nav2 = self.childViewControllers[3];
    UIImage *image2 = [[UIImage imageNamed:@"person-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSel2 = [[UIImage imageNamed:@"person_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tab2 = [[UITabBarItem alloc] initWithTitle:@"我" image:image2 selectedImage:imageSel2];
    [tab2 setTitleTextAttributes:@{NSForegroundColorAttributeName: LYHMyColor} forState:UIControlStateSelected];
    nav2.tabBarItem = tab2;
}

#pragma mark - kvo的回调方法(系统提供的回调方法)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([User shareUser].userIsLogin)
    {
        [self.meNav popToRootViewControllerAnimated:NO];
        [self.meNav popViewControllerAnimated:NO];
        //LYHMeTableViewController *vc = [[LYHMeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        LYHHMeViewController *vc = [[LYHHMeViewController alloc] init];
        [self.meNav pushViewController:vc animated:NO];
    }
    else
    {
        [self.meNav popToRootViewControllerAnimated:NO];
        [self.meNav popViewControllerAnimated:NO];
        //LYHMeUnloginViewController *vc = [[LYHMeUnloginViewController alloc] init];
        LYHHMeUnloginViewController *vc = [[LYHHMeUnloginViewController alloc] init];
        [self.meNav pushViewController:vc animated:NO];
    }
}





@end
