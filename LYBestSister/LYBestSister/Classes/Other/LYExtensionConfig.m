//
//  LYExtensionConfig.m
//  LYBestSister
//
//  Created by 张海滨 on 16/5/4.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYExtensionConfig.h"
#import <MJExtension.h>
#import "LYTopic.h"
#import "LYComment.h"

@implementation LYExtensionConfig

+ (void)load {
    /** 声明模型属性名 对应的字典key*/
    [LYTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"
                 
                 };
    }];
    
}

@end
