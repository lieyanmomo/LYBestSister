//
//  LYAllViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/26.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYAllViewController.h"

@implementation LYAllViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    self.tableView.contentInset = UIEdgeInsetsMake(LYNavigationBarBottom + LYTitlesViewH, 0, LYTabBarH, 0);
    // 滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%zd", self.title, indexPath.row];
    
    return cell;
}
@end
