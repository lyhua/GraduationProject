//
//  EmoticonViewCell.h
//  GraduationProject
//
//  Created by liangyaohua on 17/4/8.
//  Copyright © 2017年 liangyaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Emoticon.h"

@interface EmoticonViewCell : UICollectionViewCell

@property(nonatomic,strong) UIButton *emoticonButton;

@property(nonatomic,strong)Emoticon *emoticon;

@end
