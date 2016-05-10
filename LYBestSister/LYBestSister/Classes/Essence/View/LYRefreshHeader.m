//
//  LYRefreshHeader.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/29.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRefreshHeader.h"

@implementation LYRefreshHeader

#pragma mark - 重写这个方法决定刷新样式
- (void)prepare {
    [super prepare];
    
    // 将刷新中添加开关
//    [self addSubview:[[UISwitch alloc] init]];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    // 更改刷新显示文字
    [self setTitle:@"下拉开始刷新🌲" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新❀" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新...🏠" forState:MJRefreshStateRefreshing];
    
    // 自动调整透明度x（显示文字透明度）
    self.automaticallyChangeAlpha = YES;
}
@end
