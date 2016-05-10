//
//  LYRecommendCatorgayCell.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRecommendCatorgayCell.h"
#import "LYRecommendCategory.h"

@interface LYRecommendCatorgayCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation LYRecommendCatorgayCell

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = LYGrayColor(237);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) { // 选中cell
        self.nameLabel.textColor = [UIColor redColor];
        self.selectedIndicator.hidden = NO;
    } else {
        self.nameLabel.textColor = [UIColor darkGrayColor];
        self.selectedIndicator.hidden = YES;
    }
}

#pragma mark - 重写set方法
- (void)setRecommendCategory:(LYRecommendCategory *)recommendCategory {
    
    _recommendCategory = recommendCategory;
    
    self.nameLabel.text = recommendCategory.name;
    
}

@end
