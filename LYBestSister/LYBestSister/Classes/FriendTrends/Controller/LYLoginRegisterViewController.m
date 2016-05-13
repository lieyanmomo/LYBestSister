//
//  LYLoginRegisterViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/19.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYLoginRegisterViewController.h"

@interface LYLoginRegisterViewController ()

@end

@implementation LYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [LYStatusBarViewController shareLYStatusBarViewController].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [LYStatusBarViewController shareLYStatusBarViewController].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - 设置状态栏样式
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
