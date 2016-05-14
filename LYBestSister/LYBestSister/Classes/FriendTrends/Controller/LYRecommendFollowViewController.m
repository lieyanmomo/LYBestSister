//
//  LYRecommendFollowViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRecommendFollowViewController.h"
#import "LYHTTPSessionManager.h"
#import "LYRecommendCategory.h"
#import "LYRecommendUser.h"
#import "LYRecommendCatorgayCell.h"
#import "LYRecommendUserCell.h"
#import <MJExtension.h>
#import "LYRefreshHeader.h"
#import "LYRefreshAutoFooter.h"
#import <SVProgressHUD.h>

@interface LYRecommendFollowViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;

@property (weak, nonatomic) IBOutlet UITableView *userTable;

/** 请求管理者*/
@property (nonatomic, weak) LYHTTPSessionManager *manager;
/** 类别数据 */
@property (nonatomic, strong) NSArray<LYRecommendCategory *> *recommendCategories;

@end

@implementation LYRecommendFollowViewController

/** 重用标识符 */
static NSString * const LYRecommendCategoryId = @"catorgayCell";
static NSString * const LYRecommendUserId = @"userCell";

#pragma mark - 懒加载
/** 请求管理者 */
- (LYHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [LYHTTPSessionManager manager];
    }
    return _manager;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景颜色
    self.view.backgroundColor = LYCommenBackgroundColor;

    
    // 设置tableView
    [self setupTableView];
    
    // 加载左边数据
    [self loadCatorgies];
}

#pragma mark - 设置tableView
- (void)setupTableView {
    
    UIEdgeInsets inset = UIEdgeInsetsMake(LYNavigationBarBottom, 0, 0, 0);
    self.categoryTable.contentInset = inset;
    self.categoryTable.scrollIndicatorInsets = inset;
    // 去除cell间的分割线
    self.categoryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.userTable.contentInset = inset;
    self.userTable.scrollIndicatorInsets = inset;
    self.userTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 下拉刷新
    self.userTable.mj_header = [LYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    // 上拉刷新
    self.userTable.mj_footer = [LYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 加载数据
/** 加载更多数据 */
- (void)loadMoreUsers {
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 当前选中模型
    LYRecommendCategory *recommendCategory = self.recommendCategories[self.categoryTable.indexPathForSelectedRow.row];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = recommendCategory.id;
    NSInteger page = recommendCategory.page + 1;
    params[@"page"] = @(page);
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 【新页码】
        recommendCategory.page = page;
        
        // 字典数组转模型数组
        NSArray *moreUsers = [LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [recommendCategory.users addObjectsFromArray:moreUsers];
        
        // 【总数】
        recommendCategory.total = [responseObject[@"total"] integerValue];
        
        // 刷新用户表格
        [weakSelf.userTable reloadData];
        
        if (recommendCategory.users.count == recommendCategory.total) {
            weakSelf.userTable.mj_footer.hidden = YES;
        } else {
            // 结束下拉刷新
            [weakSelf.userTable.mj_footer endRefreshing];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束下拉刷新
        [weakSelf.userTable.mj_footer endRefreshing];
        
    }];
}


/** 加载最新数据 */
- (void)loadNewUsers {
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    // 当前选中模型
    LYRecommendCategory *recommendCategory = self.recommendCategories[self.categoryTable.indexPathForSelectedRow.row];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = recommendCategory.id;
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 每一次请求重新赋值【页码】
        recommendCategory.page = 1;
        
       // 字典数组转模型数组
        recommendCategory.users = [LYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 【总数】
        recommendCategory.total = [responseObject[@"total"] integerValue];
        
        // 刷新用户表格
        [weakSelf.userTable reloadData];
        
        // 结束下拉刷新
        [weakSelf.userTable.mj_header endRefreshing];
        
        if (recommendCategory.users.count == recommendCategory.total) {
            weakSelf.userTable.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束下拉刷新
        [weakSelf.userTable.mj_header endRefreshing];
        
    }];
}

/** 加载左边数据 */
- (void)loadCatorgies {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数组转模型数组
        weakSelf.recommendCategories = [LYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新数据
        [weakSelf.categoryTable reloadData];
        
        // 选中第0行
        [weakSelf.categoryTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [weakSelf.userTable.mj_header beginRefreshing];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UITableViewDataSource
/** 每组有几行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTable) { // 类别表格
        return self.recommendCategories.count;
        
    } else { // 用户表格
        // 当前选中模型
        LYRecommendCategory *recommendCategory = self.recommendCategories[self.categoryTable.indexPathForSelectedRow.row];
        return recommendCategory.users.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTable) { // ⬅️
        
        LYRecommendCatorgayCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRecommendCategoryId];
        
        cell.recommendCategory = self.recommendCategories[indexPath.row];
        
        return cell;
    } else {
        
        LYRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LYRecommendUserId];
        
        // 当前选中模型
        LYRecommendCategory *recommendCategory = self.recommendCategories[self.categoryTable.indexPathForSelectedRow.row];
        
        cell.user = recommendCategory.users[indexPath.row];
        
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.categoryTable) { // 类别表格
        
        LYRecommendCategory *recommendCategory = self.recommendCategories[indexPath.row];
        if (recommendCategory.users.count == 0) {
            // 取消之前的请求
            [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
            
            // 刷新右面表格
            [self.userTable.mj_header beginRefreshing];
        }
        
        // 刷新【用户数据】
        [self.userTable reloadData];
        
        if (recommendCategory.users.count == recommendCategory.total) {
            self.userTable.mj_footer.hidden = YES;
        }
        
    } else {
        
        LYLog(@"→%zd", indexPath.row);
        
    }
}

@end
