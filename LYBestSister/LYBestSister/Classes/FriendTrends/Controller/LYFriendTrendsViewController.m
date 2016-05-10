//
//  LYFriendTrendsViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYFriendTrendsViewController.h"

@interface LYFriendTrendsViewController ()

@end

@implementation LYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景颜色
    self.view.backgroundColor = LYCommenBackgroundColor;
    
    // 标题
    self.navigationItem.title = @"我的关注";
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
    
}

- (void)friendsRecommentClick
{
    [self performSegueWithIdentifier:@"FriendTrendsToRecommendFollow" sender:nil];
}

@end
