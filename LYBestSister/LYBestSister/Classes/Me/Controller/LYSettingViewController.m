//
//  LYSettingViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/18.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYSettingViewController.h"
#import "LYClearCacheCell.h"
#import "LYSettingCell.h"

@interface LYSettingViewController ()

@end

@implementation LYSettingViewController

static NSString * const LYClearCacheCellId = @"clear_cache";
static NSString * const LYSettingCellId = @"settingCell";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    // 注册
    [self.tableView registerClass:[LYClearCacheCell class] forCellReuseIdentifier:LYClearCacheCellId];
    [self.tableView registerClass:[LYSettingCell class] forCellReuseIdentifier:LYSettingCellId];
    
    // 背景颜色
    self.tableView.backgroundColor = LYCommenBackgroundColor;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [tableView dequeueReusableCellWithIdentifier:LYClearCacheCellId];
        }else {
            LYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:LYSettingCellId];
            if (indexPath.row == 1) {
                cell.textLabel.text = @"检查更新";
            } else {
                cell.textLabel.text = @"关于我们";
            }
            return cell;
        }
    }
    
    return nil;
    
}


@end
