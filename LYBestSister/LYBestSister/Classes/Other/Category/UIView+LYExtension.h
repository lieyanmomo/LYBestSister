//
//  UIView+LYExtension.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYExtension)
/** 控件x值*/
@property (assign, nonatomic) CGFloat x;
/** 控件y值*/
@property (assign, nonatomic) CGFloat y;
/** 控件宽度width值*/
@property (assign, nonatomic) CGFloat width;
/** 控件高度height值*/
@property (assign, nonatomic) CGFloat height;
/** 控件中心点centerX值*/
@property (assign, nonatomic) CGFloat centerX;
/** 控件中心点centerY值*/
@property (assign, nonatomic) CGFloat centerY;

/** 控件最左边minusX*/
@property (assign, nonatomic) CGFloat left;
/** 控件最右边maxX*/
@property (assign, nonatomic) CGFloat right;
/** 控件最上边minusY*/
@property (assign, nonatomic) CGFloat top;
/** 控件最下边maxY*/
@property (assign, nonatomic) CGFloat bottom;

@end
