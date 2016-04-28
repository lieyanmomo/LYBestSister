//
//  LYMeSquareButton.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYMeSquareButton.h"
#import "LYMeSquare.h"
#import <UIButton+WebCache.h>

@implementation LYMeSquareButton

#pragma mark - 创建按钮调用这个方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        // 使文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark -- 布局Button中的子控件位置
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.y = self.height * 0.1;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

#pragma mark - 重写set方法为按钮赋值
- (void)setSquare:(LYMeSquare *)square {
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage cricleImageWithName:@"defaultUserIcon"]];
}

@end
