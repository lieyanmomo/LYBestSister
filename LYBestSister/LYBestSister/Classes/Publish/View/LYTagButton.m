//
//  LYTagButton.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/18.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTagButton.h"

@implementation LYTagButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 自动计算
    [self sizeToFit];
    
    // 微调
    self.height = LYTagH;
    self.width += 3 * LYMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = LYMargin;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + LYMargin;
}
@end
