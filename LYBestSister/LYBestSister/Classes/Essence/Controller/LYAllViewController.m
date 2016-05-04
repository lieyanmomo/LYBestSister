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
#import <MJRefresh.h>
#import "LYRefreshHeader.h"
#import "LYRefreshAutoFooter.h"

@interface LYAllViewController ()

/** 请求管理者*/
@property (weak, nonatomic) LYHTTPSessionManager *manager;
/** 帖子数据*/
@property (strong, nonatomic) NSMutableArray<LYTopic *> *topics;
/** 用来加载下一页数据的参数*/
@property (copy, nonatomic) NSString *maxtime;
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
    
    // 设置tableView
    [self setUpTableView];
    
    // 数据刷新
    [self setUpRefresh];
    
}

#pragma mark -- 设置tableView
- (void)setUpTableView {
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(LYNavigationBarBottom + LYTitlesViewH, 0, LYTabBarH + LYMargin, 0);
    // 滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 行高
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LYCommenBackgroundColor;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYTopicCell class]) bundle:nil] forCellReuseIdentifier:LYTopicCellId];
}

#pragma mark - 数据刷新
- (void)setUpRefresh {
    // 下拉刷新header
    self.tableView.mj_header = [LYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新autoFooter
    self.tableView.mj_footer = [LYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
#pragma mark -- 上拉刷新数据处理
- (void)loadMoreTopics {
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"1";
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 加载下一页数据参数
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 将字典数组转换为模型数组
        NSArray *moreTopics = [LYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 将新加载的数据加载到以前数据的后面
        [weakSelf.topics addObjectsFromArray:moreTopics];
        
        // 刷新列表
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -- 下拉刷新数据处理
- (void)loadNewTopics {
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"1";
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 加载下一页数据参数
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 将字典数组转换为模型数组
        weakSelf.topics = [LYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新列表
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
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

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topics[indexPath.row].cellHeight;
}

@end
