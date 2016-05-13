//
//  LYUser.h
//  LYBestSister
//
//  Created by lieyanmomo on 16/5/3.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUser : NSObject

/** 用户名*/
@property (copy, nonatomic) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 */
@property (nonatomic, copy) NSString *sex;

@end
