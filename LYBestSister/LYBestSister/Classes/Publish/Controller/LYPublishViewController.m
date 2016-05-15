//
//  LYPublishViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/14.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPublishViewController.h"
#import "LYPublishButton.h"
#import <POP.h>
#import "LYNavigationController.h"
#import "LYPostWordViewController.h"

@interface LYPublishViewController ()

/** 标语 */
@property (nonatomic, weak) UIImageView *sloganView;

/** 动画时间 */
@property (nonatomic, strong) NSArray *times;

/** 按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation LYPublishViewController

static CGFloat const LYSpringFactor = 10;


#pragma mark - 懒加载

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    
    return _buttons;
}


- (NSArray *)times
{
    if (!_times) {
        CGFloat interval = 0.1; // 时间间隔
        _times = @[@(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(0 * interval),
                   @(1 * interval),
                   @(6 * interval)]; // 标语的动画时间
    }
    return _times;
}


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    
    // 设置标语
    [self setupSloganView];
    
    // 设置button
    [self setupButton];
    
    
}

#pragma mark -- 设置button
- (void)setupButton {
    // 按钮数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 一些参数
    NSUInteger count = images.count;
    int maxColsCount = 3; // 一行的列数
    NSUInteger rowsCount = (count + maxColsCount - 1) / maxColsCount;
    
    // 按钮尺寸
    CGFloat buttonW = LYScreenW / maxColsCount;
    CGFloat buttonH = buttonW * 0.85;
    CGFloat buttonStartY = (LYScreenH - rowsCount * buttonH) * 0.5;
    for (int i = 0; i < count; i++) {
        // 创建、添加
        LYPublishButton *button = [LYPublishButton buttonWithType:UIButtonTypeCustom];
        button.width = -1; // 按钮的尺寸为0，还是能看见文字缩成一个点，设置按钮的尺寸为负数，那么就看不见文字了
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        
        [self.view addSubview:button];
        
        
        // 内容
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        // frame
        CGFloat buttonX = (i % maxColsCount) * buttonW;
        CGFloat buttonY = buttonStartY + (i / maxColsCount) * buttonH;
        
        // 动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - LYScreenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anim.springSpeed = LYSpringFactor;
        anim.springBounciness = LYSpringFactor;
        // CACurrentMediaTime()获得的是当前时间
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button pop_addAnimation:anim forKey:nil];

    }

}

#pragma mark -- 设置标语
- (void)setupSloganView {
    
    CGFloat sloganY = LYScreenH * 0.2;
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = sloganY - LYScreenH;
    sloganView.centerX = LYScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    
    __weak typeof(self) weakSelf = self;

    // 动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(sloganY);
    anim.springSpeed = LYSpringFactor;
    anim.springBounciness = LYSpringFactor;
    // CACurrentMediaTime()获得的是当前时间
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // view开始交互
        weakSelf.view.userInteractionEnabled = YES;
    }];
    
    [sloganView.layer pop_addAnimation:anim forKey:nil];

}


#pragma mark - 退出动画
- (void)quit:(void(^)())task {
    // 禁止交互
    self.view.userInteractionEnabled = NO;
    
    // 让按钮执行动画
    for (int i = 0; i < self.buttons.count; i++) {
        LYPublishButton *button = self.buttons[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(button.layer.position.y + LYScreenH);
        // CACurrentMediaTime()获得的是当前时间
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button.layer pop_addAnimation:anim forKey:nil];
    }
    
    
    
    __weak typeof(self) weakSelf = self;
    
    // 让标题执行动画
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganView.layer.position.y + LYScreenH);
    // CACurrentMediaTime()获得的是当前时间
    anim.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        
        if (task) task();
    
    }];
    [self.sloganView.layer pop_addAnimation:anim forKey:nil];
}

#pragma mark - 点击按钮调用方法
- (void)buttonClick:(LYPublishButton *)button {
   
    [self quit:^{
        // 按钮索引
        NSInteger index = [self.buttons indexOfObject:button];
        
        switch (index) {
            case 2: { // 发布按钮
                // 弹出发段子控制器
                LYPostWordViewController *postWordVc = [[LYPostWordViewController alloc] init];
                [self.view.window.rootViewController presentViewController:[[LYNavigationController alloc] initWithRootViewController:postWordVc] animated:YES completion:nil];
                
                break;
                
            }
                
            default:
                LYLog(@"其他");
                break;
        }
        
    }];
    
}

#pragma mark - 点击【取消】按钮调用方法
- (IBAction)cancel {
    
    [self quit:nil];
    
}

#pragma mark - 点击控制器View调用方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self quit:nil];
}

@end
