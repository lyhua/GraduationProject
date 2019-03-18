//
//  LYHCommentController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/5/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHCommentController : UITableViewController

//询问是否删除弹框
@property(nonatomic,strong)UIAlertController *delteCommentAlert;

//
@property(nonatomic,strong)UIView *bottomView;

//额外属性

//评论id
@property(nonatomic,strong)NSNumber *comment_id;

@end
