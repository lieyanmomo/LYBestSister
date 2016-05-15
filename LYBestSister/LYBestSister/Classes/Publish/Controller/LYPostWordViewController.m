//
//  LYPostWordViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/14.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPostWordViewController.h"
#import "LYPLaceholderTextView.h"
#import "LYPostWordToolbar.h"

@interface LYPostWordViewController ()<UITextViewDelegate>

/** 文本框 */
@property (nonatomic, weak) LYPLaceholderTextView *placeholderTextView;
/** 工具条 */
@property (nonatomic, weak) LYPostWordToolbar *toolbar;

@end

@implementation LYPostWordViewController


#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置【navigationBar】
    [self setupNavigationBar];
    
    // 设置textView
    [self setupTextView];
    
    // 设置【Toolbar】
    [self setupToolbar];
}

#pragma mark - 设置【Toolbar】
- (void)setupToolbar {
    LYPostWordToolbar *toolbar = [LYPostWordToolbar toolbarFromXib];
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.width = self.view.width;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 设置【navigationBar】
- (void)setupNavigationBar {
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    // 开始不可以点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 强制更新【马上更新现在状态】
    [self.navigationController.navigationBar layoutIfNeeded];

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

#pragma mark - 监听

#pragma mark -- 点击【取消】按钮实现方法
- (void)cancle {
    // 让整个view取消第一响应者，从而让所有控件的键盘隐藏
    [self.view endEditing:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 点击【发表】按钮调用方法
- (void)post {
    LYLogFuc
}

#pragma mark -- 弹出键盘【工具条随键盘改变】
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 键盘弹出和隐藏时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 工具条平移的距离 == 键盘最终的Y值 - 屏幕高度
        CGFloat ty = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y - LYScreenH;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}

#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 下拉隐藏键盘
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    // 当textView改变的时候，【发表】按钮可以点按
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

@end
