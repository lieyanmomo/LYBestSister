//
//  LYPostWordViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/14.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPostWordViewController.h"
#import "LYPLaceholderTextView.h"

@interface LYPostWordViewController ()<UITextViewDelegate>

/** 文本框 */
@property (nonatomic, weak) LYPLaceholderTextView *placeholderTextView;

@end

@implementation LYPostWordViewController


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    // 设置textView
    [self setupTextView];
}


#pragma mark -- 点击取消按钮实现方法
- (void)cancle {
    // 让整个view取消第一响应者，从而让所有控件的键盘隐藏
    [self.view endEditing:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置【TextView】
- (void)setupTextView {
    LYPLaceholderTextView *placeholderTextView = [[LYPLaceholderTextView alloc] init];
    placeholderTextView.frame = self.view.bounds;
    // 无论内容有多少竖直方向永远能够拖拽
    placeholderTextView.alwaysBounceVertical = YES;
    placeholderTextView.delegate = self;
    placeholderTextView.placeholderText = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    
    [self.view addSubview:placeholderTextView];
    self.placeholderTextView = placeholderTextView;
    
}

#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

@end
