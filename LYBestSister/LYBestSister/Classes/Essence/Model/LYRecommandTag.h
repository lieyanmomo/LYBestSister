//
//  LYRecommandTag.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/19.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRecommandTag : NSObject

/** 图片*/
@property (copy, nonatomic) NSString *image_list;
/** 名字*/
@property (copy, nonatomic) NSString *theme_name;
/** 订阅数*/
@property (assign, nonatomic) NSUInteger sub_number;

@end
