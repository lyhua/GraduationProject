//
//  LYHNavigationController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/2/23.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHNavigationController.h"
#import "User.h"
#import "LYHMeTableViewController.h"
#import "LYHMeUnloginViewController.h"

@interface LYHNavigationController ()

@end


@implementation LYHNavigationController

#pragma mark 全局设置导航条的各种属相
+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 只要是通过模型设置,都是通过富文本设置
    //设置标题字体的大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    //设置导航条的标题颜色
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)dealloc
{
    [[User shareUser] removeObserver:self forKeyPath:@"userIsLogin"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
