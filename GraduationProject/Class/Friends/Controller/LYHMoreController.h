//
//  LYHMoreController.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/24.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHMoreController : UIViewController

//用于添加搜索好友
@property(nonatomic,strong)UIView *backgroudView;

@property(nonatomic,strong) UILabel *phoneLabel;

@property(nonatomic,strong) UITextField *phoneTextField;

@property(nonatomic,strong) UIButton *searchButton;

//用于获取申请好友列表
@property(nonatomic,strong) UIView *backgroudView1;

@property(nonatomic,strong) UIButton *seeButton;

@property(nonatomic,strong)UIImageView *friImageView;

//用于获取悄悄话
@property(nonatomic,strong)UIView *backgroudView2;

@property(nonatomic,strong)UIButton *getInfosButton;

@end
