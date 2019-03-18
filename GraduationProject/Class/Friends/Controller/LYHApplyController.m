//
//  LYHApplyController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/21.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHApplyController.h"
#import "LYHSearchViewCell.h"
#import "UIImage+Image.h"
#import "UIButton+Category.h"
#import "Base.h"

@interface LYHApplyController ()

@end

@implementation LYHApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNavBar];
    
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    self.navigationItem.title = @"更多";
    
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

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYHSearchViewCell *cell = [[LYHSearchViewCell alloc] init];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


#pragma mark 设置键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
#warning 键盘失灵
    [self.view endEditing:YES];
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
