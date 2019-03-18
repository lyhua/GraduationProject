//
//  LYHSettingController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/5.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHSettingController.h"
#import "Base.h"
#import "UIImage+Image.h"

@interface LYHSettingController ()

@end

@implementation LYHSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNav];
}

#pragma mark 设置导航条
- (void)setupNav
{
    UIImage *temp;
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.barTintColor = LYHColor(53,183,243);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp  forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

#pragma mark 返回
- (void)backCilck
{
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
