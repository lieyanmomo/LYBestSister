//
//  LYTopVoiceView.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/5.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopVoiceView.h"
#import <UIImageView+WebCache.h>
#import "LYTopic.h"

@interface LYTopVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation LYTopVoiceView


#pragma mark - set方法为控件赋值
- (void)setTopic:(LYTopic *)topic {
    [super setTopic:topic];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}


@end
