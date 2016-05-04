//
//  LYTopicPictureView.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/4.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYTopicPictureView.h"
#import "LYTopic.h"
#import <UIImageView+WebCache.h>

@interface LYTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;


@end

@implementation LYTopicPictureView
/** 加载中间图片方法 */
+ (instancetype)pictureView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

#pragma mark - 初始化
- (void)awakeFromNib {
    // 去除系统自带的图片拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
}

/** 重写set方法 */
- (void)setTopic:(LYTopic *)topic {
    _topic = topic;
    
    // 显示图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 是否为gif
    self.gifView.hidden = !topic.is_gif;
    
    // 查看大图
    self.seeBigPicture.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) { // 大图
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
