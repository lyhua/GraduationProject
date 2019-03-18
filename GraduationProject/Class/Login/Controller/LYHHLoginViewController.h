//
//  LYHHLoginViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHHLoginViewController : UIViewController


@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic, strong) UITextField *userTextField;
@property(nonatomic ,strong) UITextField *passwordTextField;

@property(nonatomic ,strong) UIButton *loginButton;
@property(nonatomic ,strong) UIButton *lostPasswordButton;
@property(nonatomic ,strong) UIButton *registerButton;

//背景
@property(nonatomic,strong)UIImageView *backgroudView;

@property(nonatomic,strong)UIImageView *backgroudView1;

//阴影
@property(nonatomic,strong) UIImageView *shadowImageView;
//线
@property(nonatomic,strong) UIView *lineView;
//线
@property(nonatomic,strong) UIView *lineView1;

//额外属性
@property(nonatomic) BOOL userTextFieldLenIsOk;
@property(nonatomic) BOOL passwordTextFieldLenIsOk;



@end
