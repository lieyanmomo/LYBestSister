//
//  LYRecommendUser.h
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/10.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;

@end
