//
//  LYRecommendUserCell.m
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYRecommendUserCell.h"
#import "LYRecommendUser.h"

@interface LYRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation LYRecommendUserCell

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = LYGrayColor(237);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - set方法
- (void)setUser:(LYRecommendUser *)user {
    
    _user = user;
    [self.headerImageView setHeaderImageWithURL:user.header];
    self.screenNameLabel.text = user.screen_name;
    
    if (user.fans_count > 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    } else {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }
}

@end
