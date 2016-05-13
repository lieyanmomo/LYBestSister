//
//  LYStatusBarViewController.h
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/13.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSingleton.h"


@interface LYStatusBarViewController : UIViewController

+ (void)show;

interfaceSingleton(LYStatusBarViewController);

/** 状态的显示和隐藏 */
@property (nonatomic, assign, getter=isStatusBarHidden) BOOL statusBarHidden;
/** 状态栏的样式 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;


@end
