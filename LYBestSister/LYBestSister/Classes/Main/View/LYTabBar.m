//
//  LYTabBar.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/17.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTabBar.h"

@interface LYTabBar ()

/** 发布按钮*/
@property (weak, nonatomic) UIButton *publishButton;

@end

@implementation LYTabBar

/*
 一个控件显示不出来的可能原因:
 1.hidden = YES
 2.alpha <= 0.01
 3.没有被添加到屏幕上
 4.没有尺寸
 5.位置不对
 6.可能被其他控件挡住了
 7.文字颜色\背景色跟父控件背景色一致
 8.父控件有1\2\3\6行为
 */

#pragma mark - 初始化
/** 创建发布按钮*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        // 设置按钮
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"
                                 ] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton sizeToFit];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

/** 布局子控件位置*/
- (void)layoutSubviews
{
    // 父类先布局子控件
    [super layoutSubviews];
    
    // TabBar的尺寸
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    // 发布按钮的中心点
    self.publishButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    // tabBar上按钮尺寸
    CGFloat buttonH = h;
    CGFloat buttonW = w / 5.0;
    CGFloat buttonY = 0;
    
    // 按钮索引
    int index = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        
        NSString *className = NSStringFromClass(tabBarButton.class);
        if (![className isEqualToString:@"UITabBarButton"]) continue;
        
        // 按钮的位置
        CGFloat buttonX = index * buttonW;
        if (index >= 2) {
            buttonX += buttonW;
        }
        tabBarButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
    
}

@end
