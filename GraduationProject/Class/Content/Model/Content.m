//
//  Content.m
//  GraduationProject
//
//  Created by liangyaohua on 17/3/14.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import "Content.h"
#import "Base.h"
#import "LYHConst.h"
#import "NSString+Category.h"

@implementation Content

#pragma mark 用于改变静态内容
+(void)changeWithContent:(Content *)content
{
    [Content shareContent].content = content.content;
    [Content shareContent].contentImage = content.contentImage;
    [Content shareContent].contentSmallImage = content.contentSmallImage;
    [Content shareContent].content_id = content.content_id;
    [Content shareContent].date = content.date;
    [Content shareContent].headImage = content.headImage;
    [Content shareContent].mood = content.mood;
    [Content shareContent].userName = content .userName;
    [Content shareContent].user_id = content.user_id;
    [Content shareContent].cellHeight = content.cellHeight;
    [Content shareContent].middleFrame = content.middleFrame;
    [Content shareContent].height = content.height;
    
}

//重写get方法
-(CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    //间隔10
    _cellHeight += LYHIntervel;
    //用户头像及用户名
    _cellHeight += 55;
    
    //文字的高度
    CGSize textMaxSize = CGSizeMake(LYHWidth - (2 * LYHIntervel + 65), MAXFLOAT);
    _cellHeight += [self.content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    _cellHeight += 10;
    
    //中间高度
    CGFloat middleW = textMaxSize.width;
#warning 先写死高度
    //获取图片的数量
    NSInteger count = [NSString stringDivisionWithString:_contentImage symbol:@"#"].count;
    //如果有图片才额外添加中间控件高度
    if (![_contentImage isEqualToString:@""] && _contentImage != nil) {
        //如果只有一张图片
        if (count == 1) {
            CGFloat middleH = [self.height floatValue] *0.5;
            CGFloat middleY = _cellHeight;
            CGFloat middleX = 10;
            self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
            _cellHeight += (20 + middleH);
        }
        if (count > 1 && count <= 2) {
            //向上取整
            float c = (float)count / 2;
            CGFloat middleH = 90 * ceil(c);
            CGFloat middleY = _cellHeight + 10;
            CGFloat middleX = 10;
            self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
            //向上取整用来获取间隔
            _cellHeight += (10 + middleH + 10 *ceil(count / 2));
        }
        if (count > 2 && count <= 4) {
            //向上取整
            float c = (float)count / 2;
            CGFloat middleH = 90 * ceil(c);
            CGFloat middleY = _cellHeight + 10;
            CGFloat middleX = 10;
            self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
            //向上取整用来获取间隔
            _cellHeight += (10 + middleH + 10 *ceil(count / 2));
            _cellHeight += 10;
        }
        
    }
    
    _cellHeight += 10;
    
    //底部工具栏
    _cellHeight += 44;
    
    return _cellHeight;
}

#pragma mark 单个内容静态方法(用于向评论创达数据)
+(Content *)shareContent
{
    static Content *content;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        content = [[Content alloc] init];
    });
    return content;
}

#pragma mark 内容数组静态调用方法
+(NSMutableArray<Content *>*)shareContents
{
    static NSMutableArray<Content *> *contents;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contents = [[NSMutableArray alloc] init];
    });
    return contents;
}

#pragma mark 内容数组归档(最多30条数据归档)
+(void)serializeContents
{
    //可以归档的数据
    NSInteger saveCount = (LYHSaveContentsCount < [Content shareContents].count) ? LYHSaveContentsCount : [Content shareContents].count;
    //内容归档
     NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    for(NSInteger i = 0; i < saveCount ; i++)
    {
        NSString *fileName = [LYHContentsData stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)i]];
        NSString *filePath = [documentsDir stringByAppendingPathComponent:fileName];
        [NSKeyedArchiver archiveRootObject:[Content shareContents][i] toFile:filePath];
    }
    //内容条数
    NSString *countFilePath = [documentsDir stringByAppendingPathComponent:LYHContentsCount];
    NSString *myCount = [NSString stringWithFormat:@"%ld",saveCount];
    [NSKeyedArchiver archiveRootObject:(id)myCount toFile:countFilePath];
}


#pragma mark 获取内容归档数据
+(void)unserializeContents
{
    //内容解归档
     NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //从归档取出一共有多少条内容数据(数量)
    NSString *countFilePath = [documentsDir stringByAppendingPathComponent:LYHContentsCount];
    NSString *myCount = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithFile:countFilePath];
    NSInteger count = [myCount integerValue];
    
    //取出归档数据
    for(NSInteger i=0; i<count; i++)
    {
        NSString *fileName = [LYHContentsData stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)i]];
        NSString *filePath = [documentsDir stringByAppendingPathComponent:fileName];
        //取出内容数据然后添加到Contents中
        Content *content = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        [[Content shareContents] addObject:content];
    }
}

#pragma mark content归档方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:NSStringFromSelector(@selector(content))];
    [aCoder encodeObject:self.contentImage forKey:NSStringFromSelector(@selector(contentImage))];
    [aCoder encodeObject:self.content_id forKey:NSStringFromSelector(@selector(content_id))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeObject:self.headImage forKey:NSStringFromSelector(@selector(headImage))];
    [aCoder encodeObject:self.mood forKey:NSStringFromSelector(@selector(mood))];
    [aCoder encodeObject:self.userName forKey:NSStringFromSelector(@selector(userName))];
    [aCoder encodeObject:self.user_id forKey:NSStringFromSelector(@selector(user_id))];
    [aCoder encodeObject:self.contentSmallImage forKey:NSStringFromSelector(@selector(contentSmallImage))];
    [aCoder encodeObject:self.height forKey:NSStringFromSelector(@selector(height))];
}

#pragma mark content解归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _content = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(content))];
        _contentImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(contentImage))];
        _content_id = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(content_id))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _headImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(headImage))];
        _mood = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(mood))];
        _userName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(userName))];
        _user_id = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(user_id))];
        _contentSmallImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(contentSmallImage))];
        _height = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(height))];
    }
    return self;
}


@end
