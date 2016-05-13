//
//  LYCommentHeaderView.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/13.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYCommentHeaderView.h"

@interface LYCommentHeaderView ()

/** Label */
@property (nonatomic, weak) UILabel *label;

@end

@implementation LYCommentHeaderView

#pragma mark - 初始化
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LYCommenBackgroundColor;
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
        label.x = 10;
        label.width = 100;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor darkGrayColor];
        self.label = label;
    }
    
    return self;
}

#pragma mark - set方法
- (void)setText:(NSString *)text {
    _text = [text copy];
    
    self.label.text = text;
}

@end
