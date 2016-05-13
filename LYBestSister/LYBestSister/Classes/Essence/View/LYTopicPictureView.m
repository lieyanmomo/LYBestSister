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
#import <DALabeledCircularProgressView.h>


@interface LYTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation LYTopicPictureView

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.seeBigPicture.userInteractionEnabled = NO;
}

#pragma mark - set方法赋值
/** 重写set方法 */
- (void)setTopic:(LYTopic *)topic {
    [super setTopic:topic];
    
    // 显示图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) { // 这个block可能被调用多次
        // 【receivedSize】-- 下载完的大小 【expectedSize】-- 总共大小
        if (receivedSize < 0 || expectedSize < 0) return;
        
        // 显示正在下载提醒
        self.progressView.hidden = NO;
        self.placeholderView.hidden = NO;
        
        // 下载进度计算
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 隐藏占位图片和下载进度
        self.progressView.hidden = YES;
        self.placeholderView.hidden = YES;
    }];
    
    // 是否为gif
    self.gifView.hidden = !topic.is_gif;
    
    // 查看大图
    self.seeBigPicture.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) { // 大图
        _imageView.contentMode = UIViewContentModeTop;
        _imageView.clipsToBounds = YES;
        
    } else {
        
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.clipsToBounds = NO;
    }
}

@end
