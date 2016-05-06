//
//  LYTopVideoView.h
//  LYBestSister
//
//  Created by 张海滨 on 16/5/6.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTopic;


@interface LYTopVideoView : UIView

/** 创建方法 */
+ (instancetype)videoView;

/** 模型数据 */
@property (nonatomic, strong) LYTopic *topic;


@end
