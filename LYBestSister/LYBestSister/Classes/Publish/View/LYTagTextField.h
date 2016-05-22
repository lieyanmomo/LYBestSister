//
//  LYTagTextField.h
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/22.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTagTextField : UITextField

/** 点击删除最后一个按钮 */
@property (nonatomic, copy) void (^deleteBackwardOperation)();

@end
