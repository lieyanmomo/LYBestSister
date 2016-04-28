//
//  LYFooterView.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYFooterView.h"
#import "LYHTTPSessionManager.h"
#import "LYMeSquare.h"
#import <MJExtension.h>
#import "LYMeSquareButton.h"
#import "LYWebViewController.h"


@implementation LYFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        __weak typeof(self) weakSelf = self;
        
        // 请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[LYHTTPSessionManager manager] GET:LYRequestURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 字典数组转模型数组
            NSArray *squares = [LYMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            // 根据模型数组创建方块
            [weakSelf createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }
    return self;
}

#pragma mark - 根据模块数据创建方块
- (void)createSquares:(NSArray *)squares {
    // 一共多少列
    int columnsCount = 4;
    // 一共多少块
    NSUInteger count = squares.count;
    
    CGFloat buttonW = self.width / columnsCount;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < count; i++) {
        LYMeSquareButton *button = [LYMeSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听按钮点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.width = buttonW;
        button.height = buttonH;
        button.x = (i % columnsCount) * buttonW;
        button.y = (i / columnsCount) * buttonH;
        
        // 设置数据
        button.square = squares[i];
       
        
    }
    
    // 总行数 = （总个数 + 每行的最大个数 - 1）/ 每行的最大个数
//    NSUInteger rowsCount = (count + columnsCount - 1) / columnsCount;
//    // footView的高度
//    self.height = rowsCount * buttonH;
//    
    self.height = self.subviews.lastObject.bottom;
    
    // 设置footer
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    
    // 或者
//    tableView.contentSize = CGSizeMake(0, self.bottom);
    
}

#pragma mark -- 监听按钮点击
- (void)buttonClick:(LYMeSquareButton *)button {
    
    // 连接
    NSString *url = button.square.url;
    
    if ([url hasPrefix:@"mod://"]) {
        LYLog(@"跳转到mod://网页");
    }else if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]){
        UITabBarController *rootVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *naVc = rootVc.selectedViewController;
        
        // push
        LYWebViewController *web = [[LYWebViewController alloc] init];
        web.url = url;
        web.navigationItem.title = button.square.name;
        [naVc pushViewController:web animated:YES];
        
        
    }else{
        LYLog(@"其他页面");
    }
}

@end
