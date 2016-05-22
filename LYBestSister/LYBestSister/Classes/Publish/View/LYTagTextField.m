//
//  LYTagTextField.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/22.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTagTextField.h"

@implementation LYTagTextField

- (void)deleteBackward {
    
    // 执行block
    !self.deleteBackwardOperation ? : self.deleteBackwardOperation();
    
    [super deleteBackward];
    
}

@end
