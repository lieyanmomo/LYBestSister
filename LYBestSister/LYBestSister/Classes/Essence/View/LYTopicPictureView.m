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
#import "LYSeeBigViewController.h"

@interface LYTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

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
    
#warning 是按钮不能点击-触控返回上级
    self.seeBigPicture.userInteractionEnabled = NO;
    
    // 设置进度样式
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
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

#pragma mark - set方法赋值
/** 重写set方法 */
- (void)setTopic:(LYTopic *)topic {
    _topic = topic;
    
    // 显示图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) { // 这个block可能被调用多次
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
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
