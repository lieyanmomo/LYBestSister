//
//  LYTopVoiceView.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/5.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopVoiceView.h"
#import "LYSeeBigViewController.h"
#import <UIImageView+WebCache.h>
#import "LYTopic.h"

@interface LYTopVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation LYTopVoiceView

/** 创建声音文件方法 */
+ (instancetype)voiceView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

#pragma mark - 初始化
- (void)awakeFromNib {
    
    // 防止自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 监听图片点击【添加收拾】
    self.imageView.userInteractionEnabled = YES; // 是图片可以点击【默认imageView不可以点击】
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

#pragma mark -- 图片点击方法
- (void)imageClick {
    if (self.imageView.image == nil) return;
    
    LYSeeBigViewController *seeBig = [[LYSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil
     ];
}


#pragma mark - set方法为控件赋值
- (void)setTopic:(LYTopic *)topic {
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}


@end
