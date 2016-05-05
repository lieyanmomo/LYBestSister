//
//  LYSeeBigViewController.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/5.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYSeeBigViewController.h"
#import "LYTopic.h"
#import <UIImageView+WebCache.h>

@interface LYSeeBigViewController ()<UIScrollViewDelegate>

/** 图片控件 */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LYSeeBigViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // 0.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    // 代理
    scrollView.delegate = self;
    // 插入到view中
    [self.view insertSubview:scrollView atIndex:0];
    
    // 1.添加imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    // 为imageView赋值
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.width = scrollView.width;
    imageView.height = self.topic.height *imageView.width / self.topic.width;
    imageView.x = 0;
    if (imageView.height >= scrollView.height) { // 大于屏幕高度
        imageView.y = 0;
    } else {
        imageView.centerY = scrollView.height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 滚动范围
    scrollView.contentSize = CGSizeMake(0, imageView.height);
    
    // 缩放比例
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
    }
}

#pragma mark - 返回
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 保存
- (IBAction)saveClick:(id)sender {
    
}


#pragma mark - UIScrollViewDelegate
/** 返回scrollView内部子控件缩放 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
