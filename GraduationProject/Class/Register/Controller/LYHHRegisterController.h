//
//  LYHHRegisterController.h
//  GraduationProject
//
//  Created by liangyaohua on 18/3/30.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHHRegisterController : UIViewController

@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UITextField *phoneTextField;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *verificationCodeTextField;
@property(nonatomic,strong) UIButton *verificationCodeButton;
@property(nonatomic,strong) UIButton *registerButton;


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
@property(nonatomic) BOOL phoneTextFieldLenIsOk;//电话号码长度
@property(nonatomic) BOOL passwordTextFieldLenIsOk;//密码长度
@property(nonatomic) BOOL verificationCodeTextFieldLenIsOk;//验证码长度




@end
