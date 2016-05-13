//
//  LYStatusBarViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/13.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYStatusBarViewController.h"
#import "LYSingleton.h"

@interface LYStatusBarViewController ()

@end

@implementation LYStatusBarViewController

#pragma mark - 单利
implementationSingleton(LYStatusBarViewController)

#pragma mark - window的相关处理
static UIWindow *window_;

+ (void)show {
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor clearColor];
    window_.frame = [UIApplication sharedApplication].statusBarFrame;
    // 默认是隐藏的
    window_.hidden = NO;
    // 窗口的级别
    window_.windowLevel = UIWindowLevelAlert;
    // iOS9开始创建窗口【必须有根控制器】--没有就crash
    window_.rootViewController = [[LYStatusBarViewController alloc] init];
    
    /*
     窗口级别:
     UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
     */
}

#pragma mark - 控制状态栏
- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

#pragma mark - setter
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    // 刷新状态栏 (内部会重新调用prefersStatusBarHidden和preferredStatusBarStyle方法)
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    
    // 刷新状态栏 (内部会重新调用prefersStatusBarHidden和preferredStatusBarStyle方法)
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 点击方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 拿到当前窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 让scrollView滚到最前面
    [self searchScrollViewInView:window];
}

/** 在view中搜索所有的scrollView */
- (void)searchScrollViewInView:(UIView *)view {
    
    // 遍历所有子控件
    for (UIView *subView in view.subviews) {
        [self searchScrollViewInView:subView];
    }
    
    // 如果是一个UIScrollView, 就进行滚动处理
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        
        // 计算出scrollView 以window左上角为坐标原点时的rect
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:nil];
        CGRect windowRect = scrollView.window.bounds;
        
        // 判断scrollView 跟 window 是否有重叠
        if (!CGRectIntersectsRect(windowRect, scrollViewRect)) return;
        
        // 滚动到最前面
        CGPoint offset = scrollView.contentOffset;
        offset.y = - scrollView.contentInset.top;
        [scrollView setContentOffset:offset animated:YES];
    }
    
}





@end
