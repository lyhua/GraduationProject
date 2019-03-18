//
//  LYHMyCommentController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/5/21.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "LYHMyCommentController.h"
#import <Masonry/Masonry.h>
#import "Base.h"
#import "Comment.h"
#import "User.h"
#import "LYHCommentSingleCell.h"
#import "LYHCommentsDoubleCell.h"
#import "LYHCommentQuadupleCell.h"
#import <MJRefresh/MJRefresh.h>
#import "NetworkRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "LYHContentSingleCell.h"
#import "LYHContentDoubleCell.h"
#import "LYHContentQuadrupleCell.h"
#import "NSString+Category.h"
#import "ImageSize.h"
#import "LYHCommentViewCell.h"
#import "LYHSendCommentController.h"
#import "UIImage+Image.h"

@interface LYHMyCommentController () <UITableViewDelegate, UITableViewDataSource>

//评论数组
@property(nonatomic,strong)NSMutableArray<Comment *> *comments;

//用户数据(用于模型布局)
@property(nonatomic,strong)NSMutableArray<User *> *users;

@end

@implementation LYHMyCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comments = [[NSMutableArray alloc] init];
    self.users = [[NSMutableArray alloc] init];

    //设置导航条
    [self setupNav];
    
    //设置UI
    [self setupUI];
    
    //设置背景颜色
    [self.view setBackgroundColor:LYHColor(184, 184, 184)];
    
    //注册单张图片cell
    [self.commentView registerClass:[LYHCommentSingleCell class] forCellReuseIdentifier:LyhCommentSingleCell];
    //注册两张图片cell
    [self.commentView registerClass:[LYHCommentsDoubleCell class] forCellReuseIdentifier:LyhCommentDoubleCell];
    //注册三张或四张图片cell
    [self.commentView registerClass:[LYHCommentQuadupleCell class] forCellReuseIdentifier:LyhCommentQuadrupleCell];
    //网络请求内容数据(进行自动刷新)
    [self.commentView.mj_header beginRefreshing];
    
    
    //监听评论删除通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteComments:) name:LYHDeleteCommentsNotification object:nil];
    
    //监听点击评论安通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendComments) name:LYHSendCommentsNotification object:nil];
    
    //添加观察者观察评论是否有发表(发表新评论进行更新)
    [[Comment shareComent] addObserver:self forKeyPath:@"isRefreshComment" options:NSKeyValueObservingOptionNew context:nil];
    
    
    

}

#pragma mark设置UI
-(void)setupUI
{
    _commentView = [[UITableView alloc] init];
    //取消整体的分割线
    _commentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentView];
    [_commentView setBackgroundColor:LYHColor(184, 184, 184)];
    //设置代理源
    _commentView.delegate = self;
    _commentView.dataSource = self;
    
    //添加MJRefresh下拉刷新
    _commentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    //添加MJRefresh上拉刷新
    _commentView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldComments)];
    
    
    //进行tableView布局
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    _bottomView = [[LYHSendCommentView alloc] init];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_bottomView];
    //进行底部视图布局
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark 设置导航条
-(void)setupNav
{
    UIImage *temp = nil;
    self.navigationItem.title = @"评论";
    self.navigationController.navigationBar.barTintColor = LYHMyColor;
    //设置返回按钮
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

#pragma mark 请求较新的评论数据
-(void)loadNewComments
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"comment/getCommentsWithContentId"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"content_id"] = [Comment shareComent].content_id;
    parameters[@"newOrOld"] = [NSNumber numberWithInt:1];
    //这里可能为空
    NSLog(@"first%@",self.comments.firstObject.comment_id);
    parameters[@"comment_id"] = self.comments.firstObject.comment_id;
    
    //发送数据
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"comments%@",responseObject[@"comments"]);
        NSLog(@"users%@",responseObject[@"users"]);
        NSLog(@"Comment%@",[Comment shareComent].content_id);
        //字典转模型
        NSMutableArray *moreComments = [Comment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        NSMutableArray *moreUsers = [User mj_objectArrayWithKeyValuesArray:responseObject[@"users"]];
//        //加到旧数组后面(并对进行排序)
//        moreComments = (NSMutableArray *)[[moreComments reverseObjectEnumerator] allObjects];
//        moreUsers = (NSMutableArray *)[[moreUsers reverseObjectEnumerator] allObjects];
        
        for (NSInteger i = 0; i < moreComments.count; i++) {
            //把评论数据保存到数组中
            [self.comments insertObject:moreComments[i] atIndex:0];
            //保存用户数据
            [self.users insertObject:moreUsers[i] atIndex:0];
        }
        
        //判断是否是自己发表评论不需要进行颠倒数组
//        if ([Comment shareComent].isRefreshComment) {
//            self.comments = (NSMutableArray *)[[self.comments reverseObjectEnumerator] allObjects];
//            self.users = (NSMutableArray *)[[self.users reverseObjectEnumerator] allObjects];
//        }
        //这里要
        NSLog(@"------------------%@",self.comments.firstObject.comment_id);
        //刷新表格
        [self.commentView reloadData];
        //结束上拉刷新
        [self.commentView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户出错
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        //结束下拉刷新
        [self.commentView.mj_header endRefreshing];
    }];
}

