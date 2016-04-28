//
//  LYNavigationController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/18.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYNavigationController.h"

@interface LYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - 拦截整个push过程，拿到当前push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 隐藏当前控制器的导航条
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [backButton sizeToFit];
        // 监听点击
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    // 将当前控制器压入栈
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate

/** 决定pop手势是否可用*/
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return self.viewControllers.count > 1;
}


@end
