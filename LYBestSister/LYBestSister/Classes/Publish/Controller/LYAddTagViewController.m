//
//  LYAddTagViewController.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/16.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYAddTagViewController.h"
#import "LYTagButton.h"
#import "LYTagTextField.h"
#import <SVProgressHUD.h>

@interface LYAddTagViewController ()<UITextFieldDelegate>

/** 设置容纳所有按钮和文本框的contentView */
@property (nonatomic, weak) UIView *contentView;
/** 文本框 */
@property (nonatomic, weak) LYTagTextField *textField;
/** 提醒按钮 */
@property (nonatomic, weak) UIButton *tipButton;

/** 存放所有标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation LYAddTagViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagButtons {
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    
    return _tagButtons;
}



- (UIButton *)tipButton {
    if (!_tipButton) {
        UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tipButton addTarget:self action:@selector(tipClick) forControlEvents:UIControlEventTouchUpInside];
        tipButton.x = 0;
        tipButton.width = self.contentView.width;
        tipButton.height = LYTagH;
        tipButton.backgroundColor = LYColor(70, 142, 243);
        tipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        tipButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        tipButton.contentEdgeInsets = UIEdgeInsetsMake(0, LYMargin, 0, 0);
        [self.contentView addSubview:tipButton];
        _tipButton = tipButton;
    }
    
    return _tipButton;
}



#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置navigationBar
    [self setupNavigationBar];
    
    // 设置容纳所有按钮和文本框的contentView
    [self setupContentView];
    
    // textField
    [self setupTextField];
    
    // 初始化标签
    [self setupTag];
}


#pragma mark -- 设置初始化【标签】
- (void)setupTag {
    
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self tipClick];
    }
}

#pragma mark -- 设置容纳所有按钮和文本框的contentView
- (void)setupContentView {
    UIView *contentView = [[UIView alloc] init];
    contentView.x = LYMargin;
    contentView.y = LYNavigationBarBottom;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
}




#pragma mark -- 设置textField
- (void)setupTextField {
    
    __weak typeof(self) weakSelf = self;
    
    LYTagTextField *textField = [[LYTagTextField alloc] init];
    
    // 时刻监听 textField 的 change
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    textField.width = self.contentView.width;
    textField.height = LYTagH;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.placeholderColor = [UIColor grayColor];
    
    textField.delegate = self;
    
    [self.contentView addSubview:textField];
    // 刚进入【键盘就显示】
    [textField becomeFirstResponder];
    // 刷新的前提【这个控件已经被添加到父控件】--【处理光标显示的问题】
    [textField layoutIfNeeded];
    
    self.textField = textField;
    
    textField.deleteBackwardOperation = ^{
        // 判断文本框是否有文字
        if (weakSelf.textField.hasText || weakSelf.tagButtons.count == 0) return;
        
        // 点击删除最后一个按钮
        [weakSelf tagClick:weakSelf.tagButtons.lastObject];
    };
    
    
}

#pragma mark -- 设置NavigationBar
- (void)setupNavigationBar {
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    // 开始不可以点击
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 强制更新【马上更新现在状态】
    [self.navigationController.navigationBar layoutIfNeeded];
}


#pragma mark - 设置Frame
#pragma mark -- 设置【标签按钮】frame
- (void)setupTagButton:(LYTagButton *)tagButton referenceTagButton:(LYTagButton *)referenceTagButton {
    // 没有参照按钮（tagButton是第一个标签按钮）
    if (referenceTagButton == nil) {
        tagButton.x = 0;
        tagButton.y = 0;
        return;
    }
    
    // tagButton不是第一个标签按钮
    CGFloat leftWidth = CGRectGetMaxX(referenceTagButton.frame) + LYMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (rightWidth >= tagButton.width) { // 跟上一个标签按钮处在同一行
        tagButton.x = leftWidth;
        tagButton.y = referenceTagButton.y;
    } else { // 下一行
        tagButton.x = 0;
        tagButton.y = CGRectGetMaxY(referenceTagButton.frame) + LYMargin;
    }
}

#pragma mark -- 设置【文本框】frame
- (void)setupTextFieldFrame
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    textW = MAX(100, textW);
    
    LYTagButton *lastTagButton = self.tagButtons.lastObject;
    if (lastTagButton == nil) {
        self.textField.x = 0;
        self.textField.y = 0;
    } else {
        CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LYMargin;
        CGFloat rightWidth = self.contentView.width - leftWidth;
        if (rightWidth >= textW) { // 跟新添加的标签按钮处在同一行
            self.textField.x = leftWidth;
            self.textField.y = lastTagButton.y;
        } else { // 换行
            self.textField.x = 0;
            self.textField.y = CGRectGetMaxY(lastTagButton.frame) + LYMargin;
        }
    }
    
    // 排布提醒按钮
    self.tipButton.y = CGRectGetMaxY(self.textField.frame) + LYMargin;
}


#pragma mark - 监听

#pragma mark -- 监听【标签按钮】的点击
- (void)tipClick {
    
    if (self.textField.hasText == NO) return;
    
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        return;
    }
    
    // 创建按钮
    LYTagButton *newTagButton = [LYTagButton buttonWithType:UIButtonTypeCustom];
    [newTagButton setTitle:self.textField.text forState:UIControlStateNormal];
    // 监听
    [newTagButton addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:newTagButton];
    
    // 设置位置--以最后一个按钮作为参照
    [self setupTagButton:newTagButton referenceTagButton:self.tagButtons.lastObject];
    
    [self.tagButtons addObject:newTagButton];
    
    
    
    // 文本框的位置
    [self setupTextFieldFrame];
    
    self.textField.text = nil;
    
    // 隐藏提醒按钮
    self.tipButton.hidden = YES;
    
}

#pragma mark -- 【标签按钮】点击
- (void)tagClick:(LYTagButton *)deleteButton {
    // 将要删除按钮【索引】
    NSUInteger index = [self.tagButtons indexOfObject:deleteButton];
    
    // 删除按钮
    [deleteButton removeFromSuperview];
    [self.tagButtons removeObject:deleteButton];
    
    // 处理后面的按钮
    for (NSUInteger i = index ; i < self.tagButtons.count; i++) {
        LYTagButton *tagButton = self.tagButtons[i];
        // 如果不是第0个按钮就参照上一个标签
        LYTagButton *previousTagButton = (i == 0) ? nil : self.tagButtons[i - 1];
        [self setupTagButton:tagButton referenceTagButton:previousTagButton];
    }
    
    // 排布文本框
    [self setupTextFieldFrame];
}

#pragma mark -- 【textField】的【change】
- (void)textDidChange {
    // 提示按钮
    if (self.textField.hasText) {
        
        NSString *text = self.textField.text;
        NSString *lastChar = [text substringFromIndex:text.length - 1];
        if ([lastChar isEqualToString:@","] || [lastChar isEqualToString:@"，"]) { // 最后输入为逗号【，】
            
            self.textField.text = [text substringToIndex:text.length - 1];
            
            // 点击提醒按钮
            [self tipClick];
            
        } else {
            [self setupTextFieldFrame];
            
            self.tipButton.hidden = NO;
            self.tipButton.y = CGRectGetMaxY(self.textField.frame) + LYMargin;
            [self.tipButton setTitle:[NSString stringWithFormat:@"添加标签 : %@", self.textField.text] forState:UIControlStateNormal];
        }
        
        
        
    } else {
        
        self.tipButton.hidden = YES;
        
    }

}

#pragma mark -- 点击【取消】按钮实现方法
- (void)cancle {
    // 让整个view取消第一响应者，从而让所有控件的键盘隐藏
//    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 点击【完成】按钮调用方法
- (void)done {
    // 1.将self.tagButtons中存放的所有对象的currentTitle属性值取出来，放到一个新的数组中，并返回
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.getTagsBlock ? : self.getTagsBlock(tags);
    
    // 2.关闭当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate
/** 点击键盘右下角【return】调用这个方法 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self tipClick];
    return YES;
}


@end
