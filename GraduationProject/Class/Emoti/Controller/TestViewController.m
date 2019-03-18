//
//  TestViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 17/4/6.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "TestViewController.h"
#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import "Base.h"
#import "EmoticonView.h"
#import "EmoticonAttachment.h"
@interface TestViewController ()<UITextViewDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupUI
{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, LYHWidth, LYHHeight)];
    [self.view addSubview:_textView];
    _textView.delegate = self;
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 216;
//    _emoticonView = [[EmoticonView alloc] initWithFrame:rect];
    //解决循环引用
    __weak __typeof(self) weakSelf = self;
    _emoticonView = [[EmoticonView alloc] initWithselectEmoticonBlock:^(Emoticon *emoticon) {
        [weakSelf insertEmoticon:emoticon];
    } frame:rect];
    _textView.inputView = _emoticonView;
    _textView.font = [UIFont systemFontOfSize:14];
    [_textView becomeFirstResponder];
    
}

#pragma mark 插入表情键盘
-(void)insertEmoticon:(Emoticon *)emoticon
{
    if (emoticon.isEmpty) {
        NSLog(@"isEmpty");
        return ;
    }
    if (emoticon.isRemoved) {
        //调用自身删除
        [self.textView deleteBackward];
        return;
    }
    if (emoticon.emoji) {
        [self.textView replaceRange:self.textView.selectedTextRange withText:emoticon.emoji];
    }
    [self insertImageEmoticon:emoticon];
}

#pragma mark 插入图片表情
-(void)insertImageEmoticon:(Emoticon *)emoticon
{
    //图片的属性高度
    EmoticonAttachment *attachment = [[EmoticonAttachment alloc] initWithEmotion:emoticon];
    attachment.image = [UIImage imageWithContentsOfFile:emoticon.imagePath];
    //线宽表示字体高度
    CGFloat lineHeight =  self.textView.font.lineHeight;
    attachment.bounds = CGRectMake(0, -4, lineHeight, lineHeight);
    //获取图片文本
    NSMutableAttributedString *imageText = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    //添加字体
    [imageText addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, 1)];
    //转换成可变文本
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    //插入图片
    [strM replaceCharactersInRange:self.textView.selectedRange withAttributedString:imageText];
    //替换属性文本
    //记录光标位置
    NSRange range = self.textView.selectedRange;
    //设置属性文本
    self.textView.attributedText = strM;
    //恢复光标位置
    self.textView.selectedRange = NSMakeRange(range.location + 1, 0);
}

#pragma mark 获取文本
-(void)emotionText
{
    
}





@end
