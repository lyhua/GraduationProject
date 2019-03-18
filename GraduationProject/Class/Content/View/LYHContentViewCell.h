//
//  LYHContentViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 17/3/14.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYHPicturesView.h"
#import "Pictures.h"

@class Content;

@interface LYHContentViewCell : UITableViewCell

//数据模型
@property(nonatomic,strong) Content *content;

//图片控件
//@property(nonatomic,strong)LYHPicturesView *picturesView;

//图片模型
@property(nonatomic,strong)Pictures *pictures;




@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *moodImage;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *blessingBtn;

@property (weak, nonatomic) IBOutlet UIButton *reportBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

- (IBAction)blessingBtnClick:(id)sender;

- (IBAction)reportBtnClick:(id)sender;

- (IBAction)commentBtnClick:(id)sender;

@end
