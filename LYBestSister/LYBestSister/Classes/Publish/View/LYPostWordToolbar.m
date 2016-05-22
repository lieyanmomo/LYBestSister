//
//  LYPostWordToolbar.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/15.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPostWordToolbar.h"
#import "LYNavigationController.h"
#import "LYAddTagViewController.h"

@interface LYPostWordToolbar ()


@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation LYPostWordToolbar

/** 创建xib的类方法 */
+ (instancetype)toolbarFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


#pragma mark - 初始化
- (void)awakeFromNib {
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    // 监听【点击】
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:addButton];
}

#pragma mark - 监听

#pragma mark -- 点击【加号按钮】
- (void)addClick {
    
    LYAddTagViewController *addTagC = [[LYAddTagViewController alloc] init];
    LYNavigationController *nagivationC = [[LYNavigationController alloc] initWithRootViewController:addTagC];
    
    // 获得【窗口根控制器】曾经modal出【发表文字】的导航控制器
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    [vc presentViewController:nagivationC animated:YES completion:nil];
    
}


@end