#pragma mark 请求较旧的评论数据
-(void)loadOldComments
{
    //拼接URL
    NSString *url = [BaseURL stringByAppendingString:@"comment/getCommentsWithContentId"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"content_id"] = [Comment shareComent].content_id;
    parameters[@"newOrOld"] =[NSNumber numberWithInt:0];
    //这里可能为空
    NSLog(@"last%@",self.comments.lastObject.comment_id);
    parameters[@"comment_id"] = self.comments.lastObject.comment_id;
    
    //发送请求
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSMutableArray *moreComments = [Comment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
        NSMutableArray *moreUsers = [User mj_objectArrayWithKeyValuesArray:responseObject[@"users"]];
        //加到旧数组后面(并对进行排序)
        moreComments = (NSMutableArray *)[[moreComments reverseObjectEnumerator] allObjects];
        moreUsers = (NSMutableArray *)[[moreUsers reverseObjectEnumerator] allObjects];
        [self.comments addObjectsFromArray:moreComments];
        [self.users addObjectsFromArray:moreUsers];
        
        //刷新表格
        [self.commentView reloadData];
        //结束上拉刷新
        if (moreComments.count == 0) {
            //如果服务器没有数据返回就提醒用没有数据
            [self.commentView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.commentView.mj_footer endRefreshing];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户那里出错
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        //结束下拉刷新
        [self.commentView.mj_footer endRefreshing];
        
        
    }];
}


#pragma mark 删除评论通知
-(void)deleteComments:(NSNotification *)notification
{
    //获取需要删除评论id
    NSNumber *comment_id = notification.userInfo[@"comment_id"];
    self.comment_id = comment_id;
    //显示是否删除评论弹框
    [self showDeleteCommentAlert];
    
}



#pragma mark 删除评论
-(void)deleteComment:(NSNumber *)comment_id
{
    //拼接url
    NSString *url = [BaseURL stringByAppendingString:@"comment/deleteCommentWithCommentID"];
    NSLog(@"url      ------%@",url);
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"comment_id"] = comment_id;
    
    //发送求情
    [[NetworkRequest getRequest] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //根据返回的操作码判断是否操作成功
        if (responseObject[@"error"] != nil) {
            //删除不成功
            [SVProgressHUD showErrorWithStatus:@"网络异常!"];
        }
        if (responseObject[@"msg"] != nil) {
            //从内存中删除那条评论
            NSInteger index = 0;
            for (NSInteger i = 0; i < _comments.count; i++) {
                if (_comments[i].comment_id == comment_id) {
                    index = i;
                    break;
                }
            }
            [_comments removeObjectAtIndex:index];
            //重新刷新表格
            [self.commentView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //提醒用户那里出错
        [SVProgressHUD showErrorWithStatus:@"网络异常!"];
    }];
}

#pragma mark 显示删除提示框
-(void)showDeleteCommentAlert
{
    _delteCommentAlert = [UIAlertController alertControllerWithTitle:@"删除评论" message:@"是否删除评论" preferredStyle:UIAlertControllerStyleAlert];
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [_delteCommentAlert addAction:cancelAction];
    
    //添加删除到UIAlertController中
    UIAlertAction *delteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //删除评论
        [self deleteComment:self.comment_id];
    }];
    [_delteCommentAlert addAction:delteAction];
    
    
    [self presentViewController:_delteCommentAlert animated:YES completion:nil];
}


#pragma mark 懒加载提示框
-(UIAlertController *)delteCommentAlert
{
    if (!_delteCommentAlert) {
        _delteCommentAlert = [UIAlertController alertControllerWithTitle:@"删除评论" message:@"是否删除评论" preferredStyle:UIAlertControllerStyleAlert];
        
        //添加取消到UIAlertController中
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [_delteCommentAlert addAction:cancelAction];
        
        //添加删除到UIAlertController中
        UIAlertAction *delteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //删除评论
            [self deleteComment:self.comment_id];
        }];
        [_delteCommentAlert addAction:delteAction];
    }
    
    return _delteCommentAlert;
}

#pragma mark 点击发送按钮通知实现
-(void)sendComments
{
    LYHSendCommentController *vc = [[LYHSendCommentController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [Content shareContent].height = [ImageSize shraeSize].height;
        return [Content shareContent].cellHeight - 34;
    }
    return self.comments[indexPath.row - 1].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *str = [Content shareContent].contentImage;
        NSInteger count = [NSString stringDivisionWithString:str symbol:@"#"].count;
        //根据图片的数量来设置不同的图片View
        if (count == 1) {
            
            LYHCommentSingleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell == nil)
            {
                cell = [[LYHCommentSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LyhCommentSingleCell];
            }
            //只有是单张图片才需要设置图片尺寸模型，因为其他都处理为正方形
            cell.imageSize = [ImageSize shraeSize];
            cell.content = [Content shareContent];
            //设置圆角
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 10;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (count == 2)
        {
            LYHCommentsDoubleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[LYHCommentsDoubleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LyhCommentDoubleCell];
            }
            cell.content = [Content shareContent];
            //设置圆角
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 10;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
            //        UITableViewCell *cell = [[UITableViewCell alloc] init];
            //        return cell;
        }else{
            LYHCommentQuadupleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[LYHCommentQuadupleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LyhCommentQuadrupleCell];
            }
            cell.content = [Content shareContent];
            //设置圆角
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 10;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        LYHCommentViewCell *cell = [[LYHCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //设置用户模型
        cell.user = self.users[indexPath.row - 1];
        //设置评论模型
        cell.comment = self.comments[indexPath.row - 1];
        [cell.layer setMasksToBounds:YES];
        cell.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

#pragma mark - kvo的回调方法(用户头像发生改变时)
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([Comment shareComent].isRefreshComment == YES) {
        //重新请求数据
        [self loadNewComments];
        [Comment shareComent].isRefreshComment = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
