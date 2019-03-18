//
//  LYHSendCommentController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/22.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHSendCommentController.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "User.h"
#import "Content.h"
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Comment.h"

@interface LYHSendCommentController ()<UITextViewDelegate>

@end

@implementation LYHSendCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNav];
    
    //设置UI
    [self setupUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //激活键盘
    [self.commentTextView.textView becomeFirstResponder];
}

#pragma mark 设置导航条
-(void)setupNav
{
    self.navigationController.navigationBar.barTintColor = LYHMyColor;
    //标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 36)];
    self.navigationItem.titleView = titleView;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"发布评论";
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT"size:19];;
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleView.mas_centerX);
        make.top.equalTo(titleView.mas_top).offset(8);
    }];
    //添加取消按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnClose)];
    //添加发布按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendStatus)];
    //禁止发布按钮
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

#pragma mark 设置UI
-(void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _commentTextView = [[LYHCommentTextView alloc] init];
    [self.view addSubview:_commentTextView];
    //进行布局
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //拖拽关闭键盘
    _commentTextView.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //设置键盘代理
    _commentTextView.textView.delegate = self;
    //设置垂直滚动
    _commentTextView.alwaysBounceVertical = NO;
    
    
}

#pragma 取消按钮点击事件
-(void)btnClose
{
    //关闭键盘
    [self.commentTextView.textView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 发布按钮点击事件
-(void)sendStatus
{
    //获取文本中的内容
    NSString *text = _commentTextView.textView.text;
    
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"comment/createComment"];
    //拼接参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"comment"] = text;
    parameter[@"user_id"] = [User shareUser].userId;
    parameter[@"content_id"] = [Content shareContent].content_id;
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-HH"];
    NSString *date = [dateFormat stringFromDate:[NSDate date]];
    parameter[@"date"] = date;
    NSLog(@"text--------------------%@",text);
    NSLog(@"user_id------------%@",[User shareUser].userId);
    NSLog(@"content_id--------------%@",[Content shareContent].content_id);
    NSLog(@"date-----------------%@",date);
    NSLog(@"user --------%@",[User shareUser]);
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject[@"msg"]) {
            //关闭键盘
            [self.commentTextView.textView resignFirstResponder];
            //要求上一个界面刷新评论(KVO)
            [Comment shareComent].isRefreshComment = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (responseObject[@"error"]) {
            //发布不成功,服务器问题,提醒用户稍后再试
            [SVProgressHUD showErrorWithStatus:@"网络好像有点问题!"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户上传失败
        [SVProgressHUD showErrorWithStatus:@"发布失败,稍后再试!"];
    }];
}

#pragma mark 监听文本代理方法
-(void)textViewDidChange:(UITextView *)textView
{
    //监听发布和占位文字的隐藏
    self.navigationItem.rightBarButtonItem.enabled = self.commentTextView.textView.hasText;
    self.commentTextView.placeHolderLabel.hidden = self.commentTextView.textView.hasText;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
