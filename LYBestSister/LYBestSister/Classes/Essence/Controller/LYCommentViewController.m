//
//  LYCommentViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/10.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYCommentViewController.h"
#import "LYHTTPSessionManager.h"
#import "LYTopic.h"
#import "LYComment.h"
#import "LYCommentCell.h"
#import <MJExtension.h>
#import "LYRefreshHeader.h"
#import "LYRefreshAutoFooter.h"
#import "LYCommentHeaderView.h"
#import "LYTopicCell.h"

@interface LYCommentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

/** 请求管理者 */
@property (nonatomic, weak) LYHTTPSessionManager *manager;

/** 最热评论数据 */
@property (nonatomic, strong) NSArray<LYComment *> *hottestComments;
/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<LYComment *> *lastestComments;

/** 最热评论 */
@property (nonatomic, strong) id top_cmt;

@end

@implementation LYCommentViewController

static NSString * const LYCommentCellId = @"comment";
static NSString * const LYHeaderId = @"header";

#pragma mark - 懒加载
- (LYHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [LYHTTPSessionManager manager];
    }
    
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setupBase];
    
    // 设置tableView
    [self setupTableView];
    
    // 设置tableViewHeader
    [self setupTableViewHeader];
}

/** 基本设置 */
- (void)setupBase {
    self.navigationItem.title = @"评论";
    // 弹出键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/** 设置tableView */
- (void)setupTableView {
    
    self.tableView.backgroundColor = LYCommenBackgroundColor;
    self.tableView.sectionHeaderHeight = [UIFont systemFontOfSize:16].lineHeight;
    
    self.tableView.contentInset = UIEdgeInsetsMake(LYNavigationBarBottom, 0, 0, 0);
    
    // 自动计算cell高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYCommentCell class]) bundle:nil] forCellReuseIdentifier:LYCommentCellId];
    
    [self.tableView registerClass:[LYCommentHeaderView class] forHeaderFooterViewReuseIdentifier:LYHeaderId];
    
    // 刷新
    self.tableView.mj_header = [LYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [LYRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
}

/** 设置tableViewHeader */
- (void)setupTableViewHeader {
    
    // 处理模型数据
    if (self.topic.top_cmt) {
        self.top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        self.topic.cellHeight = 0;
    }
    
    // 头部控件
    UIView *headerView = [[UIView alloc] init];
    
    // 将cell添加到headerView中
    LYTopicCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LYTopicCell class]) owner:nil options:nil].lastObject;
    cell.topic = self.topic;
    
    // cell 的 frame
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    
    [headerView addSubview:cell];
    
    headerView.height = cell.height + 2 * LYMargin;
    
    // 设置header
    self.tableView.tableHeaderView = headerView;
    
}

- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 处理模型数据
    if (self.top_cmt) {
        self.topic.top_cmt = self.top_cmt;
        
        self.topic.cellHeight = 0;
    }
}

#pragma mark - 监听键盘通实现方法
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 设置约束
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = [UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y;
    
    // 键盘动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        // 重新布局
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 加载数据
- (void)loadNewComments {
    
    // 防止上拉刷新和下拉刷新同事存在
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"hot"] = @"1";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) { // 没有评论数据
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }

        
        // 字典 -> 模型
        weakSelf.hottestComments = [LYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.lastestComments = [LYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (weakSelf.lastestComments.count == total) { // 没有更多数据
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments {
    // 防止上拉刷新和下拉刷新同事存在
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = self.lastestComments.lastObject.ID;
    
    // 发送请求
    __weak typeof(self) weakSelf = self;
    [self.manager GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) { // 没有评论数据
            
            weakSelf.tableView.mj_footer.hidden = YES;
            return;
        }
        
        
        // 字典 -> 模型
        NSArray *moreComments = [LYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.lastestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (weakSelf.lastestComments.count == total) { // 没有更多数据
            weakSelf.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.hottestComments.count) return 2;
    if (self.lastestComments.count) return 1;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    if (self.hottestComments.count && section == 0) return self.hottestComments.count;
    
    return self.lastestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    LYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LYCommentCellId];
    
    if (self.hottestComments.count && indexPath.section == 0) { // 有最热评论
        cell.comment = self.hottestComments[indexPath.row];
        
    } else {
        cell.comment = self.lastestComments[indexPath.row];
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegat
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 创建header
    LYCommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:LYHeaderId];
    
    if (self.hottestComments.count && section == 0) {
        headerView.text = @"最热评论";
    } else {
        headerView.text = @"最新评论";
    }
    
    return headerView;
}

@end
