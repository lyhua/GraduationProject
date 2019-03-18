//
//  LYHUserInfoViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/13.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHUserInfoViewController.h"
#import "Base.h"
#import "UIImage+Image.h"
#import "LYHUserInfoViewCell.h"
#import "WYGenderPickerView.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface LYHUserInfoViewController ()<UITextFieldDelegate>

@end

@implementation LYHUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    
    //设置tableView背景颜色
    self.tableView.backgroundColor = LYHColor(184, 184, 184);
    //取消整体的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //这册cell
    [self.tableView registerClass:[LYHUserInfoViewCell class] forCellReuseIdentifier:LYHUserInfo];
    
}

#pragma  mark 设置导航条
- (void)setupNav
{
    self.navigationItem.title =@"个人信息";
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(setupUserInfo)];
}


#pragma mark 设置个人信息
-(void)setupUserInfo
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"updateUserWithUserId"];
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userId"] = [User shareUser].userId;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    LYHUserInfoViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    parameters[@"name"] = cell.contentTextField.text;
    
    indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    cell =[self.tableView cellForRowAtIndexPath:indexPath];
    parameters[@"age"] = cell.contentTextField.text;
    
    indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    cell =[self.tableView cellForRowAtIndexPath:indexPath];
    if([cell.contentTextField.text isEqualToString:@"男"])
    {
        parameters[@"gender"] = @"0";
    }else{
        parameters[@"gender"] = @"1";
    }
    
    indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    cell =[self.tableView cellForRowAtIndexPath:indexPath];
    parameters[@"email"] = cell.contentTextField.text;
    
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject[@"msg"])
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        }
        if (responseObject[@"error"]) {
            [SVProgressHUD showErrorWithStatus:@"网络有问题"];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络有问题"];
    }];
    
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
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYHUserInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LYHUserInfo];
    if (indexPath.row == 0) {
        cell.contentLabel.text = @"昵称";
        cell.contentTextField.text = [User shareUser].name;
        cell.contentTextField.delegate = self;
    }else if (indexPath.row == 1) {
        cell.contentLabel.text = @"年龄";
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.contentTextField.text = [[User shareUser].age stringValue];
        cell.contentTextField.delegate = self;
    }else if(indexPath.row == 2)
    {
        cell.contentLabel.text = @"性别";
        cell.contentTextField.delegate = self;
        if([User shareUser].gender == nil)
        {
            cell.contentTextField.text = @"男";
        }else{
            if([User shareUser].gender == 0)
            {
                cell.contentTextField.text = @"男";
            }else{
                cell.contentTextField.text = @"女";
            }
        }
        
        
        
    }else if (indexPath.row == 3) {
        cell.contentLabel.text = @"邮箱";
        cell.contentTextField.delegate = self;
        cell.contentTextField.text = [User shareUser].email;
    }else if (indexPath.row == 4) {
        cell.contentLabel.text = @"手机";
        cell.contentTextField.delegate = self;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.contentTextField.text = [User shareUser].phone;
        //不准更改手机号码
        cell.contentTextField.userInteractionEnabled = NO;
    }
    return cell;
}


#pragma mark 点击空白处关闭键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
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
