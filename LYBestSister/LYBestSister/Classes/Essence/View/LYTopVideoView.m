//
//  LYTopVideoView.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/6.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopVideoView.h"
#import "LYTopic.h"
#import <UIImageView+WebCache.h>

@interface LYTopVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;

@end

@implementation LYTopVideoView

#pragma mark - set方法为控件赋值
- (void)setTopic:(LYTopic *)topic {
    [super setTopic:topic];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.timeCountLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
