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
@property (nonatomic, copy) NSString *id;

/** 评论内容*/
@property (copy, nonatomic) NSString *content;
/** 评论用户*/
@property (strong, nonatomic) LYUser *user;



/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

@end
