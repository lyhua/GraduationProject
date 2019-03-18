//
//  LYHSecretViewController.h
//  GraduationProject
//
//  Created by liangyaohua on 18/4/10.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHSecretViewController : UIViewController

//内容编辑区
@property(nonatomic,strong)UITextView *contentTextView;


//日期选择区
@property(nonatomic,strong)UITextField *dateTextField;

//日期选择键盘
@property(nonatomic,strong)UIDatePicker *datePicker;

//额外属性

//朋友的ID
@property(nonatomic,strong)NSNumber *friendId;

@end
