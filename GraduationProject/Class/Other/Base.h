//
//  Base.h
//  GraduationProject
//
//  Created by liangyaohua on 17/2/26.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#ifndef Base_h
#define Base_h

#define LYHColor(r,g,b) [UIColor colorWithRed:(r) / 256.0 green:(g) / 256.0 blue:(b) / 256.0 alpha:1]
#define BaseURL @"http://192.168.1.102:8080/app2/"
#define errorNetwork @"网络有点问题，请稍后尝试!"
#define usualError @"出错了"
#define alterPasswordSuccess @"密码修改成功"
//屏幕宽度
#define LYHWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define LYHHeight [UIScreen mainScreen].bounds.size.height
//我的视图共同cell标志
#define LYHMeCommonCell @"LYHMeCommonTableViewCell"
//我的视图头部cell标志
#define LYHMeHeadCell @"LYHMeHeadTableViewCell"
//我的视图退出cell标志
#define LYHMeExitCell @"LYHMeExitTableViewCell"

//内容cell的标示
#define LYHContentCell @"LYHContentViewCell"

//朋友cell的标示
#define LYHFriendsCell @"LYHFriendsController"

//用户归档标志
#define LYHUserData @"LYHUserData"

//内容归档标志
#define LYHContentsData @"LYHContentsData"

//图片尺寸归档标志
#define LYHImageSizesData @"LYHImageSizesData"

//内容归档条数
#define LYHContentsCount @"LYHContentsCount"

//祝福通知
#define LYHCellCommentBtnClickNotification @"LYHCellCommentBtnClickNotification"

//表情cell标示
#define LYHEmoticonViewCell @"LYHEmoticonViewCell"

//自定义蓝色
#define LYHMyColor LYHColor(253, 185, 109)

//发布相片是的宽度
#define LYHPhotosWidth (LYHWidth - (3 * 10) - 30) / 4

//单张图片cell
#define LyhContentSingleCell @"LYHContentSingleCell"

//两张图片cell
#define LyhContentDoubleCell @"LYHContentDoubleCell"

//三张图片或四张图片图片cell
#define LyhContentQuadrupleCell @"LYHContentQuadrupleCell"

//重新刷新表格
#define LYHReloadData @"LYHReloadData"

//图片浏览器通知
#define LYHPhotosBrowse @"LYHPhotosBrowse"

//评论单张图片cell
#define LyhCommentSingleCell @"LYHCommentSingleCell"

//评论两张图片cell
#define LyhCommentDoubleCell @"LYHCommentsDoubleCell"

//评论多张图片cell
#define LyhCommentQuadrupleCell @"LYHCommentQuadrupleCell"

//删除评论通知
#define LYHDeleteCommentsNotification @"LYHDeleteCommentsNotification"

//点击评论按钮通知
#define LYHSendCommentsNotification @"LYHSendCommentsNotification"

//任务cell
#define LYHMissionCell @"LYHMissionCell"

//奖励cell
#define LYHRewardCell @"LYHRewardCell"

//文章cell
#define LYHArticleCell @"LYHArticleCell"

//信息cell
#define LYHInfoCell @"LYHInfoCell"

//用户信息cell
#define LYHUserInfo @"LYHUserInfo"

//申请好友cell
#define LYHResponCell @"LYHResponCell"

#endif /* Base_h */











