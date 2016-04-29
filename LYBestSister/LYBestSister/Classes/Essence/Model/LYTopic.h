//
//  LYTopic.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    /** 图片*/
    LYTopicTypePicture = 10,
    /** 文字*/
    LYTopicTypeWord = 29,
    /** 视频*/
    LYTopicTypeVideo = 41,
    /** 声音*/
    LYTopicTypeVoice = 31
    
} LYTopicType;

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
/** 帖子类型*/
@property (assign, nonatomic) LYTopicType type;
@end
