//
//  UIImageView+LYExtension.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LYExtension)

/** 设置默认图片*/
- (void)setHeaderImageWithURL:(NSString *)url;
/** 设置圆形头像*/
- (void)setCricleHeaderImageWithURL:(NSString *)url;
/** 设置方形头像*/
- (void)setRectHeaderImageWithURL:(NSString *)url;

@end
