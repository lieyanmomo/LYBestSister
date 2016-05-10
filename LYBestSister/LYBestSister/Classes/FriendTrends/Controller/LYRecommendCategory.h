//
//  LYRecommendCategory.h
//  LYBestSister
//
//  Created by zhanghaibin on 16/5/9.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRecommendCategory : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *id;

/** 用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
/** 总数 */
@property (nonatomic, assign) NSInteger total;


@end
