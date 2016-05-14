//
//  LYBaseViewController.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/6.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYHTTPSessionManager.h"
#import "LYTopic.h"
#import "LYTopicCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LYRefreshHeader.h"
#import "LYRefreshAutoFooter.h"

#import "LYEssenceViewController.h"
#import "LYNewViewController.h"
#import "LYCommentViewController.h"

@interface LYBaseViewController ()

/** 请求管理者*/
@property (weak, nonatomic) LYHTTPSessionManager *manager;
/** 帖子数据*/
@property (strong, nonatomic) NSMutableArray<LYTopic *> *topics;
/** 用来加载下一页数据的参数*/
@property (copy, nonatomic) NSString *maxtime;
@end

@implementation LYBaseViewController

static NSString * const LYTopicCellId = @"topic";

/** 数据类型 */
- (LYTopicType)type {
    return 0;
}

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
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:LYTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:LYTitleButtonDidRepeatClickNotification object:nil];
    
}

#pragma mark -- 监听方法
/** 重复点击tabBar上的某个按钮 */
- (void)tabBarButtonDidRepeatClick {
    // 控制器的view不在窗口上时直接返回
    if (self.view.window == nil) return;
    
    // 判断是否在窗口上【坐标系转换】
    CGRect viewRect = [self.view convertRect:self.view.bounds toView:nil];
    CGRect windowRect = self.view.window.bounds;
    // 当前view没有显示在window边框范围内
    if (!CGRectIntersectsRect(viewRect, windowRect)) return;
    // 在就刷新
    [self.tableView.mj_header beginRefreshing];
}

/** 重复点击titleView上的某个按钮 */
- (void)titleButtonDidRepeatClick {
    [self tabBarButtonDidRepeatClick];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

/** 参数a */
- (NSString *)paramA {
    if ([self.parentViewController isKindOfClass:[LYNewViewController class]]) {
        return @"newlist";
    }
    
    return @"list";
}

- (void)loadMoreTopics {
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.paramA;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
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
    params[@"a"] = self.paramA;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYCommentViewController *comment = [[LYCommentViewController alloc] init];
    comment.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
    
}



@end
