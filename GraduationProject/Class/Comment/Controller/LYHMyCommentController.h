//
//  LYHMyCommentController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/21.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYHSendCommentView.h"

@interface LYHMyCommentController : UIViewController

//评论数据TableView
@property(nonatomic,strong)UITableView *commentView;

//底部视图
@property(nonatomic,strong)LYHSendCommentView *bottomView;

//询问是否删除弹框
@property(nonatomic,strong)UIAlertController *delteCommentAlert;

//额外属性

//评论id
@property(nonatomic,strong)NSNumber *comment_id;

@end
