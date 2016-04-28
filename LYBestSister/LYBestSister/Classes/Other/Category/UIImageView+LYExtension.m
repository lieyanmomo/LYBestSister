//
//  UIImageView+LYExtension.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "UIImageView+LYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LYExtension)

- (void)setHeaderImageWithURL:(NSString *)url {
    [self setCricleHeaderImageWithURL:url];
}


- (void)setCricleHeaderImageWithURL:(NSString *)url {
    
    UIImage *placeholderImage = [UIImage cricleImageWithName:@"defaultUserIcon"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 下载失败不做任何处理，显示展位图片
        if (image == nil) return;
        self.image = [image cricleImage];
    }];
}

- (void)setRectHeaderImageWithURL:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
