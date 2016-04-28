//
//  LYAllViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/26.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYAllViewController.h"
#import "LYHTTPSessionManager.h"
#import "LYTopic.h"
#import "LYTopicCell.h"
#import <MJExtension.h>

@interface LYAllViewController ()

/** 请求管理者*/
@property (weak, nonatomic) LYHTTPSessionManager *manager;
/** 帖子数据*/
@property (strong, nonatomic) NSArray *topics;

@end

@implementation LYAllViewController

static NSString * const LYTopicCellId = @"topic";

#pragma mark - 懒加载
- (LYHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [LYHTTPSessionManager manager];
    }
    return _manager;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(LYNavigationBarBottom + LYTitlesViewH, 0, LYTabBarH, 0);
    // 滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 行高
    self.tableView.rowHeight = 200;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYTopicCell class]) bundle:nil] forCellReuseIdentifier:LYTopicCellId];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"1";
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 将字典数组转换为模型数组
        weakSelf.topics = [LYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新列表
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LYTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
@end
