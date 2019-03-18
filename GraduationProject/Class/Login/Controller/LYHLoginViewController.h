//
//  LYHLoginViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 17/2/23.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHLoginViewController : UIViewController
@property(nonatomic, strong) UIImageView *userImageView;
@property(nonatomic, strong) UIImageView *passwordImageView;
@property(nonatomic, strong) UITextField *userTextField;
@property(nonatomic ,strong) UITextField *passwordTextField;
@property(nonatomic ,strong) UIButton *loginButton;
@property(nonatomic ,strong) UIButton *lostPasswordButton;
@property(nonatomic ,strong) UIButton *registerButton;

//额外属性
@property(nonatomic) BOOL userTextFieldLenIsOk;
@property(nonatomic) BOOL passwordTextFieldLenIsOk;

@end
