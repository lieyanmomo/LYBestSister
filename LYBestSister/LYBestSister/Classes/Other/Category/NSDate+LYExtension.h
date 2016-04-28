//
//  NSDate+LYExtension.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYExtension)

/** 是否为昨天*/
- (BOOL)isYesterday;

/** 是否为今天*/
- (BOOL)isToday;

/** 是否为明天*/
- (BOOL)isTomorrow;

/** 是否为今年*/
- (BOOL)isThisYear;

@end
