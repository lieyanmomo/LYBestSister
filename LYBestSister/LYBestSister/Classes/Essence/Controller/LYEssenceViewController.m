//
//  LYEssenceViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYEssenceViewController.h"
#import "LYRecommandTagViewController.h"
#import "LYTitleButton.h"
#import "LYAllViewController.h"
#import "LYVideoViewController.h"
#import "LYVoiceViewController.h"
#import "LYPictureViewController.h"
#import "LYWordViewController.h"

@interface LYEssenceViewController ()<UIScrollViewDelegate>

/** 当前被选中的标题按钮*/
@property (weak, nonatomic) LYTitleButton *selectedTitleButton;
/** 底部指示器*/
@property (weak, nonatomic) UIView *titleIndicatorView;
/** 存放所有子控制器的scrollView*/
@property (weak, nonatomic) UIScrollView *scrollView;
/** 存放所有的标题按钮*/
@property (strong, nonatomic) NSMutableArray *titleButtons;

@end

@implementation LYEssenceViewController

#pragma mark - 懒加载
// 标题按钮
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加navigationController
    [self setUpNavigationController];
    
    // 添加子控制器
    [self setUpChildViewController];
    
    // 添加scrollView
    [self setUpScrollView];
    
    // 添加标题栏
    [self setUpTitlesView];
    
    // 根据scrollView的偏移量添加子控制器的View
    [self addChildView];
}

#pragma mark - 添加navigationController
- (void)setUpNavigationController {
    
    // 背景颜色
    self.view.backgroundColor = LYCommenBackgroundColor;
    
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(mainTagSubClick)];
}

#pragma mark -- navigationItem上按钮的点击
- (void)mainTagSubClick
{
    LYRecommandTagViewController *tag = [[LYRecommandTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}

#pragma mark - 添加子控制器
- (void)setUpChildViewController {
    LYAllViewController *allViewController = [[LYAllViewController alloc] init];
    allViewController.title = @"全部";
    [self addChildViewController:allViewController];
    
    LYVideoViewController *videoViewController = [[LYVideoViewController alloc] init];
    videoViewController.title = @"视频";
    [self addChildViewController:videoViewController];
    
    LYVoiceViewController *voiceViewController = [[LYVoiceViewController alloc] init];
    voiceViewController.title = @"声音";
    [self addChildViewController:voiceViewController];
    
    LYPictureViewController *pictureViewController = [[LYPictureViewController alloc] init];
    pictureViewController.title = @"图片";
    [self addChildViewController:pictureViewController];
    
    LYWordViewController *wordViewController = [[LYWordViewController alloc] init];
    wordViewController.title = @"段子";
    [self addChildViewController:wordViewController];
    
}

#pragma mark -- 添加子控制器的View
- (void)addChildView {
    UIScrollView *scrollView = self.scrollView;
    
    // 计算scrollView的索引
    int index = scrollView.contentOffset.x / scrollView.width;
    // 添加对应的子控制器
    UIViewController *willShowViewControll = self.childViewControllers[index];
    if (willShowViewControll.isViewLoaded) return;
    
    [scrollView addSubview:willShowViewControll.view];
    
    // 位置
    willShowViewControll.view.frame = scrollView.bounds;

}

#pragma mark - 添加scrollView
- (void)setUpScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = LYRandomColor;
    // 设置scrollView的代理
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 禁止【scrollView自动设置内边距】
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置scrollView的内容大小
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
//    // 添加tableview
//    for (int i = 0; i < self.childViewControllers.count; i++) {
//        UITableViewController *tableVc = self.childViewControllers[i];
//        tableVc.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
//        // 滚动条内边距
//        tableVc.tableView.scrollIndicatorInsets = tableVc.tableView.contentInset;
//        
//        // tableView的位置
//        tableVc.tableView.x = scrollView.width * i;
//        tableVc.tableView.y = 0;
//        tableVc.tableView.width = scrollView.width;
//        tableVc.tableView.height = scrollView.height;
//        [scrollView addSubview:tableVc.view];
//        
//    }
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildView];
}

// 当scrollView停止滚动时调用 （人为手动拖拽停止滚动调用）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算按钮索引
    int index = scrollView.contentOffset.x / scrollView.width;
    LYTitleButton *titleButton = self.titleButtons[index];
    // 点击按钮
    [self titleButtonClick:titleButton];
    
    // 根据scrollView的偏移量添加
    [self addChildView];
}



#pragma mark - 添加标题栏
- (void)setUpTitlesView {
    // 0.添加标题栏view
    UIView *titilesView = [[UIView alloc] init];
    titilesView.frame = CGRectMake(0, 64, self.view.width, 40);
    titilesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titilesView];
    
    // 1.添加标题栏上的按钮
    CGFloat titleButtonW = titilesView.width / self.childViewControllers.count;
    CGFloat titleButtonH = titilesView.height;
    
    for (int i = 0; i < self.childViewControllers.count; i++) {
        // 创建按钮
        LYTitleButton *titleButton = [[LYTitleButton alloc] init];
        // 为标题栏按钮绑定tag
        titleButton.tag = i;
        // 监听点击
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titilesView addSubview:titleButton];
        // 将按钮加载到标题按钮数组中
        [self.titleButtons addObject:titleButton];
        
        // 按钮位置
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        // 设置按钮属性
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        // 数据
        [titleButton setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        
    }
    
    // 2.添加标题栏底部指示器
    UIView * titleIndicatorView = [[UIView alloc] init];
    [titilesView addSubview:titleIndicatorView];
    
    // 指示器属性
    LYTitleButton *firstTitleButton = titilesView.subviews.firstObject;
    titleIndicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    titleIndicatorView.height = 1;
    titleIndicatorView.bottom = titilesView.height;
    
    self.titleIndicatorView = titleIndicatorView;
    
    // 默认选中第一个标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 自动计算当前按钮尺寸
    
    titleIndicatorView.width = firstTitleButton.titleLabel.width;
    titleIndicatorView.centerX = firstTitleButton.centerX;
    
    
}

#pragma mark -- 监听标题栏按钮点击
- (void)titleButtonClick:(LYTitleButton *)titleButton {
    
    
    // 让选中标题按钮 回复以前的选中状态
    self.selectedTitleButton.selected = NO;
    // 被点击的按钮是选中状态
    titleButton.selected = YES;
    
    self.selectedTitleButton = titleButton;
    
    // 指示器移动
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.width = titleButton.titleLabel.width;
        self.titleIndicatorView.centerX = titleButton.centerX;
    }];
    
    // 滚动scrollView
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

@end
