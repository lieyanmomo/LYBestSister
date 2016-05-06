//
//  LYTopicCenterView.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/6.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopicCenterView.h"
#import "LYSeeBigViewController.h"

@interface LYTopicCenterView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LYTopicCenterView

/** 创建方法 */
+ (instancetype)centerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

#pragma mark - 初始化
- (void)awakeFromNib {
    // 防止自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 监听图片点击【添加收拾】
    self.imageView.userInteractionEnabled = YES; // 是图片可以点击【默认imageView不可以点击】
    // 添加【点击手势】
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

#pragma mark -- 图片点击方法
- (void)imageClick {
    if (self.imageView.image == nil) return;
    
    LYSeeBigViewController *seeBig = [[LYSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil
     ];
}

@end
