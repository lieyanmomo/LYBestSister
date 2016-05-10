//
//  LYRefreshAutoFooter.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/30.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRefreshAutoFooter.h"

@implementation LYRefreshAutoFooter

- (void)prepare {
    [super prepare];
    
    // 添加开关
//    [self addSubview:[[UISwitch alloc] init]];
    
    // 设置底部显示高度再刷新
    self.triggerAutomaticallyRefreshPercent = 3;
}

@end
