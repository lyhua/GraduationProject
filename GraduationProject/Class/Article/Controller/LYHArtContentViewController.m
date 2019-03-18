//
//  LYHArtContentViewController.m
//  GraduationProject
//
//  Created by liangyaohua on 18/4/9.
//  Copyright © 2018年 liangyaohua. All rights reserved.
//

#import "LYHArtContentViewController.h"
#import "UIImage+Image.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Base.h"
#import <Masonry/Masonry.h>

@interface LYHArtContentViewController ()

@end

@implementation LYHArtContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setupNavBar];
    
    //设置UI
    [self setupUI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    _contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 1.2);
    _contentScrollView.frame = CGRectMake(0, 0, LYHWidth, LYHHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 进行控件布局
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    _contentScrollView = [[UIScrollView alloc] init];
    //_contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //设置ScrollView背景
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    //设置内容的大小
    //_contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
    //是否滚动
    _contentScrollView.scrollEnabled=YES;
    //是否分页
    _contentScrollView.pagingEnabled=YES;
    
    [self.view addSubview:_contentScrollView];
    
    //标题布局
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    [_contentScrollView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentScrollView.mas_top).offset(5);
        make.left.equalTo(_contentScrollView.mas_left).offset(10);
        make.right.equalTo(_contentScrollView.mas_right).offset(-10);
    }];
    
    //时间标签布局
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textColor = [UIColor grayColor];
    [_contentScrollView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_left);
    }];
    
    //图片布局
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qinzi1"]];
    [_contentScrollView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
#warning 这里可以做一下图片等比例缩放
        make.size.mas_equalTo(CGSizeMake(LYHWidth, 170));
        make.top.equalTo(_timeLabel.mas_bottom);
        make.left.equalTo(_contentScrollView.mas_left);
        make.right.equalTo(_contentScrollView.mas_right);
    }];
    
    //文章内容布局
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = LYHColor(97, 97, 97);
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = LYHWidth - 20;
    [_contentScrollView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.left.equalTo(_contentScrollView.mas_left).offset(10);
        make.right.equalTo(_contentScrollView.mas_right).offset(-10);
    }];
    
#warning 先把数据写死
    _titleLabel.text = @"亲子日记";
    _timeLabel.text = @"2018-07-03 9:45";
    _imageView.image = [UIImage imageNamed:@"qinzi1"];
    _contentLabel.text = @"4月24日，星期一，小雨\r\n今天一大早，还没到起床的时间，就被轰隆隆的雷声和哗哗的雨声吵醒，今天屈源芝早上期中考试，看天下雨，我比平常早五分钟叫她起床，刚好在七点十分时我们出了门，到楼下刚好碰见女儿的同学赵一涵，于是将她一起稍上。路上，我问两个孩子，今天要考试，有没有信心考一百分？屈源芝说我可以考80分以上，赵一涵说她可以考90分以上。我笑了笑说：“为什么你俩都没有考100分的目标呢？”她们说：目标定的太高，实现不了，老师会布置很多作业。我对孩子们说：“不是说让你们非得考100分，但是还是要有考100分的自信啊”！一路没有堵车，按时到校了，孩子很高兴。中午因为单位忙，接孩子有些迟，到书香宝贝门口时，今天孩子没有上去看书，在门口边等我边和一个朋友玩。接到孩子后，问了她考的怎么样？她说英语都会填，语文有两个不会。\r\n4月25，星期二，小雨转晴\r\n下午我去听了清平小学校长武际金的讲座《学校教育的同盟军》，感受颇多，家校合育才能使孩子更好的成长，父母是孩子最好的榜样，学校必须与家庭取得联系，才能走出适合每一位孩子成长的教育。如何让5+2不等于零，如何使我们的家庭不再出现‘缺失的爸爸、焦虑的妈妈、失控的孩子’。做智慧父母，陪伴孩子快乐成长，需要父母和老师共同完成。好东西总是不够的！晚上正在手机上编写今天的讲座感受，英语老师就发了今天的考试成绩，女儿考了81分，我看了后有些难受，这学期我没有每天像上学期那样去过多的辅导她的英语，考这么多，完全在我的意料之中，今年老师每天都会让孩子默写单词，抄句子，趣配音，可我总觉得孩子在学校没有学会单词的读法，很多单词和句子孩子在读的时候都会问我怎么读？没有去和她们的英语老师沟通，不还是要天天辅导。女儿说：没考好是因为最近英语老师一直没有让复习。临睡前，女儿有些难过，说：估计语文也没考好。我说：一次没考好不要紧，关键是要找到没考好的原因，接下来好好努力。我也给她说了我的不足知道到底如何，看来得和老师交谈一下了。 看到英语成绩，孩子说，我达到目标了。我说退步太大了，看来，没有认真的辅导她英语，放任孩子自觉学习，复习。";
    
    
    
}

#pragma mark 设置导航条上的内容
- (void)setupNavBar
{
    UIImage *temp;
    self.navigationController.navigationBar.barTintColor = LYHColor(254, 217, 111);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    temp = [UIImage resetImageSize:@"left_ arrows_icon" width:25 height:25];
    [backButton setImage:temp forState:UIControlStateNormal];
    temp = [UIImage resetImageSize:@"left_ arrows_heightlight_icon" width:25 height:25];
    [backButton setImage:temp  forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [backButton addTarget:self action:@selector(backCilck) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

#pragma mark 返回
- (void)backCilck
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //使提示信息消失然后在回退
        [SVProgressHUD dismiss];
    });
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



@end
