//
//  LYPLaceholderTextView.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/15.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPLaceholderTextView.h"

@implementation LYPLaceholderTextView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认占位文字颜色
        self.placeholderTextColor = [UIColor grayColor];
        
        // 当文字发生改变时【通知】监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}



#pragma mark - 监听通知实现方法
- (void)textDidChange:(NSNotification *)note {
    // 重新调用【drawRect:】方法
    [self setNeedsDisplay];
}

- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 每次调用drawRect:方法，都会将以前画的东西清除掉

- (void)drawRect:(CGRect)rect {
    
    // 如果有文字直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderTextColor;
    
    // 【画】文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholderText drawInRect:rect withAttributes:attrs];
    
    
}

#pragma mark - 重新布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

#pragma mark - set方法
/** 占位文字 */
- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = [placeholderText copy];
    
    [self setNeedsDisplay];
}

/** 占位文字颜色 */
- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    
    [self setNeedsDisplay];
}

/** 字体 */
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    [self setNeedsDisplay];
}

/** 文本 */
- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self setNeedsDisplay];
}

/** 富文本 */
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}



@end
