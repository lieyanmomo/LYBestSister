//
//  LYTopic.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYTopic : NSObject

/** 头像*/
@property (copy, nonatomic) NSString *profile_image;
/** 昵称*/
@property (copy, nonatomic) NSString *name;
/** 发布时间*/
@property (copy, nonatomic) NSString *created_at;
/** 内容*/
@property (copy, nonatomic) NSString *text;
/** 顶贴数*/
@property (assign, nonatomic) NSInteger ding;
/** 踩贴数*/
@property (assign, nonatomic) NSInteger cai;
/** 转发数*/
@property (assign, nonatomic) NSInteger repost;
/** 评论数*/
@property (assign, nonatomic) NSInteger comment;

@end
