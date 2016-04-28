//
//  LYMeViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYMeViewController.h"
#import "LYSettingViewController.h"
#import "LYMeCell.h"
#import "LYFooterView.h"

@interface LYMeViewController ()

@end

@implementation LYMeViewController

static NSString * const LYMeCellId = @"meCell";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置TableView
    [self setupTableView];
    
    // 设置导航栏
    [self setupNavigation];
    
}

#pragma mark -- 设置TableView
- (void)setupTableView {
    
    
    self.tableView.backgroundColor = LYCommenBackgroundColor;
    // 注册
    [self.tableView registerClass:[LYMeCell class] forCellReuseIdentifier:LYMeCellId];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = LYMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(LYMargin - LYGroupFirstCellY, 0, 0, 0);
    // footerView
    self.tableView.tableFooterView = [[LYFooterView alloc] init];
}

#pragma mark -- 设置导航栏
- (void)setupNavigation {
    // 标题
    self.navigationItem.title = @"我的";
    
    // 夜间按钮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    // 设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}


#pragma mark -- 监听按钮点击
- (void)moonClick
{
    LYLogFuc
}

- (void)settingClick
{
    LYSettingViewController *vc = [[LYSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TableView 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:LYMeCellId];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    } else {
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
    }
    
    return cell;
}


@end
