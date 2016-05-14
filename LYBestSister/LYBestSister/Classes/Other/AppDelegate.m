//
//  AppDelegate.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "AppDelegate.h"
#import "LYTabBarController.h"


@interface AppDelegate ()<UITabBarControllerDelegate>

/** 记录XMGTabBarController上一次选中的位置 */
@property (nonatomic, assign) NSUInteger previousSelectedIndex;

@end

@implementation AppDelegate

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 重复点击了
    if (self.previousSelectedIndex == tabBarController.selectedIndex) {
        
        // 【发送通知】重复点击了tabBar上的某个按钮
        [[NSNotificationCenter defaultCenter] postNotificationName:LYTabBarButtonDidRepeatClickNotification object:nil];
        
    }
    
    // 记录当前的选中索引
    self.previousSelectedIndex = tabBarController.selectedIndex;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.设置窗口根控制器
    LYTabBarController *tabBarController = [[LYTabBarController alloc] init];
    tabBarController.delegate = self;
    
    self.window.rootViewController = tabBarController;
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    // 4.显示【盖住状态栏的控制器】
    [LYStatusBarViewController show];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
