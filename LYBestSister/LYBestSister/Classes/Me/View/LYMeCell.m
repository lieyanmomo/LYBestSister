//
//  LYMeCell.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYMeCell.h"

@implementation LYMeCell

#pragma mark - 通过代码创建的cell调用这个方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    // 禁止选中变灰
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

#pragma mark - 重新布局子控件调用这个方法
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 如果没有图片 直接退出
    if (self.imageView.image == nil) return;
    
    self.imageView.height = self.contentView.height - LYMargin;
    self.imageView.width = self.imageView.height;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    // 标题
    self.textLabel.x = self.imageView.right + LYMargin;
}

@end
