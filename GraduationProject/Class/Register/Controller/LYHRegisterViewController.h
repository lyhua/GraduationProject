//
//  LYHRegisterViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/1.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHRegisterViewController : UIViewController

@property(nonatomic,strong) UIImageView *phoneImageView;
@property(nonatomic,strong) UITextField *phoneTextField;
@property(nonatomic,strong) UIImageView *passwordImageView;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *verificationCodeTextField;
@property(nonatomic,strong) UIButton *verificationCodeButton;
@property(nonatomic,strong) UIButton *registerButton;
//额外属性
@property(nonatomic) BOOL phoneTextFieldLenIsOk;//电话号码长度
@property(nonatomic) BOOL passwordTextFieldLenIsOk;//密码长度
@property(nonatomic) BOOL verificationCodeTextFieldLenIsOk;//验证码长度



@end
