//
//  LYHHLostPasswordViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/1.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHHLostPasswordViewController : UIViewController

@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic ,strong) UITextField *phoneTextField;
@property(nonatomic ,strong) UITextField *passwordTextField;
@property(nonatomic ,strong) UIButton *submitButton;
@property(nonatomic ,strong) UIButton *verificationCodeButton;
@property(nonatomic ,strong) UITextField *verificationCodeTextField;


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
@property(nonatomic,assign) BOOL phoneTextFieldLenIsOk;//电话号码长度
@property(nonatomic,assign) BOOL passwordTextFieldLenIsOk;//密码长度
@property(nonatomic,assign) BOOL verificationCodeTextFieldLenIsOk;//验证码长度



@end
