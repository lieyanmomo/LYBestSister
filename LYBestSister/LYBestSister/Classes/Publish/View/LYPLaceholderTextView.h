//
//  LYPLaceholderTextView.h
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/15.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPLaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholderText;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end
