//
//  UITextField+LYExtension.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/16.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "UITextField+LYExtension.h"

/** 占位文字颜色 */
static NSString * const LYPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (LYExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    BOOL change = NO;
    
    // 保证有占位文字
    if (self.placeholder == nil) {
        self.placeholder = @" ";
        change = YES;
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:LYPlaceholderColorKey];
    
    // 恢复原状
    if (change) {
        self.placeholder = nil;
    }
}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:LYPlaceholderColorKey];
}
@end
