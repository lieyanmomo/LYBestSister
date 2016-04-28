//
//  LYRecommandTagCell.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/19.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRecommandTagCell.h"
#import "LYRecommandTag.h"
#import <UIImageView+WebCache.h>

@interface LYRecommandTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageLastView;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@end

@implementation LYRecommandTagCell

#pragma mark - 重写set方法为控件赋值
- (void)setRecommandTag:(LYRecommandTag *)recommandTag {
    
    _recommandTag = recommandTag;
    
    // 图片
    [self.imageLastView setHeaderImageWithURL:recommandTag.image_list];
    
    // 名字
    self.themeNameLabel.text = recommandTag.theme_name;
    // 订阅数
    if (recommandTag.sub_number <10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%lu人订阅", (unsigned long)recommandTag.sub_number];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommandTag.sub_number / 10000.0];
    }
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
