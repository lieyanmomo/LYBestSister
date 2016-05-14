//
//  LYComment.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/5/3.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYUser;

@interface LYComment : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 评论内容*/
@property (copy, nonatomic) NSString *content;
/** 评论用户*/
@property (strong, nonatomic) LYUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频长度 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频路径 */
@property (nonatomic, copy) NSString *voiceuri;

@end
