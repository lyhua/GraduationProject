//
//  Emoticon.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoticon : NSObject

//表情文字
@property(nonatomic,strong) NSString *chs;

//表情文字图片
@property(nonatomic,strong)NSString *png;

//编码
@property(nonatomic,strong)NSString *code;

//无关属性:为了用到setValuesForKeysWithDictionary
@property(nonatomic,strong)NSString *cht;
@property(nonatomic,strong)NSString *gif;
@property(nonatomic,strong)NSString *type;

//16进制转换成emoji表情
@property(nonatomic,strong)NSString *emoji;


//图像路径
@property(nonatomic,strong)NSString *imagePath;

//是否删除按钮标志
@property(nonatomic,assign)BOOL isRemoved;

//是否有空格按钮标志
@property(nonatomic,assign)BOOL isEmpty;

//便利构造方法
-(instancetype)initWithDictionary:(NSDictionary *)dict;

//便利构造方法(删除按钮)
-(instancetype)initWithIsRemoved:(BOOL)isRemoved;

//便利构造方法(空格按钮)
-(instancetype)initWithIsEmpty:(BOOL)isEmpty;

@end
