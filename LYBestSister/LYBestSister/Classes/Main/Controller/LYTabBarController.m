//
//  LYTabBarController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTabBarController.h"
#import "LYNavigationController.h"
#import "LYEssenceViewController.h"
#import "LYNewViewController.h"
#import "LYFriendTrendsViewController.h"
#import "LYMeViewController.h"
#import "LYTabBar.h"

@interface LYTabBarController ()

@end

@implementation LYTabBarController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加item文字属性
    [self setUpItemTextAttrs];
    
    // 添加子控制器
    [self setupChildVcs];
    
    // 处理tabBar
    [self setupTabBar];
    
}

#pragma mark -- 设置item文字属性
- (void)setUpItemTextAttrs
{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 方法或者属性后面有个UI_APPEARANCE_SELECTOR宏,才可以通过appearance对象统一设置
    // 统一设置UITabBarItem的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark -- 添加所有子控制器
- (void)setupChildVcs
{
    
    
    
    // 精华
    [self setupOneChildVc:[[LYNavigationController alloc] initWithRootViewController:[[LYEssenceViewController alloc] init]] title:@"精华" normalImage:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    // 新帖
    [self setupOneChildVc:[[LYNavigationController alloc] initWithRootViewController:[[LYNewViewController alloc] init]] title:@"新帖" normalImage:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    // 关注
    LYFriendTrendsViewController *friendTrends = [UIStoryboard storyboardWithName:NSStringFromClass([LYFriendTrendsViewController class]) bundle:nil].instantiateInitialViewController;
    [self setupOneChildVc:[[LYNavigationController alloc] initWithRootViewController:friendTrends] title:@"关注" normalImage:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    // 我
    [self setupOneChildVc:[[LYNavigationController alloc] initWithRootViewController:[[LYMeViewController alloc] initWithStyle:UITableViewStyleGrouped]] title:@"我" normalImage:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
}


- (void)setupOneChildVc:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
    // 添加子控制器
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normalImage];
    // 设置选中图片 并且控制图片不用系统渲染
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc];

}

#pragma mark -- 处理tabBar
- (void)setupTabBar
{
    [self setValue:[[LYTabBar alloc] init] forKeyPath:@"tabBar"];
}


@end
