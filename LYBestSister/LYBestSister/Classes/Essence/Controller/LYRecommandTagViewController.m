//
//  LYRecommandTagViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/19.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRecommandTagViewController.h"
#import "LYHTTPSessionManager.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "LYRecommandTag.h"
#import "LYRecommandTagCell.h"

@interface LYRecommandTagViewController ()

/** 所有的标签数据*/
@property (strong, nonatomic) NSArray *recommandTags;
/** 请求管理者*/
@property (weak, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation LYRecommandTagViewController

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


static NSString * const ID = @"recommandTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 标题
    self.title = @"推荐标签";
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = 70;
    // 隐藏cell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LYCommenBackgroundColor;
    
    // 网络请求数据
    [self loadNewRecommandTags];
}

#pragma mark - 网络请求数据
- (void)loadNewRecommandTags {
    
    // 发送请求
    [SVProgressHUD show];
    
    // 使AFN对控制器弱引用
    __weak typeof(self) weakSelf = self;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    // 从iOS9开始, 默认只支持HTTPS请求
    // 如果希望支持HTTP请求,可以在Info.plist中配置
    // NSAppTransportSecurity - Dictionary
    // -- NSAllowsArbitraryLoads - YES
    // 发送请求
    [[LYHTTPSessionManager manager] GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // JSON数组转模型数组
        weakSelf.recommandTags = [LYRecommandTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 隐藏
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果因为取消所有请求执行到这里，直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        
        // 隐藏
        [SVProgressHUD dismiss];
        
        // 提示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

//- (void)dealloc {
//    LYLogFuc
//}

#pragma mark - 控制器view即将消失的时候调用
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 隐藏
    [SVProgressHUD dismiss];
    
    // 取消当前所有请求
    [self.manager invalidateSessionCancelingTasks:YES];
    
    // 取消当前请求
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommandTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYRecommandTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.recommandTag = self.recommandTags[indexPath.row];
    
    return cell;
}
@end
