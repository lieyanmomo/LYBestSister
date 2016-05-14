//
//  LYPublishButton.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/14.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYPublishButton.h"

@implementation LYPublishButton

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return self;
}

/** 布局 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width *0.5;
    
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
