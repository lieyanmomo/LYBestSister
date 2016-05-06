//
//  LYTopic.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/28.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYComment;

typedef enum {
    
    /** 全部 */
    LYTopicTypeAll = 1,
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

/** 最热评论*/
@property (strong, nonatomic) LYComment *top_cmt;

/** 图片宽 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 音频长度 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频长度 */
@property (nonatomic, assign) NSInteger videotime;

#pragma mark - 辅助属性
/** 中间控件的frame */
@property (nonatomic, assign) CGRect centerViewFrame;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 是否为大图 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;



@end
