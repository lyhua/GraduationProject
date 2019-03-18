//
//  LYHLostPasswordViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/2/27.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHLostPasswordViewController : UIViewController
@property(nonatomic ,strong) UIImageView *phoneImageView;
@property(nonatomic ,strong) UIImageView *passwordImageView;
@property(nonatomic ,strong) UITextField *phoneTextField;
@property(nonatomic ,strong) UITextField *passwordTextField;
@property(nonatomic ,strong) UIButton *submitButton;
@property(nonatomic ,strong) UIButton *verificationCodeButton;
@property(nonatomic ,strong) UITextField *verificationCodeTextField;
//额外属性
@property(nonatomic,assign) BOOL phoneTextFieldLenIsOk;//电话号码长度
@property(nonatomic,assign) BOOL passwordTextFieldLenIsOk;//密码长度
@property(nonatomic,assign) BOOL verificationCodeTextFieldLenIsOk;//验证码长度

@end
